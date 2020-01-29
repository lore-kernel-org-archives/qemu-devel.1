Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C55AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17ECF2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw+tgT7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ECF2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpvq-0006II-2G
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1iwpuV-00059J-9x
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1iwpuU-0005QP-8u
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:09:47 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1iwpuU-0005Or-2C
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:09:46 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so311788wmc.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=7Bes8iH3GwfvjDi15qrVOynL/zOgsy2+VBm9XYKfcCY=;
 b=Nw+tgT7DKe+r1zziAr5P3OooT/NyIrPv10CS6Uc9VYpRF/ErpPpUXcXFTC/oqePxiA
 7qG9O4NJ4TUuS4LAWj7RBbz58AOivP5NqzhyhKQIiXNITejGMxjL+7Qc23PCMQpVaWDp
 bfy/wM9zPtO+d+5IOo7RALaIZJF6/UzkGFMGIn4k5G3v35gpQHEbU/iq03FFKCXJNYM4
 Qx3ax0CFl8gggd6dL7WeFEjeq5yNmTT5MD8Lcduq3xKz9e0AUKbGMpvdlKlqcgBYZFwL
 nt4E6DDf5r+UWzMztdHYyjKQXwyFC3yA5O4Mh62cDLRjlRcfn8/tPnPo9jabVdMdpg6g
 3sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=7Bes8iH3GwfvjDi15qrVOynL/zOgsy2+VBm9XYKfcCY=;
 b=ZYFdmyX0z4PHFfARCOErzszFF5ZPHzTLCvtAPbwYpGNIwqfPyySS1kFHihCKJefBfv
 qiV/aCSqeBYdzT/BkwI6GjlVWvllmeWkjXQ8vBn9TNuGpTpqphNS8L2/maySYnU3WsE/
 kS5hZWi3X5U+9gpZuTY/nnM2B3MEsTmrlH97jUiQnKAcDkfEHR31j8zXehrKZ2AEUXBD
 q+lEc56/owInlt6cUumCfZ1Ptq1VIf0DqGJyAbOryTE7UQs/dN+khxxqljBODCnZ/3wR
 vidpgTlMSAhIGE9tdsXaFffKUu7atXij2tJCOegj4vQY8bd54Y/F8LyUwDf/ELZU/X6/
 IdjA==
X-Gm-Message-State: APjAAAX+K+kNHDQPB2HiQhR8dbmBM1EqmX6YB3/281vlK21WJnb/jIR7
 w7FTvZJxeRBZNCrpJ1A+CVnHShpolEA=
X-Google-Smtp-Source: APXvYqxJTDjm4N9cdebHr4OgslkyewV+R97FyeLqBXhhjypCodGro6LzvZxM4D0u9B4NfT5rg0uO1Q==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr12604198wmb.33.1580314185131; 
 Wed, 29 Jan 2020 08:09:45 -0800 (PST)
Received: from [10.0.1.16] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id o4sm3416167wrx.25.2020.01.29.08.09.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Jan 2020 08:09:44 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 2/2] NetRxPkt: fix hash calculation of IPV6 TCP
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20200127115405.13459-2-yuri.benditovich@daynix.com>
Date: Wed, 29 Jan 2020 18:09:43 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <F97F4F13-3C10-4F39-A91F-B3341CD65CE6@gmail.com>
References: <20200127115405.13459-1-yuri.benditovich@daynix.com>
 <20200127115405.13459-2-yuri.benditovich@daynix.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 27 Jan 2020, at 13:54, Yuri Benditovich =
<yuri.benditovich@daynix.com> wrote:
>=20
> When requested to calculate the hash for TCPV6 packet,
> ignore overrides of source and destination addresses
> in in extension headers.
> Use these overrides when new hash type NetPktRssIpV6TcpEx
> requested.
> Use this type in e1000e hash calculation for IPv6 TCP, which
> should take in account overrides of the addresses.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

Acked-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>

> ---
> hw/net/e1000e_core.c | 2 +-
> hw/net/net_rx_pkt.c  | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 9b76f82db5..5b05c8ea8a 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -582,7 +582,7 @@ e1000e_rss_calc_hash(E1000ECore *core,
>         type =3D NetPktRssIpV4Tcp;
>         break;
>     case E1000_MRQ_RSS_TYPE_IPV6TCP:
> -        type =3D NetPktRssIpV6Tcp;
> +        type =3D NetPktRssIpV6TcpEx;
>         break;
>     case E1000_MRQ_RSS_TYPE_IPV6:
>         type =3D NetPktRssIpV6;
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index b2a06bd27d..1e1c504e42 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -348,7 +348,7 @@ net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
>         assert(pkt->isip6);
>         assert(pkt->istcp);
>         trace_net_rx_pkt_rss_ip6_tcp();
> -        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, =
&rss_length);
> +        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, false, =
&rss_length);
>         _net_rx_rss_prepare_tcp(&rss_input[0], pkt, &rss_length);
>         break;
>     case NetPktRssIpV6:
> --=20
> 2.17.1
>=20


