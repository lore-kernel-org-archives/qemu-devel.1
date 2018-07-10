Received: from eggs.gnu.org ([2001:4830:134:3::10]:52628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fchmo-0005vE-Dz
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fchmn-0006ZL-K5
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:49:50 -0400
Date: Tue, 10 Jul 2018 09:49:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180710014935.GF17581@lemon.usersys.redhat.com>
References: <20180709163719.87107-1-vsementsov@virtuozzo.com>
	<20180709163719.87107-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709163719.87107-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] block/io: fix copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org

On Mon, 07/09 19:37, Vladimir Sementsov-Ogievskiy wrote:
> Here two things are fixed:
> 
> 1. Architecture
> 
> On each recursion step, we go to the child of src or dst, only for one
> of them. So, it's wrong to create tracked requests for both on each
> step. It leads to tracked requests duplication.
> 
> 2. Wait for serializing requests on write path independently of
>    BDRV_REQ_NO_SERIALISING
> 
> Before commit 9ded4a01149 "backup: Use copy offloading",
> BDRV_REQ_NO_SERIALISING was used for only one case: read in
> copy-on-write operation during backup. Also, the flag was handled only
> on read path (in bdrv_co_preadv and bdrv_aligned_preadv).
> 
> After 9ded4a01149, flag is used for not waiting serializing operations
> on backup target (in same case of copy-on-write operation). This
> behavior change is unsubstantiated and potentially dangerous, let's
> drop it and add additional asserts and documentation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
