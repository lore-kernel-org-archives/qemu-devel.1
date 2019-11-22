Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C88C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CF320714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Fq8vHjRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CF320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9vk-0000dN-2H
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iY9uq-0007wA-Pz
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iY9uo-00040B-NQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:28:07 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:39110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iY9uo-0003z7-5I
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:28:06 -0500
Received: by mail-ot1-x330.google.com with SMTP id w24so6318458otk.6
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 06:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=RNs/VFrRFcAmGfbAULJ3ATgwU22dMdMxxju5abh5EGs=;
 b=Fq8vHjRxxxNcC7PWMtNLIpE4blz3TgwxJKyekoLKjYfhtmtOg7JoLbk7ML8bs4BgHx
 auLgICp2gh5SkKYfkPTwCN79OpNmMRTj9yX4CCLHohLJmthQojO642jcR26XSDGyWQCX
 uRK+EIZUAJdWN8JDaAFxh8YWu/K58NSldPGmsNdZonOaCkQsutGq0NYZaOFsL/TCV34Z
 7+Gksdtd2chxPYZE70JRY6ZuedGLG/yhDyWtGL1ZpZIQkrB17btssYQ4I5CZGpTDh1CR
 pgJd3yiEZGsnEfkKjll4YxkOiHynIPfAyZxKO0VW9oMjMXGrK28h+hd/0NTcD1/qoOlg
 Mcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=RNs/VFrRFcAmGfbAULJ3ATgwU22dMdMxxju5abh5EGs=;
 b=ZOqIhjPoWqTh0uLwYo6aBwJhOsL2yZbD8Gs9V6qUQJ8b+iAarqLhPXC0wNM4CB9fPn
 iBcyOEKRMYTbh35c9E7B3jAZh8oUmIsGTDoOEvbgZw5QwstNQY6OezHjm/zLTKmgcxh+
 r4rBTAql8b9rk1bO/GngDZn+NPW1FNrsfr4flNxrxPQo6lBlSY/GllJOl7OZ1iOKfqg8
 chlYdJEiXClnuZXJZJG6pW4orVTysC8Y3jO/iFi5kP2BZFF5Lx33gySChO91UOvTb22G
 YP6JK9uXj6Yn/Hq+28CiALWEn9Yod8FIIMiGta7vFPL/S4Dtm3UmDwT8fhF7g8nHfoPf
 1STQ==
X-Gm-Message-State: APjAAAUUyJgKQzdebXRuvaLJwQCPXhV5e1eWtBpoGqY0DQvaUo6zRGGf
 tm4ri78wEYnIqCKff8d6CedynCCc1rk=
X-Google-Smtp-Source: APXvYqxZkGB8hNNl/MAjoWMi6vB3laeHlC87Xn2eswixYmLLPSMnKvh56j0sa8Yjdooc+LNhKZFAPg==
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr10055697oto.97.1574432883600; 
 Fri, 22 Nov 2019 06:28:03 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id t2sm2195029otm.75.2019.11.22.06.28.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Nov 2019 06:28:02 -0800 (PST)
Date: Fri, 22 Nov 2019 08:28:00 -0600
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ipmi: add SET_SENSOR_READING command
Message-ID: <20191122142800.GT3556@minyard.net>
References: <20191118092429.16149-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191118092429.16149-1-clg@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Reply-To: cminyard@mvista.com
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 18, 2019 at 10:24:29AM +0100, Cédric Le Goater wrote:
> SET_SENSOR_READING is a complex IPMI command (see IPMI spec 35.17)
> which enables the host software to set the reading value and the event
> status of sensors supporting it.
> 
> Below is a proposal for all the operations (reading, assert, deassert,
> event data) with the following limitations :
> 
>  - No event are generated for threshold-based sensors.
>  - The case in which the BMC needs to generate its own events is not
>    supported.

Ok, I've included this in my tree.  I made one small change mentioned
below.  Beyond that, I think you could make this function shorter, but I
think that would actually make it harder to understand.  Breaking it
into multiple functions doesn't make sense to me, either.

If you are including this in the ppc tree:

Acked-by: Corey Minyard <cminyard@mvista.com>

with the change below and I can remove it from mine.

> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Corey Minyard <cminyard@mvista.com>
> ---
> +
> +    switch (do_gen_event) {
> +    case SENSOR_GEN_EVENT_DATA: {
> +        unsigned int bit = evd1 & 0xf;
> +        uint16_t mask = (1 << bit);
> +
> +        if (sens->assert_states & mask & sens->assert_enable) {
> +            gen_event(ibs, cmd[2], 0, evd1, evd2, evd3);
> +        }
> +
> +        if (sens->deassert_states & mask & sens->deassert_enable) {
> +            gen_event(ibs, cmd[2], 1, evd1, evd2, evd3);
> +        }
> +    }
> +        break;

I moved this break statement above the brace before it to keep the
indention consistent.  It just screwed with my brain too much :).

I looked and there is nothing in the coding style about this, and I
found this done in three different ways:

  case x: {  /* in vl.c */
      ....
      break;
  }
  case y: /* in thunk.c */
      {
           ....
      }
      break;
  case z: /* In vl.c */
  {
      ....
      break;
  }

Oddly enough, I didn't find anything about this in the Linux coding
style document, either (I was curious).  One could argue, I suppose,
that according to the "Block structure" section in the qemu style and
the similar section in the Linux style that the first is correct,
but then case statements violate the "Every indented statement is
braced" statement in the qemu style.  This has always bugged me in
C, sorry for the diatribe on this.

-corey

> +    case SENSOR_GEN_EVENT_BMC:

