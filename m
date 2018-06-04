Received: from eggs.gnu.org ([2001:4830:134:3::10]:39683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fPugQ-0000Ra-KA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fPugP-0008V4-M1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:58:22 -0400
References: <20180604141437.22758-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b962bc23-039a-7653-e180-749e3085121c@redhat.com>
Date: Mon, 4 Jun 2018 14:58:15 -0400
MIME-Version: 1.0
In-Reply-To: <20180604141437.22758-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qcow2: Do not mark
 inactive images corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org



On 06/04/2018 10:14 AM, Max Reitz wrote:
> The non-public logs in
> https://bugzilla.redhat.com/show_bug.cgi?id=1583346 (sorry...) reveal
> this problem:
> 
> $ (Create a qcow2 file "foo.qcow2" with a corrupted first L1 entry)
> $ echo 'qemu-io none0 "read 0 512"' \
>     | x86_64-softmmu/qemu-system-x86_64 -drive if=none,file=foo.qcow2 \
>                                         -monitor stdio \
>                                         -incoming exec:'cat /dev/null'
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) qemu-io none0 "read 0 512"
> qcow2: Marking image as corrupt: L2 table offset 0x44200 unaligned (L1 index: 0); further corruption events will be suppressed
> qemu-system-x86_64: block/io.c:1691: bdrv_co_pwritev: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
> [1]    18444 done                 echo 'qemu-io none0 "read 0 512"' | 
>        18445 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -drive if=none,file=foo.qcow2 -monitor stdi
> 
> Oops.
> 
> 
> The first patch in this series fixes this by treating inactive images
> like read-only images in this regard (which most importantly means not
> trying to set the corrupt flag on them), the second one adds an iotest
> case.
> 
> 
> Max Reitz (2):
>   qcow2: Do not mark inactive images corrupt
>   iotests: Add case for a corrupted inactive image
> 
>  block/qcow2.c              |  4 +++-
>  tests/qemu-iotests/060     | 30 ++++++++++++++++++++++++++++++
>  tests/qemu-iotests/060.out | 14 ++++++++++++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 

Makes sense to me, provided it's safe to check via BDRV_O_RDWR instead
of bs->read_only. (I assume it is.)

Reviewed-by: John Snow <jsnow@redhat.com>
