Received: from eggs.gnu.org ([209.51.188.92]:50322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.mielke@gmail.com>) id 1gkUOb-0000Y4-9k
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.mielke@gmail.com>) id 1gkUOa-00059b-0I
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:41:17 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mark.mielke@gmail.com>)
	id 1gkUOZ-00058U-NA
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:41:15 -0500
Received: by mail-wm1-x341.google.com with SMTP id r24so1027043wmh.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:41:15 -0800 (PST)
MIME-Version: 1.0
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
	<20190118101633.GC2146@work-vm> <20190118102102.GH20660@redhat.com>
	<328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
In-Reply-To: <328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
From: Mark Mielke <mark.mielke@gmail.com>
Date: Fri, 18 Jan 2019 08:41:02 -0500
Message-ID: <CALm7yL0nFGC1hYfvASrOL2FzO88oZURiLs-a6pR7Cjp3XS0U_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

On Fri, Jan 18, 2019 at 7:57 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 18/01/19 11:21, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Jan 18, 2019 at 10:16:34AM +0000, Dr. David Alan Gilbert wrote:
> >> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >>> The solution is to restart the VM using "-cpu host,-vmx".
> >> The problem as Christian explained in that thread is that it was commo=
n
> >> for them to start VMs with vmx enabled but for people not to use it
> >> on most of the VMs, so we break migration for most VMs even though mos=
t
> >> don't use it.
> >> It might not be robust, but it worked for a lot of people most of the
> >> time.
> It's not "not robust" (like, it usually works but sometimes fails
> mysteriously).  It's entirely broken, you just don't notice that it is
> if you're not using the feature.
>

It is useful to understand the risk. However, this is the same risk we have
been successfully living with for several years now, and it seems abrupt to
declare 3.1 and 3.2 as the Qemu version beyond which migration requires a
whole cluster restart whether or not a L2 guest had been, or will ever be
started on any of the guests.

I would like to see the risk clearly communicated, and have the option of
proceeding anyways (as we have every day since first deploying the
solution). I think I am not alone here, otherwise I would have quietly
implemented a naive patch myself without raising this for discussion. :-)

Given the known risk, I'm happy to restart all machines that have or will
likely use an L2 guest, and leverage this capability for the 80%+ of
machines that will never launch an L2 guest. Although, detecting it and
using this to block live migration in case any mistakes in detection were
made would be very cool as well.

Is this something that will already work with the pending 3.2 code? Or is
any change required to achieve this? Is it best to upgrade to 3.0 before
proceeding to 3.2 (once it is released), or will it be acceptable to
migrate from 2.12 directly to 3.2 in this manner?


> Yes, this is exactly why I said we should make the migration blocker
> > be conditional on any L2 guest having been started. I vaguely recall
> > someone saying there wasn't any way to detect this situation from
> > QEMU though ?
> You can check that and give a warning (check that CR4.VMXE=3D1 but no
> other live migration state was transferred).  However, without live
> migration support in the kernel and in QEMU you cannot start VMs *for
> the entire future life of the VM* after a live migration.  So even if we
> implemented that kind of blocker, it would fail even if no VM has been
> started, as long as the kvm_intel module is loaded on migration.  That
> would be no different in practice from what we have now.
>
> It might work to unload the kvm_intel module and run live migration with
> the CPU configured differently ("-cpu host,-vmx") on the destination.
>

For machines that will not use L2 guest, would it be a good precaution to
unload kvm_intel pre-emptively before live migration just in case? In
particular, I'm curious if doing anything at all increases the risk of
failure, or if it should be left alone entirely and never used as the
lowest risk option (and what we have traditionally been doing anyways).

I do appreciate the warnings and details. Just not the enforcement piece.

Thanks!

--=20
Mark Mielke <mark.mielke@gmail.com>
