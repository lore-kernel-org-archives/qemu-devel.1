Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD15C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46EA206A4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="makBJ80e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46EA206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9DFA-00022w-Tp
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 14:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gorcunov@gmail.com>) id 1i9DEI-0001c7-Ig
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gorcunov@gmail.com>) id 1i9DEH-0000DN-8b
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:57:06 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <gorcunov@gmail.com>) id 1i9DEG-0000Cv-Va
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:57:05 -0400
Received: by mail-lf1-x143.google.com with SMTP id c195so9584597lfg.9
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0DTjWe83PEeKAfZ77pJUpJ1SuMpU/tIMoLavaRj9hSg=;
 b=makBJ80evqUAPNUSQej7g3dFEZ/9mXMTCO8vt3cRUTFzZnMCgle7JRBK+jzXBwBsvu
 /wJD1zOeoXcMM7qQTk8fWROfVtU3XMyuCrEGOkD1Url2u1OxtLd0WOjvnhxEP3o1umjt
 b/X4Ey22fRfmJYnICQ0ST+peYkoc7PUEDPWNgf6HoHxW4Oge4HkNjBsmw2oKCxQ44kLd
 UeE8NqFDyPYuBuF3RItKcL6DiEr69Q7tOobstv/gRix0uwnKPU1kdbdLVpQkC8D2NGLB
 RxXVyAM4RdbpGEQiPk23dn4H6Cb45QtoRVI9oHAZU43bOxkOjIcL+ABjTcEz3cbV2RwL
 7lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0DTjWe83PEeKAfZ77pJUpJ1SuMpU/tIMoLavaRj9hSg=;
 b=U0xoK8Mh8xywPIfiqABjHmdDpeUWhpmKfico75ix4vcKkAS6YJZT4VYt33IB3XWFNM
 z+Rj3CSrFxlqgU4gyRVhiaZJy2DWdBqXqTUzoYKtNk1hxDsT5ABrmvk/OO97tn3V0lzV
 UXAEiNOoYIXmXEiSeRM0x5JczaLyVzKSZKd3w4HjkC6ppr/b9AnMvuQXYfbv2dSBMfuA
 Zq/PRwn7/ZBAhMBFA0fCl5im1UBw4yLHnfmbGC2cCNcikE3hZuwgiFDe4YzErIzmNdq9
 1v5fMqz4cIK3SjhEUsVZxjDFbCms/MqIQ0/Ux1LjVtCE9884zrYKcbH/W8Qjhku2NSZy
 KKlQ==
X-Gm-Message-State: APjAAAXg++Op0hNFGPs9vf8GbZGzhWjnne2lZ7sAoI2xUo1+TdZ3b1A7
 GocilPBr0M5hU6u0uDTzbCgjcblQnnY=
X-Google-Smtp-Source: APXvYqxdV3MYWgLlOZWeM7o653RlITt8cGx9eTuI/ZEwoTKACPQE2j/Hn2JxzOTA6Uk7orKTiLoPEQ==
X-Received: by 2002:ac2:5925:: with SMTP id v5mr5428733lfi.8.1568487422360;
 Sat, 14 Sep 2019 11:57:02 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
 by smtp.gmail.com with ESMTPSA id z19sm7203375ljj.50.2019.09.14.11.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 11:57:00 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
 id 90483461115; Sat, 14 Sep 2019 21:57:00 +0300 (MSK)
Date: Sat, 14 Sep 2019 21:57:00 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190914185700.GI1508@uranus>
References: <20190913154344.GH1508@uranus> <87sgoy3emv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgoy3emv.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] error-report: Add info_report_once helper
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 14, 2019 at 08:40:40PM +0200, Markus Armbruster wrote:
> You neglected to cc: the maintainer (me).  I spotted this anyway, more
> or less by chance.  Next time, please use scripts/get_maintainer.pl to
> find people you might want to cc:.

Ah, sorry for that. Will do next time, thanks!

> Cyrill Gorcunov <gorcunov@gmail.com> writes:
> 
> > We already have error_report_once and warn_report_once,
> > thus lets add info_report_once to complement. Actually
> > I use this helper a lot so might be usefull for others.
> >
> > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> 
> Patch looks reasonable enough.  However, the new info_report_once() and
> info_report_once_cond() aren't used.  Your commit message suggests you
> have users in unpublished code.  Is that correct?

Exactly. I work on yet unpublished but open source code
(https://src.openvz.org/projects/UP/repos/qemu/browse) to be
precise. But work is still in progress and hasn't been pushed
out.

You know I posted the patch simply because it might be
useful for someone and it looks a bit incomplete that
we have "warn/error once" but no info_once. Up to you
to decide if we need it in vanilla tree.

