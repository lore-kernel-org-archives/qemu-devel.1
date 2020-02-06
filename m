Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94465C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEE12082E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wkzti1cF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEE12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhrx-0002Zo-JC
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izhr6-0001aV-8Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izhr5-0002bP-14
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:10:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izhr4-0002b5-TT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580998206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2zRb3tXAIQxZO56imHoqEJVdv4R2if4PiUuwaj85so=;
 b=Wkzti1cFxZK3xmlVwmWxx83LFrrdXk2hiKkMsPk0Zmhv8BxFLWzNATWDmP+Ib+bEggcaQS
 vW0Bupq/d8FdSpMJGixnEwbI3p0HsCBFxLXIFUXDEqH0xbl98vyi3bOxsDPBGIzsCT4z9b
 BiV52TSyvBh/7yDgysG2IARC8N1UidI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-BGYQjmiRNDuhURV64AN22g-1; Thu, 06 Feb 2020 09:09:50 -0500
Received: by mail-wr1-f69.google.com with SMTP id d15so3445226wru.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 06:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RVzXs0vT/JWzWXwAbk+DNlObU6yI2YJ/O7l9F2JD3f0=;
 b=DdlqJt+UosJI+7HsUprYznp803aBU2O2cNkvo8UZce6Osr6n3BqXXr1n8uLo+avUwa
 kA2vAxmQlCJ4JOSqu+I47YpJslkkB3v4XwhLTOy9WHjTEWFj6BktbiMfUCu9qmO1vC/r
 A9CdMZLb/kGNa3ZJQoxZF/X2ZVWWomvZDV2s6ipJsyRsgvmbCTqn4DjwyttvQd414QEn
 LTLFcIIlsfe1z/e42udk0KSpcpYitPcbcV7idm2Xr5vzbydqTi6+YihOn9ntVEKTbCmT
 Mw6T8Lt1GbApGc36vMkN9ApN7XpcYF7kSx/W0ObB5H6129OuNKwf3H40g0dKjuTcEykL
 PxgQ==
X-Gm-Message-State: APjAAAWmqO6vPw3Bm0EPgt7CpPpPKGaVABE6vaRNnabn+SGoAuRLoVku
 8ww28KZPHu0/D3Mm6kdDk2j/0VKOGZh9TF6CSamYl0ufQdRrlPwnvzZ0u9iKVfftZwHUozTKbTJ
 Rq5EHi1SnqzmvYTg=
X-Received: by 2002:adf:f80c:: with SMTP id s12mr4005377wrp.1.1580998188917;
 Thu, 06 Feb 2020 06:09:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1ZRoPUnkwXLkWOeG75Cbpqf3fBLCI8VIUW8b00E6HD3TSzdPjWV/ndEMRaEYkZGSQdgJFAw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr4005348wrp.1.1580998188598;
 Thu, 06 Feb 2020 06:09:48 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t1sm3949075wma.43.2020.02.06.06.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 06:09:48 -0800 (PST)
Subject: Re: [PATCH v2 1/6] tests/boot_linux_console: add microvm acceptance
 test
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-2-git-send-email-liam.merwick@oracle.com>
 <6ceb7e42-125a-ac91-fad6-e67c332c48b4@redhat.com>
Message-ID: <03a996af-49eb-8c91-eabd-4b9a29270f63@redhat.com>
Date: Thu, 6 Feb 2020 15:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6ceb7e42-125a-ac91-fad6-e67c332c48b4@redhat.com>
Content-Language: en-US
X-MC-Unique: BGYQjmiRNDuhURV64AN22g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Liam,

On 2/6/20 2:57 PM, Philippe Mathieu-Daud=E9 wrote:
> On 2/5/20 3:56 PM, Liam Merwick wrote:
>> Refactor test_x86_64_pc() to test_x86_64_machine() so that separate
>> functions which specify the Avocado tag of ':avocado: tags=3Dmachine:'
>> as being either 'pc' or 'microvm' can be used to test booting a
>> compressed kernel using either machine class.
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> =A0 tests/acceptance/boot_linux_console.py | 20 +++++++++++++++++---
>> =A0 1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py=20
>> b/tests/acceptance/boot_linux_console.py
>> index e40b84651b0b..233601b429bd 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -51,10 +51,10 @@ class BootLinuxConsole(Test):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 os.chdir(cwd)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return self.workdir + path
>> -=A0=A0=A0 def test_x86_64_pc(self):
>> +=A0=A0=A0 def do_test_x86_64_machine(self):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> -=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>> -=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>> +=A0=A0=A0=A0=A0=A0=A0 Common routine to boot an x86_64 guest.
>> +=A0=A0=A0=A0=A0=A0=A0 Caller must specify tags=3Darch and tags=3Dmachin=
e
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>                        =20
>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>> @@ -70,6 +70,20 @@ class BootLinuxConsole(Test):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 console_pattern =3D 'Kernel command line: %s=
' %=20
>> kernel_command_line
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.wait_for_console_pattern(console_patter=
n)
>> +=A0=A0=A0 def test_x86_64_pc(self):
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>> +
>> +=A0=A0=A0 def test_x86_64_microvm(self):
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:microvm
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>> +
>> =A0=A0=A0=A0=A0 def test_mips_malta(self):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:mips
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Actually this breaks testing the distrib QEMU:

  (1/2)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:=20
PASS (2.58 s)
  (2/2)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_microvm=
:
Output: 'qemu-system-x86_64: -machine microvm: unsupported machine=20
type\nUse -machine help to list supported machines\n'
ERROR: timed out (15.10 s)

Do you mind testing the series testing a machine is available?
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675086.html


