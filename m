Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFD0C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221DB2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221DB2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyel-0004Y5-6I
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kRydF-0003AP-VB; Mon, 12 Oct 2020 10:16:59 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kRydD-0004ow-1V; Mon, 12 Oct 2020 10:16:57 -0400
Received: from [192.168.100.1] ([82.252.141.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Ml6i2-1k2moF1Y8y-00lWYx; Mon, 12 Oct 2020 16:16:23 +0200
Subject: Re: [PATCH 1/4] vmdk: fix maybe uninitialized warnings
To: Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng
 <fam@euphon.net>, qemu-devel@nongnu.org
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
 <20200930155859.303148-2-borntraeger@de.ibm.com>
 <f78c368c7a61c2386deec50cd3386253588e64dc.camel@euphon.net>
 <062fe426-3f05-eb02-0871-3c798e0885e4@de.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ddd3c54d-fb22-f52c-ae99-1a5dffeeb1ae@vivier.eu>
Date: Mon, 12 Oct 2020 16:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <062fe426-3f05-eb02-0871-3c798e0885e4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GbbuFUOtD3Z1s61rpNy7Ko4x5vuuTineYdJHD4+UFGyZ10ln3FZ
 LaZ4XoQz6Pl4GkbxaXrEW6qiNZegjNsyk7Xp0OwpI5NtrtNBd+trqtudno6oNJYBV3kBbhq
 hw7RKe0orIrZ1MemiPCiBm/5JdkE4oQ0MpbYPDNfSeQ8vGwU9vy35n7C2PBZ+o9x2vcgdo4
 /SEZ3S+fpuFftlruhEuLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+GoeOKGBUS4=:hbW92fafMTUsM66VpXl/5N
 xxtS8qFUYQ7TqJ5dz7lKHcinpOtVSSWbvO8Pk5kd5ja0UPzviXdZ0Uzu7w15cGAqs04BfHqfb
 KQYAHwhWmYzoSq3/WBh+gRaZkWbytSKTU5XX1KFNjXuOoNpmKmQFO/lytzRxcnz+1CTetnoed
 r6rJJTM5gC0gRjdJs0N7vFNgCRW0IE6GipqjZRgC7VjRnjM4QatvejWQ8m6dojtFCX0IH6yIV
 Lffjwtk6RdnTls3NpJK/keIVQsqEWpfnOoCKJkGprFQadbugK0lmMPh6k8ASTHxAi720GG3mC
 KWMOxTeszqBGVOIg3ViVrl68HYBrk6fd0IgHZfSe+18rIvLGDgdMI0QULPyFEh6azOFm1Vabi
 ubzeDTBsX7MN5UV5Yb9VGwjbVKozEtttqTiU5J9rvD2BowEWD6WMb9VUinaZqU4AGEZyDGUYR
 3kfBBd/PwYiHV2qP9NjK4xrGAslhJnleUBl43zx7a26ILZZGr6Z8KjberZT+/liriDI7WuWRy
 fk/za19Vfj8bIL4C8Ffp81lAfHaydtodsCFIaE2D1PYF2QyvlKWy24FN+ldZrQrto+Bv5sHhC
 SPoE2EjmOg1v+G0msYueSrGdNJZubiL6APn0E9AfhPB8inav8RTuWY1uKFJ7qVITI7yFo4S1C
 3JQWJFcef3bYQ7i3F1VyshjRGSUdO29mUt4UtXXM26MDTm3pHWN38ZSftLzngvlxQKIocghsG
 8QytSXmHpWtoaEBIYd7GAU1a5KT+HVqKSLN7WHPsFBB4VZCsNK7iIdR5YyO/cztH6U16EBcsl
 RsMwrMx0FkmeH/yq5VWwDqKLfytC/BU57cE7w7srbTwB3a10810AI6ynmMbvgnHzyOAhM/O
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 10:16:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 05/10/2020 à 08:26, Christian Borntraeger a écrit :
> On 30.09.20 18:36, Fam Zheng wrote:
>> On Wed, 2020-09-30 at 17:58 +0200, Christian Borntraeger wrote:
>>> Fedora 32 gcc 10 seems to give false positives:
>>>
>>> Compiling C object libblock.fa.p/block_vmdk.c.o
>>> ../block/vmdk.c: In function ‘vmdk_parse_extents’:
>>> ../block/vmdk.c:587:5: error: ‘extent’ may be used uninitialized in
>>> this function [-Werror=maybe-uninitialized]
>>>   587 |     g_free(extent->l1_table);
>>>       |     ^~~~~~~~~~~~~~~~~~~~~~~~
>>> ../block/vmdk.c:754:17: note: ‘extent’ was declared here
>>>   754 |     VmdkExtent *extent;
>>>       |                 ^~~~~~
>>> ../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in
>>> this function [-Werror=maybe-uninitialized]
>>>   620 |     ret = vmdk_init_tables(bs, extent, errp);
>>>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../block/vmdk.c:598:17: note: ‘extent’ was declared here
>>>   598 |     VmdkExtent *extent;
>>>       |                 ^~~~~~
>>> ../block/vmdk.c:1178:39: error: ‘extent’ may be used uninitialized in
>>> this function [-Werror=maybe-uninitialized]
>>>  1178 |             extent->flat_start_offset = flat_offset << 9;
>>>       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
>>> ../block/vmdk.c: In function ‘vmdk_open_vmdk4’:
>>> ../block/vmdk.c:581:22: error: ‘extent’ may be used uninitialized in
>>> this function [-Werror=maybe-uninitialized]
>>>   581 |     extent->l2_cache =
>>>       |     ~~~~~~~~~~~~~~~~~^
>>>   582 |         g_malloc(extent->entry_size * extent->l2_size *
>>> L2_CACHE_SIZE);
>>>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ~~~~~~~~~
>>> ../block/vmdk.c:872:17: note: ‘extent’ was declared here
>>>   872 |     VmdkExtent *extent;
>>>       |                 ^~~~~~
>>> ../block/vmdk.c: In function ‘vmdk_open’:
>>> ../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in
>>> this function [-Werror=maybe-uninitialized]
>>>   620 |     ret = vmdk_init_tables(bs, extent, errp);
>>>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../block/vmdk.c:598:17: note: ‘extent’ was declared here
>>>   598 |     VmdkExtent *extent;
>>>       |                 ^~~~~~
>>> cc1: all warnings being treated as errors
>>> make: *** [Makefile.ninja:884: libblock.fa.p/block_vmdk.c.o] Error 1
>>>
>>> fix them by assigning a default value.
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  block/vmdk.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/block/vmdk.c b/block/vmdk.c
>>> index 8ec62c7ab798..a00dc00eb47a 100644
>>> --- a/block/vmdk.c
>>> +++ b/block/vmdk.c
>>> @@ -595,7 +595,7 @@ static int vmdk_open_vmfs_sparse(BlockDriverState
>>> *bs,
>>>      int ret;
>>>      uint32_t magic;
>>>      VMDK3Header header;
>>> -    VmdkExtent *extent;
>>> +    VmdkExtent *extent = NULL;
>>>  
>>>      ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
>>>      if (ret < 0) {
>>> @@ -751,7 +751,7 @@ static int vmdk_open_se_sparse(BlockDriverState
>>> *bs,
>>>      int ret;
>>>      VMDKSESparseConstHeader const_header;
>>>      VMDKSESparseVolatileHeader volatile_header;
>>> -    VmdkExtent *extent;
>>> +    VmdkExtent *extent = NULL;
>>>  
>>>      ret = bdrv_apply_auto_read_only(bs,
>>>              "No write support for seSparse images available", errp);
>>> @@ -869,7 +869,7 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
>>>      uint32_t magic;
>>>      uint32_t l1_size, l1_entry_sectors;
>>>      VMDK4Header header;
>>> -    VmdkExtent *extent;
>>> +    VmdkExtent *extent = NULL;
>>>      BDRVVmdkState *s = bs->opaque;
>>>      int64_t l1_backup_offset = 0;
>>>      bool compressed;
>>> @@ -1088,7 +1088,7 @@ static int vmdk_parse_extents(const char *desc,
>>> BlockDriverState *bs,
>>>      BdrvChild *extent_file;
>>>      BdrvChildRole extent_role;
>>>      BDRVVmdkState *s = bs->opaque;
>>> -    VmdkExtent *extent;
>>> +    VmdkExtent *extent = NULL;
>>>      char extent_opt_prefix[32];
>>>      Error *local_err = NULL;
>>>  
>>
>> Looks trivial, and correct.
>>
>> Reviewed-by: Fam Zheng <fam@euphon.net>
> 
> 
> Will this go via the block or trivial tree (cced). 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


