Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8164CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E7320878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sbrbmb9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E7320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpSH-00064c-So
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kLpQD-0004SR-1L; Fri, 25 Sep 2020 11:14:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13940
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kLpQ7-0004b4-1p; Fri, 25 Sep 2020 11:14:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08PF1sUY118340; Fri, 25 Sep 2020 11:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4zzNQ9rJvoq/fCRfOoMPYd7hgaROxP7KhwypdTfrmt4=;
 b=Sbrbmb9AL2sPjTsSN5mjzyBgZDxAjd3RhEFqP5wXaDWYf5U/CA5RqT3w+z40VpWRzgyW
 UuqOSna0xxWrRG0nKct4J+T0nuGhPBF+QlMVoZV5GR17ing1GCmJakmF7gkXQ+VB1Do1
 7s7AwLgPpI8BrIh8acw8BLqtox8FKJThmtk0w+/WIU+aWRsvZcnCdxl1aUMyIdgP6OM2
 uEoU8YR/79eBzy2fiMUfItXhgilKMIVYJJVCu0xatKo/cxDsULIYl/QhX3j+Zbv9+Em2
 u9ZgRwVPdMmkeY7prt2jCf8Cohp65AbsykVkF5Aj1p51r2txnY8lyyAtG4Rb9wVMDhb8 XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33se5at7y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 11:13:53 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08PF4RCq128918;
 Fri, 25 Sep 2020 11:13:53 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33se5at7xx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 11:13:53 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08PEup7F003724;
 Fri, 25 Sep 2020 15:13:52 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma02wdc.us.ibm.com with ESMTP id 33n9m9t0er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 15:13:52 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08PFDpmB59834760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 15:13:51 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52CC46E04E;
 Fri, 25 Sep 2020 15:13:51 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 695B36E04C;
 Fri, 25 Sep 2020 15:13:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.179.152])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Sep 2020 15:13:50 +0000 (GMT)
Subject: Re: [PATCH v6 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
From: Collin Walling <walling@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
References: <20200915194416.107460-1-walling@linux.ibm.com>
 <20200916175300.5c2b6bbb.cohuck@redhat.com>
 <3f4c28d6-fe5f-2e52-2e51-3190621ea63d@linux.ibm.com>
Message-ID: <82f7c31c-16f6-8450-d241-ca8257db6469@linux.ibm.com>
Date: Fri, 25 Sep 2020 11:13:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3f4c28d6-fe5f-2e52-2e51-3190621ea63d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-25_12:2020-09-24,
 2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 10:17:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, sumanthk@linux.ibm.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 1:15 PM, Collin Walling wrote:
> On 9/16/20 11:53 AM, Cornelia Huck wrote:
> 
> [...]
> 
>>>
>>
>> Thanks, applied.
>>
>>
> 
> Thanks Conny.
> 
> Much appreciated for everyone's patience and review. The only thing I'd
> like to hold out on for now is for someone to take a peek at patch #3
> with respect to the protected virtualization stuff. I don't know too
> much about it, honestly, and I want to ensure that dynamically
> allocating memory for the SCCB makes sense there. The alternative would
> be to allocate a static 4K for the work_sccb.
> 

I had someone take a look at the patch for PV and was told everything
looks sane. Since the patches have already been applied, it seems like
it's too late to add a reviewed-by from someone?

Either way: thanks to everyone for the journey on getting these patches
through!

-- 
Regards,
Collin

Stay safe and stay healthy

