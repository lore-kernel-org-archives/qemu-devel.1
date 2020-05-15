Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB133C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FBA20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngj/4w+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FBA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZX5D-0002eT-NH
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZX4W-0001aN-9M
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:56:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZX4V-00051B-DU
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589536562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9rn0PXjrspVtB04ysXivePO9/6Tp4kEBLyzbUaHzLw=;
 b=Ngj/4w+yizxcqzVBpTsg6tnHERCgnjipFeJgB7aFx8U/aCfL67z7bop9wRCBnX8V+V+Hjf
 KFXAV9FtdRY8Nf6gDnHneLCpHd1WxAQG3Ib1+xQqY1q52g/NU+sO37WX/tii0sEJgyX4tP
 R6qUxRmO3nzIstSHF71ukI4QbUINKTc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-V2sC5OC9MWiX9ZEpQ2-sbA-1; Fri, 15 May 2020 05:56:00 -0400
X-MC-Unique: V2sC5OC9MWiX9ZEpQ2-sbA-1
Received: by mail-wm1-f69.google.com with SMTP id o8so214068wmd.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+9rn0PXjrspVtB04ysXivePO9/6Tp4kEBLyzbUaHzLw=;
 b=NqcZwKuq1YiwpDtJEezF/gE1M8OV5i7+aREyGigRtcok9jhdrCtCbtjKPY6JFr7Ocp
 lVNMYOaJLfP1hMG7hgTYAwBkJXIfIp0QvXJlv4L5SGlAxNZfxaFLFbFwFdG9M02ZU8Vd
 lLkPAGgHfAfb5mEWnYxtrVypUPGWMfA30Ktg6dEroo4cLGmyBzKsOqHu9wIfktUmlFan
 ISC8oLYlf7IrXXrO84ERn/s6SKjeo703N1AF59tWbSnU7ZnB0Vy03lr2uumfNITMdqzk
 nosVEZtFD2qVU8scsTOIsvBvuKLTbqiTbfhhtz4iWWa4BImrZtvgRCv2G929oyLjz0eA
 K4bA==
X-Gm-Message-State: AOAM530+kl2HJRV4EReDlmFg0KILaeAIAYn38veHxXdRgRqHk8DRwK1N
 Z7OtVAbP1Hb1i/pLu+tBvpkDazpwQUOA1Gkzwa9N0IzCEDFEInv7UltMjkxtffb8+gl4y5POZNk
 0vMyS8ytXd/hAelc=
X-Received: by 2002:adf:de12:: with SMTP id b18mr3414194wrm.275.1589536558922; 
 Fri, 15 May 2020 02:55:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmqQGiCTvtKv6XgF8+tAdK5cOGjapX/aaVzH9ruuX9bzI5G2PlNeoBm06860BCGLg0fv1wfw==
X-Received: by 2002:adf:de12:: with SMTP id b18mr3414171wrm.275.1589536558704; 
 Fri, 15 May 2020 02:55:58 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r11sm2966383wma.35.2020.05.15.02.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 02:55:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] tests/vm: Remove flex/bison packages
To: Claudio Fontana <cfontana@suse.de>
References: <20200515083124.5536-1-philmd@redhat.com>
 <20200515083124.5536-3-philmd@redhat.com>
 <37196f3d-1251-6b6b-2bc8-741c8ec999ba@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57076692-b79d-bc10-d2e1-0b33b9993496@redhat.com>
Date: Fri, 15 May 2020 11:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <37196f3d-1251-6b6b-2bc8-741c8ec999ba@suse.de>
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 11:41 AM, Claudio Fontana wrote:
> On 5/15/20 10:31 AM, Philippe Mathieu-Daudé wrote:
>> QEMU does use flex/bison packages.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   tests/vm/fedora      | 1 -
>>   tests/vm/freebsd     | 1 -
>>   tests/vm/netbsd      | 1 -
>>   tests/vm/ubuntu.i386 | 2 +-
>>   4 files changed, 1 insertion(+), 4 deletions(-)
> 
> 
> Hi, does openbsd need a correction as well? Or is it needed there?

You are right. I only grepped for flex, not for bison (expecting they 
are installed altogether).

So I also missed:

- .gitlab-ci.yml
- .cirrus.yml
- tests/vm/openbsd
- scripts/coverity-scan/coverity-scan.docker

> 
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 0b705f4945..13e7f9a6d5 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -35,7 +35,6 @@ class OpenBSDVM(basevm.BaseVM):
>           "bash",
>           "gmake",
>           "gsed",
> -        "bison",
>   
>           # libs: usb
>           "libusb1",
> 
> Ciao,
> 
> Claudio
> 
> 
>>
>> diff --git a/tests/vm/fedora b/tests/vm/fedora
>> index bd9c6cf295..a9195670f4 100755
>> --- a/tests/vm/fedora
>> +++ b/tests/vm/fedora
>> @@ -32,7 +32,6 @@ class FedoraVM(basevm.BaseVM):
>>       pkgs = [
>>           # tools
>>           'git-core',
>> -        'flex', 'bison',
>>           'gcc', 'binutils', 'make',
>>   
>>           # perl
>> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
>> index 298967fe9c..f87db2b126 100755
>> --- a/tests/vm/freebsd
>> +++ b/tests/vm/freebsd
>> @@ -38,7 +38,6 @@ class FreeBSDVM(basevm.BaseVM):
>>           "bash",
>>           "gmake",
>>           "gsed",
>> -        "flex", "bison",
>>   
>>           # libs: crypto
>>           "gnutls",
>> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
>> index b10c9d429d..cdac502dad 100755
>> --- a/tests/vm/netbsd
>> +++ b/tests/vm/netbsd
>> @@ -36,7 +36,6 @@ class NetBSDVM(basevm.BaseVM):
>>           "bash",
>>           "gmake",
>>           "gsed",
>> -        "flex", "bison",
>>   
>>           # libs: crypto
>>           "gnutls",
>> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
>> index 1570775335..24527cc78c 100755
>> --- a/tests/vm/ubuntu.i386
>> +++ b/tests/vm/ubuntu.i386
>> @@ -52,7 +52,7 @@ class UbuntuX86VM(basevm.BaseVM):
>>           self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
>>           self.ssh_root_check("apt-get update")
>>           self.ssh_root_check("apt-get build-dep -y qemu")
>> -        self.ssh_root_check("apt-get install -y libfdt-dev flex bison language-pack-en")
>> +        self.ssh_root_check("apt-get install -y libfdt-dev language-pack-en")
>>           self.ssh_root("poweroff")
>>           self.wait()
>>           os.rename(img_tmp, img)
>>
> 


