Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C6C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDDA20748
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdMUA9Zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDDA20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilh6k-0006mG-EH
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilh5e-00067Y-SK
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilh5c-0007Vm-9I
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:31:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilh5b-0007SV-WD
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577658670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1l0ejsR2EqGnJQXELzFYrkWSrgSXwgYoVAUXgVtx+U=;
 b=QdMUA9ZrKNpii1ZNIAEDgiBNc8+b9S2VzqWQXAZz+AJCsay8tyxE9pnJI/sonv00WPw/1S
 z1ISaTQpV1EEr4XfU0pGbRr8PHLP77/nwRgErTBUAFbNIr8Jk5jAVGzfvfbRc/pRutQjo5
 mFO3uW0CZmUdPGVnoAVwimc0A+UtNNM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-i_pvAZsZOXCHRDcAnWB4aQ-1; Sun, 29 Dec 2019 17:31:06 -0500
Received: by mail-wr1-f70.google.com with SMTP id f17so2790014wrt.19
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 14:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ymfCdkWnnBoqx6xjubmC+npOdk20OeCFVWkzZ509SzM=;
 b=qstjd/JoW9Uxfsv6K6PJ71FLw6yjnZGhIpzaD5Se0txrNH/qqmuoNBDMuQCV7EMiCz
 SI8jIaHzW8ms/0tOMUbCEvnY2tkTvBosJCX8k0c1DpTuhjKAnKDyK9jOB6ucQDzpZg3/
 f9GdxL1itTnEjXM7RegnYYH/qafmu6Jk2mXY76GV7RoobV/RyxzeKr3YTAG4ZXyaTPoo
 5/r4T3qDJSGvbFt/sDwPg9OWYzNKaP+Dub2GfPCmdTrWIE+MLB1OVnQPrM3cwtFEBZyy
 c7dSH2gOJJlyqRoemuaaJ7+f3gZMSA9bAGwdRNJTNLkMJRz4UN9gLwKBInWsURgRSnUd
 pLgg==
X-Gm-Message-State: APjAAAW1I16IoR2FttCjZaW2AZE+3UNYYSacgga3VpyU35WiTRk0hWWo
 cI1YZxF9V0Angdua0RQ7yM3UIbYd+NJNKzyEqlwW2MFAx7aphzHwCKe9c6jlkLnt0dKEgElfFiw
 GWNYrnOh/5xKm1Yg=
X-Received: by 2002:a05:600c:1003:: with SMTP id
 c3mr30473324wmc.120.1577658665454; 
 Sun, 29 Dec 2019 14:31:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxs+Am1NnJKzGzyDPQJ6b6Cj0kw0eJKqskomWAXAHStOzkSSQP9b+ftyJvItCxB8IeNQODHFg==
X-Received: by 2002:a05:600c:1003:: with SMTP id
 c3mr30473315wmc.120.1577658665271; 
 Sun, 29 Dec 2019 14:31:05 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id t8sm42203494wrp.69.2019.12.29.14.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2019 14:31:04 -0800 (PST)
Subject: Re: [PATCH v40 06/21] target/avr: Add instruction translation - Data
 Transfer Instructions
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191229215158.5788-1-mrolnik@gmail.com>
 <20191229215158.5788-7-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <27ba759b-5762-3137-fe84-750a4b4322f8@redhat.com>
Date: Sun, 29 Dec 2019 23:31:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191229215158.5788-7-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: i_pvAZsZOXCHRDcAnWB4aQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, richard.henderson@linaro.org,
 dovgaluk@ispras.ru, imammedo@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/29/19 10:51 PM, Michael Rolnik wrote:
> This includes:
>      - MOV, MOVW
>      - LDI, LDS LDX LDY LDZ
>      - LDDY, LDDZ
>      - STS, STX STY STZ
>      - STDY, STDZ
>      - LPM, LPMX
>      - ELPM, ELPMX
>      - SPM, SPMX
>      - IN, OUT
>      - PUSH, POP
>      - XCH
>      - LAS, LAC LAT
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>

Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   target/avr/translate.c | 986 +++++++++++++++++++++++++++++++++++++++++
>   target/avr/insn.decode |  43 ++
>   2 files changed, 1029 insertions(+)


