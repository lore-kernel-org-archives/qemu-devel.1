Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1F1C5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAE320575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm4Yx9SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAE320575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43473 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT2zv-0003yj-98
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT2yM-0002V9-Iw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT2yL-0000V1-H7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:34:54 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT2yL-0000T8-3R
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:34:53 -0400
Received: by mail-ot1-x343.google.com with SMTP id z17so25851711oto.4
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ncCl9GLARRJh6MLZC08g3f1XA/9ouP/KQB+UzXaPmhU=;
 b=gm4Yx9SOGimjGABKAoYr4RlFSDBcOMEs6i7c2EU5hO5sMAVqt5lJy73rCrgwxfo0r5
 zi97YhPAJTLT0VVnnomaZpltPHc118YmuZn+ey8rl+hqu6LagIlFODXePvtx5YMOv6qe
 NHJ+q9k3N/cFqXowUVFm9lRKjT7PGmzLl5XLAq9hUxsrskAQLoAQ+Z1x9uRBn5ryNLx6
 gJ6hyR8N3tXSE6tWxipG8CIOA+2puXZu7UInfKcEzd4RoM6pLR7l67x6+v4JTzZT6fyx
 uScpBM/HqXLiAi3xtIXkO7VxDuiW9IrblK+JTOHxPSr758i2EPvxxLDNRxgV8O9jd8Te
 sZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ncCl9GLARRJh6MLZC08g3f1XA/9ouP/KQB+UzXaPmhU=;
 b=ueUYTsSnZHDU0rqzEsjDqrCEQxQiX4uY+zdPQvdAtnvJNOpeohbbyjab+dW6PKijgC
 6/toD3WEx0aPUis2BD+UdoNk9b+phKa3ZqR982jZgxYyU7HpHuCHBcYZQmzsgkvRSWxb
 JZUy4awjxbHcCuXtwUj9cwrK1RqK0G1xCwwZDJvp/3jn+Z+Vj2KnvKEimrT5pN3sDJuv
 yYyTIC7PTXCfSKNSWb77cqfrWKQT5HL6etJ49Ng+/EYl/cfF0W2V5jZ0r2rxrWdLVvM/
 Id7ue0pZcoO6uJ+RPLdK8ACmmKYn6NStSxk+GUA1vrD8QpbrDt5lbcMlTwqiOsrw2br0
 lgbg==
X-Gm-Message-State: AGi0PuZstwDd4ldaD27UffUfmqTVSwBhKcVpH5bWZ9/7N1UEhu3STQK0
 iXkE1v/LQlA7xQUjb+y7ICtjRRQ/i5wFIzZZdwgvOA==
X-Google-Smtp-Source: APiQypLQ7wUMkhRObMBHGaSNLElmx4xPbZSrqh/OuvGsxMgfG7mYvIk7M4o2XpZpWtCN3qxe0Up3PgSUQs94CBDn8kw=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr17190112otc.221.1587990891350; 
 Mon, 27 Apr 2020 05:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172351.26583-1-pbonzini@redhat.com>
 <20200422172351.26583-4-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-4-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 13:34:40 +0100
Message-ID: <CAFEAcA_2G=Tns4pbT5-Zp==6md0WuUMkhaG3nvkLvb9kXP=7Qg@mail.gmail.com>
Subject: Re: [PATCH 3/8] run-coverity-scan: get Coverity token and email from
 special git config section
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::343
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

On Wed, 22 Apr 2020 at 18:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Support a [coverity] section in .git/config.  It can be used to retrieve the
> token and also, if it is different from user.email, the username of the
> submitter.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I think a couple of references to PROJTOKEN in comments need
updating to say COVERITY_TOKEN. Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

