Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FFBC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE90206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCNHinav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE90206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iondQ-0004CA-Ov
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iomW8-0006dY-Id
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iomW7-0007cT-A3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:55:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iomW7-0007bx-6H
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578394518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hhXZK6waXiBnmr0odxU7NgxYYfDC6HfydIaPIS8FwCc=;
 b=gCNHinavbigOUPO41qNiYI3bN13SetHQxb+SgOgTZUanEqze5gDFgxsC8m/t8tr7pFVbG7
 A+aMasLUE+G0il9luXCMoKWvuMRJrgDoMbJPvD22GAUhHAJ8qavDvuGXZzNaRa0CW0Y1qb
 MYJ/yjkXe/yOmyKsq7KcOzOA1va2M/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-uy_BnrLVOgyGOsNQPKdGcQ-1; Tue, 07 Jan 2020 05:55:14 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so19108540wrm.18
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Os9CxIhXNJ0oXSGR+KwiDvplTNsja19E/C5m6OPss7M=;
 b=cF7hRFi61O2+2b8vfHbEWAGG6ax+1+vZo3XdVNSvVjW8TIzlJL9nlBKpSpsMOjV/AX
 9MkuVGFoTpv4MFim0WmGvJ3zYU5XTz2Z846K/Z69UefGOnex+NPH6mLXE8ElMLYT8h0G
 +5EtpkWR5kdGAFxqv3fi6N9i5LZGjhOAPNRvaaUH7VxthgAbBWDBB0TIAzZUkhMr4zwM
 wyhTvnFg0xEhyRTZOZNHN1twCucE7HUtYYP5QsRqgSWKwqwEVXnf/gE5qM40FqU35m/i
 TwE1OEK/w+jnREiwkxWRftEWd/jKkEzHG06QMTXsltKH5L7BbHBA0iUM0KNs/M88diiu
 bYUQ==
X-Gm-Message-State: APjAAAU8sBfxlm6eEjn+eg9uOcB4d0oOKfF1OqWrnvLIyFMbplgiI5FS
 hwQVSsgDs4cXxHRykns/BGmXbkjeiG/DFPmptVeQ4nVGQJ7L3qO2XQbuj4JIxPtqx2ZYGApQ+I3
 J/hy4zJ0HXItrpuo=
X-Received: by 2002:adf:eb51:: with SMTP id u17mr108866061wrn.29.1578394513131; 
 Tue, 07 Jan 2020 02:55:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZn0VYd/V/zNYe59k7LQ+zqsc3ubQbxlc7tCrvQ7YFApgV27+KayJZSkJZ6YzamX7G1QzoAA==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr108866018wrn.29.1578394512923; 
 Tue, 07 Jan 2020 02:55:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id t1sm26610479wma.43.2020.01.07.02.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:55:12 -0800 (PST)
Subject: Re: [PATCH v2 0/4] tcg: Include tcg files using tcg/ dirname, reduce
 cpp search path list
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200101112303.20724-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ddded8a0-0df1-7408-b8c3-6a8ae1a5f438@redhat.com>
Date: Tue, 7 Jan 2020 11:55:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200101112303.20724-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: uy_BnrLVOgyGOsNQPKdGcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/01/20 12:22, Philippe Mathieu-Daud=C3=A9 wrote:
> Noticed we could clean this while reviewing Richard patch last night:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg667606.html
>=20
> Since v1:
> - moved headers to include/tcg/ (Paolo)
> - include in .inc.c relative to parent (Stefan)
>=20
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05356.html


Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

but I'll let Richad pick it up.

Paolo


