Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CECC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9EB22260
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9EB22260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtjs-0002xs-Ch
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kQthj-0001CC-NB; Fri, 09 Oct 2020 10:49:07 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:50861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kQthh-0000X0-Mk; Fri, 09 Oct 2020 10:49:07 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.241])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 5C6476A77D1A;
 Fri,  9 Oct 2020 16:48:53 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 9 Oct 2020
 16:48:52 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00237030dfa-280e-44c1-bb73-c65194f67d83,
 424B68D8262774F7E0505757ECD126D3ED7B1FD9) smtp.auth=groug@kaod.org
Date: Fri, 9 Oct 2020 16:48:51 +0200
From: Greg Kurz <groug@kaod.org>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
Message-ID: <20201009164851.6ed9dedd@bahia.lan>
In-Reply-To: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e853ae8f-3684-4454-b676-c2813a05cfe1
X-Ovh-Tracer-Id: 8670836660998019366
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrhedugdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhtrhhivhhirghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 10:48:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-trivial@nongnu.org, jasowang@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 09 Oct 2020 07:02:56 -0700
Elena Afanasova <eafanasova@gmail.com> wrote:

> From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
> From: Elena Afanasova <eafanasova@gmail.com>
> Date: Fri, 9 Oct 2020 06:41:36 -0700
> Subject: [PATCH] hw/net: move allocation to the heap due to very large stack
>  frame
> 

Something seems to have gone wrong with the message body here, which
results in an awkward changelog... but maybe someone can fix that when
applying the patch.

> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/net/spapr_llan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 2093f1bad0..581320a0e7 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
>      SpaprVioDevice *sdev = spapr_vio_find_by_reg(spapr->vio_bus, reg);
>      SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
>      unsigned total_len;
> -    uint8_t *lbuf, *p;
> +    uint8_t *p;
> +    g_autofree uint8_t *lbuf = NULL;
>      int i, nbufs;
>      int ret;
>  
> @@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
>          return H_RESOURCE;
>      }
>  
> -    lbuf = alloca(total_len);
> +    lbuf = g_malloc(total_len);
>      p = lbuf;
>      for (i = 0; i < nbufs; i++) {
>          ret = spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),


