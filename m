Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBAF20786
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aO4zi4br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBAF20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDyqy-0006OT-70
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kDyq9-0005rr-Gv
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 19:40:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8300
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kDyq5-0001YM-NC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 19:40:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 083NUooD097895
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2020 19:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4tgUEMWFB6w5y3kFbcDVGF5j0H5r8KUHlknPjOls0jc=;
 b=aO4zi4brFpV7mKh2LytyHh+kdqtJ+13aDY38S+bflhfzX+xq1TfIlku5dSZi3c0Z/h/W
 cvDi+4GJ2WF5gfM6DLEG3LjXBfTQUnlG+xZELLnvYUfFIcKTeFgrzHHAvIg81uhQIheN
 qj+AdL/30HtgcprG7fWLlh/d3vYP1LyBvRjSPK+/kf+KPQTEkaquhE1GyPEbR0PqXSlr
 uFu6ICINDxaiJyS00m5fowowPvYowjFbi/Qr47rjkPxj76Y0srhQiHiWvmTDh/+vQScE
 PdnTp8Yn+fEqhhz2HJUxCgRtrP3qzRpIaXgMEWsJFudjch6eVEZPvay8LN+aVvnt5PYL BA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33b86aaynu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 19:40:20 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 083NUoB0097944
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2020 19:40:20 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33b86aaynk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2020 19:40:20 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 083NbEqj016669;
 Thu, 3 Sep 2020 23:40:20 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma05wdc.us.ibm.com with ESMTP id 337en9uevb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2020 23:40:20 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 083NeF9h34144800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2020 23:40:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 220FCC605A;
 Thu,  3 Sep 2020 23:40:19 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA9DCC6055;
 Thu,  3 Sep 2020 23:40:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2020 23:40:18 +0000 (GMT)
Subject: Re: [PATCH 51/63] tpm_spapr: Rename VIO_SPAPR_VTPM to TPM_SPAPR
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-52-ehabkost@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <7208b1cb-5811-8111-80c9-4bf23d590ec7@linux.ibm.com>
Date: Thu, 3 Sep 2020 19:40:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-52-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-03_14:2020-09-03,
 2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 19:38:51
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 6:42 PM, Eduardo Habkost wrote:
> Make the type checking macro name consistent with the TYPE_*
> constant.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> Cc: qemu-devel@nongnu.org
> ---
>   hw/tpm/tpm_spapr.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index e3775adc57..aa86d5f943 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -31,7 +31,7 @@
>   #define DEBUG_SPAPR 0
>   
>   typedef struct SpaprTpmState SpaprTpmState;
> -DECLARE_INSTANCE_CHECKER(SpaprTpmState, VIO_SPAPR_VTPM,
> +DECLARE_INSTANCE_CHECKER(SpaprTpmState, TPM_SPAPR,
>                            TYPE_TPM_SPAPR)
>   
>   typedef struct TpmCrq {
> @@ -132,7 +132,7 @@ static inline int spapr_tpm_send_crq(struct SpaprVioDevice *dev, TpmCrq *crq)
>   
>   static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
>   {
> -    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
> +    SpaprTpmState *s = TPM_SPAPR(dev);
>       TpmCrq local_crq;
>       TpmCrq *crq = &s->crq; /* requests only */
>       int rc;
> @@ -235,7 +235,7 @@ static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
>   
>   static void tpm_spapr_request_completed(TPMIf *ti, int ret)
>   {
> -    SpaprTpmState *s = VIO_SPAPR_VTPM(ti);
> +    SpaprTpmState *s = TPM_SPAPR(ti);
>       TpmCrq *crq = &s->crq;
>       uint32_t len;
>       int rc;
> @@ -283,7 +283,7 @@ static int tpm_spapr_do_startup_tpm(SpaprTpmState *s, size_t buffersize)
>   
>   static const char *tpm_spapr_get_dt_compatible(SpaprVioDevice *dev)
>   {
> -    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
> +    SpaprTpmState *s = TPM_SPAPR(dev);
>   
>       switch (s->be_tpm_version) {
>       case TPM_VERSION_1_2:
> @@ -297,7 +297,7 @@ static const char *tpm_spapr_get_dt_compatible(SpaprVioDevice *dev)
>   
>   static void tpm_spapr_reset(SpaprVioDevice *dev)
>   {
> -    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
> +    SpaprTpmState *s = TPM_SPAPR(dev);
>   
>       s->state = SPAPR_VTPM_STATE_NONE;
>       s->numbytes = 0;
> @@ -316,7 +316,7 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>   
>   static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
>   {
> -    SpaprTpmState *s = VIO_SPAPR_VTPM(ti);
> +    SpaprTpmState *s = TPM_SPAPR(ti);
>   
>       if (tpm_backend_had_startup_error(s->be_driver)) {
>           return TPM_VERSION_UNSPEC;
> @@ -377,7 +377,7 @@ static Property tpm_spapr_properties[] = {
>   
>   static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
>   {
> -    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
> +    SpaprTpmState *s = TPM_SPAPR(dev);
>   
>       if (!tpm_find()) {
>           error_setg(errp, "at most one TPM device is permitted");



