Received: from eggs.gnu.org ([2001:4830:134:3::10]:57011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec78V-0003J8-8o
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec78U-00057Y-CD
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:09:31 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ec78U-00056g-6a
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:09:30 -0500
Received: by mail-oi0-x243.google.com with SMTP id d124so15285775oib.13
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 02:09:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 10:09:09 +0000
Message-ID: <CAFEAcA-En6Pqo=bjOrDMfkNmnN5UR-7S=b45Vu6P34Ag4jdMEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 January 2018 at 17:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Changes from v1:
>     32 build fix
>     vhost-user-blk build fix
>     s390 qom fix
>     include mem slot limit fix
>
> The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 1d9dc60062ae05375c080bbe2db5a5c3c4f495bc:
>
>   vhost: used_memslots refactoring (2018-01-16 18:52:03 +0200)
>
> ----------------------------------------------------------------
> pc, pci, virtio: features, fixes, cleanups
>
> A bunch of fixes, cleanus and new features all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi -- this pullreq triggers a lot of alignment warnings for vhost
in the clang runtime sanitizer:

/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:325:22:
runtime error: member access within misaligned address 0x7fff9c7bdf1c
for type 'VhostUserMemory' (aka
 'struct VhostUserMemory'), which requires 8 byte alignment
0x7fff9c7bdf1c: note: pointer points here
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  85 54 c8 a8 5c 55
00 00  01 cf 9f ac 5c 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:325:22:
runtime error: store to misaligned address 0x7fff9c7bdf1c for type
'uint32_t' (aka 'unsigned int'), w
hich requires 8 byte alignment
0x7fff9c7bdf1c: note: pointer points here
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  85 54 c8 a8 5c 55
00 00  01 cf 9f ac 5c 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:335:22:
runtime error: member access within misaligned address 0x7fff9c7bdf1c
for type 'VhostUserMemory' (aka
 'struct VhostUserMemory'), which requires 8 byte alignment
0x7fff9c7bdf1c: note: pointer points here
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  85 54 c8 a8 5c 55
00 00  01 cf 9f ac 5c 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:335:22:
runtime error: load of misaligned address 0x7fff9c7bdf1c for type
'uint32_t' (aka 'unsigned int'), wh
ich requires 8 byte alignment
0x7fff9c7bdf1c: note: pointer points here
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  85 54 c8 a8 5c 55
00 00  01 cf 9f ac 5c 55 00 00
              ^

(and more)

thanks
-- PMM
