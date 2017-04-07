Received: from eggs.gnu.org ([2001:4830:134:3::10]:55859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cwMLy-00053s-46
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cwMLx-0003Kl-4q
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:22:34 -0400
MIME-Version: 1.0
In-Reply-To: <1491484536-22776-1-git-send-email-lidongchen@tencent.com>
References: <1491484536-22776-1-git-send-email-lidongchen@tencent.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Fri, 7 Apr 2017 13:22:31 +0800
Message-ID: <CAOGPPbdw-JEMM9MDJwQFcSJRmCn9nxqmyFF18ORcP0NdVoXLkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] use blk_pwrite_zeroes for each zero
 cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, Lidong Chen <lidongchen@tencent.com>

the test result for this patch:

the migration command :
virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
--copy-storage-all qemu+ssh://10.59.163.38/system

the qemu-img info on source host:
qemu-img info /instanceimage/165cf436-312f-47e7-90f2-f8aa63f34893/165cf436-312f-47e7-90f2-f8aa63f34893_vda.qcow2
image: /instanceimage/165cf436-312f-47e7-90f2-f8aa63f34893/165cf436-312f-47e7-90f2-f8aa63f34893_vda.qcow2
file format: qcow2
virtual size: 1.0T (1095216660480 bytes)
disk size: 1.5G (1638989824 bytes)
cluster_size: 65536
backing file: /baseimage/img2016042213665396/img2016042213665396.qcow2

the qemu-img info on dest host(before apply patch):
qemu-img info /instanceimage/165cf436-312f-47e7-90f2-f8aa63f34893/165cf436-312f-47e7-90f2-f8aa63f34893_vda.qcow2
image: /instanceimage/165cf436-312f-47e7-90f2-f8aa63f34893/165cf436-312f-47e7-90f2-f8aa63f34893_vda.qcow2
file format: qcow2
virtual size: 40G (42949672960 bytes)
disk size: 4.1G (4423286784 bytes)
cluster_size: 65536
backing file: /baseimage/img2016042213665396/img2016042213665396.qcow2

the qemu-img info on dest host(after apply patch):
qemu-img info /instanceimage/165cf436-312f-47e7-90f2-f8aa63f34893/165cf436-312f-47e7-90f2-f8aa63f34893_vda.qcow2
image: /instanceimage/165cf436-312f-47e7-90f2-f8aa63f34893/165cf436-312f-47e7-90f2-f8aa63f34893_vda.qcow2
file format: qcow2
virtual size: 40G (42949672960 bytes)
disk size: 2.3G (2496200704 bytes)
cluster_size: 65536
backing file: /baseimage/img2016042213665396/img2016042213665396.qcow2

the disk size reduce from 4.1G to 2.3G.


On Thu, Apr 6, 2017 at 9:15 PM,  <jemmy858585@gmail.com> wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>
> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
> this maybe cause the qcow2 file size is bigger after migration.
> This patch check each cluster, use blk_pwrite_zeroes for each
> zero cluster.
>
> Lidong Chen (2):
>   block: make bdrv_get_cluster_size public
>   migration/block: use blk_pwrite_zeroes for each zero cluster
>
>  block/io.c            |  2 +-
>  include/block/block.h |  1 +
>  migration/block.c     | 34 ++++++++++++++++++++++++++++++++--
>  3 files changed, 34 insertions(+), 3 deletions(-)
>
> --
> 1.8.3.1
>
