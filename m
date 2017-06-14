Received: from eggs.gnu.org ([2001:4830:134:3::10]:53233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL6sx-0002Kf-7m
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL6st-0001id-7N
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:54:55 -0400
Received: from mail-eopbgr30121.outbound.protection.outlook.com
	([40.107.3.121]:20352
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dL6ss-0001hk-LW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:54:51 -0400
Date: Wed, 14 Jun 2017 14:54:22 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170614115421.GJ2004@rkaganb.sw.ru>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-17-rkagan@virtuozzo.com>
	<999e60c5-7ee7-5346-6940-1fcd5d7b4264@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999e60c5-7ee7-5346-6940-1fcd5d7b4264@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/23] hyperv: map overlay pages after
 updating msrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 01:12:12PM +0200, Paolo Bonzini wrote:
> 
> 
> On 06/06/2017 20:19, Roman Kagan wrote:
> > There is a design flaw in the Hyper-V SynIC implementation in KVM: when
> > message page or event flags page is enabled by setting the corresponding
> > msr, KVM zeroes it out.  This violates the spec in general (per spec,
> > the pages have to be overlay ones and only zeroed at cpu reset), but
> > it's non-fatal in normal operation because the user exit happens after
> > the page is zeroed, so it's the underlying guest page which is zeroed
> > out, and sane guests don't depend on its contents to be preserved while
> > it's overlaid.
> > 
> > However, in the case of vmstate load the overlay pages are set up before
> > msrs are set so the contents of those pages get lost.
> > 
> > To work it around, avoid setting up overlay pages in .post_load.
> > Instead, postpone it until after the msrs are pushed to KVM.  As a
> > result, KVM just zeroes out the underlying guest pages similar to how it
> > happens during guest-initiated msr writes, which is tolerable.
> 
> Why not disable the zeroing for host-initiated MSR writes?  This is
> pretty clearly a KVM bug, we can push it to stable kernels too.

The only problem with this is that QEMU will have no reliable way to
know if the KVM it runs with has this bug fixed or not.  Machines
without vmbus work and even migrate fine with the current KVM despite
this bug (the only user of those pages currently is synic timers which
re-arm themselves and post messages regardless of zeroing).  Now
updating QEMU to a vmbus-enabled version without updating the kernel
will make the migrations cause guest hangs.

If that is tolerable I can happily drop this patch as it complicates
code a little.  Distros probably won't be affected as they can make sure
their kernels have this bug fixed before they roll out a vmbus-capable
QEMU.

What do you think?

Thanks,
Roman.
