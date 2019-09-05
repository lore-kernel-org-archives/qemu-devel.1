Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4A0C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A920D2082C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNfizHMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A920D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tOd-0008Ks-7b
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5tMr-0006gu-4g
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5tMo-0001d7-BS
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:08:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5tMn-0001be-QD
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:08:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85F76le056386;
 Thu, 5 Sep 2019 15:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=1CuojXYGP/huYoiQZ5EIJHtZPWB2y2BspqueRIuhvFU=;
 b=PNfizHMFaynsOQrUlqZe3P1t3exSXQjQcDL659S4zsLrvVqgEa86aIx80bqd2xGtT2+w
 Ekgm2ULEMiEcDuO4Oc/bnkmsNZnSjgZfln8vLiL02CfJDcnu67I8SNN5gB/88jWKUvVZ
 fy7BqPc3vEvxx5ybgJUC5iGXoHc67B51yHMdGv/kXntUblwAPHqet8d9n1tAer4RzI2Q
 gNVs3NjA02mec0tZUokJzL3N1MojcXiaev/eJraJKlfhxScCHIEmLx32mxksrEq9SbMf
 HnMfzbuo3+v4ZK1hIbO+ESG8G8QTz1ZgJohTJziyDAQuGRnLH3ufLskQxa9gZDWafKJr fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2uu4q70062-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:07:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85EmFa1145193;
 Thu, 5 Sep 2019 15:07:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2utvr3r5yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:07:50 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x85F7lIE026784;
 Thu, 5 Sep 2019 15:07:47 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Sep 2019 08:07:47 -0700
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <3bf3631115123d4a6a360b41ef0aaa47b40ff08d.1567534653.git.jag.raman@oracle.com>
 <20190904081129.GA2828@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <2b0b3ce0-06d6-e953-66fd-ead53110c0a9@oracle.com>
Date: Thu, 5 Sep 2019 11:07:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190904081129.GA2828@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050143
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [RFC v3 PATCH 01/45] multi-process: memory: alloc
 RAM from file at offset
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 mreitz@redhat.com, kanth.ghatraju@oracle.com, kraxel@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, liran.alon@oracle.com,
 marcandre.lureau@gmail.com, kwolf@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/4/2019 4:11 AM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Allow RAM MemoryRegion to be created from an offset in a file, instead
>> of allocating at offset of 0 by default. This is needed to synchronize
>> RAM between QEMU & remote process.
>> This will be needed for the following patches.
>>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> ---
>>   exec.c                    | 11 +++++++----
>>   include/exec/ram_addr.h   |  2 +-
>>   include/qemu/mmap-alloc.h |  3 ++-
>>   memory.c                  |  2 +-
>>   util/mmap-alloc.c         |  7 ++++---
>>   util/oslib-posix.c        |  2 +-
>>   6 files changed, 16 insertions(+), 11 deletions(-)
> 
> I'm surprised this doesn't change something in
> vhost-user.c:vhost_user_set_mem_table so that the vhost-user client
> knows what it's mapping?

Hi Dave,

vhost-user does not use the functions addressed in this patch for
mapping the RAM onto the remote process. It calls mmap() for this
purpose (vu_set_mem_table_exec()).

Thanks!
--
Jag

> 
> Dave
> 
>> diff --git a/exec.c b/exec.c
>> index 3e78de3..b3f1aa9 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1885,6 +1885,7 @@ static void *file_ram_alloc(RAMBlock *block,
>>                               ram_addr_t memory,
>>                               int fd,
>>                               bool truncate,
>> +                            off_t offset,
>>                               Error **errp)
>>   {
>>       MachineState *ms = MACHINE(qdev_get_machine());
>> @@ -1936,7 +1937,8 @@ static void *file_ram_alloc(RAMBlock *block,
>>       }
>>   
>>       area = qemu_ram_mmap(fd, memory, block->mr->align,
>> -                         block->flags & RAM_SHARED, block->flags & RAM_PMEM);
>> +                         block->flags & RAM_SHARED, block->flags & RAM_PMEM,
>> +                         offset);
>>       if (area == MAP_FAILED) {
>>           error_setg_errno(errp, errno,
>>                            "unable to map backing store for guest RAM");
>> @@ -2325,7 +2327,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>>   #ifdef CONFIG_POSIX
>>   RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>                                    uint32_t ram_flags, int fd,
>> -                                 Error **errp)
>> +                                 off_t offset, Error **errp)
>>   {
>>       RAMBlock *new_block;
>>       Error *local_err = NULL;
>> @@ -2370,7 +2372,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>       new_block->used_length = size;
>>       new_block->max_length = size;
>>       new_block->flags = ram_flags;
>> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
>> +    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>> +                                     errp);
>>       if (!new_block->host) {
>>           g_free(new_block);
>>           return NULL;
>> @@ -2400,7 +2403,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>           return NULL;
>>       }
>>   
>> -    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
>> +    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, errp);
>>       if (!block) {
>>           if (created) {
>>               unlink(mem_path);
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index b7b2e60..15837a1 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -164,7 +164,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>                                      Error **errp);
>>   RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>                                    uint32_t ram_flags, int fd,
>> -                                 Error **errp);
>> +                                 off_t offset, Error **errp);
>>   
>>   RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>>                                     MemoryRegion *mr, Error **errp);
>> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
>> index e786266..4f57985 100644
>> --- a/include/qemu/mmap-alloc.h
>> +++ b/include/qemu/mmap-alloc.h
>> @@ -25,7 +25,8 @@ void *qemu_ram_mmap(int fd,
>>                       size_t size,
>>                       size_t align,
>>                       bool shared,
>> -                    bool is_pmem);
>> +                    bool is_pmem,
>> +                    off_t start);
>>   
>>   void qemu_ram_munmap(int fd, void *ptr, size_t size);
>>   
>> diff --git a/memory.c b/memory.c
>> index 5d8c9a9..debed5e 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1622,7 +1622,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>>       mr->destructor = memory_region_destructor_ram;
>>       mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
>>                                              share ? RAM_SHARED : 0,
>> -                                           fd, &err);
>> +                                           fd, 0, &err);
>>       mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>>       if (err) {
>>           mr->size = int128_zero();
>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>> index f7f177d..4b727bd 100644
>> --- a/util/mmap-alloc.c
>> +++ b/util/mmap-alloc.c
>> @@ -86,7 +86,8 @@ void *qemu_ram_mmap(int fd,
>>                       size_t size,
>>                       size_t align,
>>                       bool shared,
>> -                    bool is_pmem)
>> +                    bool is_pmem,
>> +                    off_t start)
>>   {
>>       int flags;
>>       int map_sync_flags = 0;
>> @@ -147,7 +148,7 @@ void *qemu_ram_mmap(int fd,
>>       offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
>>   
>>       ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
>> -               flags | map_sync_flags, fd, 0);
>> +               flags | map_sync_flags, fd, start);
>>   
>>       if (ptr == MAP_FAILED && map_sync_flags) {
>>           if (errno == ENOTSUP) {
>> @@ -172,7 +173,7 @@ void *qemu_ram_mmap(int fd,
>>            * we will remove these flags to handle compatibility.
>>            */
>>           ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
>> -                   flags, fd, 0);
>> +                   flags, fd, start);
>>       }
>>   
>>       if (ptr == MAP_FAILED) {
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index fe0309c..f6a243f 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -204,7 +204,7 @@ void *qemu_memalign(size_t alignment, size_t size)
>>   void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
>>   {
>>       size_t align = QEMU_VMALLOC_ALIGN;
>> -    void *ptr = qemu_ram_mmap(-1, size, align, shared, false);
>> +    void *ptr = qemu_ram_mmap(-1, size, align, shared, false, 0);
>>   
>>       if (ptr == MAP_FAILED) {
>>           return NULL;
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

