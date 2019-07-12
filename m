Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96AFC742B0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 09:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DABB21019
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 09:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DABB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlrZ9-0003p7-Ca
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 05:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hlrYx-0003Ps-TY
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 05:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hlrYw-0004HS-Ql
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 05:09:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hlrYw-0004FS-KP
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 05:09:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so4096570wme.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 02:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VVrhFjBw36GbrBlL1I11LYJ9w5EsrQN9E2Wz4ljH9Og=;
 b=uffjN60CYmrG3qg/iI+4BsQghEVnq5oww39VRqqO6wzPcaQWS2vRg0dKXnAVDXb06p
 OWTL2OpMz+dwvhNeXBrBiNTkGV8TQgc3h279bTQ2+qBw1aCCi98CN1CRuGV7UBLpea3h
 v0pDhKAo7V8HPgfHxz1aNsx54HJ44jMEtl0YwNWX71wIjBYMWNmk9YF3zOEg+jKAnkeL
 caLbXoefhC6RWPNq6ZT19bJVq0dWVh91mt1Oa2vLWfUz9M31xJA94dEVnfbq49UXZFEl
 pWllvb/1SLjWTGzG/2Eir0Qdpx7P3OhZ0t8/2gV/cLyDRA73PBM+V4chnD9Sqa74U6OM
 kyqg==
X-Gm-Message-State: APjAAAVUlJDUlWoNT5XyIvDr3/yUJsmp6PC9swTQy7wGjvRUnSa/lehw
 0oP4ate1jY2NlHS/dDxHJU3EuQ==
X-Google-Smtp-Source: APXvYqxtNuoYelDYypkJFNzTsp7ZX1dNuNa6Jb/yXeJk7M9n3OUsDasnsAjkJyQup4EG3CJ/kstGpw==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr8766014wmc.19.1562922593278;
 Fri, 12 Jul 2019 02:09:53 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id w7sm8533747wrn.11.2019.07.12.02.09.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 02:09:52 -0700 (PDT)
Date: Fri, 12 Jul 2019 11:09:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190712090950.d3ngfoyhnutdmkqj@steredhat>
References: <20190712055935.23061-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712055935.23061-1-armbru@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH for-4.1] Makefile: Fix "make install" when
 "make all" needs work
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
Cc: peter.maydell@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 07:59:35AM +0200, Markus Armbruster wrote:
> Until recently, target install used to recurse into target directories
> in its recipe: it ran make install in a for-loop.  Since target
> install depends on target all, this trivially ensured we run the
> sub-make install only after completing target all.
> 
> Commit 1338a4b "Makefile: Reuse all's recursion machinery for clean
> and install" moved the target recursion to dependencies.  That's good
> (the commit message explains why), but I forgot to add dependencies to
> ensure make runs the sub-make install only after completing target
> all.  Do that now.
> 
> Fixes: 1338a4b72659ce08eacb9de0205fe16202a22d9c
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index 1fcbaed62c..09b77e8a7b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -522,6 +522,7 @@ $(ROM_DIRS_RULES):
>  recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
>  recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
>  recurse-install: $(addsuffix /install, $(TARGET_DIRS))
> +$(addsuffix /install, $(TARGET_DIRS)): all
>  
>  $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
>  	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o")

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

