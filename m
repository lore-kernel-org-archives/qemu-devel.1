Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CFBC46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 06:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43CD20674
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 06:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Taq3ujzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43CD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPJzB-0005L3-La
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 02:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kPJxJ-00042S-LY; Mon, 05 Oct 2020 02:26:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kPJxH-0001YG-AJ; Mon, 05 Oct 2020 02:26:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0956EdgS120724; Mon, 5 Oct 2020 02:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JLQJqg06Iuq4nuZuwS3YJBaCnR0XxEFiPWdMo4akQtU=;
 b=Taq3ujzssseUebPoQ1nm9ldXq40TBakRAPBRaV15PVEvXAMPYj4PaK1YQUpwHKxtbD79
 83pZLbIAC2VtH85SJGfmx+Zeh0gwhahtlOtGoTX9G4Dpw7jXPcDGEj1HML+5scYILH2P
 lhbzZI3EnggRmMsbyAeUD3qqAnaQQoLrAi0Jzx/wHuGayQv6baDv4ypCKrYv5Z5FtHma
 vguzosAz9KmFRwjQDJgYHZtqnxHLEwOsgjXa6LHmPUBKIcQMqAcVneetiJ0Xu46zeV7W
 7c2O9NL6CTaEgWBPoukXto/hy0NvxvfkPAlm/MhNLl6AqvtiBz8ugTJ47kXyNltDBUxj cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33yx1vr882-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 02:26:31 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0956I3H9144890;
 Mon, 5 Oct 2020 02:26:31 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33yx1vr874-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 02:26:31 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0956BgJA008382;
 Mon, 5 Oct 2020 06:26:29 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03ams.nl.ibm.com with ESMTP id 33xgx89ujk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 06:26:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 0956QRJn21954940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2020 06:26:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF7B0A4054;
 Mon,  5 Oct 2020 06:26:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88F9BA4066;
 Mon,  5 Oct 2020 06:26:26 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.0.84])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2020 06:26:26 +0000 (GMT)
Subject: Re: [PATCH 1/4] vmdk: fix maybe uninitialized warnings
To: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
 <20200930155859.303148-2-borntraeger@de.ibm.com>
 <f78c368c7a61c2386deec50cd3386253588e64dc.camel@euphon.net>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Message-ID: <062fe426-3f05-eb02-0871-3c798e0885e4@de.ibm.com>
Date: Mon, 5 Oct 2020 08:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f78c368c7a61c2386deec50cd3386253588e64dc.camel@euphon.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-05_04:2020-10-02,
 2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050048
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:25:59
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30.09.20 18:36, Fam Zheng wrote:
> On Wed, 2020-09-30 at 17:58 +0200, Christian Borntraeger wrote:
>> Fedora 32 gcc 10 seems to give false positives:
>>
>> Compiling C object libblock.fa.p/block_vmdk.c.o
>> ../block/vmdk.c: In function ‘vmdk_parse_extents’:
>> ../block/vmdk.c:587:5: error: ‘extent’ may be used uninitialized in
>> this function [-Werror=maybe-uninitialized]
>>   587 |     g_free(extent->l1_table);
>>       |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> ../block/vmdk.c:754:17: note: ‘extent’ was declared here
>>   754 |     VmdkExtent *extent;
>>       |                 ^~~~~~
>> ../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in
>> this function [-Werror=maybe-uninitialized]
>>   620 |     ret = vmdk_init_tables(bs, extent, errp);
>>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../block/vmdk.c:598:17: note: ‘extent’ was declared here
>>   598 |     VmdkExtent *extent;
>>       |                 ^~~~~~
>> ../block/vmdk.c:1178:39: error: ‘extent’ may be used uninitialized in
>> this function [-Werror=maybe-uninitialized]
>>  1178 |             extent->flat_start_offset = flat_offset << 9;
>>       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
>> ../block/vmdk.c: In function ‘vmdk_open_vmdk4’:
>> ../block/vmdk.c:581:22: error: ‘extent’ may be used uninitialized in
>> this function [-Werror=maybe-uninitialized]
>>   581 |     extent->l2_cache =
>>       |     ~~~~~~~~~~~~~~~~~^
>>   582 |         g_malloc(extent->entry_size * extent->l2_size *
>> L2_CACHE_SIZE);
>>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ~~~~~~~~~
>> ../block/vmdk.c:872:17: note: ‘extent’ was declared here
>>   872 |     VmdkExtent *extent;
>>       |                 ^~~~~~
>> ../block/vmdk.c: In function ‘vmdk_open’:
>> ../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in
>> this function [-Werror=maybe-uninitialized]
>>   620 |     ret = vmdk_init_tables(bs, extent, errp);
>>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../block/vmdk.c:598:17: note: ‘extent’ was declared here
>>   598 |     VmdkExtent *extent;
>>       |                 ^~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [Makefile.ninja:884: libblock.fa.p/block_vmdk.c.o] Error 1
>>
>> fix them by assigning a default value.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  block/vmdk.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index 8ec62c7ab798..a00dc00eb47a 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -595,7 +595,7 @@ static int vmdk_open_vmfs_sparse(BlockDriverState
>> *bs,
>>      int ret;
>>      uint32_t magic;
>>      VMDK3Header header;
>> -    VmdkExtent *extent;
>> +    VmdkExtent *extent = NULL;
>>  
>>      ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
>>      if (ret < 0) {
>> @@ -751,7 +751,7 @@ static int vmdk_open_se_sparse(BlockDriverState
>> *bs,
>>      int ret;
>>      VMDKSESparseConstHeader const_header;
>>      VMDKSESparseVolatileHeader volatile_header;
>> -    VmdkExtent *extent;
>> +    VmdkExtent *extent = NULL;
>>  
>>      ret = bdrv_apply_auto_read_only(bs,
>>              "No write support for seSparse images available", errp);
>> @@ -869,7 +869,7 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
>>      uint32_t magic;
>>      uint32_t l1_size, l1_entry_sectors;
>>      VMDK4Header header;
>> -    VmdkExtent *extent;
>> +    VmdkExtent *extent = NULL;
>>      BDRVVmdkState *s = bs->opaque;
>>      int64_t l1_backup_offset = 0;
>>      bool compressed;
>> @@ -1088,7 +1088,7 @@ static int vmdk_parse_extents(const char *desc,
>> BlockDriverState *bs,
>>      BdrvChild *extent_file;
>>      BdrvChildRole extent_role;
>>      BDRVVmdkState *s = bs->opaque;
>> -    VmdkExtent *extent;
>> +    VmdkExtent *extent = NULL;
>>      char extent_opt_prefix[32];
>>      Error *local_err = NULL;
>>  
> 
> Looks trivial, and correct.
> 
> Reviewed-by: Fam Zheng <fam@euphon.net>


Will this go via the block or trivial tree (cced). 

