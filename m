Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38778C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 14:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E0220718
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 14:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL0Xr5HF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E0220718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilwTm-0004ra-1J
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 09:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilwT1-0004Ii-K4
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilwSz-0005Wv-RE
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:56:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilwSz-0005Wi-MU
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577717780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgFR1xDac1SK2J4H43k2WJfgpKX1rkcdRy+S1pJTjLg=;
 b=OL0Xr5HFkPagZ47Z3KaqK4oMBnQ+vYOUFRe8DlPo36Sv0bulxAwbsNkqFzBv0o5SndP4UN
 Ti2DF9kyNx0qoFzKyCqw0TD55BBYa9Tv0P2if3IOuRUMc0YJDNFwSJ9Sbe4HudybxzpXt7
 FpolfrbCI4TcJv1qRJLxOodJIqctQM4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-BtMB3BPbPty72YH9DO96MQ-1; Mon, 30 Dec 2019 09:56:16 -0500
Received: by mail-wm1-f72.google.com with SMTP id p5so1517934wmc.4
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 06:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=03s0E4aQWCdqgJM1YJTbLIKn6CEi/zKfH+0EXS+0kcs=;
 b=h24/rRMjVs/vssP/ZTeKa37NEseaEpd7GPujlntoki/+K9yT1Jlnvv9+3kJC0EQ0TC
 hJdAWfzCVOyEW/VYyETe5jyEELTkFO2aH0PVWAvFSi3+eYrGSVZiMgQTnPq0bb8QbWiy
 VwNS4bP63Z1gsVlZMjxXBZUPjG5OIrQV6SqHZwZs5HTOfbR4jx6+5+FUJUoQ7+bwPicf
 8+QC5+wI2S9uPKQXrd/53LbpJfnL0dP8ZD/Lt8ZMggcYoDgBSKjtIa4I5psw1q5VDm0d
 9+2JSpn4YQNgAN6rC+KVNOTS8jRMxY6++zdxV9QaXS2kuOmDy8cSdTZAHsRQe4aZ6KDt
 hzew==
X-Gm-Message-State: APjAAAVnwPRPbxv1Eg1KS5Qw3lJXkwHbqmRpSjONrI3nbV3og7LFOOEQ
 tephlsvI7lWA2Crzp6d2whSHLi3h8Xe9nUb5vd94uUBW7Sy0hh+Abssn/1a1hROcAdk+j8FegDp
 JP7IrB8kyC9NdhW8=
X-Received: by 2002:adf:e547:: with SMTP id z7mr69179059wrm.258.1577717775680; 
 Mon, 30 Dec 2019 06:56:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+9xqU6Ep/6gY5aLLj5xtJwpsRB/bWxg+qSeZqTgRPKb8dNES0beO6L4ICVQ6SxWjKmUgwRg==
X-Received: by 2002:adf:e547:: with SMTP id z7mr69179042wrm.258.1577717775489; 
 Mon, 30 Dec 2019 06:56:15 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-186-92.w92-134.abo.wanadoo.fr.
 [92.134.161.92])
 by smtp.gmail.com with ESMTPSA id i8sm46050169wro.47.2019.12.30.06.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2019 06:56:14 -0800 (PST)
Subject: Re: [PATCH v2 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <CAPan3WpDbWb_cBMJPgokSLKAJndMQLvRdOav6CPpDbFv+ChN0g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9756419b-55bf-23a9-556a-d5bc5fb29331@redhat.com>
Date: Mon, 30 Dec 2019 15:56:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WpDbWb_cBMJPgokSLKAJndMQLvRdOav6CPpDbFv+ChN0g@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BtMB3BPbPty72YH9DO96MQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 12:28 PM, Niek Linnenbank wrote:
> Hi,
>=20
> Here a short status report of this patch series.

Good idea!

>=20
> For V3 update I already prepared the following:
>  =C2=A0- reworked all review comments from Philippe, except:
>  =C2=A0=C2=A0 - patch#8: question for the SID, whether command-line overr=
ide is=20
> required (and how is the best way for machine-specific cli arg?) [1]

Answered recently.

> - added BootROM support, allows booting with only specifying -sd <IMG>
> - added SDRAM controller driver, for U-Boot SPL
> - added Allwinner generic RTC driver (for both Cubieboard and OrangePi=20
> PC, supports sun4i, sun6i, sun7i)
> - small fixes for EMAC
>=20
> My current TODO:
>  =C2=A0- integrate Philips acceptance tests in the series

You can queue them in your series, adding your Signed-off-by tag after=20
mine. See:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin

   The sign-off is a simple line at the end of the explanation for the=20
patch, which certifies that you wrote it or otherwise have the right to=20
pass it on as an open-source patch.

See point (c).

>  =C2=A0- integrate Philips work for generalizing the Allwinner timer, and=
=20
> finish it

We can also do that later, and get your work merged first.

>  =C2=A0- test and fix BSD targets (NetBSD, FreeBSD) [2, 3]
>  =C2=A0- further generalize the series to cover very similar SoCs: H2+, H=
5
>=20
> Does anyone have more comments/requests for the V3 update?
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04049.html
> [2] https://wiki.netbsd.org/ports/evbarm/allwinner/
> [3]=20
> https://wiki.freebsd.org/action/show/arm/Allwinner?action=3Dshow&redirect=
=3DFreeBSD%2Farm%2FAllwinner


