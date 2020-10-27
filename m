Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F439C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F6B21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffDHa7w9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F6B21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLun-0001IG-4g
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXLrF-00054x-Lm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXLrA-0002OY-Qj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603793131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5O5Uacq4GrAwMI+4S72+5ZRtO/m756IkZGfgtVKPhrA=;
 b=ffDHa7w9N0fQ8rXu3zNNP3QaDQx+1QpNNHrLwxKt3m7o7M4HRhU+/E5eBu6vRsFgKD4w7i
 NmU/AwiAD7Ild+SU9QneQwBst+3Lz5XaBL5YW/xJJxislb6vvCKmnCHRg5swg15N5iT+FZ
 C9PfHREfllHyWQzCN4jsq5X87uN/UHE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-EKMZzY6qN9CJsu9Vq8lzew-1; Tue, 27 Oct 2020 06:05:23 -0400
X-MC-Unique: EKMZzY6qN9CJsu9Vq8lzew-1
Received: by mail-ej1-f71.google.com with SMTP id x12so642356eju.22
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 03:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5O5Uacq4GrAwMI+4S72+5ZRtO/m756IkZGfgtVKPhrA=;
 b=iYNS0D3KgHgMMB/TIqDx6v9DNoHS3PyJHB8x5tM0KDb+Dk4CwAGOReYYSuYkk9mtXg
 IWNPH+eP1VZkbNkQNhNtDQ8mW6cHlbKZtB+YJIs8DMW+botY+/lfyIoAJabW7Xov4sdE
 aAyiv7mRA3lzLjcaPHBUBjWZQzBcY18VCO7j33RmWaYLQhr+TG3x6vLAWBOAhfeQThiK
 ze8gKUihhlBDDHVnoyMxhaME2ABfyKxU00KiNOEHEoz9+LMb0AyA7cXjpV52v39AV74P
 PeZIiBlc4RB4JxCeFxSsMOREq7ZO6EGed4u5o8WhIN5/KQT1lg5+3tEtnXV5peVkMwF5
 vgRA==
X-Gm-Message-State: AOAM531NoYFJ/tboyS481J92lISfSscSIYoxcj5RPTeFqOhbUAZn3pIU
 1XishjdzmaZQwHDhQHhK9pyY+R2gcNwHyEm67W/XLALKUrH3gB9D0E9thl1eIdBs0Gx5h448AEr
 /OkOVB0DNTNMO73s=
X-Received: by 2002:a17:906:cc18:: with SMTP id
 ml24mr1519234ejb.298.1603793122394; 
 Tue, 27 Oct 2020 03:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYFjk/N3nBafC8Uwuw5BDEdtnlQDm88QzE7e8siRafqU1tDMCHULe9AwjcbrxMhZtX2IFWdQ==
X-Received: by 2002:a17:906:cc18:: with SMTP id
 ml24mr1519219ejb.298.1603793122187; 
 Tue, 27 Oct 2020 03:05:22 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p17sm656255edw.10.2020.10.27.03.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 03:05:21 -0700 (PDT)
Subject: Re: [PATCH] tests/vm: update openbsd to release 6.8
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
References: <20201027053048.GB64546@humpty.home.comstyle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cbae54c3-fa97-19e6-512c-7ac570f56b12@redhat.com>
Date: Tue, 27 Oct 2020 11:05:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027053048.GB64546@humpty.home.comstyle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 6:30 AM, Brad Smith wrote:
> tests/vm: update openbsd to release 6.8
> 
> A double dash at the end of a package name removes ambiguity
> when the intent is to install a non-FLAVORed package.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I confirm Brad sent us this patch off-list, and
- our review comments are addressed,
- the tags are correct.

The patch format itself seems broken... Like a copy/paste
into an email client...

---

> 
> 
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 8356646f21..5ffa4f1b37 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>      name = "openbsd"
>      arch = "x86_64"
>  
> -    link = "https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.iso"
> -    csum = "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4ab9436ee3"
> +    link = "https://cdn.openbsd.org/pub/OpenBSD/6.8/amd64/install68.iso"
> +    csum = "47e291fcc2d0c1a8ae0b66329f040b33af755b6adbd21739e20bb5ad56f62b6c"
>      size = "20G"
>      pkgs = [
>          # tools
> @@ -36,10 +36,10 @@ class OpenBSDVM(basevm.BaseVM):
>          "bash",
>          "gmake",
>          "gsed",
> -        "gettext",
> +        "gettext-tools",
>  
>          # libs: usb
> -        "libusb1",
> +        "libusb1--",
>  
>          # libs: crypto
>          "gnutls",
> 


