Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799CCC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4181920FC3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGre8rRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4181920FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7rS-0004aX-Ay
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kD7l7-000175-G9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:59:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kD7l5-0002Fl-06
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598972377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0V3tRs+iuXuch8PThdK16Z9VnyaIF9KlY0A+gu55m6U=;
 b=VGre8rRDzDpMFAW9Ab2AYRZKBeITO8VLd3SN/+qRDfiQuWGjOiuFWcY/MFa3QrcpOSnOFv
 FymEqFEQMOb6IqxW7kst83HSgb+0XEI9G2wT3PWOKUeur68wsC3rSi2VJMbuhFsTuXGDZr
 jI8xF8Gcvb0Y7qpO9bP4P2COgx0SVFI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-RqFMXBb1Nkqef3mRrnUmrQ-1; Tue, 01 Sep 2020 10:59:26 -0400
X-MC-Unique: RqFMXBb1Nkqef3mRrnUmrQ-1
Received: by mail-qk1-f199.google.com with SMTP id 205so1113550qkd.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 07:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0V3tRs+iuXuch8PThdK16Z9VnyaIF9KlY0A+gu55m6U=;
 b=Qdbiwb9tM9mAC62LIil5ID3Kk5nyW04wCCDovJOKofsCsmzZSuD+iT19yCyd3alzQV
 IVJOOp//xR8idgMiSSrYfd0h7YoDA3x+Rv+QheIi77gKIng0FwfvWVY1Fg4SHbNd4Sab
 krK2RF8Tb3Jp1I10gV6HcB5uo8GiTEjb8Lz48uQUtgrf7ISuKZn1K5Tl1H8Lu5Om5NyD
 dSKgpZGgo1uUpfnIOUhDGdl4gh/9WoYK+YKRVLA2BFPggLTUZDSO8qrPH6n+7s7hMdZM
 vE7q4vyGCblIEWquHAYUzeCzEFTbfa1P8qmythEiYHvtA+MKakFJPHm5XNPwNQyWlElQ
 0m1g==
X-Gm-Message-State: AOAM533JObbIfL0NqgONYD+KkDh48EL+70n00/o0fI9gQyfd2DNXKB66
 jD9wqALWq2dWecufN3jV92jk3yJDTHLgs3BKcqbzjGCnY2lMfdAmMRQI3LA33oseIWi3b0lcZ5U
 ePfJIDeOXITviGzU=
X-Received: by 2002:aed:3b95:: with SMTP id r21mr2307915qte.368.1598972365872; 
 Tue, 01 Sep 2020 07:59:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7J6CP7BGLRwBBlxVEvvsnSKKOTEv85rbYeTYltyjxu4qyE1Xe5U3bPyfkpdMlEyzk89uNNQ==
X-Received: by 2002:aed:3b95:: with SMTP id r21mr2307887qte.368.1598972365573; 
 Tue, 01 Sep 2020 07:59:25 -0700 (PDT)
Received: from [192.168.0.172] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 e9sm1902348qkb.8.2020.09.01.07.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 07:59:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] Makefile: Add back TAGS/ctags/cscope rules
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
 <159897001005.442705.16516671603870288336.stgit@bahia.lan>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <f31b9650-9db4-e038-9e4d-bd5faf1f5b96@redhat.com>
Date: Tue, 1 Sep 2020 09:59:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159897001005.442705.16516671603870288336.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 9:20 AM, Greg Kurz wrote:
> It is a bit of a pain to be forced to run configure before being able
> to use cscope and friends. Add back the rules to build them in-tree
> as before commit a56650518f5b.
> 
> Fixes: a56650518f5b ("configure: integrate Meson in the build system")
> Signed-off-by: Greg Kurz <groug@kaod.org>

This might be a user error on my part, but the way I read this it sounds 
like I could do this:

	$ rm -rf build
	$ make cscope

and have it emit a cscope file,  but when I do so it complains about the 
build dir not existing. As I understand it, running ./configure (or 
meson build) is what generates that build dir. Here's the error for 
posterity:

changing dir to build for make "cscope"...
make[1]: *** build: No such file or directory.  Stop.
make: *** [GNUmakefile:11: cscope] Error 2

One comment inline

> ---
>   Makefile |   17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 81794d5c34a2..8ffe2872915d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -62,7 +62,7 @@ ninja-distclean::
>   build.ninja: config-host.mak
>   
>   Makefile.ninja: build.ninja ninjatool
> -	./ninjatool -t ninja2make --omit clean dist uninstall < $< > $@
> +	./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags < $< > $@
>   -include Makefile.ninja
>   
>   ${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command += -MP
> @@ -229,6 +229,21 @@ distclean: clean ninja-distclean
>   	rm -f linux-headers/asm
>   	rm -Rf .sdk
>   
> +.PHONY: ctags
> +ctags:
> +	rm -f tags
> +	find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
> +
> +.PHONY: TAGS
> +TAGS:
> +	rm -f TAGS
> +	find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
> +
> +cscope:

Since this recipe doesn't output an artifact called "cscope" I wonder if 
this should be:

.PHONY: cscope
cscope:
	...

or alternatively:

cscope.out:
	...


> +	rm -f "$(SRC_PATH)"/cscope.*
> +	find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
> +	cscope -b -i"$(SRC_PATH)/cscope.files"
> +
>   ifdef INSTALL_BLOBS
>   BLOBS=bios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
>   vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
> 
> 
> 

Connor


