Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD5C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6253206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZerwcfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6253206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSNm-0003r1-45
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34226 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQSMs-0002y8-10
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:05:30 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQSMo-0000nH-EU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:05:29 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33975)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQSMo-0000m1-1n
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:05:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id 72so988692otu.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+aRwRBujFFd4qByOEjYnIjVKWb5J3NYVKXHhT+5ioFE=;
 b=pZerwcfb+c9gWQUCKLHgMGLstHQAduAUkLOLPKT05mCM9H8Q8qpDUZDJLHX5EhbTOv
 c4joO651dkDlxoJdCTrzHCaGQV6qnDPqz84omQQfggnbzZx+t9YykQP1w/8yJUmzOdBl
 rHa1RDmZQQMd6KePuvE2yq0ZZmDas+NgdODu+gyI2GCp/k1r5dQYoNi/RuuxfRJcQtKG
 4ksEuJC6QkB06bnphOUpUJV9VnBG2XsZ4IQH/PayHYady+/NCXpTfdgBz2Bi+PazN3aw
 qTf71AQ1vYfb69fcS0WCYVrSjRMyIlj+eAeiSu/1O41wSoLv8RbISvKhd2dhEv9Mj6Ry
 WMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+aRwRBujFFd4qByOEjYnIjVKWb5J3NYVKXHhT+5ioFE=;
 b=MxPcs/MJjN1Y/p07PyJ33vb+agf5GytLdf3VRR3sywkvD+vM1SpT/KyFCqJAP1rsG3
 gpzbcN3h737FnLLqqYNs9JNrPiSE3lZ/1HaJt73JuCCOVcnBnoe6kkjr4l+UvXKB0e/2
 FwMxVmWLfvlBimchRBaa6rTw7Pf5uqy38H0iVMnHAGcBioyAQxiBTIDb/7M3Tzv8DWrv
 N60ea1+WUYEo4d/j3jHgsSIqPoImMwFlP1r/Rkg7ymCq8UO8LG+ANUvBungRQGLWskLu
 oTFRNtv9KvI/WQdhuah0cL/6Vsz0vj0chDiLax39sJFtwYeV0mCx7hgo4UkMRjiSBtZ/
 CH3g==
X-Gm-Message-State: AGi0PuZ0kvKSgI2xQ4ZNFhfkZBKs3R/t0eBigXPw0giewZGzlb05dWqL
 CzH1EoYu2TZtAk/ZoWNM0fVhG2Y/F4M9vHsews79qaTsPU8=
X-Google-Smtp-Source: APiQypJRy08gJhHNhhKtwmaY6YL0pezlaeoNOikFib90uXMlfQww9TZpROuUlhtQ3Bpj+CmD4gmaJnkH4WsYnvU7hR0=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr8926514otb.135.1587373524829; 
 Mon, 20 Apr 2020 02:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200418085145.489726-1-rfried.dev@gmail.com>
In-Reply-To: <20200418085145.489726-1-rfried.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 10:05:13 +0100
Message-ID: <CAFEAcA9ODtKo9K84wkArjvPWNKqD6NhuN8r6gt+ycLLXc_Bq4A@mail.gmail.com>
Subject: Re: [PATCH resend v2] net: cadence_gem: clear RX control descriptor
To: Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Apr 2020 at 09:52, Ramon Fried <rfried.dev@gmail.com> wrote:
>
> The RX ring descriptors control field is used for setting
> SOF and EOF (start of frame and end of frame).
> The SOF and EOF weren't cleared from the previous descriptors,
> causing inconsistencies in ring buffer.
> Fix that by clearing the control field of every descriptors we're
> processing.
>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



Applied to target-arm.next for 5.1, thanks.

-- PMM

