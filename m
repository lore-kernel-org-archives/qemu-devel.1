Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2EFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6189F21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGxggF2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6189F21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaiXN-0002Ty-Gv
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaiLt-0002J6-37
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaiLg-0002Pm-7A
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:38:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43270
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaiLf-0002Lh-5m
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575041901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLxPmCibd/jvExQ+b8ZmycwQV2L50zWdzkVxWAZ1Lxs=;
 b=NGxggF2eI3pzRyfxTbPi6C4PLLuHJF7zF24asPDAz2j3ZYe3smfzriLb4bEkeaouTlYqo4
 wd+dNXAoLNgONPk/u1oT+ECLYCsDoO3DTCPCebyXTbihpMtoQguOvAj71GzZNw8CTXdYtZ
 pJwFSvP1xNRdnHGiOpZt99P7EFgTcRg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-fDuu4-gEOlOqgUxmdr7tMg-1; Fri, 29 Nov 2019 10:38:20 -0500
Received: by mail-wm1-f72.google.com with SMTP id l11so4686844wmi.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 07:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dLxPmCibd/jvExQ+b8ZmycwQV2L50zWdzkVxWAZ1Lxs=;
 b=W0tt2mk8juZmhpRgujCq1vz+UzC88JQC1Z6tMayyn/1D3N/cP569J3mmhkDe1bxUTQ
 MHxZppU/2B9nNpJbzdQCSCp6DLgvb2MQr8OD4+p6wi3f5fpMlRPpTT1FK3KvhJ7FuEYi
 H7oL5H5aD1BRhjejT8xKyIXCjH+nR24j2UNdn/MZ3FFKuzkgzUtjhSwkWyqfWUDo62Ir
 7SuiVk+289F+OJcgn/YGWJLf3ZPElsmf8ayq4Ajgl7v1B+6zvp4Mi5Gtly4uqVHZKDlw
 6i2k9bo13IGxnL0ocBOS+CABGUbsb5F7Rz6OwoGRErdr5l/2awsIGrOh8ukAZ+4kysnR
 co1A==
X-Gm-Message-State: APjAAAWrBusV9q/KEAOrw82l3NPLQNlYt1zMoZyQn2SvhjOH4xc0u/Hn
 x8TMkY7sxs5hZ+zuR2d7J/o8qSWZ2sG1uKtkY0fGySznXBY0OAjOG36f+bZFt5L6BaTFRJ19yGS
 c1e5BPv4uspnSo+I=
X-Received: by 2002:adf:a551:: with SMTP id j17mr53471052wrb.18.1575041898635; 
 Fri, 29 Nov 2019 07:38:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7qSzPs8nWCGnGeGRfTAxdwLaJeO65SrMeX/kRJVKGB3wgalgeoCzMvFNe/dmOLh0Yi3AATA==
X-Received: by 2002:adf:a551:: with SMTP id j17mr53471040wrb.18.1575041898449; 
 Fri, 29 Nov 2019 07:38:18 -0800 (PST)
Received: from [192.168.1.74] (67.23.27.109.rev.sfr.net. [109.27.23.67])
 by smtp.gmail.com with ESMTPSA id h15sm28786322wrb.44.2019.11.29.07.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 07:38:17 -0800 (PST)
Subject: Re: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loopback
 mode.
To: bilalwasim676@gmail.com, qemu-devel@nongnu.org
References: <20191129150508.24404-1-bilalwasim676@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <afe9efde-7ac1-8607-446a-8fbf10accece@redhat.com>
Date: Fri, 29 Nov 2019 16:38:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129150508.24404-1-bilalwasim676@gmail.com>
Content-Language: en-US
X-MC-Unique: fDuu4-gEOlOqgUxmdr7tMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>,
 aa1ronham@gmail.com, jcd@tribudubois.net, qemu-arm@nongnu.org,
 bilal_wasim@mentor.com, linux@roeck-us.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bilal,

Cc'ing Jason, the maintainer of network devices.

On 11/29/19 4:05 PM, bilalwasim676@gmail.com wrote:
> From: bwasim <bilal_wasim@mentor.com>

Your git setup misses your 'user.name', you could fix it running:

   git config user.name "Bilal Wasim"

(eventually with the --global option).

The patch looks good otherwise.

Thanks!

> Loopback mode only works when specific conditions (as dictated
> by the IP guide) are met, i.e. the MII_MODE is set and the
> RMII_MODE is cleared. If not, we simply send the packet on the
> output queue (for TX to the host network). Tested by running a
> custom RTOS and TXing a ton of packets. The same packets were
> received on the RX side..
> 
> Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> ---
>   hw/net/imx_fec.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index bd99236864..c51e7f7363 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -256,6 +256,29 @@ static const VMStateDescription vmstate_imx_eth = {
>   
>   static void imx_eth_update(IMXFECState *s);
>   
> +/*
> + * Function to check if the MAC is configured to run in loopback mode.
> + * If so, invoke the "receive" routine.
> + * Else write to the output.
> + * */
> +static void send_pkt(IMXFECState *s, uint8_t *frame, int frame_size)
> +{
> +    NetClientState *nc = qemu_get_queue(s->nic);
> +
> +    /*
> +     * Loopback or Normal mode ?
> +     * Per the FEC Manual: If loopback is enabled, the MII_MODE
> +     * should be SET and the RMII_MODE should be cleared. Loopback
> +     * will only work if this criterion is met. If not met,
> +     * we will send the frame on the output queue. */
> +    if ((s->regs[ENET_RCR] & ENET_RCR_LOOP) && (s->regs[ENET_RCR] & ENET_RCR_MII_MODE)
> +            && !(s->regs[ENET_RCR] & ENET_RCR_RMII_MODE)) {
> +        nc->info->receive(nc, frame, frame_size);
> +    } else {
> +        qemu_send_packet(nc, frame, frame_size);
> +    }
> +}
> +
>   /*
>    * The MII phy could raise a GPIO to the processor which in turn
>    * could be handled as an interrpt by the OS.
> @@ -488,7 +511,7 @@ static void imx_fec_do_tx(IMXFECState *s)
>           frame_size += len;
>           if (bd.flags & ENET_BD_L) {
>               /* Last buffer in frame.  */
> -            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_size);
> +            send_pkt(s, (uint8_t *)&s->frame, frame_size);
>               ptr = s->frame;
>               frame_size = 0;
>               s->regs[ENET_EIR] |= ENET_INT_TXF;
> @@ -586,7 +609,7 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
>               }
>               /* Last buffer in frame.  */
>   
> -            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_size);
> +            send_pkt(s, (uint8_t *)&s->frame, frame_size);
>               ptr = s->frame;
>   
>               frame_size = 0;
> 


