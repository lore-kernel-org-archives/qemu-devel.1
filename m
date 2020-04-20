Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008CAC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0CE206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ah1shf4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0CE206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYOc-0000Sm-Ty
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33952 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQYMm-00074K-Fd
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:29:51 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQYMk-0004Sv-Qe
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:29:48 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41245)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQYMk-0004Qr-Cq
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:29:46 -0400
Received: by mail-oi1-x243.google.com with SMTP id k9so9097501oia.8
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zPPXb24P1AsNF2EzClAYbclgmVA23VofI5lKiseqe7g=;
 b=ah1shf4HSg/nvJ8s11qa+8NLytbbP2+0zc73p3ql5uknLz2DKkaIN1AMLSCXwCoQOB
 IUUNGwz+DoPmYxblBA9qILxBrLosv/D5rtRuJKby1Q4gjKAmckfomvUUsaxvzuo6jCH7
 aqihy/dQmta8H50f6yKPqN3XUmS/+txHciVu9yA68j+iORY3e1prjo7HcQUuAGQuPNiY
 PGTV2YlVJsylE2iPM1M8tfX9pefTk9qQqdQ487KHyPq8P4aNDCrnsRG15PRdri0HFVwW
 ZE0FWBNlj7vf1iMsuc68NqPtwGh0j3Lhp1LaYo9d+oCYclxukpkYlCbsI9dAVjkynYI2
 77SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zPPXb24P1AsNF2EzClAYbclgmVA23VofI5lKiseqe7g=;
 b=n2oEb0DdrkTcnR3gmNJLwz5AMYs+4aE+6lB1pV4c4FMPaqWc2aNicEELLnGNE9GZbi
 U6LcjOn0qNXZeQKJODSw1JrFl3S4A8VCqZNuhl0b2UBv9BimrOrJGAUCruAGw5wnMqfI
 zmebjX/sPoCn+99gnR2s05Ud/61kB3wjwjanfxYZs6EDEREtjDq/xG3i/VHqIKnzDTYH
 8Wd8a5jIeWK+Pd+DpfJRR4NqZbYPgzlZWc0xr/IKimkDLem1zebfDn8zC9SlVO+jxJnv
 wZ0M8nKi670C3vq04mfZMK5r8XK2zJnEUOGDkwCmU3zUKoilBKYr+EAujGzHbHdnVSfo
 Ognw==
X-Gm-Message-State: AGi0PubI2wN2MBYJlAsimMPErT0UkdNfxVI9VQcTA8ON2U9YQbfXTcB6
 aamqqtA6BBVgwC1Ace9VZb3beCRqHQc7MSkPL5BA0g==
X-Google-Smtp-Source: APiQypJiq2K2V4ldr/J8WQcI/YqsUZiz1LKQorCqjmJgGRBjKTVuRpqVwN+xWRf8OGxvvJhbxblTyskx5LHJFx1jgWY=
X-Received: by 2002:aca:3a8a:: with SMTP id
 h132mr10490068oia.146.1587396583373; 
 Mon, 20 Apr 2020 08:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <20200420151344.GC1080594@mit.edu>
 <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
In-Reply-To: <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 16:29:32 +0100
Message-ID: <CAFEAcA9BQQah2vVfnwO4-3m4eHv9QtfvjvDpTdw+SmqicsDOMA@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Linux API <linux-api@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Florian Weimer <fw@deneb.enyo.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020 at 16:24, Eric Blake <eblake@redhat.com> wrote:
> It will be interesting to find how much code (wrongly) assumes it can
> use a blind assignment of fcntl(fd, F_SETFD, 1) and thereby accidentally
> wipes out other existing flags, when it should have instead been doing a
> read-modify-write to protect flags other than FD_CLOEXEC.

For instance, a quick grep shows 4 instances of this in QEMU :-)

thanks
-- PMM

