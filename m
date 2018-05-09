Received: from eggs.gnu.org ([2001:4830:134:3::10]:42466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fGE4t-0001xv-Oy
	for qemu-devel@nongnu.org; Tue, 08 May 2018 21:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fGE4s-0004vU-UK
	for qemu-devel@nongnu.org; Tue, 08 May 2018 21:39:35 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fGE4s-0004vE-Pa
	for qemu-devel@nongnu.org; Tue, 08 May 2018 21:39:34 -0400
Received: by mail-io0-x243.google.com with SMTP id e78-v6so40876701iod.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 18:39:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508171942.GS2500@work-vm>
References: <1525618499-1560-1-git-send-email-lidongchen@tencent.com>
	<20180508171942.GS2500@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 9 May 2018 09:39:33 +0800
Message-ID: <CAOGPPbcV-oYq_XNxnPa0ii5EadLe77N7t=k+GVZuURx4kDi3oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: update index field when
 delete or qsort RDMALocalBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Wed, May 9, 2018 at 1:19 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> rdma_delete_block function deletes RDMALocalBlock base on index field,
>> but not update the index field. So when next time invoke rdma_delete_block,
>> it will not work correctly.
>>
>> If start and cancel migration repeatedly, some RDMALocalBlock not invoke
>> ibv_dereg_mr to decrease kernel mm_struct vmpin. When vmpin is large than
>> max locked memory limitation, ibv_reg_mr will failed, and migration can not
>> start successfully again.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  migration/rdma.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index ed9cfb1..0dd4033 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -713,6 +713,9 @@ static int rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
>>              memcpy(local->block + block->index, old + (block->index + 1),
>>                  sizeof(RDMALocalBlock) *
>>                      (local->nb_blocks - (block->index + 1)));
>> +            for (x = block->index; x < local->nb_blocks - 1; x++) {
>> +                local->block[x].index--;
>> +            }
>
> Yes; is that equivalent to   local->blocks[x].index = x;   ?

yes, it's equivalent.

>
>>          }
>>      } else {
>>          assert(block == local->block);
>> @@ -3398,6 +3401,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
>>              qsort(rdma->local_ram_blocks.block,
>>                    rdma->local_ram_blocks.nb_blocks,
>>                    sizeof(RDMALocalBlock), dest_ram_sort_func);
>> +            for (i = 0; i < local->nb_blocks; i++) {
>> +                local->block[i].index = i;
>> +            }
>> +
>
> Which is basically the way that one does it;
>
> OK, it's a while since I looked at this but I think it fixes my 3 year
> old 03fcab38617 patch, so
>
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>>              if (rdma->pin_all) {
>>                  ret = qemu_rdma_reg_whole_ram_blocks(rdma);
>>                  if (ret) {
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
