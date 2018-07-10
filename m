Received: from eggs.gnu.org ([2001:4830:134:3::10]:41291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcucW-0004Gx-Tt
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcucV-0004Lu-Ot
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:32:04 -0400
Date: Tue, 10 Jul 2018 17:31:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180710153155.GM5852@localhost.localdomain>
References: <1531235146-6048-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531235146-6048-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V5] qemu-img: align result of
 is_allocated_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 10.07.2018 um 17:05 hat Peter Lieven geschrieben:
> We currently don't enforce that the sparse segments we detect during convert are
> aligned. This leads to unnecessary and costly read-modify-write cycles either
> internally in Qemu or in the background on the storage device as nearly all
> modern filesystems or hardware have a 4k alignment internally.
> 
> This patch modifies is_allocated_sectors so that its *pnum result will always
> end at an alignment boundary. This way all requests will end at an alignment
> boundary. The start of all requests will also be aligned as long as the results
> of get_block_status do not lead to an unaligned offset.
> 
> The number of RMW cycles when converting an example image [1] to a raw device that
> has 4k sector size is about 4600 4k read requests to perform a total of about 15000
> write requests. With this path the additional 4600 read requests are eliminated while
> the number of total write requests stays constant.
> 
> [1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.vmdk
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>

It looked convincing, but I'm afraid this is still not correct.
qemu-iotests 122 fails for me with this patch.

Kevin
