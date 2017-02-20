Received: from eggs.gnu.org ([2001:4830:134:3::10]:32950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cfkRJ-0003Uh-PO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cfkRE-0000kf-Pw
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:39:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cfkRE-0000kJ-KP
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:39:20 -0500
Date: Mon, 20 Feb 2017 09:39:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170220093914.GB2372@work-vm>
References: <0f8f3bd3-04d2-7213-2afb-ea75507eced6@linux.vnet.ibm.com>
	<be5d706e-edd8-3428-971d-59f9df5b91d1@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be5d706e-edd8-3428-971d-59f9df5b91d1@de.ibm.com>
Subject: Re: [Qemu-devel] Error handling for KVM_GET_DIRTY_LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> On 02/16/2017 03:51 PM, Janosch Frank wrote:
> > While trying to fix a bug in the s390 migration code, I noticed that
> > QEMU ignores practically all errors returned from that VM ioctl. QEMU
> > behaves as specified in the KVM api and only processes -1 (-EPERM) as an
> > error.
> > 
> > Unfortunately the documentation is wrong/old and KVM may return -EFAULT,
> > -EINVAL, -ENOTSUPP (BookE) and -ENOENT. This bugs me, as I found a case
> > where I want to return -EFAULT because of guest memory problems and QEMU
> > will still happily migrate the VM.
> > 
> > I currently don't see a reason why we continue to migrate on EFAULT and
> > EINVAL. But returning -error from kvm_physical_sync_dirty_bitmap might
> > also a bit hard, as it kills QEMU.
> > 
> > Do we want to fix this and if, how do we want it done?
> > If not we at least have a definitive mail to point to when the next one
> > comes around. I also have a KVM patch to update the api documentation if
> > wanted (maybe we should dust that off a bit anyhow).
> 
> I think we want to handle _ALL_ error of that ioctl. Instead of aborting
> QEMU we might just want to abort the migration  in that case?

Yes, I don't see any reason to kill the source guest.

> > This has been brought up in 2009 [1] the first time and was more or less
> > fixed and then reverted in 2014 [2].
> > 
> > The reason in [1] was that PPC hadn't settled yet on a valid return code.
> > 
> > In [2] it was too close to the v2 to handle it properly.
> > 
> > 
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2009-07/msg01772.html
> > 
> > [2] https://lists.nongnu.org/archive/html/qemu-devel/2014-04/msg01993.html
> 
> So back then it was just too close to 2.0 and should have been revisited for 
> 2.1. Lets now fix it for 2.9?

Yes

Dave

> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
