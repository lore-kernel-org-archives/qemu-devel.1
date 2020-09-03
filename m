Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455DC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533E32083B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IyuSS3xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533E32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDypW-0005PQ-HL
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kDyoh-0004xB-Nt
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 19:38:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kDyof-0001KZ-KP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 19:38:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 083NWGoe131378
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2020 19:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UVgLu1CCoIn4FpQADHF9EPkxhhmDe0ulmIqoK2n8zvU=;
 b=IyuSS3xQOM1oe9/Xx55lRQUTYdJhsxD3D87Ked2uKt11I3d5U+b0s4YlV+1g8xsPl6sU
 xI4cqjwjpBF29QEUSA8wOisvVO9OdCki6R6U41AywJsDzmsIfqkDxuiH0ldunE6L5diX
 8VU2q7lre3T2obDyl8SAcgqgtfBfZxolp2cxzD4bO3EUz+giPOCuEx2sRu5NrlSaj2Aq
 JC40veGkWNDd+TACyWWtJUEx6ySFvCOeTd/MkmqOOGngpWbI7XMjCgjS87FUI6K/Dcy3
 kGtLTPnHz4ovwv3spCyMjQgdLACIGL7isK1S8j/z/7GJ0Ww0QzJ/hWRULJDnYoOsIEvL Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33b9931f69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 19:38:50 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 083Na5L1145411
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2020 19:38:50 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33b9931f60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2020 19:38:50 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 083Nc31R000556;
 Thu, 3 Sep 2020 23:38:49 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03dal.us.ibm.com with ESMTP id 337en9xba9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2020 23:38:49 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 083NcncG43909474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2020 23:38:49 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2833E112062;
 Thu,  3 Sep 2020 23:38:49 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 140E1112061;
 Thu,  3 Sep 2020 23:38:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2020 23:38:49 +0000 (GMT)
Subject: Re: [PATCH 50/63] tpm_crb: Rename CRB to TPM_CRB
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-51-ehabkost@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <82df1626-f976-b726-8168-52a05bbeb7ef@linux.ibm.com>
Date: Thu, 3 Sep 2020 19:38:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-51-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-03_14:2020-09-03,
 2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
>   hw/tpm/tpm_crb.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index aa9c00aad3..f4e3f0abbc 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -47,7 +47,7 @@ struct CRBState {
>   };
>   typedef struct CRBState CRBState;
>   
> -DECLARE_INSTANCE_CHECKER(CRBState, CRB,
> +DECLARE_INSTANCE_CHECKER(CRBState, TPM_CRB,
>                            TYPE_TPM_CRB)
>   
>   #define CRB_INTF_TYPE_CRB_ACTIVE 0b1
> @@ -86,7 +86,7 @@ enum crb_cancel {
>   static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
>                                     unsigned size)
>   {
> -    CRBState *s = CRB(opaque);
> +    CRBState *s = TPM_CRB(opaque);
>       void *regs = (void *)&s->regs + (addr & ~3);
>       unsigned offset = addr & 3;
>       uint32_t val = *(uint32_t *)regs >> (8 * offset);
> @@ -113,7 +113,7 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
>   static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>                                  uint64_t val, unsigned size)
>   {
> -    CRBState *s = CRB(opaque);
> +    CRBState *s = TPM_CRB(opaque);
>       uint8_t locty =  addr >> 12;
>   
>       trace_tpm_crb_mmio_write(addr, size, val);
> @@ -190,7 +190,7 @@ static const MemoryRegionOps tpm_crb_memory_ops = {
>   
>   static void tpm_crb_request_completed(TPMIf *ti, int ret)
>   {
> -    CRBState *s = CRB(ti);
> +    CRBState *s = TPM_CRB(ti);
>   
>       s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
>       if (ret != 0) {
> @@ -201,7 +201,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
>   
>   static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
>   {
> -    CRBState *s = CRB(ti);
> +    CRBState *s = TPM_CRB(ti);
>   
>       return tpm_backend_get_tpm_version(s->tpmbe);
>   }
> @@ -232,7 +232,7 @@ static Property tpm_crb_properties[] = {
>   
>   static void tpm_crb_reset(void *dev)
>   {
> -    CRBState *s = CRB(dev);
> +    CRBState *s = TPM_CRB(dev);
>   
>       if (s->ppi_enabled) {
>           tpm_ppi_reset(&s->ppi);
> @@ -281,7 +281,7 @@ static void tpm_crb_reset(void *dev)
>   
>   static void tpm_crb_realize(DeviceState *dev, Error **errp)
>   {
> -    CRBState *s = CRB(dev);
> +    CRBState *s = TPM_CRB(dev);
>   
>       if (!tpm_find()) {
>           error_setg(errp, "at most one TPM device is permitted");



