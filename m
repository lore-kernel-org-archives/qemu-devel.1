Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D4FC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C57922267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bpWPzxIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C57922267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVa3U-0006xk-5k
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kVa2m-0006Rs-1J; Thu, 22 Oct 2020 08:50:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kVa2j-0006xL-QY; Thu, 22 Oct 2020 08:50:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09MCXT0M031188; Thu, 22 Oct 2020 08:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qNyFhLFWw94r/iBWbkivCOOtM6+sUhDVC5NAlw9CwqA=;
 b=bpWPzxIB5WRrxF8sOo1iWNm2/ktTWXgbUh9fkQ92MDc0V8Bi7N9l028v9Z8TIcvFSa1I
 EU6bxz14phPtYvhJPo5qjwqvC+72eqeYfxTFY397fFFaYazYCRDIPvOW2yhvLJHDtcbu
 yTXgF1qLA7LW639NIPSch85fDNC7iCah+5dQis1tiYRnh61dJiIuNMm4yl0MdpJyzrYh
 L/y3UH2o6Sm9OB97fWCQYI4kXu/uaSuE2PrlkdPxhq8fPDFZac6m7a4RWbgqHGv4LkAT
 lnn7IBHIo5CCeKtWsx89J+G2ddycJgr7MOv+1WNO45/TU2pIRsdIr7zxI2Vg5h7wajxL BA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b5pd126g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 08:50:05 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09MCXTRb031190;
 Thu, 22 Oct 2020 08:50:05 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b5pd125p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 08:50:05 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MCYrk7021855;
 Thu, 22 Oct 2020 12:50:04 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01wdc.us.ibm.com with ESMTP id 347r89g3nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 12:50:04 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09MCnu2A64094696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 12:49:56 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48BC9BE056;
 Thu, 22 Oct 2020 12:50:01 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C93DBE054;
 Thu, 22 Oct 2020 12:50:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.200.244])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 22 Oct 2020 12:50:00 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] s390x: pv: Diag318 fixes
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20201022103135.126033-1-frankja@linux.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <56891e08-68d4-6d5a-8525-f33ff0a0e2d7@linux.ibm.com>
Date: Thu, 22 Oct 2020 08:50:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022103135.126033-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-22_06:2020-10-20,
 2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:40:49
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 6:31 AM, Janosch Frank wrote:
> Here are two fixes for the diag318 support that fix crashes when
> booting PV guests.
> 
> We're working on extending our testing to catch problems like these
> earlier.
> 
> 
> Branch:
> https://gitlab.com/frankja/qemu/-/commits/bb/frankja/diag318_fixes
> 
> CI:
> https://gitlab.com/frankja/qemu/-/pipelines/206174979
> 
> 
> V2:
> 	* Moved fencing nto cpu model functions
> 	* Added rev-by and acks
> 
> 
> Janosch Frank (2):
>   s390x: pv: Remove sclp boundary checks
>   s390x: pv: Fix diag318 PV fencing
> 
>  hw/s390x/sclp.c             | 5 -----
>  target/s390x/cpu_features.c | 5 +++++
>  target/s390x/cpu_features.h | 4 ++++
>  target/s390x/cpu_models.c   | 4 ++++
>  target/s390x/kvm.c          | 3 +--
>  5 files changed, 14 insertions(+), 7 deletions(-)
> 

Thanks for correcting this. You've certainly received plenty of reviews
and ack's, but since this touches code I worked on:

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
Collin

Stay safe and stay healthy

