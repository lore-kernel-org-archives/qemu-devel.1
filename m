Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BA0206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmrBBIYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BA0206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWZs-0005E6-SU
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWYs-0003pr-1Q
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:23:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21393
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWYn-0006N6-CP
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589534596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3wtmS8Fjy3NmqO5LIR7a9Ha2sEl/bGv/Gzbvotz5/k=;
 b=MmrBBIYHLXV91DOfYGNq4+VcR+UafIUADYJqwPidCjXBrU1kdZo6G1I2Z/qexO+zrZMPhg
 6fUOeEGq1ch6JeKJU9mjVykgpexgh26oEYmMLJoUmG94SUHpDsJT2ihxVw4hs9xSqHWK+K
 txcTJ3t3kDV+lDdmh97YWDxFqjEDfqg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-OFH1UUdlMGibts7NYHDB2Q-1; Fri, 15 May 2020 05:23:15 -0400
X-MC-Unique: OFH1UUdlMGibts7NYHDB2Q-1
Received: by mail-wr1-f71.google.com with SMTP id z5so870763wrt.17
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J3wtmS8Fjy3NmqO5LIR7a9Ha2sEl/bGv/Gzbvotz5/k=;
 b=rt6Gb565tJBe7RX7UHkIlRan0b/JJXDLzhdgflej/NrX5ye7F5Q/XcGu0LffDvpRTm
 bdrS6KnlfhgZX0ZOpZhsOb885lfS+Z+luvyjRG1VN6JbmpGV0XHwq8lVwHGCLqTjl656
 LhI3TAocSjm7b06LPEbrUL2iNnUws4clkcI0AGKxzNTWn/fIoAjpLam/dgD2xLZSVxrD
 pzji6zr5KYR2jC0+BdAeX2zdUg8Dw63K9mmdFCADPEoUm6jUiY7ZBT068cC0AG9goYtm
 Q54V4bo5WR1PvWjZMn0aAegwS/qeDaK7coGlFpp1DJ26X9tAiqM7u47CnNIq5MtyCeUt
 9rWA==
X-Gm-Message-State: AOAM531YAYE3Id57QsDMVpYf0yEPLAJUJgD2TvQ5w/32rVnrE6rNNzts
 y6mMFzWiMvfgF2bAb4F9F+4zdajLTxeWiAqmYPFbySLyvK+xnDvtSv8SErEfXXqPmRLSGrF6id3
 ggBCUvMcN5fnOvSs=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr2939551wmj.101.1589534593644; 
 Fri, 15 May 2020 02:23:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp0lEzF/HrVljSBbw5K0TftRLZDhvpfRufob5Mu/GAvyxNt5VMlHgIgLrNutVsY91mIlg+OA==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr2939526wmj.101.1589534593420; 
 Fri, 15 May 2020 02:23:13 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g9sm2725560wru.7.2020.05.15.02.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 02:23:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] tests/vm: Remove flex/bison packages
To: qemu-devel@nongnu.org
References: <20200515083124.5536-1-philmd@redhat.com>
 <20200515083124.5536-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0a92421f-7a77-2cf7-3bfb-1bc72e7f7137@redhat.com>
Date: Fri, 15 May 2020 11:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515083124.5536-3-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 10:31 AM, Philippe Mathieu-Daudé wrote:
> QEMU does use flex/bison packages.

"... does not use ..." (Thanks Claudio).

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   tests/vm/fedora      | 1 -
>   tests/vm/freebsd     | 1 -
>   tests/vm/netbsd      | 1 -
>   tests/vm/ubuntu.i386 | 2 +-
>   4 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index bd9c6cf295..a9195670f4 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -32,7 +32,6 @@ class FedoraVM(basevm.BaseVM):
>       pkgs = [
>           # tools
>           'git-core',
> -        'flex', 'bison',
>           'gcc', 'binutils', 'make',
>   
>           # perl
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 298967fe9c..f87db2b126 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -38,7 +38,6 @@ class FreeBSDVM(basevm.BaseVM):
>           "bash",
>           "gmake",
>           "gsed",
> -        "flex", "bison",
>   
>           # libs: crypto
>           "gnutls",
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index b10c9d429d..cdac502dad 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -36,7 +36,6 @@ class NetBSDVM(basevm.BaseVM):
>           "bash",
>           "gmake",
>           "gsed",
> -        "flex", "bison",
>   
>           # libs: crypto
>           "gnutls",
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 1570775335..24527cc78c 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -52,7 +52,7 @@ class UbuntuX86VM(basevm.BaseVM):
>           self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
>           self.ssh_root_check("apt-get update")
>           self.ssh_root_check("apt-get build-dep -y qemu")
> -        self.ssh_root_check("apt-get install -y libfdt-dev flex bison language-pack-en")
> +        self.ssh_root_check("apt-get install -y libfdt-dev language-pack-en")
>           self.ssh_root("poweroff")
>           self.wait()
>           os.rename(img_tmp, img)
> 


