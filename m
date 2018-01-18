Received: from eggs.gnu.org ([2001:4830:134:3::10]:55172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecFtc-0000rw-46
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecFtX-0004sF-8I
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:30:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecFtW-0004rd-Vz
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:30:39 -0500
Date: Thu, 18 Jan 2018 21:30:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180118213022-mutt-send-email-mst@kernel.org>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
	<CAFEAcA-En6Pqo=bjOrDMfkNmnN5UR-7S=b45Vu6P34Ag4jdMEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-En6Pqo=bjOrDMfkNmnN5UR-7S=b45Vu6P34Ag4jdMEQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/34] pc, pci, virtio: features, fixes,
 cleanups
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

On Thu, Jan 18, 2018 at 10:09:09AM +0000, Peter Maydell wrote:
> On 16 January 2018 at 17:46, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Changes from v1:
> >     32 build fix
> >     vhost-user-blk build fix
> >     s390 qom fix
> >     include mem slot limit fix
> >
> > The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:
> >
> >   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 1d9dc60062ae05375c080bbe2db5a5c3c4f495bc:
> >
> >   vhost: used_memslots refactoring (2018-01-16 18:52:03 +0200)
> >
> > ----------------------------------------------------------------
> > pc, pci, virtio: features, fixes, cleanups
> >
> > A bunch of fixes, cleanus and new features all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi -- this pullreq triggers a lot of alignment warnings for vhost
> in the clang runtime sanitizer:

Are these build or make check errors?

> /home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:325:22:
> runtime error: member access within misaligned address 0x7fff9c7bdf1c
> for type 'VhostUserMemory' (aka
>  'struct VhostUserMemory'), which requires 8 byte alignment
> 0x7fff9c7bdf1c: note: pointer points here
>   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  85 54 c8 a8 5c 55
> 00 00  01 cf 9f ac 5c 55 00 00
>               ^
> /home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:325:22:
> runtime error: store to misaligned address 0x7fff9c7bdf1c for type
> 'uint32_t' (aka 'unsigned int'), w
> hich requires 8 byte alignment
> 0x7fff9c7bdf1c: note: pointer points here
>   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  85 54 c8 a8 5c 55
> 00 00  01 cf 9f ac 5c 55 00 00
>               ^
> /home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:335:22:
> runtime error: member access within misaligned address 0x7fff9c7bdf1c
> for type 'VhostUserMemory' (aka
>  'struct VhostUserMemory'), which requires 8 byte alignment
> 0x7fff9c7bdf1c: note: pointer points here
>   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  85 54 c8 a8 5c 55
> 00 00  01 cf 9f ac 5c 55 00 00
>               ^
> /home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:335:22:
> runtime error: load of misaligned address 0x7fff9c7bdf1c for type
> 'uint32_t' (aka 'unsigned int'), wh
> ich requires 8 byte alignment
> 0x7fff9c7bdf1c: note: pointer points here
>   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  85 54 c8 a8 5c 55
> 00 00  01 cf 9f ac 5c 55 00 00
>               ^
> 
> (and more)
> 
> thanks
> -- PMM
