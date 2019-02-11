Received: from eggs.gnu.org ([209.51.188.92]:56849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtBfo-0006Gi-Po
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtBfn-0001uv-Jy
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:31:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gtBfn-0001rw-9m
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:30:59 -0500
Date: Mon, 11 Feb 2019 13:30:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190211133049.GF2627@work-vm>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
	<20190204130958.18904-5-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204130958.18904-5-yury-kotov@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] migration: Add capabilities
 validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, wrfsh@yandex-team.ru

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Currently we don't check which capabilities set in the source QEMU.
> We just expect that the target QEMU has the same enabled capabilities.
> 
> Add explicit validation for capabilities to make sure that the target VM
> has them too. This is enabled for only new capabilities to keep compatibily.

I'd rather keep the capaiblities on the wire as strings, rather than
indexes; indexes are too delicate.

I guess we also have to think about what happens when new capabilities
are added; what happens when we migrate to an older qemu that doesn't
know about that capability?
What happens when we migrate to a newer capability which thinks you
forgot to send that capability across?

While we're on capabilities, I think you also need to check if the
skip-shared is enabled with postcopy; I don't think they'll work
together.

Dave


> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  migration/savevm.c | 101 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 322660438d..9603a38bca 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -57,6 +57,7 @@
>  #include "sysemu/replay.h"
>  #include "qjson.h"
>  #include "migration/colo.h"
> +#include "qemu/bitmap.h"
>  
>  #ifndef ETH_P_RARP
>  #define ETH_P_RARP 0x8035
> @@ -316,6 +317,8 @@ typedef struct SaveState {
>      uint32_t len;
>      const char *name;
>      uint32_t target_page_bits;
> +    uint32_t caps_count;
> +    uint8_t *capabilities;
>  } SaveState;
>  
>  static SaveState savevm_state = {
> @@ -323,15 +326,51 @@ static SaveState savevm_state = {
>      .global_section_id = 0,
>  };
>  
> +static bool should_validate_capability(int capability)
> +{
> +    assert(capability >= 0 && capability < MIGRATION_CAPABILITY__MAX);
> +    /* Validate only new capabilities to keep compatibility. */
> +    switch (capability) {
> +    case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static uint32_t get_validatable_capabilities_count(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    uint32_t result = 0;
> +    int i;
> +    for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
> +        if (should_validate_capability(i) && s->enabled_capabilities[i]) {
> +            result++;
> +        }
> +    }
> +    return result;
> +}
> +
>  static int configuration_pre_save(void *opaque)
>  {
>      SaveState *state = opaque;
>      const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
> +    MigrationState *s = migrate_get_current();
> +    int i, j;
>  
>      state->len = strlen(current_name);
>      state->name = current_name;
>      state->target_page_bits = qemu_target_page_bits();
>  
> +    state->caps_count = get_validatable_capabilities_count();
> +    state->capabilities = g_renew(uint8_t, state->capabilities,
> +                                  state->caps_count);
> +    for (i = j = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
> +        if (should_validate_capability(i) && s->enabled_capabilities[i]) {
> +            state->capabilities[j++] = i;
> +        }
> +    }
> +
>      return 0;
>  }
>  
> @@ -347,6 +386,45 @@ static int configuration_pre_load(void *opaque)
>      return 0;
>  }
>  
> +static bool configuration_validate_capabilities(SaveState *state)
> +{
> +    bool ret = true;
> +    MigrationState *s = migrate_get_current();
> +    unsigned long *source_caps_bm;
> +    int i;
> +
> +    source_caps_bm = bitmap_new(MIGRATION_CAPABILITY__MAX);
> +    for (i = 0; i < state->caps_count; i++) {
> +        int capability = state->capabilities[i];
> +        if (capability >= MIGRATION_CAPABILITY__MAX) {
> +            error_report("Received unknown capability %d", capability);
> +            ret = false;
> +        } else {
> +            set_bit(capability, source_caps_bm);
> +        }
> +    }
> +
> +    for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
> +        bool source_state, target_state;
> +        if (!should_validate_capability(i)) {
> +            continue;
> +        }
> +        source_state = test_bit(i, source_caps_bm);
> +        target_state = s->enabled_capabilities[i];
> +        if (source_state != target_state) {
> +            error_report("Capability %s is %s, but received capability is %s",
> +                         MigrationCapability_str(i),
> +                         target_state ? "on" : "off",
> +                         source_state ? "on" : "off");
> +            ret = false;
> +            /* Don't break here to report all failed capabilities */
> +        }
> +    }
> +
> +    g_free(source_caps_bm);
> +    return ret;
> +}
> +
>  static int configuration_post_load(void *opaque, int version_id)
>  {
>      SaveState *state = opaque;
> @@ -364,6 +442,10 @@ static int configuration_post_load(void *opaque, int version_id)
>          return -EINVAL;
>      }
>  
> +    if (!configuration_validate_capabilities(state)) {
> +        return -EINVAL;
> +    }
> +
>      return 0;
>  }
>  
> @@ -380,6 +462,11 @@ static bool vmstate_target_page_bits_needed(void *opaque)
>          > qemu_target_page_bits_min();
>  }
>  
> +static bool vmstate_capabilites_needed(void *opaque)
> +{
> +    return get_validatable_capabilities_count() > 0;
> +}
> +
>  static const VMStateDescription vmstate_target_page_bits = {
>      .name = "configuration/target-page-bits",
>      .version_id = 1,
> @@ -391,6 +478,19 @@ static const VMStateDescription vmstate_target_page_bits = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_capabilites = {
> +    .name = "configuration/capabilities",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vmstate_capabilites_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_V(caps_count, SaveState, 1),
> +        VMSTATE_VARRAY_UINT32_ALLOC(capabilities, SaveState, caps_count, 1,
> +                                    vmstate_info_uint8, uint8_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_configuration = {
>      .name = "configuration",
>      .version_id = 1,
> @@ -404,6 +504,7 @@ static const VMStateDescription vmstate_configuration = {
>      },
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_target_page_bits,
> +        &vmstate_capabilites,
>          NULL
>      }
>  };
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
