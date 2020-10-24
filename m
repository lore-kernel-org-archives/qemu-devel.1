Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DFC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD222076D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SVwQT3qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD222076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWIth-0004le-17
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 08:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kWIsd-0004J3-Gj; Sat, 24 Oct 2020 08:42:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kWIsZ-0001TF-KV; Sat, 24 Oct 2020 08:42:43 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09OCWRp3178845; Sat, 24 Oct 2020 08:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EEjUiQQ1jFId9LHs457MOsOWXZJtUA8LEvIVIK61Atc=;
 b=SVwQT3qu0Zd86r7uXfgkHMKV2NsocBzCRIxydzv5PiA2FkiWt3IAjTnAPM11AGr4gr+s
 TSWnlc44yB5DipfDwgMBstWYeimmek3H0lPSoGBQWmCy9fLPtHKAs690gUCDOZjItU8F
 xV5aJL0lbfZTfseSbKzPGcpXaXFxUQOiWdBXzlZdhBvHewALkvzYY8D6o42X+KqHFS4W
 ajNvwTDixwcWDAVIn+Y6bJzb88zT5zEhu/KDt2OsDc6hJNKPAyi4SX4dLv/pakH/60LS
 7WS1r3VNfnme2mPxgsC9Mfp9z25ugM3VTp3p6WSnRXC1iIbe6o9QUab8wXCKZf6/7fs9 mA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34cfx7v6kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Oct 2020 08:42:37 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09OCX58F179686;
 Sat, 24 Oct 2020 08:42:36 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34cfx7v6kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Oct 2020 08:42:36 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09OCZDLb017236;
 Sat, 24 Oct 2020 12:42:35 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01wdc.us.ibm.com with ESMTP id 34cbw82ej7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Oct 2020 12:42:35 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09OCgY5W1507976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Oct 2020 12:42:34 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 553E06A04F;
 Sat, 24 Oct 2020 12:42:34 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49A296A04D;
 Sat, 24 Oct 2020 12:42:33 +0000 (GMT)
Received: from [9.160.36.16] (unknown [9.160.36.16])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 24 Oct 2020 12:42:33 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
 <4f779021-19c6-0203-e37d-563e17419db0@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <7033b159-b907-0aa9-3add-88e88a53f957@linux.vnet.ibm.com>
Date: Sat, 24 Oct 2020 08:42:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <4f779021-19c6-0203-e37d-563e17419db0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-24_09:2020-10-23,
 2020-10-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010240095
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 08:42:37
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-s390x <qemu-s390x@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/2020 1:17 AM, Thomas Huth wrote:
> Compiling all code with -Wno-void-pointer-to-enum-cast sounds like the wrong
> approach to me, since this might hide some real bugs in other spots instead.
> 
> Could you please try to cast the value through (uintptr_t) first, e.g. :
> 
>      S390Feat feat = (S390Feat)(uintptr_t) opaque;
> 
> It's a little bit ugly, but still better than to disable the warning
> globally, I think.
> 
>   Thomas

Hi Thomas,
I did a quick check and casting to a uintptr_t seem to be a working
solution to the issue. I will fix this in v3

Thanks,
Daniele

