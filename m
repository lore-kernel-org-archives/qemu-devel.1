Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77ADC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C66206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="KO1j7I49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C66206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is24z-0000TE-O3
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 05:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1is22P-00074M-LI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1is22N-0005Jc-HU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:06:05 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1is22K-0005Hy-Gm; Thu, 16 Jan 2020 05:06:00 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 5EF8B96EF0;
 Thu, 16 Jan 2020 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579169158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4hZuZViVzqK2EGV64oYWVx94KmetHRPNAceptOPVIk=;
 b=KO1j7I49TqTJcTnscT/tDUqFuJSxTNDPnwPEtzSmRabaZ8PB12Lzj0RT39ZyKCKtK/oez6
 TPM8nct6roY1c2rI2sAgtJfN3hs8RHwZunuRGKnscTq/6sc3yw9RhSHV9dE4GrXrwvH1Mu
 k7s6NPSJ2AzwDleetgrPotj6Y9uZ0QQ=
Subject: Re: [PATCH v5 02/22] gdbstub: stop passing GDBState * around and use
 global
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-3-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <3a12e209-2854-9fb2-f310-1670e6b1f56e@greensocs.com>
Date: Thu, 16 Jan 2020 11:05:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579169158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4hZuZViVzqK2EGV64oYWVx94KmetHRPNAceptOPVIk=;
 b=XIY4wLshh7KWlccb4IZbweRBTf1Zb4HgcW1UZl1EHTFOu9/BsBmJ7ku0C/NVldHPyvoAsO
 J+4Eu79eKgSusv/AUrYRYYSkN9ceai3uryprXG2a+WEv6Ia0wsj/yPQFG4akfd0xOD5UIX
 xkV6M4Npwv/sg+m5eTzS6AJQ0Pof7SQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579169158; a=rsa-sha256; cv=none;
 b=T7azZzJh01lkap2w1TSV5AlKiukdx5BLFGmFjHasQeZ4O7ghfuF3sQxTT3eYfhS50yFUSh
 x+T724Xypci7eMdAk7Z7IEYeeB4sNPQpM0sFcv4Z4CYkIBRnQarjx+GHcVjjbD/70AzBBp
 YEAsiGf9glMKQ1x44Ps4CoAtZGBFlko=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/14/20 4:09 PM, Alex Benn=C3=A9e wrote:
> We only have one GDBState which should be allocated at the time we
> process any commands. This will make further clean-up a bit easier.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> ---
> v3
>   - remove final *s paramters from function calls
> v4
>   - a few fixups for coding style
> ---
>  gdbstub.c | 561 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 278 insertions(+), 283 deletions(-)
>=20

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

--
Damien

