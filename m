Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B13EC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCA6206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DXZV/DRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCA6206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kakPL-0006J0-VH
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kakLN-0003j5-4F
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:50:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57128
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kakLK-00043y-6p
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:50:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A5IVWob087272
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 13:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/IALuIXI4SOUxYGhc8o6ZnlW6n6S8voN/zY7VrJHzI8=;
 b=DXZV/DRp0PX9VbMWXUkeAazxdFaxoTO2lcQUGejSs4KNcv9xHJ5WOZeyFK/eoJQ1/LRH
 AiC4DdRDrbwCbOvaL6+8YhHlp0kw8tI9phpJ1qnMAtVld3U+gPPEiTNBd7tQP0GYYmjg
 IzQNi5O3W0cPyik2m1qUtSQykQYa/KY+kZvsJWvlPwqV/oLLYVuruXrAZNuFMUBZhaom
 txnHRNaD4dl7Sch/miqeabpNGMNA/WVLlLvUarVkonP1G5PxWX8cajDXMS45DIQPNESF
 E51YzJiEuLU2RviRflcZRgyQj4QUIHtPN6Lkt0iMK0UZE8nDltDt16hUv+gLh+zMM+QC fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34m4enc4cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 13:50:37 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5IW833089349
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 13:50:36 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34m4enc4cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 13:50:36 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5IoJ1v006990;
 Thu, 5 Nov 2020 18:50:36 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01wdc.us.ibm.com with ESMTP id 34h0251h9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 18:50:36 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A5IoTJ411928260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2020 18:50:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28C487805F;
 Thu,  5 Nov 2020 18:50:35 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8939D7805E;
 Thu,  5 Nov 2020 18:50:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2020 18:50:34 +0000 (GMT)
Subject: Re: [PATCH v2 37/44] qdev: Move qdev_prop_tpm declaration to
 tpm_prop.h
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201104160021.2342108-38-ehabkost@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <60140708-fc33-608d-eebb-5841e7640ada@linux.ibm.com>
Date: Thu, 5 Nov 2020 13:50:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201104160021.2342108-38-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-05_11:2020-11-05,
 2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 13:50:37
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 11:00 AM, Eduardo Habkost wrote:
> Move the variable declaration close to the macro that uses it.
>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>   hw/tpm/tpm_prop.h            | 2 ++
>   include/hw/qdev-properties.h | 1 -
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
> index 85e1ae5718..871af584b7 100644
> --- a/hw/tpm/tpm_prop.h
> +++ b/hw/tpm/tpm_prop.h
> @@ -25,6 +25,8 @@
>   #include "sysemu/tpm_backend.h"
>   #include "hw/qdev-properties.h"
>   
> +extern const PropertyInfo qdev_prop_tpm;
> +
>   #define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
>       DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
>   
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 2bec65c8e5..c3eaf5e3c5 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -63,7 +63,6 @@ extern const PropertyInfo qdev_prop_uint64;
>   extern const PropertyInfo qdev_prop_int64;
>   extern const PropertyInfo qdev_prop_size;
>   extern const PropertyInfo qdev_prop_string;
> -extern const PropertyInfo qdev_prop_tpm;
>   extern const PropertyInfo qdev_prop_on_off_auto;
>   extern const PropertyInfo qdev_prop_size32;
>   extern const PropertyInfo qdev_prop_arraylen;



