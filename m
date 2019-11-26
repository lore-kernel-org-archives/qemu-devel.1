Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC43C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C99206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fl10JKxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C99206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjv5-0006X7-Bv
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 18:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZjsv-000553-QF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZjsu-0000ll-U2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:04:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZjsu-0000lO-QK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574809480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ypvOCN5pnDNbN5MTl9lLmP3MEQw+3iP2OBa7IxgZH0=;
 b=fl10JKxheFWebl0HMiLWqUApLQUUsDdwqQi818ZqHqLzsW+sUtVTgRA126wh59EIKR2Tjv
 1CGZrQaWTBhdhOQPJ+NeLjbj9vDIEzuxL4uV2v2E+nwb0sn15HACtPv3dYc1j5IxKidL0O
 PSK+0NzUJMqzNhPzRNI8gLVQJOBqFu0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-LXxanIxQPJOzxTnljcRKzQ-1; Tue, 26 Nov 2019 18:04:38 -0500
Received: by mail-wr1-f71.google.com with SMTP id f8so5999014wrw.21
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 15:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y/lj1ZVcaKq80aKLNDPnfubp4VFIrOnP60cac4K9vVI=;
 b=V2E+bFTnUqG6KjYr9GqiKf6pbBywEwAr7V/E612UqqoFKG+G1bQUNO/WJFYSQrcr0Z
 ZiJoGAZi+pMLJMgl21fOllQv3zmtnZVIYzliLY/mB8RSdWA7u3G+VeP0Yo8XOVbvbqDW
 86LIRTtwWRL8Ix6LdPj2W2hliNcBpsKErahmFYcIjgqrdcNOtulcCYxKm+cZiZ9hmtgV
 daUVh3oDcNEpaWpLkejIxyj96691gMC24cUkS9KH7/qOYBg7vjvzow0FpKWBlURtyBfr
 y1NrkYq7ftlYPRCnhzhBvG0n+LNm4ENU1y5U5ZvKPGzs+rzvdjsJK7hD6Rx4ilaeqtub
 VJKA==
X-Gm-Message-State: APjAAAVH+e+5VgW3vDYgSor7U3bCrRpUFZAsEmXUxaX3hhZGKqyuN1WM
 a7jYjr32AqBkunE6gTSc0nElozvTF7roNplTlRy+K6vuoKZRup/EvkinnTwyDVD4af9/Eef6zra
 iJDWGNwquQROCnvU=
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr1276587wma.120.1574809477478; 
 Tue, 26 Nov 2019 15:04:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcH18TZfpG6UgST6DsPYwnA4Dz+ZPf8qrZIhg8+NPa6staCnLhxziQGEaqA6yOEFopcWoOBQ==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr1276575wma.120.1574809477327; 
 Tue, 26 Nov 2019 15:04:37 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id j3sm16389129wrs.70.2019.11.26.15.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 15:04:36 -0800 (PST)
Subject: Re: [PATCH v36 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-6-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <06d7ebc6-a16c-2e06-2f10-1846783a1e30@redhat.com>
Date: Wed, 27 Nov 2019 00:04:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191124050225.30351-6-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: LXxanIxQPJOzxTnljcRKzQ-1
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
Cc: dovgaluk@ispras.ru, thuth@redhat.com, richard.henderson@linaro.org,
 aleksandar.m.mail@gmail.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/24/19 6:02 AM, Michael Rolnik wrote:
> This includes:
> - ADD, ADC, ADIW
> - SBIW, SUB, SUBI, SBC, SBCI
> - AND, ANDI
> - OR, ORI, EOR
> - COM, NEG
> - INC, DEC
> - MUL, MULS, MULSU
> - FMUL, FMULS, FMULSU
> - DES
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>   target/avr/translate.c | 822 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 822 insertions(+)

Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


