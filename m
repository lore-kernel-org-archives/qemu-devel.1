Received: from eggs.gnu.org ([2001:4830:134:3::10]:53729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dig1G-0003qc-Tx
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dig1G-0001tt-49
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:04:54 -0400
Date: Fri, 18 Aug 2017 20:04:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170818120420.GC15392@lemon>
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
	<1493916761-32319-6-git-send-email-kwolf@redhat.com>
	<849a6489-11f5-73c0-a7a8-400c58f995a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849a6489-11f5-73c0-a7a8-400c58f995a4@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] block: Fix write/resize permissions
 for inactive images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xie Changlong <xiechanglong.d@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Zhang Hailiang <zhang.zhanghailiang@huawei.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, qemu-devel@nongnu.org

On Fri, 08/18 18:06, Xie Changlong wrote:
> The root casue is when we run replication in secondary, vmstate changes to
> RUN_STATE_INMIGRATE, then blockdev_init() sets bdrv_flags |=
> BDRV_O_INACTIVE. So the whole chain become readonly. I've tried on my side,
> but it seems not easy to fix it. I wonder if there is any way to bypass
> this? Any suggestion would be appreciated.

The non-shared storage migration uses "nbd_server_add -w" at destinition side
where BDRV_O_INACTIVE is set for images like your case, the way it handles it is
by calling bdrv_invalidate_cache(). See nbd_export_new().

See also commit 3dff24f2dffc5f3aa46dc014122012848bd7959d.

I'm not sure if this is enough for block replication?

Fam
