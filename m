Received: from eggs.gnu.org ([2001:4830:134:3::10]:46001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqhQg-000177-AX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqhQe-0006ZW-Sj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eqhQe-0006Vc-L9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:32 -0500
Date: Tue, 27 Feb 2018 15:44:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180227154401.GA2848@work-vm>
References: <20180215153955.3253-1-brijesh.singh@amd.com>
	<20180215153955.3253-17-brijesh.singh@amd.com>
	<20180216154702.GC2308@work-vm>
	<8be03317-c192-fc4e-a4bd-0c9658e79f52@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be03317-c192-fc4e-a4bd-0c9658e79f52@amd.com>
Subject: Re: [Qemu-devel] [PATCH v9 16/29] sev/i386: add command to encrypt
 guest memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> 
> 
> On 2/16/18 9:47 AM, Dr. David Alan Gilbert wrote:
> > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >> The KVM_SEV_LAUNCH_UPDATE_DATA command is used to encrypt a guest memory
> >> region using the VM Encryption Key created using LAUNCH_START.
> >>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Richard Henderson <rth@twiddle.net>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> >> ---
> >>  accel/kvm/kvm-all.c      |  2 ++
> >>  include/sysemu/sev.h     |  1 +
> >>  stubs/sev.c              |  5 +++++
> >>  target/i386/sev.c        | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  target/i386/trace-events |  1 +
> >>  5 files changed, 58 insertions(+)
> >>
> >> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> >> index 4468c8fe002c..4974c00c46fb 100644
> >> --- a/accel/kvm/kvm-all.c
> >> +++ b/accel/kvm/kvm-all.c
> >> @@ -1679,6 +1679,8 @@ static int kvm_init(MachineState *ms)
> >>          if (!kvm_state->memcrypt_handle) {
> >>              goto err;
> >>          }
> >> +
> >> +        kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
> >>      }
> >>  
> >>      ret = kvm_arch_init(ms, s);
> >> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> >> index 5c8c549b68ec..c16102b05ec4 100644
> >> --- a/include/sysemu/sev.h
> >> +++ b/include/sysemu/sev.h
> >> @@ -69,5 +69,6 @@ struct SEVState {
> >>  typedef struct SEVState SEVState;
> >>  
> >>  void *sev_guest_init(const char *id);
> >> +int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
> >>  
> >>  #endif
> >> diff --git a/stubs/sev.c b/stubs/sev.c
> >> index 24c7b0c3e04d..74182bb545e2 100644
> >> --- a/stubs/sev.c
> >> +++ b/stubs/sev.c
> >> @@ -15,6 +15,11 @@
> >>  #include "qemu-common.h"
> >>  #include "sysemu/sev.h"
> >>  
> >> +int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
> >> +{
> >> +    return 1;
> >> +}
> >> +
> >>  SevState sev_get_current_state(void)
> >>  {
> >>      return SEV_STATE_UNINIT;
> >> diff --git a/target/i386/sev.c b/target/i386/sev.c
> >> index 6f767084fd57..04a64b5bc61d 100644
> >> --- a/target/i386/sev.c
> >> +++ b/target/i386/sev.c
> >> @@ -90,6 +90,12 @@ fw_error_to_str(int code)
> >>      return sev_fw_errlist[code];
> >>  }
> >>  
> >> +static bool
> >> +sev_check_state(SevState state)
> >> +{
> >> +    return current_sev_guest_state == state ? true : false;
> >> +}
> >> +
> >>  static void
> >>  sev_set_guest_state(SevState new_state)
> >>  {
> >> @@ -466,6 +472,36 @@ sev_launch_start(SEVState *s)
> >>      return 0;
> >>  }
> >>  
> >> +static int
> >> +sev_launch_update_data(uint8_t *addr, uint64_t len)
> >> +{
> >> +    int ret, fw_error;
> >> +    struct kvm_sev_launch_update_data *update;
> >> +
> >> +    if (addr == NULL || len <= 0) {
> >> +        return 1;
> >> +    }
> >> +
> >> +    update = g_malloc0(sizeof(*update));
> >> +    if (!update) {
> >> +        return 1;
> >> +    }
> >>
> > Keep checking for the g_malloc0 use - it will never return NULL;
> > if you want it to be safe from running out of memory use g_try_malloc0
> > otherwise you can just remove the !update check.
> > Also it's better to use the g_new0 macro (or g_try_new0) - it's neater
> > and avoids the whole sizeof thing.
> > (You have that in a bunch of the patches)
> 
> I didn't realized that g_malloc0() will never return NULL. I checked
> just glib doc,

Yes, all of the normal glib allocators assert on failure to allocate
rather than returning NULL.   Our normal advice is to use
g_new0/g_malloc0 for small items and you don't need to check it; but for
anything large use the g_try_* variants, they do return NULL on a
failure.

> if v10 is needed then I can remove them all or can submit
> a follow-up patch.

If there are no other changes needed then it's fine as a followup;
if you need to reroll anyway then lets tidy them all up.

Dave

> 
> thanks
> 
> 
> > Dave
> >
> >> +    update->uaddr = (__u64)addr;
> >> +    update->len = len;
> >> +    trace_kvm_sev_launch_update_data(addr, len);
> >> +    ret = sev_ioctl(KVM_SEV_LAUNCH_UPDATE_DATA, update, &fw_error);
> >> +    if (ret) {
> >> +        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
> >> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> >> +        goto err;
> >> +    }
> >> +
> >> +err:
> >> +    g_free(update);
> >> +    return ret;
> >> +}
> >> +
> >>  void *
> >>  sev_guest_init(const char *id)
> >>  {
> >> @@ -540,6 +576,19 @@ err:
> >>      return NULL;
> >>  }
> >>  
> >> +int
> >> +sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
> >> +{
> >> +    assert(handle);
> >> +
> >> +    /* if SEV is in update state then encrypt the data else do nothing */
> >> +    if (sev_check_state(SEV_STATE_LUPDATE)) {
> >> +        return sev_launch_update_data(ptr, len);
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  static void
> >>  sev_register_types(void)
> >>  {
> >> diff --git a/target/i386/trace-events b/target/i386/trace-events
> >> index 9402251e9991..c0cd8e93217f 100644
> >> --- a/target/i386/trace-events
> >> +++ b/target/i386/trace-events
> >> @@ -12,3 +12,4 @@ kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
> >>  kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
> >>  kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
> >>  kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
> >> +kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
> >> -- 
> >> 2.14.3
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
