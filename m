Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70917206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70917206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLpe-0001aT-OM
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjLod-0000AL-1y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:56:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjLoa-0005Tn-AW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:56:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05BBVpGw096037; Thu, 11 Jun 2020 07:56:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31kdn6kb8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 07:56:08 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05BBX8cN099714;
 Thu, 11 Jun 2020 07:56:08 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31kdn6kb77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 07:56:08 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BBsrVj023151;
 Thu, 11 Jun 2020 11:56:07 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02wdc.us.ibm.com with ESMTP id 31g2s8v7y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 11:56:07 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05BBu65w53281070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2020 11:56:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D17C112062;
 Thu, 11 Jun 2020 11:56:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F63D112061;
 Thu, 11 Jun 2020 11:56:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2020 11:56:06 +0000 (GMT)
Subject: Re: [PATCH 4/8] hw/tpm: Remove unnecessary 'tpm_int.h' header
 inclusion
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200610200247.21378-1-philmd@redhat.com>
 <20200610200247.21378-5-philmd@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <75a54014-700e-2a32-307c-ac1ea9d01b84@linux.ibm.com>
Date: Thu, 11 Jun 2020 07:56:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200610200247.21378-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-11_10:2020-06-10,
 2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 07:55:30
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 4:02 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   hw/tpm/tpm_crb.c        | 1 -
>   hw/tpm/tpm_spapr.c      | 1 -
>   hw/tpm/tpm_tis_common.c | 1 -
>   3 files changed, 3 deletions(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index cd004e7f8e..664ff70ef9 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -25,7 +25,6 @@
>   #include "migration/vmstate.h"
>   #include "sysemu/tpm_backend.h"
>   #include "sysemu/reset.h"
> -#include "tpm_int.h"
>   #include "tpm_util.h"
>   #include "tpm_ppi.h"
>   #include "trace.h"
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index ce65eb2e45..ab1a86ad6e 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -20,7 +20,6 @@
>   #include "migration/vmstate.h"
>   
>   #include "sysemu/tpm_backend.h"
> -#include "tpm_int.h"
>   #include "tpm_util.h"
>   
>   #include "hw/ppc/spapr.h"
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index 1af4bce139..94704870f6 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -33,7 +33,6 @@
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
>   #include "sysemu/tpm_backend.h"
> -#include "tpm_int.h"
>   #include "tpm_util.h"
>   #include "tpm_ppi.h"
>   #include "trace.h"



