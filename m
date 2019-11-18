Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45015C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E192D20643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKq1TFPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E192D20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWi6t-0004zQ-V1
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWi5N-0003zH-QF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWi5M-0000Dy-Mv
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:33:01 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWi5M-0000DQ-IS
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:33:00 -0500
Received: by mail-ot1-x344.google.com with SMTP id l14so14645051oti.10
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D8MMoACI2h95QiXucMFmC2Ks9gfXSKg5zeZKiGuN6VM=;
 b=rKq1TFPHb2ruVmAaTrr1aFJRwQ4Nq4xM2ygl7zwXqgdVohFvYXpKlTVEDTVCMZJheQ
 IK8f3cH4eOyjyqs3un1e/Zkok7CNXBI8K0deBnSyBpYGA+ev0+2WfGAigA7HUMfmHpyG
 jkVi7Wmwgz1FtaFkvvuewSf0bmt+JtaJ4mOUp1xqALZqqVMylWJj/iDn7rKwxUUFg6B3
 msC3Q6Y5YBp2m81NzAburqWX488EZ2gWlMhKp1J/2b6l/+RA9OcvlwdWmH/7SOQZ0lbd
 Yg1BKPoNLSoOq9742DyyOIJTe+OEWjJeo+nWJ7gRxDESxoGsrULmZhD9SrqEoUWCB6/3
 rAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D8MMoACI2h95QiXucMFmC2Ks9gfXSKg5zeZKiGuN6VM=;
 b=jCVt1cEKnq+hW325Y89Aq8wOUaqHJ3gM8QjvLd/1BLSTc/1sRMchcUxLX488Mm6wwY
 4dHJcQTQimwq5D0+QoDEl8jixSWIar4qjfVeooVHlKE8y5iUyXg+pSIt6mIlqSKOxfnQ
 qCForu/Kg8qiMDAy/O7L7zoKE0k+iSEpG/PGCnDtlRNmZRp+SaNh/mPAdXArx8D4Ra1o
 UPvsYvhFDdpyVLBnKop1hLSSAqyYaekfKWFfRZC+9HBEIQ0o7MsEuO8GUQc0IH+SYc04
 ZbuAMcQfK8ibhOWWoGTPg67rl7Gm1Lz6U2e2doP6ms9/aM2rFIveCaJSUpegZ7I8AmlG
 lfAA==
X-Gm-Message-State: APjAAAUYj8WCvnwVvHDOgodI/SctF1QrZ2j2SvwtdXRmYBD0tS8uClMu
 9OIxEAnGIPtF8u3Il2RiFkiOowxpqpC/igU0Gmjq6g==
X-Google-Smtp-Source: APXvYqxEuutLtmlmDDqXyyxQ5w9vh2YeLf+sqjpsq5AI6wzlB88XLcllkmJHHlxGK4ZDKJoEuNuT3Do3ZDA/vcZGRfk=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr50084oto.97.1574087579727;
 Mon, 18 Nov 2019 06:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-13-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-13-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 14:32:47 +0000
Message-ID: <CAFEAcA9knQhHCjzU8JJ3YB7H7iR=uhn_a_6FxMMyDSNE_yA3cg@mail.gmail.com>
Subject: Re: [PATCH v3 12/33] serial: replace serial_exit_core() with unrealize
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 18:33, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Instead of calling serial_exit_core() directly, use the QDev unrealize
> callback.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

