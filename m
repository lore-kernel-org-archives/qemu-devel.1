Received: from eggs.gnu.org ([2001:4830:134:3::10]:50283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr887-0002vY-9A
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr886-0002Lk-Bj
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:10:39 -0400
Date: Thu, 23 Mar 2017 20:10:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170323191025.GG5344@noname.redhat.com>
References: <1489233245-27057-1-git-send-email-ashijeetacharya@gmail.com>
	<1489233245-27057-2-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489233245-27057-2-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vmdk: Optimize I/O by allocating
 multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: famz@redhat.com, jsnow@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 11.03.2017 um 12:54 hat Ashijeet Acharya geschrieben:
> The vmdk driver in block/vmdk.c used to allocate cluster by cluster
> which slowed down its I/O performance.
> 
> Make vmdk driver allocate multiple clusters at once to reduce the
> overhead costs of multiple separate cluster allocation calls. The number
> of clusters allocated at once depends on the L2 table boundaries. Also
> the first and the last clusters are allocated separately as we may need
> to perform COW for them
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Ashijeet, this is pretty hard to review because you're doing too many
things in a single patch. The rule is to do only one logical change in
each patch whenever it's possible. In particular, pure code motion (or
renames) need to be separated from code modification because when you
move code and modify it at the same time, it is very hard to see the
actual difference.

Do you think you could split this into multiple patches, like this:

1. Move vmdk_find_offset_in_cluster() to the top
2. Rename get_whole_cluster() to do_alloc_cluster_offset()
   (To be honest, both names aren't great. Something like qcow2's
   perform_cow() would describe better what's going on there.)
3. Factor out some code from get_cluster_offset() into handle_alloc()
4. Rename get_cluster_offset() into vmdk_get_cluster_offset()
...
n. Handle multiple clusters at once

Obviously, I haven't taken the time to fully read and understand all of
your patch, so don't take this too literally, but you see what kind of
granularity the individual patches should be. If you do it like this,
each change becomes really simple and can be reviewed and discussed on
its own. And if we later find a bug in VMDK, git bisect can point out
exactly which step introduced the problem rather than pointing at a
single big commit that is hard to understand.

Good splitting of patches is one of the tricks to get quicker reviews.
Admittedly, it is often not easy, but it is worth spending some thought
on how to make a series really easy to read for others.

Kevin
