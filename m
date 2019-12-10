Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED43C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 23:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987AE206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 23:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6txmMGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987AE206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iep2x-0003gb-Oc
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 18:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iep2H-000390-8e
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iep2E-0004p4-2f
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:35:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26789
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iep2D-0004nk-V4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576020917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDHDD6CLpR2FGvi12LgL95vrnX1ErvCJiZo1GlrSJvk=;
 b=T6txmMGoNSOlvngo2VxzEZUeR3ZjyxMGWa2K9MQurnd/yfWO/K1QLhtnydW3B9F4PDvXIf
 /SqvJBETqBfqnl8LooFrKdRQyCjJkVRHf43wEK+g1ziy5HfJoQpezBXFMaJw5J8WK/TLMK
 Dszj6EJY5PQXrXa+Ghef5fw/9ewgtoQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-6jgl6HZ3PMK8MysPtzF5sQ-1; Tue, 10 Dec 2019 18:35:13 -0500
Received: by mail-wr1-f69.google.com with SMTP id k18so2967187wrw.9
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 15:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NBRHcZ0PhDC/Wa+NYptbdLWQeAyEVv4meHAzLqwIYMY=;
 b=t7G3CABkuh3+e7hFK8GyQwvtFqwNcpzH2OTXTwxYc7oaLGgvNZAjGai1ptYWWcRwZ4
 aWxcln1zI+f6fZKPkOEGhEZL4KoEMtfBcKhaZym/CmBJnt3ohqGoSWX2Vqznt+ExlbtV
 PaG8dadlin1CKO/c+alaBDj+6C1Q2skZpgYA8eHv4zBEX+r8kYEEQy3PMGeyDHtaZL6e
 rAt6ANfuwmgzA7ZA6gBbJ37YjQSs/dynrDEKMCI93mxUwuI6AAQFFh19ooD49mQZCob/
 6MIuqKoWdc8Ra7JawlTmtTVsCT+LEnw2BbIGr+rKo76t3vpegLR6+YNZl39kcJZRoLFA
 b8Hw==
X-Gm-Message-State: APjAAAVY38ehxUSeul26J3mfPmOQ/GapwZ6AqRfdOuaxSYx2/zGWkwRs
 oVpXaFxJSeM0iwRz8xKJ4W4lUn60REw5kBUZLqZPEfC8YO70RjTQhmHxWqT9VyJk6A9sK9/6e/L
 ag+sdJxkx3w6cOLo=
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr86083wrt.339.1576020912933;
 Tue, 10 Dec 2019 15:35:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6tNNJbkHys8uJI9UYYH75eMat0kEudlRP5DWmmHih4eObAzQ9kWuog+D/zfdbATgb/gYjoQ==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr86071wrt.339.1576020912768;
 Tue, 10 Dec 2019 15:35:12 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id n8sm87910wrx.42.2019.12.10.15.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 15:35:12 -0800 (PST)
Subject: Re: [PATCH v2 1/1] display/bochs-display: fix memory leak
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <cover.1576013209.git.dirty@apple.com>
 <d6c26e68db134c7b0c7ce8b61596ca2e65e01e12.1576013209.git.dirty@apple.com>
 <61e67881-55fd-faf3-3112-31a525106465@redhat.com>
 <CAL1e-=hsLfJKFgOewTFbhUtTO5QMDtUdAT+vDu-fJy=wCsrAyw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe96850f-d315-689b-cec1-422f77c983ef@redhat.com>
Date: Wed, 11 Dec 2019 00:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hsLfJKFgOewTFbhUtTO5QMDtUdAT+vDu-fJy=wCsrAyw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 6jgl6HZ3PMK8MysPtzF5sQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 12:28 AM, Aleksandar Markovic wrote:
>=20
> On Wednesday, December 11, 2019, Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 12/10/19 10:27 PM, Cameron Esfahani via wrote:
>=20
>         Fix memory leak in bochs_display_update().=C2=A0 Leaks 304 bytes =
per
>         frame.
>=20
>         Signed-off-by: Cameron Esfahani <dirty@apple.com
>         <mailto:dirty@apple.com>>
>=20
>=20
>     Funny to have a dirty@ email fixing a DirtyBitmapSnapshot leak =3D)
>=20
>     Fixes: 33ebad54056
>=20
>=20
> Dirty fixing bad in a snap. What a fix. :-o

Nice one! =3D)


