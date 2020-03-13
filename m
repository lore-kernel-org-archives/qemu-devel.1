Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E0AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F1520746
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrYOhtJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F1520746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkNm-0001ya-Uk
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkNB-0001Xh-VS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkNA-0004RO-SO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:29:09 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCkNA-0004Q8-MD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:29:08 -0400
Received: by mail-oi1-x242.google.com with SMTP id w13so9336259oih.4
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TEBEAkRmGVVCH/9YuWoJb2TmAVZWCUwMxeF8Yqvohbw=;
 b=GrYOhtJPkpP/7GoVpYI54sKk2C9bUdTYHvpfsdyEyhD3+DdplB+iFUsv2uFzrjUbNp
 YvkuhXnlRmElyxKOqJ/xS7TuFQ1aA1zM6SIlNihzQ/7IFy25mMjn7Cgat9PSbTju1Bil
 wd55JxazLT2kl8gLpKfrf86lGzOWhDg3+3EnYtC7zU3TS1vfKN1+XPiCsfrGzwF0xEQW
 F81eP0+JCGrSJQScpT27TbDg/2UEidNrxhwA5+UtmQgMFNex91ksRixXF3s1ZUnr7gNT
 zxbY8Y1knnPW52/MPJ1e2cgoOT8epn4pf/7/B2hr8LN2/ZqyBHdN6NcCrnkN+MeF7wWW
 HB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TEBEAkRmGVVCH/9YuWoJb2TmAVZWCUwMxeF8Yqvohbw=;
 b=B6+gh4Q0Ezbg1JySy18gFzCWOgHrZPRx7Q4XU4O9goOY3RUxaASWGkvLOZoV9b5Yb9
 cnbwRbptuiapUTpZbIhoAq96ZDOO9b7nBcSa2bmP0aGosyd/s3GQPBdi+1lsC1+azNVc
 b9CEHtN2rBsNeC8reGW+yCEciz+0+aob2cnO99ZMEQhb7UHxY8mobEDPs1S2K0ftuE8Q
 QQw4cOCM3DAErKYfu5H6BQj5f/F3OakMjuQJPOG6SL0hKw48C0Qv5WuY6f2Ju/cz1l9U
 9jW2WBaWkf/DuKMrbXdrorkh/DJdVYosW/+ssRWwhsjFL+7RphDPT15P7B6jY60UeX6f
 8eHw==
X-Gm-Message-State: ANhLgQ0eVpTX7Cfew+cYNdhB9FEmwMK7+gOSuKCLKDBU9UoG5R06qYpC
 WdgXm7pYXdtk9GijUTBR0MFSEZNJ9PDVjbEAQKnP7A==
X-Google-Smtp-Source: ADFU+vsS5z2DP0IBTs0GomoSm5BR2+zEzhfpb2Ri/W2zZUCW3NrPvSO1ZqdIean6ozyOQA2ptKrM+rd/t2j0JSZO6x0=
X-Received: by 2002:aca:47c8:: with SMTP id u191mr7190493oia.170.1584106147767; 
 Fri, 13 Mar 2020 06:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-15-frankja@linux.ibm.com>
In-Reply-To: <20200311132151.172389-15-frankja@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 13:28:56 +0000
Message-ID: <CAFEAcA84eNDe82ZNCDO3apgjhoa3UEriWo1+2aW7L4ok0hMZgQ@mail.gmail.com>
Subject: Re: [PATCH v9 14/15] docs: Add protvirt docs
To: Janosch Frank <frankja@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 13:31, Janosch Frank <frankja@linux.ibm.com> wrote:
>
> Lets add some documentation for the Protected VM functionality.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  docs/system/index.rst    |  1 +
>  docs/system/protvirt.rst | 56 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 docs/system/protvirt.rst
>
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index 6e5f20fa1333ce23..74afbd7cc3fc0296 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -34,3 +34,4 @@ Contents:
>     deprecated
>     build-platforms
>     license
> +   protvirt

The order of this list in index.rst determines the order
of the table of contents in the manual. Could you put
your new document at a reasonable place in the manual,
not just at the bottom of the list, please?

For something that is s390 specific, the ideal would
be to create a new docs/system/target-s390x.rst
which is then the place where all s390 docs can
hang off of. This is how we're handling various
other guest architecture docs. It doesn't all
have to go in a single page -- eg target-arm.rst
is an example of putting some sub-documents into
docs/system/arm/ and referring to them from
target-arm.rst.

thanks
-- PMM

