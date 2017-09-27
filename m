Received: from eggs.gnu.org ([2001:4830:134:3::10]:35067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxJML-0006Z6-To
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxJML-0003G2-43
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:55:10 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-15-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <65959795-4b92-a744-fab7-9f214ebdb13d@redhat.com>
Date: Wed, 27 Sep 2017 16:54:55 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-15-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/23] qemu-img: Speed up compare on
 pre-allocated larger file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> Compare the following images with all-zero contents:
> $ truncate --size 1M A
> $ qemu-img create -f qcow2 -o preallocation=off B 1G
> $ qemu-img create -f qcow2 -o preallocation=metadata C 1G
> 
> On my machine, the difference is noticeable for pre-patch speeds,
> with more than an order of magnitude in difference caused by the
> choice of preallocation in the qcow2 file:
> 
> $ time ./qemu-img compare -f raw -F qcow2 A B
> Warning: Image size mismatch!
> Images are identical.
> 
> real	0m0.014s
> user	0m0.007s
> sys	0m0.007s
> 
> $ time ./qemu-img compare -f raw -F qcow2 A C
> Warning: Image size mismatch!
> Images are identical.
> 
> real	0m0.341s
> user	0m0.144s
> sys	0m0.188s
> 
> Why? Because bdrv_is_allocated() returns false for image B but
> true for image C, throwing away the fact that both images know
> via lseek(SEEK_HOLE) that the entire image still reads as zero.
> From there, qemu-img ends up calling bdrv_pread() for every byte
> of the tail, instead of quickly looking for the next allocation.
> The solution: use block_status instead of is_allocated, giving:
> 
> $ time ./qemu-img compare -f raw -F qcow2 A C
> Warning: Image size mismatch!
> Images are identical.
> 
> real	0m0.014s
> user	0m0.011s
> sys	0m0.003s
> 
> which is on par with the speeds for no pre-allocation.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Makes good sense to me.

Reviewed-by: John Snow <jsnow@redhat.com>
