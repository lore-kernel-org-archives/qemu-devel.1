Received: from eggs.gnu.org ([2001:4830:134:3::10]:50077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewsH8-0006nS-Jf
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewsH6-00064Z-U9
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:32:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewsH6-000644-Lu
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:32:12 -0400
Received: by mail-ot0-x243.google.com with SMTP id q5-v6so289454oth.12
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:32:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520977432-187679-1-git-send-email-mst@redhat.com>
References: <1520977432-187679-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 16:31:49 +0000
Message-ID: <CAFEAcA-rdopYd4crVJyhVAFKSwAzSTNt66UZg417L3dhLigKgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, vhost, pci, pc: features,
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

On 13 March 2018 at 21:45, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 8750b78fcfcb6f49bf037242624953195ada69a8:
>
>   test/acpi-test-data: add ACPI tables for dimmpxm test (2018-03-13 23:09:51 +0200)
>
> ----------------------------------------------------------------
> virtio,vhost,pci,pc: features, cleanups
>
> SRAT tables for DIMM devices
> new virtio net flags for speed/duplex
> cleanups in pci and vhost
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi. I'm afraid this triggers a lot of clang runtime sanitizer warnings
about misaligned accesses:

TEST: tests/vhost-user-test... (pid=1391)
  /i386/vhost-user/read-guest-mem:
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:341:22:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 c9 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:341:22:
runtime error: store to misaligned address 0x7ffdfe94ab34 for type
'uint32_t' (aka 'unsigned int'), which requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 c9 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:351:22:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 c9 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:351:22:
runtime error: load of misaligned address 0x7ffdfe94ab34 for type
'uint32_t' (aka 'unsigned int'), which requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 c9 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:356:31:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 c9 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:356:31:
runtime error: load of misaligned address 0x7ffdfe94ab34 for type
'uint32_t' (aka 'unsigned int'), which requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 c9 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:356:18:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 c9 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:356:13:
runtime error: member access within misaligned address 0x7ffdfe94ab3c
for type 'VhostUserMemoryRegion' (aka 'struct VhostUserMemoryRegion'),
which requires 8 byte alignment
0x7ffdfe94ab3c: note: pointer points here
  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00 00 00  01 93 a3 c7 c9 55
00 00  d0 ad 94 fe fd 7f 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:356:41:
runtime error: store to misaligned address 0x7ffdfe94ab4c for type
'uint64_t' (aka 'unsigned long'), which requires 8 byte alignment
0x7ffdfe94ab4c: note: pointer points here
  01 93 a3 c7 c9 55 00 00  d0 ad 94 fe fd 7f 00 00  84 61 36 40 20 7f
00 00  40 5a ab c7 c9 55 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:357:31:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:357:31:
runtime error: load of misaligned address 0x7ffdfe94ab34 for type
'uint32_t' (aka 'unsigned int'), which requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:357:18:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 00  01 93 a3 c7 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:357:13:
runtime error: member access within misaligned address 0x7ffdfe94ab3c
for type 'VhostUserMemoryRegion' (aka 'struct VhostUserMemoryRegion'),
which requires 8 byte alignment
0x7ffdfe94ab3c: note: pointer points here
  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00 00 00  01 93 a3 c7 00 90
05 11  20 7f 00 00 fd 7f 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:357:41:
runtime error: store to misaligned address 0x7ffdfe94ab44 for type
'uint64_t' (aka 'unsigned long'), which requires 8 byte alignment
0x7ffdfe94ab44: note: pointer points here
  40 00 00 00 00 00 00 00  01 93 a3 c7 00 90 05 11  20 7f 00 00 fd 7f
00 00  84 61 36 40 20 7f 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:358:31:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 20  00 00 00 00 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:358:31:
runtime error: load of misaligned address 0x7ffdfe94ab34 for type
'uint32_t' (aka 'unsigned int'), which requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 20  00 00 00 00 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:358:18:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00
00 20  00 00 00 00 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:358:13:
runtime error: member access within misaligned address 0x7ffdfe94ab3c
for type 'VhostUserMemoryRegion' (aka 'struct VhostUserMemoryRegion'),
which requires 8 byte alignment
0x7ffdfe94ab3c: note: pointer points here
  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00 00 20  00 00 00 00 00 90
05 11  20 7f 00 00 fd 7f 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:358:41:
runtime error: store to misaligned address 0x7ffdfe94ab3c for type
'uint64_t' (aka 'unsigned long'), which requires 8 byte alignment
0x7ffdfe94ab3c: note: pointer points here
  d0 94 a3 c7 c9 55 00 00  40 00 00 00 00 00 00 20  00 00 00 00 00 90
05 11  20 7f 00 00 fd 7f 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:359:31:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 00 00 00 00  00 00 00 00 00 00
00 20  00 00 00 00 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:359:31:
runtime error: load of misaligned address 0x7ffdfe94ab34 for type
'uint32_t' (aka 'unsigned int'), which requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 00 00 00 00  00 00 00 00 00 00
00 20  00 00 00 00 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:359:18:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 00 00 00 00  00 00 00 00 00 00
00 20  00 00 00 00 00 90 05 11
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:359:13:
runtime error: member access within misaligned address 0x7ffdfe94ab3c
for type 'VhostUserMemoryRegion' (aka 'struct VhostUserMemoryRegion'),
which requires 8 byte alignment
0x7ffdfe94ab3c: note: pointer points here
  d0 94 a3 c7 00 00 00 00  00 00 00 00 00 00 00 20  00 00 00 00 00 90
05 11  20 7f 00 00 fd 7f 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:359:41:
runtime error: store to misaligned address 0x7ffdfe94ab54 for type
'uint64_t' (aka 'unsigned long'), which requires 8 byte alignment
0x7ffdfe94ab54: note: pointer points here
  20 7f 00 00 fd 7f 00 00  84 61 36 40 20 7f 00 00  40 5a ab c7 c9 55
00 00  00 00 00 00 00 00 00 00
              ^
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:360:22:
runtime error: member access within misaligned address 0x7ffdfe94ab34
for type 'VhostUserMemory' (aka 'struct VhostUserMemory'), which
requires 8 byte alignment
0x7ffdfe94ab34: note: pointer points here
  40 00 00 00 00 00 00 00  d0 94 a3 c7 00 00 00 00  00 00 00 00 00 00
00 20  00 00 00 00 00 90 05 11
              ^
OK

and similarly for /i386/vhost-user/migrate and for the x86-64 versions
of the tests.

thanks
-- PMM
