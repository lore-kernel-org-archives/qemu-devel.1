Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC78C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C18421775
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yw+4ckTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C18421775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9YiQ-0001UU-Hx
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 13:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j9Yhg-0000bv-UN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j9Yhf-0007oY-82
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:25:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j9Yhe-0007kx-Ue
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:25:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024IN761097836;
 Wed, 4 Mar 2020 18:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IMFJnhLiVLmBd3ftHHZrq2K6cJUxEZoz0Zyz/cfpypI=;
 b=yw+4ckTEomt1lZ2c/l4BwavcHonGxLKRWRhU7wPf48NZFLnG6A4QNfIXb79ijVY0EEWN
 8UpVNPOA1o6Nx0CdIgAYvTGM8qFnwgo/GVJx6Kneb+2830fbQI6PZuV9AA/t4siVvrxf
 jPpvBzLqAwxjlVWiwzgyv62pXgdXK0L11CpekBT3pCpAY1OhQjsyxXGohzbfpt9Fo1xr
 n55V8v4lxV6ecJM1cXLYImQcNqGwRgueD1CfWkSin6qvXDXAEBjKYLtTg+avsa3zwqZK
 yoT95bIZdfO540y/L13YXvqym8jPfBevjrMLiPbmRvTrN5FXdwrH+z9/l/SBHXKeM1dW 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yghn3bw22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 18:24:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024ICpQa013623;
 Wed, 4 Mar 2020 18:24:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yg1rrsvwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 18:24:51 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024IOnB1028829;
 Wed, 4 Mar 2020 18:24:49 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Mar 2020 18:24:49 +0000
Subject: Re: [PATCH v5 01/50] multi-process: memory: alloc RAM from file at
 offset
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <e5ab1f93904f30113b358561e207a94076e24653.1582576372.git.jag.raman@oracle.com>
 <20200303195149.GV3170@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <6b20dc64-28de-51a7-9227-c1d74be368a0@oracle.com>
Date: Wed, 4 Mar 2020 13:24:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303195149.GV3170@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=2 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/3/2020 2:51 PM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Allow RAM MemoryRegion to be created from an offset in a file, instead
>> of allocating at offset of 0 by default. This is needed to synchronize
>> RAM between QEMU & remote process.
>> This will be needed for the following patches.
>>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> 
> This looks reasonable to me, so :
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> but can I suggest you take simple things like this and split them out
> into a separate little series;  I think people would probably take them
> even though the current users have a 0 offset.

Thanks Dave! We'll split these out of the series and integrate them
first.

--
Jag

> 
> Dave
> 
>> ---
>>   exec.c                    | 11 +++++++----
>>   include/exec/ram_addr.h   |  2 +-
>>   include/qemu/mmap-alloc.h |  3 ++-
>>   memory.c                  |  2 +-
>>   util/mmap-alloc.c         |  7 ++++---
>>   util/oslib-posix.c        |  2 +-
>>   6 files changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index c930040..e524185 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1841,6 +1841,7 @@ static void *file_ram_alloc(RAMBlock *block,
>>                               ram_addr_t memory,
>>                               int fd,
>>                               bool truncate,
>> +                            off_t offset,
>>                               Error **errp)
>>   {
>>       Error *err = NULL;
>> @@ -1893,7 +1894,8 @@ static void *file_ram_alloc(RAMBlock *block,
>>       }
>>   
>>       area = qemu_ram_mmap(fd, memory, block->mr->align,
>> -                         block->flags & RAM_SHARED, block->flags & RAM_PMEM);
>> +                         block->flags & RAM_SHARED, block->flags & RAM_PMEM,
>> +                         offset);
>>       if (area == MAP_FAILED) {
>>           error_setg_errno(errp, errno,
>>                            "unable to map backing store for guest RAM");
>> @@ -2322,7 +2324,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>>   #ifdef CONFIG_POSIX
>>   RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>                                    uint32_t ram_flags, int fd,
>> -                                 Error **errp)
>> +                                 off_t offset, Error **errp)
>>   {
>>       RAMBlock *new_block;
>>       Error *local_err = NULL;
>> @@ -2367,7 +2369,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>       new_block->used_length = size;
>>       new_block->max_length = size;
>>       new_block->flags = ram_flags;
>> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
>> +    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>> +                                     errp);
>>       if (!new_block->host) {
>>           g_free(new_block);
>>           return NULL;
>> @@ -2397,7 +2400,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>           return NULL;
>>       }
>>   
>> -    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
>> +    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, errp);
>>       if (!block) {
>>           if (created) {
>>               unlink(mem_path);
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 5e59a3d..1b9f489 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -121,7 +121,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
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
>> index aeaa8dc..131bc6c 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1595,7 +1595,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>>       mr->destructor = memory_region_destructor_ram;
>>       mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
>>                                              share ? RAM_SHARED : 0,
>> -                                           fd, &err);
>> +                                           fd, 0, &err);
>>       mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>>       if (err) {
>>           mr->size = int128_zero();
>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>> index 27dcccd..a28f702 100644
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
>> index 5a291cc..bd221dd 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -205,7 +205,7 @@ void *qemu_memalign(size_t alignment, size_t size)
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
> 

