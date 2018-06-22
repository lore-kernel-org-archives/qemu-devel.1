Received: from eggs.gnu.org ([2001:4830:134:3::10]:40534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fWKw2-0004pI-Po
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fWKvz-0004Oj-K2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:13:02 -0400
References: <20180622102928.173420-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb7c5829-bf46-a1d0-7191-28b3202ddc98@redhat.com>
Date: Fri, 22 Jun 2018 14:12:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180622102928.173420-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 22/06/2018 12:29, Christian Borntraeger wrote:
> kexec/kdump as well as the bootloader use a subcode of diagnose 308
> that is supposed to reset the I/O subsystem but not comprise a full
> "reboot". With the latest refactoring this is now broken when
> -no-reboot is used or when libvirt acts on a reboot QMP event, for
> example a virt-install from iso images.
> We need to mark these "subsystem reset" as special.
> 
> Fixes: a30fb811cbe9 (s390x: refactor reset/reipl handling)
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
> v3->v4: - rename to SHUTDOWN_CAUSE_SUBSYSTEM_RESET
>         - modify comments and patch descriptions
> 
>  hw/s390x/ipl.c          | 8 +++++++-
>  include/sysemu/sysemu.h | 4 ++++
>  vl.c                    | 4 ++--
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d67349004..f278036fa7 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -535,7 +535,13 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>              ipl->iplb_valid = s390_gen_initial_iplb(ipl);
>          }
>      }
> -    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +    if (reset_type == S390_RESET_MODIFIED_CLEAR ||
> +        reset_type == S390_RESET_LOAD_NORMAL) {
> +        /* ignore -no-reboot, send no event  */
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
> +    } else {
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +    }
>      /* as this is triggered by a CPU, make sure to exit the loop */
>      if (tcg_enabled()) {
>          cpu_loop_exit(cs);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index e893f72f3b..9a621de02f 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -44,6 +44,10 @@ typedef enum ShutdownCause {
>                                       turns that into a shutdown */
>      SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
>                                       that into a shutdown */
> +    SHUTDOWN_CAUSE_SUBSYSTEM_RESET,/* Partial guest reset that does not trigger
> +                                      QMP events and ignores --no-reboot. This
> +                                      is useful for sanitize hypercalls on s390
> +                                      that are used during kexec/kdump/boot */
>      SHUTDOWN_CAUSE__MAX,
>  } ShutdownCause;
>  
> diff --git a/vl.c b/vl.c
> index b3426e03d0..c196e39287 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1628,7 +1628,7 @@ void qemu_system_reset(ShutdownCause reason)
>      } else {
>          qemu_devices_reset();
>      }
> -    if (reason) {
> +    if (reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
>          qapi_event_send_reset(shutdown_caused_by_guest(reason),
>                                &error_abort);
>      }
> @@ -1674,7 +1674,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>  
>  void qemu_system_reset_request(ShutdownCause reason)
>  {
> -    if (no_reboot) {
> +    if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
>          shutdown_requested = reason;
>      } else {
>          reset_requested = reason;
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

Paolo
