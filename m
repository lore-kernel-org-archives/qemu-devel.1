Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02747C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF24E20707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIT6mdF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF24E20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUqQ-00060K-FW
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUpF-0004wD-Bb
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUpE-0004D1-DO
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:01:53 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioUpE-0004Ca-8Z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:01:52 -0500
Received: by mail-ot1-x344.google.com with SMTP id i15so4626975oto.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MyBoD+GRi5UgrLaTQFGGHT9g8eJIcgDuyxmBDZcx7jA=;
 b=CIT6mdF123mFv3Rae1Tl1KAm4uj9g4wttRix9Uf4C07GxwTqAYg8fLPP+lRtRfC7v8
 wf61FnImqKFAvNH2nBLLayuFpvmPH3cYfTPP65FR3ORAru5a4JjboYpVbKqVBelj7mK6
 ixhUGcEHbaezpoUZDQSGh0Px4zj+RxDI3Tc10THLxoKXHNJCojdF0+OjHlYUuxrNgW/U
 K1VcBTTOCx45xvSCAYcrGtyB51WXUwly9w/Sesu6n+APIazbvgQawsmBXU6e1Q6jflQT
 6A6wRa5FQxPOQXjc7XebFeCgaP6kwfWR9bIOZU/2wBn/Jsv+4LvuyyaieuAQm8Ss9cEd
 CTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MyBoD+GRi5UgrLaTQFGGHT9g8eJIcgDuyxmBDZcx7jA=;
 b=h7pyqDFNay6g9G+kiUW+AxVFjJyNUh/WzyjVhx+VZ1HkRzGdUVUgTdGGqKOvfy2UY+
 IUS1/XkH7jnG4JCbfKTdReFY2Kr0GHouShjsKanQRlWT8VeiZUctgaDjnb7FHxb5exFq
 2YCPMsA/tmZLPzgoLdp9W0jlWHJq9FRPOa2Dfy93XS0QETbH9WN+Z49jShrP7Nvvf7pd
 LshBzQhTKVRIf9vNWf87S+CE2arrpFsm8ar+ZiA7n0Mxv4A0NB83BUy+lsJnXa4+3Im4
 Fx2GAyr3xF2v1gYhcW/5E+hf1kAGcGYh67z4v0HIze2mwqCM0+QVBCzXWcFDG7zCXdbj
 diIQ==
X-Gm-Message-State: APjAAAVa+mlCXgQMItzcnYUcOI27pzg2dl563NG/3g1Eo1+AMBL1RGJr
 51Qu1zKhaP0TLBRc3b/kp259ee8r7pq3xwTKfqNAvg==
X-Google-Smtp-Source: APXvYqyN3Qy5833Ukash96rF5OUD14LXna8qHDW4hGaedlmGlHUrIJ6dQjEh6K0R1IIzuSAcLjC5RbIP0H/iW/idUfE=
X-Received: by 2002:a9d:644a:: with SMTP id m10mr12895009otl.97.1578326511606; 
 Mon, 06 Jan 2020 08:01:51 -0800 (PST)
MIME-Version: 1.0
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-6-f4bug@amsat.org>
In-Reply-To: <20191230110953.25496-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 16:01:40 +0000
Message-ID: <CAFEAcA8VVmU2L9oV73hBVcAZWhbZCKiR4RThcteswMr1_uo6YA@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/arm/allwinner-a10: Remove local qemu_irq variables
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Dec 2019 at 11:10, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> We won't reuse the CPU IRQ/FIQ variables. Simplify by calling
> qdev_get_gpio_in() in place.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

