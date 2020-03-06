Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE8C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D844A20726
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NG00zCTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D844A20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAE5W-00065d-3m
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAE20-0003Yb-8h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAE1z-0001Am-33
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:32:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAE1y-00018h-UU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583505170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MciQNyN4puP4uISdMKPF4/ZwtOTkJo5eWMkzV5CviTI=;
 b=NG00zCTEUhTSGsIzVJTVSgontxnlGgUYu6YBMgqeX6OL2g3uN0D6VD0X3YdYL3m41lcFPn
 JLfVTk1SpSkv1iGV0C6Fy9UWwrYgCYb/5EWIUi1bUpoF5Vn9t3d/WP4FdxUYR4q/02ThlC
 10VPdp/B8UgtQGbEwS1ZEvb4yJnhdJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-zJqfLIDaMzii0fTZfTypAA-1; Fri, 06 Mar 2020 09:32:48 -0500
X-MC-Unique: zJqfLIDaMzii0fTZfTypAA-1
Received: by mail-wm1-f72.google.com with SMTP id w12so710042wmc.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 06:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MciQNyN4puP4uISdMKPF4/ZwtOTkJo5eWMkzV5CviTI=;
 b=juq/+CEdOxUbclUt4iEym2rjyBWu/7ljnL/rYz7H2/V6JHCPtOgKTg+TZZKhf0NR95
 ESPnwEOwi4MV2OvGQgtizXO1F2A/XpJfIG47OzdqzsBhXZjVEZAKqRmWkkHFSqNjpzCV
 GqgazFy0+BZKrBgCEn7/45KLD8W3cQpxIBOjZcIat+9G6WkQhiQCc+mmQEZQU44IZa8y
 pisgb5IbnTtW6Ts1F6peZ27Zv+zjISDZRm9MILsYsm21zXoMJt/ZsI+mZNlVSgyrs4RR
 Hn9YB6yapMi5oDTf5V4RIp1Pe7B0dqTnlhnuySJC4KhB8NxW07i2YQEK99YMWcKPzcDJ
 lJhg==
X-Gm-Message-State: ANhLgQ2rHCPMzQSk+QLW0EojPwYWAQtjBryW4ZAENqm+zNhA9DG1ID5F
 AgAsncix6l3KYPTi1YavlN3oSZYnuUW11iEjv7k8L0pKsYehYNPPwfnrUKPbPZQIv9nOn+BItBx
 RQZ1ls9zT93QRkY0=
X-Received: by 2002:adf:b189:: with SMTP id q9mr4295894wra.169.1583505167221; 
 Fri, 06 Mar 2020 06:32:47 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvfC4XI/C4hPNymJ0ig58Mr3Wb8DB75OkzZxsZkwjJImZwkz1giFz7SXVJx5+5OS0io3ejxSQ==
X-Received: by 2002:adf:b189:: with SMTP id q9mr4295867wra.169.1583505166976; 
 Fri, 06 Mar 2020 06:32:46 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j14sm49494974wrn.32.2020.03.06.06.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 06:32:46 -0800 (PST)
Subject: Re: [PATCH] qemu.nsi: Install Sphinx documentation
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200306134751.2572-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <70e18816-1d16-93a1-5e49-2f54132602fb@redhat.com>
Date: Fri, 6 Mar 2020 15:32:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306134751.2572-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/20 2:47 PM, Peter Maydell wrote:
> The old qemu-doc.html is no longer built, so update the Windows
> installer to install the new Sphinx manual sets.
> 
> We install all five of the manuals, even though some of them
> (notably the user-mode manual) will not be very useful to Windows
> users, because skipping some of them would mean broken links
> in the top level 'index.html' page.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've tested this (building it via the fedora docker image
> and installing into a Windows VM) but I don't know anything
> much about the installer so there might be neater ways to do it...
> 
> NB: I didn't realize that patchew included a test of building
> the Windows installer, so until we get this (or some variant)
> into master I'm afraid patchew will be emailing failure reports
> to every submitted patchseries. Sorry about that :-(
> ---
>   qemu.nsi | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu.nsi b/qemu.nsi
> index 0c29ba359cd..1a0112265b0 100644
> --- a/qemu.nsi
> +++ b/qemu.nsi
> @@ -177,9 +177,20 @@ SectionEnd
>   !ifdef CONFIG_DOCUMENTATION
>   Section "Documentation" SectionDoc
>       SetOutPath "$INSTDIR"

Now that we have multiple files installed, I'd move them into a separate 
directory: ${INSTDIR}/docs/ seems appropriate. Can be done later.

> -    File "${BINDIR}\qemu-doc.html"
> +    File "${BINDIR}\index.html"
> +    SetOutPath "$INSTDIR\interop"
> +    FILE /r "${BINDIR}\interop\*.*"
> +    SetOutPath "$INSTDIR\specs"
> +    FILE /r "${BINDIR}\specs\*.*"
> +    SetOutPath "$INSTDIR\system"
> +    FILE /r "${BINDIR}\system\*.*"
> +    SetOutPath "$INSTDIR\tools"
> +    FILE /r "${BINDIR}\tools\*.*"
> +    SetOutPath "$INSTDIR\user"
> +    FILE /r "${BINDIR}\user\*.*"
> +    SetOutPath "$INSTDIR"

The last SetOutPath seems alone (copy/paste mistake I suppose).
Otherwise looks good.

>       CreateDirectory "$SMPROGRAMS\${PRODUCT}"
> -    CreateShortCut "$SMPROGRAMS\${PRODUCT}\User Documentation.lnk" "$INSTDIR\qemu-doc.html" "" "$INSTDIR\qemu-doc.html" 0
> +    CreateShortCut "$SMPROGRAMS\${PRODUCT}\User Documentation.lnk" "$INSTDIR\index.html" "" "$INSTDIR\index.html" 0
>   SectionEnd
>   !endif
>   
> @@ -227,7 +238,12 @@ Section "Uninstall"
>       Delete "$INSTDIR\qemu-io.exe"
>       Delete "$INSTDIR\qemu.exe"
>       Delete "$INSTDIR\qemu-system-*.exe"
> -    Delete "$INSTDIR\qemu-doc.html"
> +    Delete "$INSTDIR\index.html"
> +    RMDir /r "$INSTDIR\interop"
> +    RMDir /r "$INSTDIR\specs"
> +    RMDir /r "$INSTDIR\system"
> +    RMDir /r "$INSTDIR\tools"
> +    RMDir /r "$INSTDIR\user"
>       RMDir /r "$INSTDIR\keymaps"
>       RMDir /r "$INSTDIR\share"
>       ; Remove generated files
> 


