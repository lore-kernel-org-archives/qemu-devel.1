Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06883C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EE320878
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i84I1ufq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyC3-0002u0-CX
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kVy8G-0007gH-KJ; Fri, 23 Oct 2020 10:33:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kVy8E-00023i-2g; Fri, 23 Oct 2020 10:33:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09NEVd3Z044491; Fri, 23 Oct 2020 10:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xfB5FtjMEpEG75KhXjFddPVSaii8axiMkw6/7ceAh9g=;
 b=i84I1ufqfzYBa3qFpYvIB0DQVttzRs3mJII2bG8A8pxddOa7TlScNWKDI8aqcm2FC04a
 OSFQ3xXVVoDSXz4iHmgHMya1zojcRUnVFryv7U42JQeWRrUZ+zp1Q6f6BrW+J/dtMoXg
 szj6K8bz9KMsZ29LAzcZFlsGVtwzeO911IfbYjS2Lk8zXnI7WLsO39+pOCw4MR2zoUx9
 rOXwgae4eBGqP4ceQv/P9K2gj78bLOgolhd3qX0gkS7/9TBbyzBWF+VC766wsFFNDZeh
 CakQPR5s8C5Q6CBy92s/6GyomVUyV2AATY778t6eMGCY8p+QN/kD/TEKxCm8KN1zOZDp Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34by72uqh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 10:33:22 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09NEWC6s051073;
 Fri, 23 Oct 2020 10:33:21 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34by72uqgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 10:33:21 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NERTjQ030791;
 Fri, 23 Oct 2020 14:33:20 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 347r89rw2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 14:33:20 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09NEXKYY22479330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 14:33:20 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00574112075;
 Fri, 23 Oct 2020 14:33:19 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5160112062;
 Fri, 23 Oct 2020 14:33:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2020 14:33:19 +0000 (GMT)
Subject: Re: [PATCH 23/30] tpm: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201014134248.14146-1-chetan4windows@gmail.com>
 <20201023123516.19843-1-chetan4windows@gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <0c40a9a1-062b-073a-c384-0fdb426bd819@linux.ibm.com>
Date: Fri, 23 Oct 2020 10:33:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201023123516.19843-1-chetan4windows@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-23_07:2020-10-23,
 2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230099
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 10:33:22
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.108,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 8:35 AM, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
>
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   backends/tpm/tpm_emulator.c    | 2 +-
>   backends/tpm/tpm_passthrough.c | 2 +-
>   backends/tpm/tpm_util.c        | 2 +-
>   hw/tpm/tpm_prop.h              | 2 +-
>   include/sysemu/tpm_util.h      | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 201cd38..a012adc 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -14,7 +14,7 @@
>    * This library is free software; you can redistribute it and/or
>    * modify it under the terms of the GNU Lesser General Public
>    * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>    *
>    * This library is distributed in the hope that it will be useful,
>    * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
> index 8f6f499..21b7459 100644
> --- a/backends/tpm/tpm_passthrough.c
> +++ b/backends/tpm/tpm_passthrough.c
> @@ -11,7 +11,7 @@
>    * This library is free software; you can redistribute it and/or
>    * modify it under the terms of the GNU Lesser General Public
>    * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>    *
>    * This library is distributed in the hope that it will be useful,
>    * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index b58d298..e6aeb63 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -8,7 +8,7 @@
>    * This library is free software; you can redistribute it and/or
>    * modify it under the terms of the GNU Lesser General Public
>    * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>    *
>    * This library is distributed in the hope that it will be useful,
>    * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
> index 85e1ae5..d19e40c 100644
> --- a/hw/tpm/tpm_prop.h
> +++ b/hw/tpm/tpm_prop.h
> @@ -8,7 +8,7 @@
>    * This library is free software; you can redistribute it and/or
>    * modify it under the terms of the GNU Lesser General Public
>    * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>    *
>    * This library is distributed in the hope that it will be useful,
>    * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/include/sysemu/tpm_util.h b/include/sysemu/tpm_util.h
> index 63e872c..08f0517 100644
> --- a/include/sysemu/tpm_util.h
> +++ b/include/sysemu/tpm_util.h
> @@ -8,7 +8,7 @@
>    * This library is free software; you can redistribute it and/or
>    * modify it under the terms of the GNU Lesser General Public
>    * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>    *
>    * This library is distributed in the hope that it will be useful,
>    * but WITHOUT ANY WARRANTY; without even the implied warranty of



