Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D469420782
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CbBI0FmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D469420782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMf7-0003Rb-Dx
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kaMXp-00025L-Hz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:26:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57176
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kaMXn-0008LP-9f
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:26:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A4H2HRe035508
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2020 12:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kKBZ+j7U70henpjK1wQ+CoY3gVLdjgzzuQGkyjVg3zY=;
 b=CbBI0FmJsBuMBzP2NLrnBg8uSudCUUq8rGx6NYVtwBTLgI2PkznU03zi6go503PJssuv
 qvupaDaG9Z68jVlzam67uXejkUe6noRpURaOMnQADl2pqVkB9xss5jJqjxivjFW2h2so
 YLmeyUqpVDl2ieMZ1yhREWzCxkElIfd8J4AHPoS1QyGovYzsZ+OHndeOWC2LOiH5MDXf
 gV6D5fZiZSPWZXdDZ8jfj1bKwzjXLIK1Fett/o10vu47L6sCPPyW/pKoXiFgqKQrGPqT
 zb+MseWvjzFhKSQd0k8ePCzVzR/YhG9xzoxdrfTyUvVcP3EwhSokGfMCWc9e3p9fz6X2 dg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34ksruq1n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 12:25:56 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A4H2RKM036591
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2020 12:25:56 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34ksruq1mv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2020 12:25:55 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A4HNVZF018469;
 Wed, 4 Nov 2020 17:25:55 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02dal.us.ibm.com with ESMTP id 34h022j5wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2020 17:25:55 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A4HPm2510683132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Nov 2020 17:25:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E31F07805F;
 Wed,  4 Nov 2020 17:25:53 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 223FD78060;
 Wed,  4 Nov 2020 17:25:53 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  4 Nov 2020 17:25:52 +0000 (GMT)
Subject: Re: [PATCH v2 18/44] qdev: Avoid using prop->name unnecessarily
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201104160021.2342108-19-ehabkost@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <bcf24d05-7281-1579-7bd2-15527b3257ad@linux.ibm.com>
Date: Wed, 4 Nov 2020 12:25:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201104160021.2342108-19-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-04_11:2020-11-04,
 2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=2 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 12:25:56
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 10:59 AM, Eduardo Habkost wrote:
> We already get the property name as argument to the property
> getter and setters, we don't need to use prop->name.  This will
> make it easier to remove the Property.name field in the future.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
> This is a new patch added in series v2
> ---
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>   backends/tpm/tpm_util.c          |  2 +-
>   hw/core/qdev-properties-system.c | 14 +++++++-------
>   hw/core/qdev-properties.c        |  4 ++--
>   3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index e91c21dd4a..dba2f6b04a 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -63,7 +63,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
>       s = qemu_find_tpm_be(str);
>       if (s == NULL) {
>           error_setg(errp, "Property '%s.%s' can't find value '%s'",
> -                   object_get_typename(obj), prop->name, str);
> +                   object_get_typename(obj), name, str);
>       } else if (tpm_backend_init(s, TPM_IF(obj), errp) == 0) {
>           *be = s; /* weak reference, avoid cyclic ref */
>       }
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 808e7136a0..202abd0e4b 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -141,7 +141,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
>       }
>       if (!blk) {
>           error_setg(errp, "Property '%s.%s' can't find value '%s'",
> -                   object_get_typename(OBJECT(dev)), prop->name, str);
> +                   object_get_typename(OBJECT(dev)), name, str);
>           goto fail;
>       }
>       if (blk_attach_dev(blk, dev) < 0) {
> @@ -262,10 +262,10 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
>       s = qemu_chr_find(str);
>       if (s == NULL) {
>           error_setg(errp, "Property '%s.%s' can't find value '%s'",
> -                   object_get_typename(obj), prop->name, str);
> +                   object_get_typename(obj), name, str);
>       } else if (!qemu_chr_fe_init(be, s, errp)) {
>           error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
> -                      object_get_typename(obj), prop->name, str);
> +                      object_get_typename(obj), name, str);
>       }
>       g_free(str);
>   }
> @@ -965,7 +965,7 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>           abort();
>       }
>   
> -    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
> +    visit_type_enum(v, name, &speed, prop->info->enum_table, errp);
>   }
>   
>   static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
> @@ -981,7 +981,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    if (!visit_type_enum(v, prop->name, &speed, prop->info->enum_table,
> +    if (!visit_type_enum(v, name, &speed, prop->info->enum_table,
>                            errp)) {
>           return;
>       }
> @@ -1050,7 +1050,7 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
>           abort();
>       }
>   
> -    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
> +    visit_type_enum(v, name, &width, prop->info->enum_table, errp);
>   }
>   
>   static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
> @@ -1066,7 +1066,7 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    if (!visit_type_enum(v, prop->name, &width, prop->info->enum_table,
> +    if (!visit_type_enum(v, name, &width, prop->info->enum_table,
>                            errp)) {
>           return;
>       }
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index a7bbc1235a..69181ce31d 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -50,7 +50,7 @@ void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
>       Property *prop = opaque;
>       int *ptr = qdev_get_prop_ptr(obj, prop);
>   
> -    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
> +    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
>   }
>   
>   void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
> @@ -65,7 +65,7 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
> +    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
>   }
>   
>   void qdev_propinfo_set_default_value_enum(ObjectProperty *op,



