Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855B8C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518B22073F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnNZEfqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518B22073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIUI-00071M-OE
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBIT7-00063p-Kj
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBIT6-0006ip-Bv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:57:01 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBIT6-0006ib-4W
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:57:00 -0400
Received: by mail-ot1-x341.google.com with SMTP id 21so6059400otj.11
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CyRdeEQgyAOnG3zd1dPteCUF9YJxa0UTr2S1CwNwhPY=;
 b=EnNZEfqcOhov16oGRIeDPsXRXxtMM9cwnPq4N8gpky5rDZIZp1F6n84c5ZwdKi0B33
 5B9es0xCvPkDrITd3wuEV84aGXpPzfBJtLEwzBZKSTr5x/lrVxoxWT1/6kP1x1AOrd/Z
 ZlDgfu4fH7AAN7bLUhrCbHDgmJ9tbJBHB926qehkulrgxtErvabidceuywyrzzwuZgTE
 UOLxhWSBaL8ajKHyQYsieEtq972PSqnBZSa8Fb9pTjJHQZOFzDYDVumkAo+bXWq6dJ55
 VEUTL0jSELkSAbIC7jCqDI8YOETnv316Sn5YAuIvJlZm2F4gdskiSSwXKD2Cp04U4Z8I
 +9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CyRdeEQgyAOnG3zd1dPteCUF9YJxa0UTr2S1CwNwhPY=;
 b=SvYbhWfMSNkP4WaijTZs6mUVaO/QE1ZESwcNP+EaOJQReoNBZ8K8XZeOcpn/pHomTC
 hFrNBj5/QyxmtRBYF4BxzSjfHz/3vawviPomfbQ3chpAy4r9uTHdNDuvgdmVcXqIHKXG
 0L8+93BqcvCGB3rPTgYbdCAnmpCCwKunGmkHutzE5HKM0rCPy/YmBCAyriOXvzH/hTjS
 or/EHHhaxdMbiJOAp6SOV8s8E2XuworUVLzlWbZ9WOvqEGM7IIPkxJFI2+DqcUA0FXB2
 4KJQpeRG0nEA5aSEpZsLCH3IOiU3/Q+qWG4vWcjrMzFl+/7S+HVEj/WE0OUrrhrpUk46
 9cdw==
X-Gm-Message-State: APjAAAV1E6UnTU0+YAok+TJUht+xqp5qh++Q1hM41qQ6HMFiddWxt8j2
 t3YWuiKLn5z7soik+dGi7Ri0kIMMwoO4+C5Y30WReQ==
X-Google-Smtp-Source: APXvYqy+tGx5SMX7NTX8cBattDmtPLjj57rK1rveQw733lQtHmRq5QcLPh40tqyHzUEpM9c5cxOFTMk8QMlKupQxxjI=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr4093811ote.97.1568984219068; 
 Fri, 20 Sep 2019 05:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190919155957.12618-1-peter.maydell@linaro.org>
 <a72e3d2a-ff05-a85b-616c-2bd47a1575e2@redhat.com>
In-Reply-To: <a72e3d2a-ff05-a85b-616c-2bd47a1575e2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 13:56:47 +0100
Message-ID: <CAFEAcA_tFpYkwWgUQ9jsdwA+TF5Z+mSF_zbL2hLmNoGPbdGjkg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix in-tree builds when Sphinx is available
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 13:27, Eric Blake <eblake@redhat.com> wrote:
>
> On 9/19/19 10:59 AM, Peter Maydell wrote:
> > In commit 27a296fce9821e we switched the qemu-ga manpage over to
> > being built from Sphinx.  The makefile rules for this were correct
> > for an out-of-tree build, but break for in-tree builds if Sphinx is
> > present and we're trying to build the documentation.
> >
>
> > Fix this by using $(MANUAL_BUILDDIR) when constructing the
> > list of DOCS files we want to build and also in the source
> > file name we install for 'make install'.
> >
> > (Among other things, this broke the Shippable CI builds.)
> >
> > Reported-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  Makefile | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
>
> Tested in-tree builds both with and without sphinx installed:
>
> Tested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks; applied patch to master as a buildfix.

-- PMM

