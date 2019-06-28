Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E3AC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B779208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzvSbxVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B779208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgek8-0007di-RD
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 20:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36000)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hgejd-00076e-48
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hgejb-00054x-39
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:27:25 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:38736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hgeja-00051n-BD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:27:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id y15so2040282pfn.5
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 17:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=pLHfPP7FjP/uE9RZSLQvD6XSge/jBsyE88XyGOQUBsI=;
 b=TzvSbxVGhzfkUs0XGCXC5hdvsVZLYIsnTow7aN4hUCP3Z2fc+DEzizVekZsq9g+R4D
 rYOkEUPrl5sKAkHg8wU2dXWCgglM0veudwks6Xjii0iOYOe/dbmNwGJ/ViM7ZNac1cEf
 MzbifbjQ9niVDPb+FTnCu1yhE2NnPH/nOwHDvF3eSNjdrn8EfT4+7v8UX/C48sY+nPe3
 UcvRgGnlyljN6Y1s6+i0FiOQjOTz7e4h1bNBTs6SezR58I3qSrG9Sh+Yj9W6RQB0BrQm
 SoYXOU7yd8Za+W+e5DXhpVDQqvzjZFd1a7LJEeX6URIPwdS9pKKCA/k6DSludm8izgHU
 c9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=pLHfPP7FjP/uE9RZSLQvD6XSge/jBsyE88XyGOQUBsI=;
 b=dY40VO3g11BnYI92HLQnug+GMELZ+NJknD2/EKGNKkIlU3sgibERNEJ+NwoOutOPAZ
 Ci8NJeUbYQUPxBlkcAOM0qo1IGnO4p4rLKLQmqvQoH+w+/lIiDLmSfRZYMJ//MVuA2vr
 6jOHXxdasD0nac5Zv0vD7R+rm4Xhfhg3ZRuqVGnJw6SR7p9g7sdZdY9i6Vlu3nOCjyT0
 h98hzIHHSTG/6MP1HaPik+ZXeazPIeD3uu6BQzv4FQrmyVpf1YY9NM+UL7G+TJnnBlQ2
 HX3cTj+DFhPKVSffpXaIy3UCVbmc0AbgcrDBs/StJyOUJxVglbj6Eg4zGC1yZWn6UTtA
 SRMQ==
X-Gm-Message-State: APjAAAXOyZ7vf+HptoTlwMyOsCZMWEvgBQSe6ccMlBv+97+uYjSa+dcQ
 UZP3vkgPhq6LVDMMNrglE+w=
X-Google-Smtp-Source: APXvYqzjOhsdXuf/YdXwQa1Z4Z8C51Ksqqw+espB1yVA+n4uyWThYsjnPwHepkB7bNYgorOhaucRmQ==
X-Received: by 2002:a17:90a:898e:: with SMTP id
 v14mr9405298pjn.119.1561681638314; 
 Thu, 27 Jun 2019 17:27:18 -0700 (PDT)
Received: from localhost.localdomain ([125.130.54.1])
 by smtp.gmail.com with ESMTPSA id f197sm240359pfa.161.2019.06.27.17.27.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 17:27:17 -0700 (PDT)
Date: Fri, 28 Jun 2019 09:27:13 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190628002713.GA19257@localhost.localdomain>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 07:09:39PM +0200, Richard Henderson wrote:
> On 6/27/19 3:22 PM, Lucien Anti-Spam wrote:
> > Hi Laurent / Richard,
> > (resent email )
> > 
> > Does anyone have any knowledge why
> >     gen_exception(s, s->base.pc_next, EXCP_RTE);
> > 
> > is generated for "RTE" instruction, where as the "RTS" goes a gen_jmp?
> > ( note see target/m68k/translate.c in functions DISAS_INSN(rte) and DISAS_INSN(rts)
> 
> History, it would seem.  Paul Brook implemented it that way in 2007.

Ok, thank you I wanted to make sure RTE wasnt being one like this as a special case.

> 
> I think that it should not be implemented as an exception.  It should be a call
> to one of two different helpers (cf and m68k), followed by either a normal exit
> to main loop (to recognize the new interrupt state) or a debug exception.
> 
> This sort of modification should be fairly easy to perform, if you have the time.
> 

The original way of handling it was causing single step to malfunction, I dont
rightly know why but the effect was that step would step twice and end up
inside the ISR function again OR just stepping past the RTE as if it didnt
exist.

I have made a quick hack to implement it the way you suggest and confirm that
works better.

HOWEVER, the "return" address is the instruction that causes the exception.
So it immediately does return to the ISR.

This is a different issue, but I think interrelated to the original problem.

Further single stepping INTO the failing instruction results in ending up
at the ISR +1 instruction

I will look at these but so far a little lost on the why for of them.

Cheers,
Luc

> 
> r~

