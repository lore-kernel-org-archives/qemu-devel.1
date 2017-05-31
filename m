Received: from eggs.gnu.org ([2001:4830:134:3::10]:60224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG93O-00021T-2O
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG93K-0000y0-TL
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dG93K-0000xY-LQ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:13:06 -0400
Date: Wed, 31 May 2017 20:12:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170531191258.GH3342@work-vm>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113128eucas1p17a89f8cb47d5731c50f94c3218ba155f@eucas1p1.samsung.com>
	<1495539071-12995-5-git-send-email-a.perevalov@samsung.com>
	<20170524023629.GD3873@pxdev.xzpeter.org>
	<20170524064548.GA12925@aperevalov-ubuntu>
	<20170524113338.GL3873@pxdev.xzpeter.org>
	<d4289a31-5661-dcfc-ca08-e7af2eb57ba1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4289a31-5661-dcfc-ca08-e7af2eb57ba1@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V6 04/10] migration: split
 ufd_version_check onto receive/request features part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: Peter Xu <peterx@redhat.com>, i.maximets@samsung.com, qemu-devel@nongnu.org

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> On 05/24/2017 02:33 PM, Peter Xu wrote:
> > On Wed, May 24, 2017 at 09:45:48AM +0300, Alexey wrote:
> > 
> > [...]
> > 
> > > > >           return false;
> > > > >       }
> > > > > -    ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
> > > > > -                 (__u64)1 << _UFFDIO_UNREGISTER;
> > > > > +    ioctl_mask = 1 << _UFFDIO_REGISTER |
> > > > > +                 1 << _UFFDIO_UNREGISTER;
> > > > Could I ask why we explicitly removed (__u64) here? Since I see the
> > > > old one better.
> > > maybe my change not robust, in any case thank to point me, but now I
> > > think, here should be a constant instead of ioctl_mask, like
> > > UFFD_API_IOCTLS, the total meaning of that check it's make sure kernel
> > > returns to us no error and accepted features.
> > > ok, from the beginning:
> > > 
> > > if we request unsupported feature (we check it before) or internal
> > > state of userfault ctx inside kernel isn't UFFD_STATE_WAIT_API (for
> > > example we are in the middle of the coping process)
> > > 	ioctl should end with EINVAL error and ioctls field in
> > > 	uffdio_api will be empty
> > > 
> > > Right now I think ioctls check for UFFD_API is not necessary.
> > > We just say here, we will use _UFFDIO_REGISTER, _UFFDIO_UNREGISTER,
> > > but kernel supports it unconditionally, by contrast with
> > > UFFDIO_REGISTER ioctl - it also returns ioctl field in uffdio_register
> > > structure, here can be a variations.
> > Sorry I didn't get the point...
> I misprinted
> >We just say here, we will use _UFFDIO_REGISTER
> 
> > s/_UFFDIO_REGISTER/_UFFDIO_API/g
> but the point, ioctl_mask is not necessary here, kernel always returns it.
> But for _UFFDIO_UNREGISTER, later, not in this function, yes that check is required.

But Peter's only point was that to build the mask it's better to keep
the (__u64) cast for safety.

Dave

> > 
> > AFAIU here (__u64) makes the constant "1" a 64bit variable. Just like
> > when we do bit shift we normally have "1ULL<<40". I liked it since
> > even if _UFFDIO_REGISTER is defined as >32 it will not overflow since
> > by default a constant "1" is a "int" typed (and it's 32bit width).
> 
> > Thanks,
> > 
> 
> -- 
> Best regards,
> Alexey Perevalov
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
