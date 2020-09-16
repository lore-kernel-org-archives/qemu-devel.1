Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F84C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD261223D6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="azgH51sB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD261223D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIb33-0001ff-Er
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 13:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kIb1W-0000Ta-4C; Wed, 16 Sep 2020 13:15:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kIb1T-0007vy-Lf; Wed, 16 Sep 2020 13:15:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08GH1krO151283; Wed, 16 Sep 2020 13:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3bF7rTonqSubCRHLOLbqUYXUwVIhRRtEIh6I++vECZQ=;
 b=azgH51sBVX60TtwaidumAyg+Gcat3PY8b8d2ByVw2nZnoOmB8zgv7FYFTg7GoCkItPGC
 zwuyr9n458quBrXuTPcK7PFBYaSi9bHq9wCRWR3KgADshpnNUT/21b1fw4j2rCsSGPkh
 uOd3fUCfAbn9WbXS+4c5VEC7CODRNoXCVlHW6Pyi+w5aNpF8hOoGCJrvdPk3sRgyrK6m
 /PDFWjRCRtr2zlAj3WTHRB4fsl9PyA6aTrUNE5Qst4yVCCOfGcoG+X8aMU9JewZZiY1A
 HYsHaQLK1cPcTD+75ZHpKKoTXqUcn3IMplfbWHbqF5zVAyYGT/3Vl0vz3CWbCN4MJ6TY Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33knk1jrky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2020 13:15:09 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08GHCZDH000586;
 Wed, 16 Sep 2020 13:15:09 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33knk1jrk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2020 13:15:08 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GH2TsH014273;
 Wed, 16 Sep 2020 17:15:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02wdc.us.ibm.com with ESMTP id 33k67bx52e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2020 17:15:07 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08GHF6Mu54067470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2020 17:15:06 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35DED6A047;
 Wed, 16 Sep 2020 17:15:06 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46DAB6A051;
 Wed, 16 Sep 2020 17:15:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.149.137])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Sep 2020 17:15:05 +0000 (GMT)
Subject: Re: [PATCH v6 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
To: Cornelia Huck <cohuck@redhat.com>
References: <20200915194416.107460-1-walling@linux.ibm.com>
 <20200916175300.5c2b6bbb.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <3f4c28d6-fe5f-2e52-2e51-3190621ea63d@linux.ibm.com>
Date: Wed, 16 Sep 2020 13:15:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916175300.5c2b6bbb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-16_11:2020-09-16,
 2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 13:15:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.062,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, sumanthk@linux.ibm.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 11:53 AM, Cornelia Huck wrote:

[...]

>>
> 
> Thanks, applied.
> 
> 

Thanks Conny.

Much appreciated for everyone's patience and review. The only thing I'd
like to hold out on for now is for someone to take a peek at patch #3
with respect to the protected virtualization stuff. I don't know too
much about it, honestly, and I want to ensure that dynamically
allocating memory for the SCCB makes sense there. The alternative would
be to allocate a static 4K for the work_sccb.

-- 
Regards,
Collin

Stay safe and stay healthy

