Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77719C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C5E20848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOah7EFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C5E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49553 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B16-0006AR-G9
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j2Ayf-0001xZ-VJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j2Ayd-0006nD-KX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:40:09 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:45322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j2Ayd-0006mM-GV; Thu, 13 Feb 2020 04:40:07 -0500
Received: by mail-yw1-xc43.google.com with SMTP id a125so2287453ywe.12;
 Thu, 13 Feb 2020 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6Q0qB5blx30CgH7LC/Q64RAkBHUHVkwmIqC9zE+i9wA=;
 b=XOah7EFbhmf3/3BLajWW6e0pToDIfi237Rp35OQIHfGEwTCYnPA9LsCBieXeMNPSK9
 BbouB31z3y/6+TV63WBMcHs/hduNccxn5r2HtNB7M5ImbvIpobxNZTJNYEtM68tkaHzg
 tbQvGF6u1Whs3lpMAWEtsDrvLiV2pE9v0++v5tL7d+lpOG5Kiif7mPKa83pU7HhlIPMU
 +CpuQR+Q+fASQsm2gtf6OKhUD6QjGFS+P7fqMVnZ1Qb1yDcGImGoNcrWw9ww0r1vacuw
 2p0EEwacv3bcVYYDb0fXhGrsyOZpo0NeTDEPaoC4maJ1sGrRonrcxTCrfKZw1EnHeR/Q
 +aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6Q0qB5blx30CgH7LC/Q64RAkBHUHVkwmIqC9zE+i9wA=;
 b=U3J+UlTpxR2c2DxUtRw+6dqKlzV5utFNT+o+Z5/BiJdtMrtE3QwbrIBYLaLYD7dwgn
 1bGBesBbkxLZ5pw1zOcwWdIBAppSTCzT/+cMeSLU28d8WulIrAgd5qqsOqEp+bERQk9h
 pdei56Dr17K7wCSyFN3GV8Pfaw+Tpg0YyjqCeElf7nRbGnd9o7IReSRMb1gHxXNVVU6m
 KX3R16Jagli8rWcbbpamKho66o7tQNxfzuurkNAIMOK1j/xTORo9R6CTujzLwYdM7sYj
 A8tq2/M//HlvlrGwaHYVA1xhRrk7kR5sckffXCJw+kC0TCYGzhxcJgkfJ/ppz+lsfgN0
 tjXA==
X-Gm-Message-State: APjAAAXTYLTheX75UtRszvBbyfnMJe8nz7LXzCvXy8KuJyUmrAKaF9BS
 rPAo8ibgsIuAYGaFKYOq8NQAoZ7M7crlsY4JYgY=
X-Google-Smtp-Source: APXvYqzYdWGZ0rh6H0kGcm9gOMLsZ3Q5ZvgE/v++SLk5oA8keG1npJu0IqTVVFFFqZRDTJGCL1cHzD8xCUshQzZuQwc=
X-Received: by 2002:a81:9816:: with SMTP id p22mr2156509ywg.209.1581586806456; 
 Thu, 13 Feb 2020 01:40:06 -0800 (PST)
MIME-Version: 1.0
References: <1565335544-23584-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKOyTXgs5uZuukZjAEqQkTtf1U+vD=u9_470+OgsfaQdqQ@mail.gmail.com>
 <CAEUhbmW0sCEN7mzSfCvUBSqhAGD3v5JyeDj2iSqs0MQJv13bag@mail.gmail.com>
 <67e917c9-d080-5af1-22ea-ba6d9af4daee@redhat.com>
In-Reply-To: <67e917c9-d080-5af1-22ea-ba6d9af4daee@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 13 Feb 2020 17:39:55 +0800
Message-ID: <CAEUhbmUswmWjiaAy+26mYkEMpciTP6u6=WDmVX2U9MKo=uR_qA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] hw: net: cadence_gem: Fix build errors in
 DB_PRINT()
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

On Mon, Aug 19, 2019 at 1:40 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/8/19 =E4=B8=8B=E5=8D=881:24, Bin Meng wrote:
> > On Sat, Aug 10, 2019 at 9:58 AM Alistair Francis <alistair23@gmail.com>=
 wrote:
> >> On Fri, Aug 9, 2019 at 12:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>> When CADENCE_GEM_ERR_DEBUG is turned on, there are several
> >>> compilation errors in DB_PRINT(). Fix them.
> >>>
> >>> While we are here, update to use appropriate modifiers in
> >>> the same DB_PRINT() call.
> >>>
> >>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >>
> > Ping?
> >
> > What's the status of this patch?
> >
> > Regards,
> > Bin
>
>
> Applied.

I checked latest qemu/master and found this patch isn't applied. Could
you please take a look?

Regards,
Bin

