Received: from eggs.gnu.org ([209.51.188.92]:48853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gtYaB-0007oZ-Qo
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gtYaA-00056b-7Y
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:58:43 -0500
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:39412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gtYa9-0004XO-JD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:58:42 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190211133049.GF2627@work-vm>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
	<20190204130958.18904-5-yury-kotov@yandex-team.ru>
	<20190211133049.GF2627@work-vm>
MIME-Version: 1.0
Date: Tue, 12 Feb 2019 16:58:23 +0300
Message-Id: <163731549979903@myt4-a988562a11ab.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>

11.02.2019, 16:30, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0Currently we don't check which capabilities set in the source QE=
MU.
>> =C2=A0We just expect that the target QEMU has the same enabled capabil=
ities.
>>
>> =C2=A0Add explicit validation for capabilities to make sure that the t=
arget VM
>> =C2=A0has them too. This is enabled for only new capabilities to keep =
compatibily.
>
> I'd rather keep the capaiblities on the wire as strings, rather than
> indexes; indexes are too delicate.
>

It seems that strings also have a problem. E.g. when we remove 'x-' prefi=
x from
x-some-capability. But I don't insist.

> I guess we also have to think about what happens when new capabilities
> are added; what happens when we migrate to an older qemu that doesn't
> know about that capability?
> What happens when we migrate to a newer capability which thinks you
> forgot to send that capability across?
>

I thought about such cases:

> what happens when new capabilities are added?
If new capability should be validated, then source will send it, target w=
ill
expect it. Otherwise, nothing will happen.

> what happens when we migrate to an older qemu that doesn't
> know about that capability?

Incoming migration will be failed as expected. If old qemu doesn't know t=
he
capability, therefore qemu doesn't support it. In this case, user should =
disable
the capability on source before migration.

> What happens when we migrate to a newer capability which thinks you
> forgot to send that capability across?

Sorry, I'm not sure that I understood correctly. It seems that it's the s=
ame
case as the previous one.

> While we're on capabilities, I think you also need to check if the
> skip-shared is enabled with postcopy; I don't think they'll work
> together.
>

I agree, postcopy and skip-shared shouldn't be enabled together.
Will add a check in v3.

> Dave
>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0migration/savevm.c | 101 +++++++++++++++++++++++++++++++++=
++++++++++++
>> =C2=A0=C2=A01 file changed, 101 insertions(+)
>>
>> =C2=A0diff --git a/migration/savevm.c b/migration/savevm.c
>> =C2=A0index 322660438d..9603a38bca 100644
>> =C2=A0--- a/migration/savevm.c
>> =C2=A0+++ b/migration/savevm.c
>> =C2=A0@@ -57,6 +57,7 @@
>> =C2=A0=C2=A0#include "sysemu/replay.h"
>> =C2=A0=C2=A0#include "qjson.h"
>> =C2=A0=C2=A0#include "migration/colo.h"
>> =C2=A0+#include "qemu/bitmap.h"
>>
>> =C2=A0=C2=A0#ifndef ETH_P_RARP
>> =C2=A0=C2=A0#define ETH_P_RARP 0x8035
>> =C2=A0@@ -316,6 +317,8 @@ typedef struct SaveState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *name;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t target_page_bits;
>> =C2=A0+ uint32_t caps_count;
>> =C2=A0+ uint8_t *capabilities;
>> =C2=A0=C2=A0} SaveState;
>>
>> =C2=A0=C2=A0static SaveState savevm_state =3D {
>> =C2=A0@@ -323,15 +326,51 @@ static SaveState savevm_state =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global_section_id =3D 0,
>> =C2=A0=C2=A0};
>>
>> =C2=A0+static bool should_validate_capability(int capability)
>> =C2=A0+{
>> =C2=A0+ assert(capability >=3D 0 && capability < MIGRATION_CAPABILITY_=
_MAX);
>> =C2=A0+ /* Validate only new capabilities to keep compatibility. */
>> =C2=A0+ switch (capability) {
>> =C2=A0+ case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>> =C2=A0+ return true;
>> =C2=A0+ default:
>> =C2=A0+ return false;
>> =C2=A0+ }
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static uint32_t get_validatable_capabilities_count(void)
>> =C2=A0+{
>> =C2=A0+ MigrationState *s =3D migrate_get_current();
>> =C2=A0+ uint32_t result =3D 0;
>> =C2=A0+ int i;
>> =C2=A0+ for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
>> =C2=A0+ if (should_validate_capability(i) && s->enabled_capabilities[i=
]) {
>> =C2=A0+ result++;
>> =C2=A0+ }
>> =C2=A0+ }
>> =C2=A0+ return result;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static int configuration_pre_save(void *opaque)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SaveState *state =3D opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *current_name =3D MACHI=
NE_GET_CLASS(current_machine)->name;
>> =C2=A0+ MigrationState *s =3D migrate_get_current();
>> =C2=A0+ int i, j;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state->len =3D strlen(current_name=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state->name =3D current_name;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state->target_page_bits =3D qemu_t=
arget_page_bits();
>>
>> =C2=A0+ state->caps_count =3D get_validatable_capabilities_count();
>> =C2=A0+ state->capabilities =3D g_renew(uint8_t, state->capabilities,
>> =C2=A0+ state->caps_count);
>> =C2=A0+ for (i =3D j =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
>> =C2=A0+ if (should_validate_capability(i) && s->enabled_capabilities[i=
]) {
>> =C2=A0+ state->capabilities[j++] =3D i;
>> =C2=A0+ }
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> =C2=A0=C2=A0}
>>
>> =C2=A0@@ -347,6 +386,45 @@ static int configuration_pre_load(void *opa=
que)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static bool configuration_validate_capabilities(SaveState *stat=
e)
>> =C2=A0+{
>> =C2=A0+ bool ret =3D true;
>> =C2=A0+ MigrationState *s =3D migrate_get_current();
>> =C2=A0+ unsigned long *source_caps_bm;
>> =C2=A0+ int i;
>> =C2=A0+
>> =C2=A0+ source_caps_bm =3D bitmap_new(MIGRATION_CAPABILITY__MAX);
>> =C2=A0+ for (i =3D 0; i < state->caps_count; i++) {
>> =C2=A0+ int capability =3D state->capabilities[i];
>> =C2=A0+ if (capability >=3D MIGRATION_CAPABILITY__MAX) {
>> =C2=A0+ error_report("Received unknown capability %d", capability);
>> =C2=A0+ ret =3D false;
>> =C2=A0+ } else {
>> =C2=A0+ set_bit(capability, source_caps_bm);
>> =C2=A0+ }
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
>> =C2=A0+ bool source_state, target_state;
>> =C2=A0+ if (!should_validate_capability(i)) {
>> =C2=A0+ continue;
>> =C2=A0+ }
>> =C2=A0+ source_state =3D test_bit(i, source_caps_bm);
>> =C2=A0+ target_state =3D s->enabled_capabilities[i];
>> =C2=A0+ if (source_state !=3D target_state) {
>> =C2=A0+ error_report("Capability %s is %s, but received capability is =
%s",
>> =C2=A0+ MigrationCapability_str(i),
>> =C2=A0+ target_state ? "on" : "off",
>> =C2=A0+ source_state ? "on" : "off");
>> =C2=A0+ ret =3D false;
>> =C2=A0+ /* Don't break here to report all failed capabilities */
>> =C2=A0+ }
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ g_free(source_caps_bm);
>> =C2=A0+ return ret;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static int configuration_post_load(void *opaque, int versi=
on_id)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SaveState *state =3D opaque;
>> =C2=A0@@ -364,6 +442,10 @@ static int configuration_post_load(void *op=
aque, int version_id)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EI=
NVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0+ if (!configuration_validate_capabilities(state)) {
>> =C2=A0+ return -EINVAL;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> =C2=A0=C2=A0}
>>
>> =C2=A0@@ -380,6 +462,11 @@ static bool vmstate_target_page_bits_needed=
(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0> qemu_tar=
get_page_bits_min();
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static bool vmstate_capabilites_needed(void *opaque)
>> =C2=A0+{
>> =C2=A0+ return get_validatable_capabilities_count() > 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static const VMStateDescription vmstate_target_page_bits =3D=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "configuration/target-pa=
ge-bits",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.version_id =3D 1,
>> =C2=A0@@ -391,6 +478,19 @@ static const VMStateDescription vmstate_tar=
get_page_bits =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0};
>>
>> =C2=A0+static const VMStateDescription vmstate_capabilites =3D {
>> =C2=A0+ .name =3D "configuration/capabilities",
>> =C2=A0+ .version_id =3D 1,
>> =C2=A0+ .minimum_version_id =3D 1,
>> =C2=A0+ .needed =3D vmstate_capabilites_needed,
>> =C2=A0+ .fields =3D (VMStateField[]) {
>> =C2=A0+ VMSTATE_UINT32_V(caps_count, SaveState, 1),
>> =C2=A0+ VMSTATE_VARRAY_UINT32_ALLOC(capabilities, SaveState, caps_coun=
t, 1,
>> =C2=A0+ vmstate_info_uint8, uint8_t),
>> =C2=A0+ VMSTATE_END_OF_LIST()
>> =C2=A0+ }
>> =C2=A0+};
>> =C2=A0+
>> =C2=A0=C2=A0static const VMStateDescription vmstate_configuration =3D =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "configuration",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.version_id =3D 1,
>> =C2=A0@@ -404,6 +504,7 @@ static const VMStateDescription vmstate_conf=
iguration =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.subsections =3D (const VMStateDes=
cription*[]) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&vmstate_t=
arget_page_bits,
>> =C2=A0+ &vmstate_capabilites,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0};
>> =C2=A0--
>> =C2=A02.20.1
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury
