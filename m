Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB61C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39242207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4E7Tb91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39242207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jic8J-0003Sz-EP
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jic7K-0002AT-6S
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:08:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jic7I-0001Gy-SN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:08:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id l11so20826111wru.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=g6Qq75Y4R9AmAiXFiyNALmpoQBF/WOdCpoY6VVwRMUk=;
 b=G4E7Tb91aC29gHoJ9zbOe+LXKrGfIxfL8YEAibHOCHOeIC3O0+UuJXFOeCX6CvDMjS
 7w/b0hCWC7wYUPjj922+xVX5/5vTX+lveuMCTf5Ym3FuFnTF91x2pr3ZJij0ybn8EKV/
 EUqli/vsjyutJeF7VN17LFQAOWVObpczCqYwQ6jbf1TAm9Ga/s7GhOBvTAHZtj+GI7em
 eT63vlBjJIz2ht5X43Bfn48HYSS2pWmPDcK1rBrf+f6WNCzNsykjbMrCZ+FHpuwcF/Gx
 itq0fjnWbkKB4BkyfQSkXCn8U30OR/Tx1IluLAGlOM4nx9sqA0VXHlRQ++3aUjxVhPbC
 F3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=g6Qq75Y4R9AmAiXFiyNALmpoQBF/WOdCpoY6VVwRMUk=;
 b=FfPkvJvfgjS+AH/Kdwa6kLaRDocnUtlpilXdZiILoPrBP785hrR9QFaisC4pg2h4Ws
 wi4Dns0nzGp0a4RIxUTydTzPOn/w5yDQVdyjIdfSw/ImQWvqOPhfr6Zhfev8bUyDpFR3
 HYdV/Oetqu2pDL3+LL797jqDX4hm4zboZ3lZry3zIyrLRCgDTemFZ/351jkwwWjz2sUi
 +zcmj3OsO+18e52JMqyezYCUezxGCjC8ff4e9sXODtpk5P1D7l+Fcormi6VP+zYbMMSR
 SodLQosqiJDprEMDxcRAmrKMGG3iOszkoGDbMw7bzASZYwfXqWnsyq7J5g2974sBmpZl
 cRcA==
X-Gm-Message-State: AOAM5327HGZHO5/iqU9l0eGh28PIbju9nNUIH5Tm+x/6qzGKrYE+oH7q
 KAzwOv3TJDsZXdrt0IAK77rrYQ==
X-Google-Smtp-Source: ABdhPJy61g0tYYBsKqjAi28HP8CgXFskcyI2H6fGsDKwrS5AHJt7cQFGZorM6yhfuULn/2GCICVgLA==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr3905958wrm.168.1591700907041; 
 Tue, 09 Jun 2020 04:08:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm2985887wru.33.2020.06.09.04.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 04:08:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 145361FF7E;
 Tue,  9 Jun 2020 12:08:25 +0100 (BST)
References: <20200609103809.23443-1-alex.bennee@linaro.org>
 <20200609103809.23443-16-alex.bennee@linaro.org>
 <4f27f12b-b2eb-9a63-c561-959059f1bb15@suse.de>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PULL 15/17] tests/vm: Remove flex/bison packages
In-reply-to: <4f27f12b-b2eb-9a63-c561-959059f1bb15@suse.de>
Date: Tue, 09 Jun 2020 12:08:25 +0100
Message-ID: <871rmo5weu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 Philippe =?utf-8?Q?Ma?= =?utf-8?Q?thieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> This series incidentally removes the build warnings when not having flex/=
bison,
>
> could someone queue it?
>
> Thanks,
>
> Claudio
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg01851.html

If it is all reviewed I can pick it up in the next testing/next bits if
no one else cares.

>
>
> On 6/9/20 12:38 PM, Alex Benn=C3=A9e wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>=20
>> QEMU does not use flex/bison packages.
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Reviewed-by: Claudio Fontana <cfontana@suse.de>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20200515163029.12917-3-philmd@redhat.com>
>>=20
>> diff --git a/tests/vm/fedora b/tests/vm/fedora
>> index bd9c6cf295c..a9195670f4b 100755
>> --- a/tests/vm/fedora
>> +++ b/tests/vm/fedora
>> @@ -32,7 +32,6 @@ class FedoraVM(basevm.BaseVM):
>>      pkgs =3D [
>>          # tools
>>          'git-core',
>> -        'flex', 'bison',
>>          'gcc', 'binutils', 'make',
>>=20=20
>>          # perl
>> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
>> index 298967fe9cf..f87db2b126e 100755
>> --- a/tests/vm/freebsd
>> +++ b/tests/vm/freebsd
>> @@ -38,7 +38,6 @@ class FreeBSDVM(basevm.BaseVM):
>>          "bash",
>>          "gmake",
>>          "gsed",
>> -        "flex", "bison",
>>=20=20
>>          # libs: crypto
>>          "gnutls",
>> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
>> index b10c9d429de..cdac502dad8 100755
>> --- a/tests/vm/netbsd
>> +++ b/tests/vm/netbsd
>> @@ -36,7 +36,6 @@ class NetBSDVM(basevm.BaseVM):
>>          "bash",
>>          "gmake",
>>          "gsed",
>> -        "flex", "bison",
>>=20=20
>>          # libs: crypto
>>          "gnutls",
>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>> index 0b705f49452..13e7f9a6d56 100755
>> --- a/tests/vm/openbsd
>> +++ b/tests/vm/openbsd
>> @@ -35,7 +35,6 @@ class OpenBSDVM(basevm.BaseVM):
>>          "bash",
>>          "gmake",
>>          "gsed",
>> -        "bison",
>>=20=20
>>          # libs: usb
>>          "libusb1",
>> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
>> index 15707753353..24527cc78c7 100755
>> --- a/tests/vm/ubuntu.i386
>> +++ b/tests/vm/ubuntu.i386
>> @@ -52,7 +52,7 @@ class UbuntuX86VM(basevm.BaseVM):
>>          self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/s=
ources.list")
>>          self.ssh_root_check("apt-get update")
>>          self.ssh_root_check("apt-get build-dep -y qemu")
>> -        self.ssh_root_check("apt-get install -y libfdt-dev flex bison l=
anguage-pack-en")
>> +        self.ssh_root_check("apt-get install -y libfdt-dev language-pac=
k-en")
>>          self.ssh_root("poweroff")
>>          self.wait()
>>          os.rename(img_tmp, img)
>>=20


--=20
Alex Benn=C3=A9e

