Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C92FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA10C2076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BvdYvQze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA10C2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGbn-0007BR-IF
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kYGas-0006iS-Qm
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:40:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kYGaq-0002ia-JX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:40:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09TMVxfZ025189
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 18:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cCcrVGzOuTYzWuCWGIjGmU6FcPujua55XN/23RJCDCA=;
 b=BvdYvQzejMHSQPZNjPRyuySKb4BztUNhpLKddrdDljSUhFC98J3X6LOYlqSm/roLWm7G
 nFEOn8A+NVMlLoaIGLWCsrFmCZFZ4TRNbxfklX4kPYPTqtYYBiHOUL0+KW8xlOpxTYfc
 vb4+BsxUG7zFNz9/UrigS2uvQKPYtbC9dPIaBJ13biytLZ6XEtHCsBUxyAOHtnN4X7kE
 9jaPI+zodoI/ttirO9KCleOT67eQAqWM2zAuVdoa2KK18yf4MF/nqifzG4YHvJTOVzu8
 pNwwzab5hp8z/eM1g1VV6D9J5NQiE0h2ghllqeV8/pu8oYEH1aZNU+ZI3hmuoKLPLjeB cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34fyxsejuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 18:40:25 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09TMdJKO052235
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 18:40:25 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34fyxseju7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2020 18:40:25 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09TMbNLf027760;
 Thu, 29 Oct 2020 22:40:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 34cbw9r224-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2020 22:40:24 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09TMeN2s53215708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2020 22:40:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AED078064;
 Thu, 29 Oct 2020 22:40:23 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9E6578063;
 Thu, 29 Oct 2020 22:40:22 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2020 22:40:22 +0000 (GMT)
Subject: Re: [PATCH 29/36] qdev: Move qdev_prop_tpm declaration to tpm_prop.h
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-30-ehabkost@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <a8fc74ce-5e93-327a-d235-b1c1c4873269@linux.ibm.com>
Date: Thu, 29 Oct 2020 18:40:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201029220246.472693-30-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-29_12:2020-10-29,
 2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 18:40:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.261,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 6:02 PM, Eduardo Habkost wrote:
> Move the variable declaration close to the macro that uses it.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org


Reviewed-by:  Stefan Berger <stefanb@linux.ibm.com>

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
> index e1ef466790..2b00a1bcf6 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -18,7 +18,6 @@ extern const PropertyInfo qdev_prop_uint64;
>   extern const PropertyInfo qdev_prop_int64;
>   extern const PropertyInfo qdev_prop_size;
>   extern const PropertyInfo qdev_prop_string;
> -extern const PropertyInfo qdev_prop_tpm;
>   extern const PropertyInfo qdev_prop_on_off_auto;
>   extern const PropertyInfo qdev_prop_size32;
>   extern const PropertyInfo qdev_prop_uuid;



