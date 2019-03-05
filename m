Received: from eggs.gnu.org ([209.51.188.92]:36122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1C83-00049m-U0
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1C81-0004qY-6U
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:37:15 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190213164853.32412-1-berto@igalia.com>
References: <20190213164853.32412-1-berto@igalia.com>
Date: Tue, 05 Mar 2019 16:36:42 +0100
Message-ID: <w514l8hcoz9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qcow2: Default to 4KB for the qcow2 cache
 entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

On Wed 13 Feb 2019 05:48:53 PM CET, Alberto Garcia wrote:
> QEMU 2.12 (commit 1221fe6f636754ab5f2c1c87caa77633e9123622) introduced
> a new setting called l2-cache-entry-size that allows making entries on
> the qcow2 L2 cache smaller than the cluster size.
>
> I have been performing several tests with different cluster and entry
> sizes and all of them show that reducing the entry size (aka L2 slice)
> consistently improves I/O performance, notably during random I/O (all
> tests done with sequential I/O show similar results). This is to be
> expected because loading and evicting an L2 slice is more expensive
> the larger the slice is.
>
> Here are some numbers on fully populated 40GB qcow2 images. The
> rightmost column represents the maximum L2 cache size in both cases.
>
>    Cluster size = 64 KB
>    |-------------+--------------+--------------+--------------|
>    |             | 1MB L2 cache | 3MB L2 cache | 5MB L2 cache |
>    |-------------+--------------+--------------+--------------|
>    |  4KB slices |    6545 IOPS |   12045 IOPS |   55680 IOPS |
>    | 16KB slices |    5177 IOPS |    9798 IOPS |   56278 IOPS |
>    | 64KB slices |    2718 IOPS |    5326 IOPS |   57355 IOPS |
>    |-------------+--------------+--------------+--------------|
>
>    Cluster size = 256 KB
>    |--------------+----------------+--------------+-----------------|
>    |              | 512KB L2 cache | 1MB L2 cache | 1280KB L2 cache |
>    |--------------+----------------+--------------+-----------------|
>    |   4KB slices |      8539 IOPS |   21071 IOPS |      55417 IOPS |
>    |  64KB slices |      3598 IOPS |    9772 IOPS |      57687 IOPS |
>    | 256KB slices |      1415 IOPS |    4120 IOPS |      58001 IOPS |
>    |--------------+----------------+--------------+-----------------|
>
> As can be seen in the numbers, the only exception to the rule is when
> the cache is large enough to hold all L2 tables. This is also to be
> expected because in this case no cache entry is ever evicted so
> reducing its size doesn't bring any benefit.
>
> This patch sets the default L2 cache entry size to 4KB except when the
> cache is large enough for the whole disk.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
