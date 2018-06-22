Received: from eggs.gnu.org ([2001:4830:134:3::10]:35916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fWIes-0007Kj-Aa
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fWIen-0007gc-F0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:47:10 -0400
Date: Fri, 22 Jun 2018 11:46:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180622114659.7858fe00.cohuck@redhat.com>
In-Reply-To: <c4ce8f0c-ccbb-3d79-459f-bb771a68685a@de.ibm.com>
References: <20180621170143.113370-1-borntraeger@de.ibm.com>
	<d27919d1-6017-3b57-815d-0bdeb96dea6e@redhat.com>
	<c4ce8f0c-ccbb-3d79-459f-bb771a68685a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Thu, 21 Jun 2018 22:34:49 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/21/2018 07:08 PM, Paolo Bonzini wrote:
> > On 21/06/2018 19:01, Christian Borntraeger wrote:  
> >> kexec/kdump as well as the bootloader use a subcode of diagnose 308
> >> that is supposed to reset the subsystem but not comprise a full
> >> "reboot". With the latest refactoring this is now broken when
> >> -no-reboot is used. This for example breaks virt-install from
> >> iso images.
> >>
> >> We need to mark these "soft" reboots as ok for rebooting.
> >>
> >> Fixes: a30fb811cbe9 (s390x: refactor reset/reipl handling)
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>  
> > 
> > Ok, then my suggestion made even more sense. :)  No other objections
> > apart from the name of the constant.
> > 
> > Paolo  
> 
> SHUTDOWN_CAUSE_S390_PARTIAL ?

Don't like that one much.

> 
> SHUTDOWN_CAUSE_S390_SUBSYS_RESET?

Either that, or drop the 'S390' (is it conceivable that other
architectures have something similar)?

> 
> 
> >   
> >> ---
> >>  hw/s390x/ipl.c          | 8 +++++++-
> >>  include/sysemu/sysemu.h | 3 +++
> >>  vl.c                    | 4 ++--
> >>  3 files changed, 12 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> >> index 0d67349004..ade6896af6 100644
> >> --- a/hw/s390x/ipl.c
> >> +++ b/hw/s390x/ipl.c
> >> @@ -535,7 +535,13 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
> >>              ipl->iplb_valid = s390_gen_initial_iplb(ipl);
> >>          }
> >>      }
> >> -    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >> +    if (reset_type == S390_RESET_MODIFIED_CLEAR ||
> >> +        reset_type == S390_RESET_LOAD_NORMAL) {
> >> +        /* ignore -no-reboot */
> >> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET_FORCE);
> >> +    } else {
> >> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >> +    }
> >>      /* as this is triggered by a CPU, make sure to exit the loop */
> >>      if (tcg_enabled()) {
> >>          cpu_loop_exit(cs);
> >> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> >> index e893f72f3b..345369d924 100644
> >> --- a/include/sysemu/sysemu.h
> >> +++ b/include/sysemu/sysemu.h
> >> @@ -44,6 +44,9 @@ typedef enum ShutdownCause {
> >>                                       turns that into a shutdown */
> >>      SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
> >>                                       that into a shutdown */
> >> +    SHUTDOWN_CAUSE_GUEST_RESET_FORCE,/* Guest reset that should ignore
> >> +                                        --no-reboot. This is useful for reset
> >> +                                        like actions as s390 kexec/kdump */
> >>      SHUTDOWN_CAUSE__MAX,
> >>  } ShutdownCause;
> >>  
> >> diff --git a/vl.c b/vl.c
> >> index b3426e03d0..44e65071bc 100644
> >> --- a/vl.c
> >> +++ b/vl.c
> >> @@ -1628,7 +1628,7 @@ void qemu_system_reset(ShutdownCause reason)
> >>      } else {
> >>          qemu_devices_reset();
> >>      }
> >> -    if (reason) {
> >> +    if (reason != SHUTDOWN_CAUSE_GUEST_RESET_FORCE) {
> >>          qapi_event_send_reset(shutdown_caused_by_guest(reason),
> >>                                &error_abort);
> >>      }
> >> @@ -1674,7 +1674,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
> >>  
> >>  void qemu_system_reset_request(ShutdownCause reason)
> >>  {
> >> -    if (no_reboot) {
> >> +    if (no_reboot && reason != SHUTDOWN_CAUSE_GUEST_RESET_FORCE) {
> >>          shutdown_requested = reason;
> >>      } else {
> >>          reset_requested = reason;
> >>  
> >   
> 

The patch looks sane to me.
