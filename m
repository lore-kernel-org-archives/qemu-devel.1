Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67CCC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6491F22226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V682ltLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6491F22226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZx4m-0002ve-Bq
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kZwv1-00086k-SR; Tue, 03 Nov 2020 09:04:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kZwuw-0003gy-T5; Tue, 03 Nov 2020 09:04:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A3E2G7l008936; Tue, 3 Nov 2020 09:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=i4E7pz6Sn1vg3EvO7OnSv9dnprDBg2CmMWChg+Xf5gY=;
 b=V682ltLlH+FaovNSTNWK8aGNcSrL/CGTHHGvPbKXY6RJtfhZHt++3Dw996DfMxiVmuZc
 co7VA8LtlvhdN+CvMXrZ8VoAalPaUnrVrNLlaV9nzbWDXicf3Y5yjL5a1yRTjqFKeH9N
 4aD60P9i70G9Niq8ZvDmARIp/OIo9qH1FzGL0iUb2V06RIfkVO0aBsYvqkVjwsDFm5eI
 bZjD9JRR/7lp5a7/gSWMp4DJjWRcHpxJqRo0gU75VFb2SacULXvWfwo74bWQ1WV5UYsn
 Wxyl1JJ0fY9Z32DwZL7zMVrQhejRKhnc/aqvMpFy+qaED4diD9WihF+Hhe7fYFfrjs+Z 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34k86cs3ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 09:04:02 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3E2SMe010298;
 Tue, 3 Nov 2020 09:04:01 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34k86cs3de-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 09:04:01 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3E3WAk019780;
 Tue, 3 Nov 2020 14:03:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 34h0fcuafc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 14:03:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A3E3tRs4325996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Nov 2020 14:03:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A5385205F;
 Tue,  3 Nov 2020 14:03:55 +0000 (GMT)
Received: from [9.160.83.122] (unknown [9.160.83.122])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5202252059;
 Tue,  3 Nov 2020 14:03:52 +0000 (GMT)
Subject: Re: [PATCH-for-5.2 0/4] misc: Trivial format string fixes
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201103112558.2554390-1-philmd@redhat.com>
 <64132d34-dbd9-03ee-6f11-a6908df025bf@linux.vnet.ibm.com>
Message-ID: <ddd49883-7c97-966b-1f62-52f39f4952ad@linux.vnet.ibm.com>
Date: Tue, 3 Nov 2020 16:03:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <64132d34-dbd9-03ee-6f11-a6908df025bf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-03_08:2020-11-03,
 2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030093
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 05:07:52
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 03/11/2020 15:58, Dov Murik wrote:
> On 03/11/2020 13:25, Philippe Mathieu-Daudé wrote:
>> IIUC qemu-trivial@ doesn't queue patches during freeze,
>>
>> so it might be easier if patches are queued by respective
>>
>> subsystem maintainers.
>>
>>
>>
>> Philippe Mathieu-Daudé (4):
>>
>>    hw/display/cirrus_vga: Remove debugging code commented out
>>
>>    hw/display/cirrus_vga: Fix hexadecimal format string specifier
>>
>>    hw/ppc/spapr_tpm_proxy: Fix hexadecimal format string specifier
>>
>>    migration/ram: Fix hexadecimal format string specifier
>>
>>
>>
>>   hw/display/cirrus_vga.c | 20 +-------------------
>>
>>   migration/ram.c         |  2 +-
>>
>>   hw/ppc/trace-events     |  2 +-
>>
>>   3 files changed, 3 insertions(+), 21 deletions(-)
>>
>>
>>
> 
> 
> There's at least one more easy fix:
> 
> hw/misc/trace-events:106:mos6522_get_next_irq_time(uint16_t latch, 
> int64_t d, int64_t delta) "latch=%d counter=0x%"PRId64 " 
> delta_next=0x%"PRId64
> 
> but I have no idea how to test this.
> 
> -Dov
> 

... and one more in hw/usb/u2f-passthru.c:348 :

         error_report("%s: Bad written size (req 0x%zu, val 0x%zd)",
                      TYPE_U2F_PASSTHRU, sizeof(host_packet), written);


Again, I have no idea how to test/trigger these areas in the code.

-Dov


