Received: from eggs.gnu.org ([2001:4830:134:3::10]:39894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejjfs-0008Fc-UY
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejjfn-0004tA-Ug
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:43:28 -0500
References: <20180207163622.29935-1-pbonzini@redhat.com>
	<20180207163622.29935-3-pbonzini@redhat.com>
	<20180208013517.GB24289@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ac0b76e-213a-60c3-c010-87512d3a564a@redhat.com>
Date: Thu, 8 Feb 2018 11:42:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180208013517.GB24289@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: add block job opblockers for
 scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

On 08/02/2018 02:35, Fam Zheng wrote:
> On Wed, 02/07 17:36, Paolo Bonzini wrote:
>> @@ -2626,6 +2656,36 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
>>  
>>      scsi_realize(&s->qdev, errp);
>>      scsi_generic_read_device_identification(&s->qdev);
>> +
>> +    /* For op blockers, due to lack of support for dirty bitmaps.  */
>> +    error_setg(&sb->mirror_source,
>> +               "scsi-block does not support acting as a mirroring source");
>> +    error_setg(&sb->commit_source,
>> +               "scsi-block does not support acting as an active commit source");
> 
> An alternative way would be adding BLOCK_OP_TYPE_DIRTY_BITMAP. The error message
> will not be as nice but it can be useful for another (blockjob) operation that
> requires dirty bitmap support, or another device that doesn't support dirty
> bitmaps. Though there isn't one for now.

Yeah, I thought about it.  Another possibility is make BLOCK_OP_TYPE_* a
bitmask.  Then you can easily add a single Error * for multiple
blockers, and BLOCK_OP_TYPE_DIRTY_BITMAP can be defined as
BLOCK_OP_TYPE_MIRROR_SOURCE|BLOCK_OP_TYPE_COMMIT_SOURCE; likewise for
notifiers below.

Paolo

>> +
>> +    /* For op blockers, due to lack of support for write notifiers.  */
>> +    error_setg(&sb->backup_source,
>> +               "scsi-block does not support acting as a backup source");
>> +
>> +    sb->insert_bs.notify = scsi_block_insert_bs;
>> +    blk_add_insert_bs_notifier(s->qdev.conf.blk, &sb->insert_bs);
>> +    sb->remove_bs.notify = scsi_block_remove_bs;
>> +    blk_add_remove_bs_notifier(s->qdev.conf.blk, &sb->remove_bs);
>> +
>> +    scsi_block_insert_bs(&sb->insert_bs, s->qdev.conf.blk);
>> +}
>> +
>> +static void scsi_block_unrealize(SCSIDevice *dev, Error **errp)
>> +{
>> +    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
>> +    SCSIBlockState *sb = DO_UPCAST(SCSIBlockState, sd, s);
>> +
>> +    notifier_remove(&sb->insert_bs);
>> +    notifier_remove(&sb->remove_bs);
>> +    scsi_block_remove_bs(&sb->insert_bs, s->qdev.conf.blk);
>> +    error_free(sb->mirror_source);
>> +    error_free(sb->commit_source);
>> +    error_free(sb->backup_source);
>>  }
>>  
>>  typedef struct SCSIBlockReq {
>> @@ -3017,6 +3077,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
>>      SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
>>  
>>      sc->realize      = scsi_block_realize;
>> +    sc->unrealize    = scsi_block_unrealize;
>>      sc->alloc_req    = scsi_block_new_request;
>>      sc->parse_cdb    = scsi_block_parse_cdb;
>>      sdc->dma_readv   = scsi_block_dma_readv;
>> @@ -3031,6 +3092,7 @@ static const TypeInfo scsi_block_info = {
>>      .name          = "scsi-block",
>>      .parent        = TYPE_SCSI_DISK_BASE,
>>      .class_init    = scsi_block_class_initfn,
>> +    .instance_size = sizeof(SCSIBlockState),
>>  };
>>  #endif
>>  
>> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
>> index c4e52a5fa3..a48a49ca79 100644
>> --- a/include/sysemu/block-backend.h
>> +++ b/include/sysemu/block-backend.h
>> @@ -182,6 +182,7 @@ void blk_set_guest_block_size(BlockBackend *blk, int align);
>>  void *blk_try_blockalign(BlockBackend *blk, size_t size);
>>  void *blk_blockalign(BlockBackend *blk, size_t size);
>>  bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp);
>> +void blk_op_block(BlockBackend *blk, BlockOpType op, Error *reason);
>>  void blk_op_unblock(BlockBackend *blk, BlockOpType op, Error *reason);
>>  void blk_op_block_all(BlockBackend *blk, Error *reason);
>>  void blk_op_unblock_all(BlockBackend *blk, Error *reason);
>> -- 
>> 2.14.3
>>
>>
> 
> Fam
> 
