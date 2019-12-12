Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2962DC00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF68F21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF68F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifVBq-0000iB-4M
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifVAc-0007ly-A8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifVAb-0000rC-Av
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:34:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31770
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ifVAZ-0000mG-0n; Thu, 12 Dec 2019 15:34:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCKW680021393; Thu, 12 Dec 2019 15:34:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wurcr1c2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 15:34:39 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCKW9St021739;
 Thu, 12 Dec 2019 15:34:39 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wurcr1c2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 15:34:39 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCKRFYQ005251;
 Thu, 12 Dec 2019 20:34:38 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02wdc.us.ibm.com with ESMTP id 2wr3q712k5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 20:34:38 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCKYbB728246432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 20:34:37 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9856D136053;
 Thu, 12 Dec 2019 20:34:37 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C395913604F;
 Thu, 12 Dec 2019 20:34:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 20:34:35 +0000 (GMT)
Subject: Re: [PATCH v5 1/5] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
To: Eric Blake <eblake@redhat.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-2-stefanb@linux.vnet.ibm.com>
 <a7312621-b3d4-6ee1-5e44-70d34dfbd2a2@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <08c30e83-930d-4264-3052-cba246106009@linux.ibm.com>
Date: Thu, 12 Dec 2019 15:34:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a7312621-b3d4-6ee1-5e44-70d34dfbd2a2@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_07:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120157
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 3:33 PM, Eric Blake wrote:
> On 12/12/19 2:24 PM, Stefan Berger wrote:
>> Implement support for TPM on ppc64 by implementing the vTPM CRQ 
>> interface
>> as a frontend. It can use the tpm_emulator driver backend with the 
>> external
>> swtpm.
>>
>> The Linux vTPM driver for ppc64 works with this emulation.
>>
>> This TPM emulator also handles the TPM 2 case.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
>
> Odd that your diff doesn't include the usual --- marker or a diffstat.
>
>
>> +++ b/hw/tpm/tpm_spapr.c
>> @@ -0,0 +1,405 @@
>> +/*
>> + * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware 
>> System Emulator
>> + *
>> + * PAPR Virtual TPM
>> + *
>> + * Copyright (c) 2015, 2017 IBM Corporation.
>
> Do you want to claim 2019?
>
:-)


