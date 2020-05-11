Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3FEC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9875320722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJKX2Z8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9875320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7pZ-0001Pb-PK
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY7cE-0001ON-Em
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:33:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22450
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY7cC-00077R-D9
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589200379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNNV0qs1SjdJBOj8gSVVeLYEgNbzc5QlNqFsgOVbvTg=;
 b=DJKX2Z8ZipyDp9bycE6eqOUv3DgqZV1KL7hfUrspnEaKH59QSaGzqh+WhfB3xbeModaAFQ
 a2mZ1svGl5eaIfZFGltHIqZ0Ucnl8pEEqdupNdUDpt5HwEq3VSjakzyCFRgGvinOq5sxMy
 nTQKFL7YPswUyjRH9fQr0zBbU8RdPyg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-XWdKqipbMlCBt1paysVQBg-1; Mon, 11 May 2020 08:32:56 -0400
X-MC-Unique: XWdKqipbMlCBt1paysVQBg-1
Received: by mail-wr1-f71.google.com with SMTP id p13so411647wrw.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 05:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PNNV0qs1SjdJBOj8gSVVeLYEgNbzc5QlNqFsgOVbvTg=;
 b=rBgWyXdwxMx5ezRknih9liq9EiMywBFslFTBH6I+5FHow8LjCVjCtofETMDxDrn9J0
 JwKsqoolybovXyeg83fCbu4vBwDcv5o4EAXGD0zfoyRY52ljcLE9oH4IBAOVf/F0aaNk
 nkUda7jW3GmjzB3hrvBzwHNknZbFyJ5d+Cyg5qIXR+65PpT0eXB5NpEA0r9CznuzsBtT
 s2IIoNo1/tElL5JqsGwsm9hquGLx3AYiUJN81sD23Vqjyruhtzb90mgfbwwaFfAuQcKr
 gcD+WIDXjOrzdI09e3wpIrEmaZ5krXaPb8NEMOMFMiof//Xr8fMdWNXDhc4VQggJUszL
 j3Sg==
X-Gm-Message-State: AGi0PuY134WLOx8M0iG7KJvWMlLgU0R5fOri5MMZkmtfbNUa+NbncMM9
 U4pvaTCYAz1Hoyaj4wl4Wy6wAGQoZQvQTN1h7EYhrcbcwqKmPYTMfR/rV+S8KMO9t4Ydh1it/G4
 EhpBAm0huIowDIvs=
X-Received: by 2002:a1c:25c4:: with SMTP id l187mr28219496wml.89.1589200375101; 
 Mon, 11 May 2020 05:32:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ3Nkr9fL8w21ZbLvGSWjCMXRRGd+OZoRZFv5kk5yEn0/CWHQ7FILrAEVNi8y/PhLgRC+gGGg==
X-Received: by 2002:a1c:25c4:: with SMTP id l187mr28219477wml.89.1589200374907; 
 Mon, 11 May 2020 05:32:54 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q184sm26881509wma.25.2020.05.11.05.32.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 05:32:53 -0700 (PDT)
Subject: Re: [PATCH] ui: update keycodemapdb submodule commit
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200505125713.940953-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e98883d2-7afc-442e-b01e-fb8278f80cb6@redhat.com>
Date: Mon, 11 May 2020 14:32:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505125713.940953-1-berrange@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Volker

On 5/5/20 2:57 PM, Daniel P. Berrangé wrote:
> Primarily this is to pull in a fix for Win32 keycodes. The other useful
> change is the removal of build timestamp from generated files which is
> desirable for reproducable builds.
> 
> The make rules need updating due to slightly changed CLI syntax - more
> args must now come after the command name.
> 
> 27acf0ef828bf719b2053ba398b195829413dbdd Fix win32 keycode for VK_OEM_102
> 317d3eeb963a515e15a63fa356d8ebcda7041a51 Add support for generating RST formatted docs pages
> 7381b9bfadd31c4c9e9a10b5bb5032f9189d4352 Introduce separate args for title & subtitle with docs generator
> 6280c94f306df6a20bbc100ba15a5a81af0366e6 keymap-gen: Name sections in pod output
> df4e56f8fab65ba714ec18f4e7338a966a1620ad Add an empty meson project
> 16e5b0787687d8904dad2c026107409eb9bfcb95 remove buildtime from generated files
> 044f21dd0d4f62519aae9f1d53a026407a0b664f add header file generators
> 7779876a6b06755e3bb2c94ee3ded50635bcb0fa c++: add extern declaration to the generated file
> 0e0a317889464397d6f1ae03aad0d2ca593aab04 move CLanguageGenerator closer to CLanguageGenerator itself
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   Makefile        | 4 ++--
>   ui/keycodemapdb | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 34275f57c9..5f2b63b1cd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -310,10 +310,10 @@ ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile
>   	$(call quiet-command,\
>   	    stem=$* && src=$${stem%-to-*} dst=$${stem#*-to-} && \
>   	    test -e $(KEYCODEMAP_GEN) && \
> -	    $(PYTHON) $(KEYCODEMAP_GEN) \
> +	    $(PYTHON) $(KEYCODEMAP_GEN) code-map \
>   	          --lang glib2 \
>   	          --varname qemu_input_map_$${src}_to_$${dst} \
> -	          code-map $(KEYCODEMAP_CSV) $${src} $${dst} \
> +	          $(KEYCODEMAP_CSV) $${src} $${dst} \
>   	        > $@ || rm -f $@, "GEN", "$@")
>   
>   $(KEYCODEMAP_GEN): .git-submodule-status
> diff --git a/ui/keycodemapdb b/ui/keycodemapdb
> index 6b3d716e2b..27acf0ef82 160000
> --- a/ui/keycodemapdb
> +++ b/ui/keycodemapdb
> @@ -1 +1 @@
> -Subproject commit 6b3d716e2b6472eb7189d3220552280ef3d832ce
> +Subproject commit 27acf0ef828bf719b2053ba398b195829413dbdd
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


