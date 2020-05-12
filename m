Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72B3C54E8E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE53206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s/n3QEOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE53206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTXo-0008VQ-R1
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYTWr-0007v5-RE
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:56:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYTWp-0002FS-OH
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:56:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CBr2Li178428;
 Tue, 12 May 2020 11:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=xgO5BI/QT2AiRR9aK6FLMkLqaKVDGY0keB+yOrQeGpU=;
 b=s/n3QEOsZWLDNQE2uU0xMgTnXknYkgxpsN19BGFE13roHi59rEaKtxomNZ/ZLtAkWHmK
 0qLt5zMv4C37O6aVWXz/+Fx7hrV8Xax9IjrnGXVC/OA9XTTZYdz6W1LpT6GVrf/yGZRm
 T8ATrmBvT1Re1ynYmfvQHs93G9CZqayE1jgKm27jvnlavWqaxTpyeuUp4eWyVnn2Jzhb
 Gqztn+mO4XpLO511au0GngPYIYjKpQ+TLdYiOM4o9hOWVgJ4yZhcgjpQPzHXXCikUSDP
 8C67mYwantntWSh5Nv+IpCv15KtMRH284153szOkmDvofMxphuzp1UygA8nsb5awPopD gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 30x3gsjfqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 11:56:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CBrwDp094842;
 Tue, 12 May 2020 11:56:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 30ydsqadj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 11:56:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CBua6t011429;
 Tue, 12 May 2020 11:56:37 GMT
Received: from jags-mac.fios-router.home (/98.118.8.56)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 04:56:36 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200512084855.GC1191162@redhat.com>
Date: Tue, 12 May 2020 07:56:33 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4DB4B9E-E7E3-4F1F-917C-898F9B150EFB@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512084855.GC1191162@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120089
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 07:56:54
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, john.g.johnson@oracle.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 12, 2020, at 4:48 AM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Wed, Apr 22, 2020 at 09:13:36PM -0700, elena.ufimtseva@oracle.com =
wrote:
>> From: Jagannathan Raman <jag.raman@oracle.com>
>>=20
>> Allow RAM MemoryRegion to be created from an offset in a file, =
instead
>> of allocating at offset of 0 by default. This is needed to =
synchronize
>> RAM between QEMU & remote process.
>=20
> Can you elaborate on why remote processes require the RAM to be offset
> from zero ?

Hi Daniel,

As it turns out, the RAM is scattered across the physical address space
(system_memory) of QEMU. Therefore, the system memory is composed
of multiple sections of RAM, and some sections start at a non-zero RAM
offset.

As a result, the remote process needs the ability to map these RAM
sections into system_memory.

Thank you!
--
Jag

>=20
> NB, I'm not objecting - I'm just curious to understand more.
>=20
>>=20
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>> exec.c                    | 11 +++++++----
>> include/exec/ram_addr.h   |  2 +-
>> include/qemu/mmap-alloc.h |  3 ++-
>> memory.c                  |  2 +-
>> util/mmap-alloc.c         |  7 ++++---
>> util/oslib-posix.c        |  2 +-
>> 6 files changed, 16 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/exec.c b/exec.c
>> index 2874bb5088..d0ac9545f4 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1801,6 +1801,7 @@ static void *file_ram_alloc(RAMBlock *block,
>>                             ram_addr_t memory,
>>                             int fd,
>>                             bool truncate,
>> +                            off_t offset,
>>                             Error **errp)
>> {
>>     void *area;
>> @@ -1851,7 +1852,8 @@ static void *file_ram_alloc(RAMBlock *block,
>>     }
>>=20
>>     area =3D qemu_ram_mmap(fd, memory, block->mr->align,
>> -                         block->flags & RAM_SHARED, block->flags & =
RAM_PMEM);
>> +                         block->flags & RAM_SHARED, block->flags & =
RAM_PMEM,
>> +                         offset);
>>     if (area =3D=3D MAP_FAILED) {
>>         error_setg_errno(errp, errno,
>>                          "unable to map backing store for guest =
RAM");
>> @@ -2283,7 +2285,7 @@ static void ram_block_add(RAMBlock *new_block, =
Error **errp, bool shared)
>> #ifdef CONFIG_POSIX
>> RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>                                  uint32_t ram_flags, int fd,
>> -                                 Error **errp)
>> +                                 off_t offset, Error **errp)
>> {
>>     RAMBlock *new_block;
>>     Error *local_err =3D NULL;
>> @@ -2328,7 +2330,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t =
size, MemoryRegion *mr,
>>     new_block->used_length =3D size;
>>     new_block->max_length =3D size;
>>     new_block->flags =3D ram_flags;
>> -    new_block->host =3D file_ram_alloc(new_block, size, fd, =
!file_size, errp);
>> +    new_block->host =3D file_ram_alloc(new_block, size, fd, =
!file_size, offset,
>> +                                     errp);
>>     if (!new_block->host) {
>>         g_free(new_block);
>>         return NULL;
>> @@ -2358,7 +2361,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t =
size, MemoryRegion *mr,
>>         return NULL;
>>     }
>>=20
>> -    block =3D qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
>> +    block =3D qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, =
errp);
>>     if (!block) {
>>         if (created) {
>>             unlink(mem_path);
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 5e59a3d8d7..1b9f489ff0 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -121,7 +121,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t =
size, MemoryRegion *mr,
>>                                    Error **errp);
>> RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>                                  uint32_t ram_flags, int fd,
>> -                                 Error **errp);
>> +                                 off_t offset, Error **errp);
>>=20
>> RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>>                                   MemoryRegion *mr, Error **errp);
>> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
>> index e786266b92..4f579858bc 100644
>> --- a/include/qemu/mmap-alloc.h
>> +++ b/include/qemu/mmap-alloc.h
>> @@ -25,7 +25,8 @@ void *qemu_ram_mmap(int fd,
>>                     size_t size,
>>                     size_t align,
>>                     bool shared,
>> -                    bool is_pmem);
>> +                    bool is_pmem,
>> +                    off_t start);
>>=20
>> void qemu_ram_munmap(int fd, void *ptr, size_t size);
>>=20
>> diff --git a/memory.c b/memory.c
>> index 601b749906..f5fec476b7 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1596,7 +1596,7 @@ void =
memory_region_init_ram_from_fd(MemoryRegion *mr,
>>     mr->destructor =3D memory_region_destructor_ram;
>>     mr->ram_block =3D qemu_ram_alloc_from_fd(size, mr,
>>                                            share ? RAM_SHARED : 0,
>> -                                           fd, &err);
>> +                                           fd, 0, &err);
>>     mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : =
0;
>>     if (err) {
>>         mr->size =3D int128_zero();
>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>> index 27dcccd8ec..a28f7025f0 100644
>> --- a/util/mmap-alloc.c
>> +++ b/util/mmap-alloc.c
>> @@ -86,7 +86,8 @@ void *qemu_ram_mmap(int fd,
>>                     size_t size,
>>                     size_t align,
>>                     bool shared,
>> -                    bool is_pmem)
>> +                    bool is_pmem,
>> +                    off_t start)
>> {
>>     int flags;
>>     int map_sync_flags =3D 0;
>> @@ -147,7 +148,7 @@ void *qemu_ram_mmap(int fd,
>>     offset =3D QEMU_ALIGN_UP((uintptr_t)guardptr, align) - =
(uintptr_t)guardptr;
>>=20
>>     ptr =3D mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
>> -               flags | map_sync_flags, fd, 0);
>> +               flags | map_sync_flags, fd, start);
>>=20
>>     if (ptr =3D=3D MAP_FAILED && map_sync_flags) {
>>         if (errno =3D=3D ENOTSUP) {
>> @@ -172,7 +173,7 @@ void *qemu_ram_mmap(int fd,
>>          * we will remove these flags to handle compatibility.
>>          */
>>         ptr =3D mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
>> -                   flags, fd, 0);
>> +                   flags, fd, start);
>>     }
>>=20
>>     if (ptr =3D=3D MAP_FAILED) {
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 062236a1ab..4c6b9e90c6 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -209,7 +209,7 @@ void *qemu_memalign(size_t alignment, size_t =
size)
>> void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool =
shared)
>> {
>>     size_t align =3D QEMU_VMALLOC_ALIGN;
>> -    void *ptr =3D qemu_ram_mmap(-1, size, align, shared, false);
>> +    void *ptr =3D qemu_ram_mmap(-1, size, align, shared, false, 0);
>>=20
>>     if (ptr =3D=3D MAP_FAILED) {
>>         return NULL;
>> --=20
>> 2.25.GIT
>>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|
>=20
>=20


