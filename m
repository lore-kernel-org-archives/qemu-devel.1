Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27B0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 04:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFA92084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 04:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjRQYX6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFA92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGErV-0004fH-Q4
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 00:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mattkilgore12@gmail.com>) id 1iGEql-0004CJ-Lw
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 00:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mattkilgore12@gmail.com>) id 1iGEqk-00055z-EB
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 00:05:51 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mattkilgore12@gmail.com>)
 id 1iGEqk-000554-8S
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 00:05:50 -0400
Received: by mail-io1-xd41.google.com with SMTP id q10so10667045iop.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=8FT15PJzVfAsoByH7kpNGWsQNWufnyykQrGMnKVou9o=;
 b=FjRQYX6lR24Jj1+Ycg7FpGLMhM9d4ym0CRafIEl22XHXRzj3tNaSNPsh5DdIHbZeLY
 S7ujo9mMYZxfngsPtX/l1lcx4koU9N6cmPxztnAZgtD0B0RTxBiIakBAKsyn/Dy+BFWs
 hPLJiESHOeVjzw1nd0xMdknHLaJsl2WGxkC1RFVX3V0IlEPdm3YaoqWa8aCEg0bKGpyT
 biNVLkFlnKXBedmjatr2YEf3omBqik96bAQPoUMWaValcrE3rwUd/gRcwXKQDVvxKt+F
 pkGZeXVTKkkTQ0GgJ4RYeb7xJ4FNGVcbwu14xF4nBIEcSzZoqRbVmdctjm18gXllDQHK
 8IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=8FT15PJzVfAsoByH7kpNGWsQNWufnyykQrGMnKVou9o=;
 b=sDWyzuBmwa9aMLj4IFGTnjnewHn/LVeA0cWwKdg8DCPevHMz6guFg/IAppbLlktKFK
 ObHvN80k6EsiqLkFJC4IaAeji3P3l0wEH5d+uSemD4SVjmP38X7Jjfa8iCQI4IvbJoVH
 JV7Huytz1yX0YKDJvRsnv0CcCAYhjWSaSPI0yi4x61OnPKOd0rq7HiHj17uw02cgHL0w
 BlGfTZHRkEv8VW5f9QcPiqptm10z2v/yfUgEc6HRzmCFFdJ4LHMmLpnBF/VSmnFK9r0+
 R83+tv9MXdB9h8v627BQ1/eT81BMRjj9Lpldsz3ob9keZdY/nWWHAuMLNhCr0ufH8BZX
 yahQ==
X-Gm-Message-State: APjAAAWJUxrQ2UvDnmAqf89+nrxLsejpzLdZADhFEBckADd3A35BCOs0
 5FW48Swd1E1Yo74orjiTkZ0=
X-Google-Smtp-Source: APXvYqyhnV4oElO+C5DQOWTKpp3809E9kfY1CIDrru90NLq9xet97jyqfdmaEuFiyxoYQI1l5B6qDg==
X-Received: by 2002:a6b:c8cf:: with SMTP id y198mr7722070iof.179.1570161949130; 
 Thu, 03 Oct 2019 21:05:49 -0700 (PDT)
Received: from gmail.com (d118-75-38-58.col.wideopenwest.com. [75.118.58.38])
 by smtp.gmail.com with ESMTPSA id
 t4sm2832016ili.8.2019.10.03.21.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 21:05:48 -0700 (PDT)
Date: Fri, 4 Oct 2019 00:05:50 -0400
From: Matthew Kilgore <mattkilgore12@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] curses: correctly pass color and attributes to setcchar()
Message-ID: <20191004040550.2xm4ohlwragjtjfw@gmail.com>
References: <20191003001849.7109-1-mattkilgore12@gmail.com>
 <58556cc8-0810-4630-5162-0a3a94484c4b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58556cc8-0810-4630-5162-0a3a94484c4b@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: samuel.thibault@ens-lyon.org, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Thu, Oct 03, 2019 at 09:36:56AM +0200, Philippe Mathieu-Daudé wrote:
>Hi Matthew,
>
>On 10/3/19 2:18 AM, Matthew Kilgore wrote:
>>The current code uses getcchar() and setcchar() to handle the cchar_t
>>values, which is correct, however it incorrectly deconstructs the chtype
>>value that it then passes to setcchar():
>>
>>     1. The bit mask 0xff against the chtype is not guaranteed to be
>>        correct. curses provides the 'A_ATTRIBUTES' and 'A_CHARTEXT' masks
>>        to do this.
>>
>>     2. The color pair has to be passed to setcchar() separately, any color
>>        pair provided in the attributes is ignored.
>
>You clearly describe 2 different changes in the same patch.
>Do you mind splitting in 2 atomic patches?

Done, I've sent a new patch set with these changes split into two
patches.

Thanks,
Matthew Kilgore

>
>>
>>The first point is not that big of a deal, the 0xff mask is very likely
>>to be correct. The second issue however results in colors no longer
>>working when using the curses display, instead the text will always be
>>white on black.
>>
>>This patch fixes the color issue by using PAIR_NUMBER() to retrieve the
>>color pair number from the chtype value, and then passes that number to
>>setcchar.
>
>>Along with that, the hardcoded 0xff masks are replaced with
>>A_ATTRIBUTES and A_CHARTEXT.
>
>This comment would go in the 1st patch.
>
>>
>>Signed-off-by: Matthew Kilgore <mattkilgore12@gmail.com>
>>---
>>  ui/curses.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>>diff --git a/ui/curses.c b/ui/curses.c
>>index ec281125acbd..3a1b71451c93 100644
>>--- a/ui/curses.c
>>+++ b/ui/curses.c
>>@@ -75,14 +75,16 @@ static void curses_update(DisplayChangeListener *dcl,
>>      line = screen + y * width;
>>      for (h += y; y < h; y ++, line += width) {
>>          for (x = 0; x < width; x++) {
>>-            chtype ch = line[x] & 0xff;
>>-            chtype at = line[x] & ~0xff;
>>+            chtype ch = line[x] & A_CHARTEXT;
>>+            chtype at = line[x] & A_ATTRIBUTES;
>>+            short color_pair = PAIR_NUMBER(line[x]);
>>+
>>              ret = getcchar(&vga_to_curses[ch], wch, &attrs, &colors, NULL);
>>              if (ret == ERR || wch[0] == 0) {
>>                  wch[0] = ch;
>>                  wch[1] = 0;
>>              }
>>-            setcchar(&curses_line[x], wch, at, 0, NULL);
>>+            setcchar(&curses_line[x], wch, at, color_pair, NULL);
>>          }
>>          mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
>>      }
>>

