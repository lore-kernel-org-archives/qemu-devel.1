Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA244C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 14:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7E320738
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 14:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKAE88fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7E320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2FDV-0003vL-Lk
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 10:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1k2FCy-0003WG-MU
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 10:43:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1k2FCx-0006nW-77
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 10:43:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id g8so12191467wmk.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2020 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=lYQL71sX6J6/Y/YbJMdaGZ52xMj2hAhnKLXedjS6zus=;
 b=PKAE88fx2u1JFwMrbfnlkzFgU6/EQTBqM0LFXsuSexedQ1uNmmzX6ojceTE3bFaCpL
 B2SUQ1DXlGz49px3EkcnHO7lMthWIH7DagrnXpib/BBjGXsrV8K0Nkq1nI0ZqFFhkiK2
 wJ9ZuaMBD4+Z4dS4084lmxh4qOChm4uULbeSXViCXOVXOh3bUOIdVqXdpx7m+plQQ5Mq
 4pmuHEMd7i3JyC/Jw7zlau6x/wSecvYrzrSy4RfrjaOptZrc/13CcN9GOu9QY3cSaHlQ
 +bO5+ktlUmfQ+oTxbimLdR3Lov5fQZrYXnpDHqoUqy49q3N/OXOiATcH/mPeKxGAq/pZ
 56ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=lYQL71sX6J6/Y/YbJMdaGZ52xMj2hAhnKLXedjS6zus=;
 b=LyuCOadefFb7j+nH4lCKO5K2RSLPZGDMSIIyftomvmLjFNRynpz2C5r4q2nhHOF2Z0
 C7TBVxsnMr8Tq01Kx1I0KSOiZlJZDgryiQo0rqMRtm6T/8lD+Vn3n0ooeXC+sP5gaOOz
 FfyVmvKXBfventoe3o9u8zMw6SP6h7Fdh5xvneiqJLgeyKJQOBx1affwQYoatSFCgTB6
 u8Tv8U4oK7SQTuDI2JT2L9N9wj6/SDqlZvdI/gqapCMHCGq5dRv0mXheQvTV/uAMvfnN
 bQJop9LRqdDzweb9UahrscmMLXAb/zuoE1SATYIKHqGOHhOKVzajaggcYo/ifwV6hNZy
 iRAA==
X-Gm-Message-State: AOAM533yu8xpDqnzWFhyfWqhjGPSFCNGf74bY99v/dyVXDncSXLI915l
 5yFdf+4euNjAPoi7aYKcOHo=
X-Google-Smtp-Source: ABdhPJzLu8Ry3bQ1k3mLa10mUT5wJSp7wVIWMS1ospO+O/hX0xz528DaHlf7Boz3OFf81kEK9N0UoQ==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr11779148wmm.90.1596379404929; 
 Sun, 02 Aug 2020 07:43:24 -0700 (PDT)
Received: from [192.168.1.90] ([5.102.195.137])
 by smtp.gmail.com with ESMTPSA id f15sm18240825wmj.39.2020.08.02.07.43.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Aug 2020 07:43:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] hw/net/net_tx_pkt: fix assertion failure in
 net_tx_pkt_add_raw_fragment()
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20200801164238.1610609-1-mcascell@redhat.com>
Date: Sun, 2 Aug 2020 17:43:22 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <E55CC0D0-FD86-472E-8A7F-F05F39855D7A@gmail.com>
References: <20200801164238.1610609-1-mcascell@redhat.com>
To: Mauro Matteo Cascella <mcascell@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=dmitry.fleytman@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, ezrakiez@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On 1 Aug 2020, at 19:42, Mauro Matteo Cascella <mcascell@redhat.com> =
wrote:
>=20
> An assertion failure issue was found in the code that processes =
network packets
> while adding data fragments into the packet context. It could be =
abused by a
> malicious guest to abort the QEMU process on the host. This patch =
replaces the
> affected assert() with a conditional statement, returning false if the =
current
> data fragment exceeds max_raw_frags.
>=20


Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>


> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> ---
> hw/net/net_tx_pkt.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 9560e4a49e..da262edc3e 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -379,7 +379,10 @@ bool net_tx_pkt_add_raw_fragment(struct NetTxPkt =
*pkt, hwaddr pa,
>     hwaddr mapped_len =3D 0;
>     struct iovec *ventry;
>     assert(pkt);
> -    assert(pkt->max_raw_frags > pkt->raw_frags);
> +
> +    if (pkt->raw_frags >=3D pkt->max_raw_frags) {
> +        return false;
> +    }
>=20
>     if (!len) {
>         return true;
> --=20
> 2.26.2
>=20


