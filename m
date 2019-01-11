Received: from eggs.gnu.org ([209.51.188.92]:48252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghuFt-0006Ku-Nf
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghuFs-00087j-UL
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:41:37 -0500
Date: Fri, 11 Jan 2019 11:41:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111104126.GC5010@dhcp-200-186.str.redhat.com>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110132048.49451-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org

Am 10.01.2019 um 14:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> drv_co_block_status digs bs->file for additional, more accurate search
> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
> 
> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> knows, where are holes and where is data. But every block_status
> request calls lseek additionally. Assume a big disk, full of
> data, in any iterative copying block job (or img convert) we'll call
> lseek(HOLE) on every iteration, and each of these lseeks will have to
> iterate through all metadata up to the end of file. It's obviously
> ineffective behavior. And for many scenarios we don't need this lseek
> at all.
> 
> So, let's "5daa74a6ebc" by default, leaving an option to return
> previous behavior, which is needed for scenarios with preallocated
> images.
> 
> Add iotest illustrating new option semantics.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I still think that an option isn't a good solution and we should try use
some heuristics instead.

Kevin
