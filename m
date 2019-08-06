Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573DFC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2551620C01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqCTDFKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2551620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huzk4-00065k-GI
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 09:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huzji-0005g1-32
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huzjh-0004sU-8V
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:42:46 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huzjh-0004sC-3I
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:42:45 -0400
Received: by mail-ot1-x341.google.com with SMTP id r6so92533228oti.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m+1XsYnbj/6Ci0QwtjerowJ3XFjQ6oVh6Arqc3BipRs=;
 b=JqCTDFKfGlrnUyha8g7nJ87FDjBlOT7kdQ0ncaYADmmPdO+C/7SGoY+bdwaLgzat0g
 Dl+5ksXwGlhsvJPcXp1nP01qYhW+sTe5u8ht/MNcG3RmnQi10tELei8zZM9/Gf9VZj5i
 Nn85KLqctKlfRQM63FhMelgzSrujLOiGZGsLExSm/nPWImBMBH7i4ObFmnQSvfnV1uAE
 Py2+3KRJ/c1xDFYzrkshExF3iBgxN2YG01tK8Kcp5d4A9GsGa3P4T3Feg11W+22YMuE8
 IQR5KzJr23NCE54IuZ/M41JQV+JJl1xb1AdOudMGDevEk31Xvm3UtTwD+prbtn0jHSYW
 2lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m+1XsYnbj/6Ci0QwtjerowJ3XFjQ6oVh6Arqc3BipRs=;
 b=cJhib4XgCeb/Bq0dHCpVVI7VqaIkCpbg8DpxZL8JScGHrQPK4A1w5rw6HObVJNUaDz
 0kscYE6vpDUZHPMuvGFjzF14KGGJZXm626t1Cgqj5Z4sQLSAzWaU1sxjIV46z1DzzJZC
 EjFsNwdiSynyYuf+5ZMYZkq6N2iuxHO06XKfOUqXiN53+QrR19xh4esaa8nrLmve+1+S
 QAZdb8aGc2+RL2lZcIrUt4JDUKJPkQ0on2Z1MjaWB6snRfi19MXLA8dZsaUfHp6vZ3e7
 ub0+UrjXjVDUvAl1vyW4cR/isXKvEQ9iQmQutLU/q+1YApgxtNuyx/1R0mEqHFZsWilc
 e7Xw==
X-Gm-Message-State: APjAAAWoooGXEvBd2VEfIg8I0LzHByBd/5PYj1Yy0LahFyczP2482jRr
 RYdssMl4o0XnI8NVd+5xoncILtDf4T2UIjM6r5PHVA==
X-Google-Smtp-Source: APXvYqzR7rsnj0Eu8IyFAHIzRx/wPjvMaeAiDtEmTNuysf+bgzSC1krCsDwbo9jPlFSnh38v53XCKHIDQ5PVKCAWgJo=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr2880659otj.97.1565098964186; 
 Tue, 06 Aug 2019 06:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190806115819.16026-1-cohuck@redhat.com>
 <20190806133952.vcgjaz6zx27b25u6@sirius.home.kraxel.org>
In-Reply-To: <20190806133952.vcgjaz6zx27b25u6@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 14:42:32 +0100
Message-ID: <CAFEAcA-w0YEhnfu-eJuQx-Kb5s7ESwKkYqUs40+arnZxABoXQQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.1?] compat: disable edid on
 virtio-gpu base device
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Aug 2019 at 14:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Aug 06, 2019 at 01:58:19PM +0200, Cornelia Huck wrote:
> > 'edid' is a property of the virtio-gpu base device, so turning
> > it off on virtio-gpu-pci is not enough (it misses -ccw). Turn
> > it off on the base device instead.
> >
> > Fixes: 0a71966253c8 ("edid: flip the default to enabled")
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
> > Only just noticed this... should we still shove this into 4.1?
> > Or do we need a compat 4.1.1 dance for this?
>
> I'd say 4.1, doing it in 4.1.1 becomes too messy.
>
> Peter, can you apply this directly, or do you want
> a single-patch-pull-req instead?

If you're happy for it to go in I'll just apply it directly.

thanks
-- PMM

