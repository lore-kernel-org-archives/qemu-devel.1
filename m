Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F8CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D067420716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GiO5yte2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D067420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6K1C-0001kj-Tk
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k6K0P-0001Fk-PP; Thu, 13 Aug 2020 16:39:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24784
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k6K0N-0007Tz-K5; Thu, 13 Aug 2020 16:39:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07DKUqpm116887; Thu, 13 Aug 2020 16:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HIbd55gQYgUr8yUE0rAxv9AV4i95qtwpucMHygg7Q+Y=;
 b=GiO5yte2W8vpW7yvYLp0SMOGt9S2GbLjKR77ItASyLVf/eVG9RH27FrBfWnY5mTeCJ6/
 Lf48bkd1nMGxLjF/EjM+ceEO5FBtLZLGlwb5daKXbZCXKOTC6tuzhK/HjNTLE8J6hwGL
 amp1fT4g5/Dex5VoH5WwGffrYnEpHQm1D7u/X4xTGQv8rFD+0tQHoYGLd+Tv4YmhcXEw
 4ILE6o+u7Rh56HaCRTCWG2biOgpGVJm0eLAZfovWsL45KPBy2rHRPhRS971Z8sJMembq
 03L0IQTdE+Jt0XFFN7SOMRdm+Sw4AbjoqUyLXdOIPhyL/dN5qh2OWPGLWRvoz3DAEtcc /Q== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32w0n0ypex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 16:39:03 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DKZBps016115;
 Thu, 13 Aug 2020 20:39:02 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03dal.us.ibm.com with ESMTP id 32skp9r627-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 20:39:02 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07DKd2cB40894876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2020 20:39:02 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC911112064;
 Thu, 13 Aug 2020 20:39:01 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE619112063;
 Thu, 13 Aug 2020 20:39:00 +0000 (GMT)
Received: from oc6336877782.ibm.com (unknown [9.85.187.161])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 13 Aug 2020 20:39:00 +0000 (GMT)
Subject: Re: [PATCH] spapr/xive: Use xive_source_esb_len()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159733969034.320580.6571451425779179477.stgit@bahia.lan>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Message-ID: <b5cfd02b-abf7-8d03-7ae2-1f483bf7b0bc@linux.vnet.ibm.com>
Date: Thu, 13 Aug 2020 17:38:59 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <159733969034.320580.6571451425779179477.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-13_16:2020-08-13,
 2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130142
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=gromero@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 15:03:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Greg,

On 8/13/20 2:28 PM, Greg Kurz wrote:
> static inline size_t xive_source_esb_len(XiveSource *xsrc)
> {
>      return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> }
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> Follow-up on "ppc/xive: Rework setup of XiveSource::esb_mmio"
> http://patchwork.ozlabs.org/project/qemu-devel/patch/159679992680.876294.7520540158586170894.stgit@bahia.lan/
> ---
>   hw/intc/spapr_xive.c     |    2 +-
>   hw/intc/spapr_xive_kvm.c |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 3c84f64dc464..4bd0d606ba17 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -336,7 +336,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
>   
>       /* Set the mapping address of the END ESB pages after the source ESBs */
> -    xive->end_base = xive->vc_base + (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> +    xive->end_base = xive->vc_base + xive_source_esb_len(xsrc);
>   
>       /*
>        * Allocate the routing tables
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 82a6f99f022d..3263b982239a 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -831,7 +831,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
>   
>       /* Clear the KVM mapping */
>       xsrc = &xive->source;
> -    esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> +    esb_len = xive_source_esb_len(xsrc);

hrm I'd like to not add another level of indirection here.
In this specific case I think it's more clear to read just

1ull << xsrc->esb_shift) * xsrc->nr_irqs

and get the idea of one IRQ per ESB page (or pair of pages,
for trigger and management), than one having to look at
what is inside "a box" called xive_source_esb_len().

Wrapping it under another function doesn't help more when
reading the code, XIVE is already tricky enough :)


Cheers,
Gustavo

PS: It seems something messed up with the commit message. It
can be that the ML did that tho...

