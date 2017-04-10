Received: from eggs.gnu.org ([2001:4830:134:3::10]:40509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxOez-0003su-9b
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 22:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxOey-00075a-2z
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 22:02:29 -0400
MIME-Version: 1.0
In-Reply-To: <20170410014736.GC15038@lemon>
References: <1491554685-1288-1-git-send-email-lidongchen@tencent.com>
	<20170407101038.GB16233@lemon>
	<CAOGPPbcLi5vdOEd9ph2-3=b6pezdZ1JAoUgvFf-6Ka-EDqD+vw@mail.gmail.com>
	<CAOGPPbdA9mBXb8pSmYFuSR-MGU--=nbxJCBpJ4EJc-p50dCAtw@mail.gmail.com>
	<20170410014736.GC15038@lemon>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 10 Apr 2017 10:02:23 +0800
Message-ID: <CAOGPPbfhOb81ncmu72gn84b1uj51Nx=Tf_0bim5yzUDu4_7zyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Mon, Apr 10, 2017 at 9:47 AM, Fam Zheng <famz@redhat.com> wrote:
> On Sat, 04/08 21:29, 858585 jemmy wrote:
>> On Sat, Apr 8, 2017 at 12:52 PM, 858585 jemmy <jemmy858585@gmail.com> wrote:
>> > On Fri, Apr 7, 2017 at 6:10 PM, Fam Zheng <famz@redhat.com> wrote:
>> >> On Fri, 04/07 16:44, jemmy858585@gmail.com wrote:
>> >>> From: Lidong Chen <lidongchen@tencent.com>
>> >>>
>> >>> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
>> >>> this maybe cause the qcow2 file size is bigger after migration.
>> >>> This patch check each cluster, use blk_pwrite_zeroes for each
>> >>> zero cluster.
>> >>>
>> >>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> >>> ---
>> >>>  migration/block.c | 37 +++++++++++++++++++++++++++++++++++--
>> >>>  1 file changed, 35 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/migration/block.c b/migration/block.c
>> >>> index 7734ff7..c32e046 100644
>> >>> --- a/migration/block.c
>> >>> +++ b/migration/block.c
>> >>> @@ -885,6 +885,11 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>> >>>      int64_t total_sectors = 0;
>> >>>      int nr_sectors;
>> >>>      int ret;
>> >>> +    int i;
>> >>> +    int64_t addr_offset;
>> >>> +    uint8_t *buf_offset;
>> >>
>> >> Poor variable names, they are not offset, maybe "cur_addr" and "cur_buf"? And
>> >> they can be moved to the loop block below.
>> > ok, i will change.
>> >
>> >>
>> >>> +    BlockDriverInfo bdi;
>> >>> +    int cluster_size;
>> >>>
>> >>>      do {
>> >>>          addr = qemu_get_be64(f);
>> >>> @@ -934,8 +939,36 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>> >>>              } else {
>> >>>                  buf = g_malloc(BLOCK_SIZE);
>> >>>                  qemu_get_buffer(f, buf, BLOCK_SIZE);
>> >>> -                ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
>> >>> -                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
>> >>> +
>> >>> +                ret = bdrv_get_info(blk_bs(blk), &bdi);
>> >>> +                cluster_size = bdi.cluster_size;
>> >>> +
>> >>> +                if (ret == 0 && cluster_size > 0 &&
>> >>> +                    cluster_size < BLOCK_SIZE &&
>> >>
>> >> I think cluster_size == BLOCK_SIZE should work too.
>> > This case the (flags & BLK_MIG_FLAG_ZERO_BLOCK) should be true,
>> > and will invoke blk_pwrite_zeroes before apply this patch.
>> > but maybe the source qemu maybe not enabled zero flag.
>> > so i think cluster_size <= BLOCK_SIZE is ok.
>> >
>> >>
>> >>> +                    BLOCK_SIZE % cluster_size == 0) {
>> >>> +                    for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
>> >>> +                        addr_offset = addr * BDRV_SECTOR_SIZE
>> >>> +                                        + i * cluster_size;
>> >>> +                        buf_offset = buf + i * cluster_size;
>> >>> +
>> >>> +                        if (buffer_is_zero(buf_offset, cluster_size)) {
>> >>> +                            ret = blk_pwrite_zeroes(blk, addr_offset,
>> >>> +                                                    cluster_size,
>> >>> +                                                    BDRV_REQ_MAY_UNMAP);
>> >>> +                        } else {
>> >>> +                             ret = blk_pwrite(blk, addr_offset, buf_offset,
>> >>> +                                              cluster_size, 0);
>> >>> +                        }
>> >>> +
>> >>> +                        if (ret < 0) {
>> >>> +                            g_free(buf);
>> >>> +                            return ret;
>> >>> +                        }
>> >>> +                    }
>> >>> +                } else {
>> >>> +                    ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
>> >>> +                                     nr_sectors * BDRV_SECTOR_SIZE, 0);
>> >>> +                }
>> >>>                  g_free(buf);
>> >>>              }
>> >>>
>> >>> --
>> >>> 1.8.3.1
>> >>>
>> >>
>> >> Is it possible use (source) cluster size as the transfer chunk size, instead of
>> >> BDRV_SECTORS_PER_DIRTY_CHUNK? Then the existing BLK_MIG_FLAG_ZERO_BLOCK logic
>> >> can help and you don't need to send zero bytes on the wire. This may still not
>> >> be optimal if dest has larger cluster, but it should cover the common use case
>> >> well.
>> >
>> > yes, i also think BDRV_SECTORS_PER_DIRTY_CHUNK is too large.
>> > This have two disadvantage:
>> > 1. it will cause the dest qcow2 file size is bigger after migration.
>> > 2. it will cause transfer not necessary data, and maybe cause the
>> > migration can't be successful.
>> >
>> > in my production environment, some vm only write 2MB/s, the dirty
>> > block migrate speed is 70MB/s.
>> > but it still migration timeout.
>> >
>> > but if we change the size of BDRV_SECTORS_PER_DIRTY_CHUNK, it will
>> > break the protocol.
>> > the old version qemu will not be able to migrate to new version qemu.
>> > there are not information about the length about the migration buffer.
>> >
>> > so i think we should add new flags to indicate that there are an
>> > additional byte about the length
>> > of migration buffer. i will send another patch later, and test the result.
>>
>> Hi Fam:
>> Do we need consider the circumstances than migrate from new qemu version
>> to old qemu version?
>
> Yes, usually we use a subsection to achieve that - missing the "chunk size"
> field should result in using the old BDRV_SECTORS_PER_DIRTY_CHUNK value.

ok, i will develop a prototype firstly, and send out the performance
test result later.

>
> Fam
>
>>
>> >
>> > this patch is also valuable, there are many old version qemu in my
>> > production environment.
>> > and will be benefit with this patch.
>> >
>> >>
>> >> Fam
>>
