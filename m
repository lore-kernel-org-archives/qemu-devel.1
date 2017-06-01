Received: from eggs.gnu.org ([2001:4830:134:3::10]:38452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGN0m-0008JQ-GZ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGN0j-0007WP-Cz
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGN0j-0007W5-6r
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:07:21 -0400
Date: Thu, 1 Jun 2017 11:07:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170601100713.GD2083@work-vm>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113131eucas1p24a041de6004237e437f97a24340507e2@eucas1p2.samsung.com>
	<1495539071-12995-9-git-send-email-a.perevalov@samsung.com>
	<20170524075305.GG3873@pxdev.xzpeter.org>
	<20170524093720.GC12925@aperevalov-ubuntu>
	<20170524112220.GJ3873@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524112220.GJ3873@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH V6 08/10] migration: calculate vCPU
 blocktime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Alexey <a.perevalov@samsung.com>, i.maximets@samsung.com, qemu-devel@nongnu.org

* Peter Xu (peterx@redhat.com) wrote:

> > > Why use *__nocheck() rather than atomic_xchg() or even atomic_read()?
> > > Same thing happened a lot in current patch.
> > atomic_read/atomic_xchg for mingw/(gcc on arm32) has build time check,
> > 
> > QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *));
> > 
> > it prevents using 64 atomic operation on 32 architecture, just mingw I
> > think, but postcopy-ram.c isn't compiling for mingw.
> > On other 32 platforms as I know clang/gcc allow to use 8 bytes
> > long variables in built atomic operations. In arm32 it allows in
> > builtin. But QEMU on arm32 still
> > has that sanity check, and I think it's bug, so I just worked it around.
> > Maybe better was to fix it.
> > 
> > I tested in docker, using follow command:
> > make docker-test-build@debian-armhf-cross
> > 
> > And got following error
> > 
> > /tmp/qemu-test/src/migration/postcopy-ram.c: In function
> > 'mark_postcopy_blocktime_begin':
> > /tmp/qemu-test/src/include/qemu/compiler.h:86:30: error: static
> > assertion failed: "not expecting: sizeof(*&dc->vcpu_addr[cpu]) >
> > sizeof(void *)"
> >  #define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x)
> > 
> > when I used atomic_xchg,
> > I agree with you, but I think need to fix atomic.h firstly and add additional
> > #ifdef there.
> > 
> > And I didn't want to split 64 bit values onto 32 bit values, but I saw
> > in mailing list people are doing it.
> 
> If this is a bug, then I guess the best way is to fix it. But before
> that - can a 32bit system really do 64bit atomic ops? Is it really a
> bug at all?

Some can, but not all.
ARM has 'ldrexd' for 64bit atomics; but I can't remember which subset
of ARMs has it; I think most recent stuff.
I don't think you can guarantee it's on all architectures though, but it
might be on any we care about.

Dave

> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
