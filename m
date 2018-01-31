Received: from eggs.gnu.org ([2001:4830:134:3::10]:50459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egvH6-0000wd-5R
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egvH1-0006OC-F2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:30:16 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:42212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egvH1-0006LO-4d
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:30:11 -0500
Received: from player778.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 211F3AC8A9
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 17:30:08 +0100 (CET)
Date: Wed, 31 Jan 2018 17:30:06 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180131173006.2597a490@bahia.lan>
In-Reply-To: <CAFEAcA-q3K-6zVVjU3gxKjd6a4kYd0RLfVLfMhPgwskY=qb-hg@mail.gmail.com>
References: <20180130173935.5172-1-groug@kaod.org>
	<CAFEAcA-q3K-6zVVjU3gxKjd6a4kYd0RLfVLfMhPgwskY=qb-hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/10] 9p patches for 2.12 20180130
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 31 Jan 2018 10:14:46 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 30 January 2018 at 17:39, Greg Kurz <groug@kaod.org> wrote:
> > The following changes since commit 30d9fefe1aca1e92c785214aa9201fd7c2287d56:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/input-20180129-v2-pull-request' into staging (2018-01-29 15:52:27 +0000)
> >
> > are available in the git repository at:
> >
> >   https://github.com/gkurz/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 0dfef72861261bdfd30f2cc53d61c12c097af11a:
> >
> >   tests/virtio-9p: explicitly handle potential integer overflows (2018-01-30 15:28:56 +0100)
> >
> > ----------------------------------------------------------------
> > This series is mostly about 9p request cancellation. It fixes a
> > long standing bug (read "specification violation") where the server
> > would send an invalid response when the client has cancelled an
> > in-flight request. This was causing annoying spurious EINTR returns
> > in linux. The fix comes with some related testing in QTEST.
> >
> > Other patches are code cleanup and improvements.
> >
> > ----------------------------------------------------------------
> > Greg Kurz (9):
> >       9pfs: drop v9fs_register_transport()
> >       tests: virtio-9p: move request tag to the test functions
> >       tests: virtio-9p: wait for completion in the test code
> >       tests: virtio-9p: use the synth backend
> >       tests: virtio-9p: add LOPEN operation test
> >       tests: virtio-9p: add WRITE operation test
> >       libqos/virtio: return length written into used descriptor
> >       tests: virtio-9p: add FLUSH operation test
> >       tests/virtio-9p: explicitly handle potential integer overflows
> >
> > Keno Fischer (1):
> >       9pfs: Correctly handle cancelled requests  
> 
> Hi. This fails 'make check' on sparc hosts:
> 
> TEST: tests/virtio-9p-test... (pid=21410)
>   /ppc64/virtio/9p/pci/nop:                                            OK
>   /ppc64/virtio/9p/pci/config:                                         OK
>   /ppc64/virtio/9p/pci/fs/version/basic:                               OK
>   /ppc64/virtio/9p/pci/fs/attach/basic:                                OK
>   /ppc64/virtio/9p/pci/fs/walk/basic:                                  OK
>   /ppc64/virtio/9p/pci/fs/walk/no_slash:                               OK
>   /ppc64/virtio/9p/pci/fs/walk/dotdot_from_root:                       OK
>   /ppc64/virtio/9p/pci/fs/lopen/basic:                                 OK
>   /ppc64/virtio/9p/pci/fs/write/basic:                                 OK
>   /ppc64/virtio/9p/pci/fs/flush/success:
> Broken pipe
> FAIL
> GTester: last random seed: R02S3152e3829aa0155ecb8ed934af62a54f
> (pid=21546)
>   /ppc64/virtio/9p/pci/fs/flush/ignored:
> Broken pipe
> FAIL
> GTester: last random seed: R02Sd8d854ef25a0afc00dfe43cdab8f8bc7
> (pid=21552)
> FAIL: tests/virtio-9p-test
> 
> On x86 with the clang runtime sanitizer it gives errors about
> misaligned loads:
> 
> /home/petmay01/linaro/qemu-for-merges/hw/9pfs/9p-synth.c:531:15:
> runtime error: member access within misaligned address 0x7fb933502017
> for type 'QtestV9fsSynthFlushData', which requires 4 byte alignment
> 0x7fb933502017: note: pointer points here
>  04 00 00 00 0a  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
> 00 00 00 00 00 00 00  00 00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/9pfs/9p-synth.c:531:15:
> runtime error: load of misaligned address 0x7fb933502017 for type
> 'uint32_t' (aka 'unsigned int'), which requires 4 byte alignment
> 0x7fb933502017: note: pointer points here
>  04 00 00 00 0a  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
> 00 00 00 00 00 00 00  00 00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/9pfs/9p-synth.c:532:22:
> runtime error: member access within misaligned address 0x7fb933502017
> for type 'QtestV9fsSynthFlushData', which requires 4 byte alignment
> 0x7fb933502017: note: pointer points here
>  04 00 00 00 0a  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
> 00 00 00 00 00 00 00  00 00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/9pfs/9p-synth.c:532:22:
> runtime error: load of misaligned address 0x7fb933502017 for type
> 'uint32_t' (aka 'unsigned int'), which requires 4 byte alignment
> 0x7fb933502017: note: pointer points here
>  04 00 00 00 0a  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
> 00 00 00 00 00 00 00  00 00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/9pfs/9p-synth.c:531:15:
> runtime error: member access within misaligned address 0x7f33bb102017
> for type 'QtestV9fsSynthFlushData', which requires 4 byte alignment
> 0x7f33bb102017: note: pointer points here
>  04 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
> 00 00 00 00 00 00 00  00 00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/9pfs/9p-synth.c:531:15:
> runtime error: load of misaligned address 0x7f33bb102017 for type
> 'uint32_t' (aka 'unsigned int'), which requires 4 byte alignment
> 0x7f33bb102017: note: pointer points here
>  04 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
> 00 00 00 00 00 00 00  00 00 00
>              ^
> 
> which is probably what is causing the sparc failure.
> 
> This code looks suspicious:
> 
> static ssize_t v9fs_synth_qtest_flush_write(void *buf, int len, off_t offset,
>                                             void *arg)
> {
>     QtestV9fsSynthFlushData *data = buf;
> 
>     assert(len == sizeof(*data));
> 
>     if (data->usec_timeout) {
> 
> as you can't in general cast an arbitrary pointer into a
> structure and use it like that.
> 

... which is likely to happen if it points to some data coming from
a QTEST originated stream of bytes... :-\

> Given that the only thing in the data stream is a 32-bit value,
> it would be simpler just to say
>   uint32_t usec_timeout = ldl_XX_p(buf);
> 

Well, at the present time there's only a 32-bit value but this
may change. So I'd prefer to copy the bytes into an aligned
structure.

> I put 'XX' there because the other thing that looks weird here
> is the handling of endianness. The code as written is doing
> a "load a host-order 32-bit value", which would be ldl_he_p().
> But should a buffer in the 9pfs code really have anything
> in host-order rather than a fixed-by-protocol order?
> Using ldl_le_p() or ldl_be_p() seems more plausible. (Whatever
> code is generating this byte stream might also need attention.)
> 

The code at the other end is test code in QTEST, the goal of
which is to simulate a blocking 9P "write" request. Is it safe
to assume that this test code does "host-order" stores ?

> thanks
> -- PMM
