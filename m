Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903562083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xe8CIV7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903562083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJc0-0002Ot-PX
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixJb4-0001Ih-TC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixJb3-00006w-L8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:51:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixJb3-00006O-Hl
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580428301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yCtMZcyX9Djv30AsmdBHLUXdoYgOcgW/+zWzxA0Zts=;
 b=Xe8CIV7DV+6eKMiZwbZsdYq2ddUtaZrz7D0nEEXW7D0Bkrwp25gm3PpETwASqr6DRm2TfX
 dZ3QFc6eaknZFyiizfXocuX69zxZbbsTZv7Z5xxdlGTeWYcmbcz9rKkdwvs06vbV2Dg3Fu
 f7Z6Dr3SYzAzNh04Wp/tkEsZ4HY4E/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327--4DJYbPAPSSgqllPKS24Jw-1; Thu, 30 Jan 2020 18:51:35 -0500
Received: by mail-wr1-f69.google.com with SMTP id 50so1569827wrc.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ged53cFAht+PtfTblqzo8LwvBg2MQiuAS2/Zloms4ek=;
 b=M8exen+XiZwhd/2xYs4bNixMzbFbevDzLrlX1aV4HjR29ng2Wy858FeXvK+UjdMrjb
 8H9bawWePPnZHopwJpzl39sIsvHjSrR9BfHb3fLGsdZHwrjXnw2TsPvaceoC2kufcDYY
 T03p7fsRf1h6bXJoWhoU26HGEcigHAIavxqfOmDb33nH4Omt4FPpnM0gVPIuXgdP8YMs
 oWeSYslYTe9g2l/XKuwRv2Sb5BX0Kj4p6QSTSvCGfaO/+42C3igFHwoMskTjeaylyFGp
 cVarUjJwBBbcPWdBmC0/Mr6Z+IG+MIsf0bl76mK3c1/oVb6x+nW2LRS/2F1XFpa0D64l
 mukw==
X-Gm-Message-State: APjAAAWZ3a5f0okHaGJAL5hpVYlzbUV1KLM6wRYM3eUwlh7OLZ6tah/O
 E5h7oi4JaQWFiwq5A22C28WDPhhl7o4977ssGypXMVmLRL1a81ZrrS/zppxGfumHlvP1m4suB+m
 HP2wO5xOcEW0YQHM=
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr8576372wmb.114.1580428294084; 
 Thu, 30 Jan 2020 15:51:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbryRKNbG6FemM4l6gxbEi3RfIx9HUT+7e4VFUlvyYKUeOL4eDdvzugDCZ1pSAqB18TK+O7g==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr8576351wmb.114.1580428293799; 
 Thu, 30 Jan 2020 15:51:33 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id k16sm9999660wru.0.2020.01.30.15.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 15:51:33 -0800 (PST)
Subject: Re: [PATCH 1/6] tests/boot_linux_console: add microvm acceptance test
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-2-git-send-email-liam.merwick@oracle.com>
 <a968cbba-911c-ac0b-6b7e-d50e83e877e3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <acf418d0-a002-4ae0-06cc-c26bf495f3f8@redhat.com>
Date: Fri, 31 Jan 2020 00:51:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a968cbba-911c-ac0b-6b7e-d50e83e877e3@redhat.com>
Content-Language: en-US
X-MC-Unique: -4DJYbPAPSSgqllPKS24Jw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 6:41 PM, Wainer dos Santos Moschetta wrote:
> On 1/27/20 2:36 PM, Liam Merwick wrote:
>> Refactor test_x86_64_pc() to test_x86_64_machine() so that separate
>> functions which specify the Avocado tag of ':avocado: tags=3Dmachine:'
>> as being either 'pc' or 'microvm' can be used to test booting a
>> compressed kernel using either machine class.
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> ---
>> =A0 tests/acceptance/boot_linux_console.py | 15 +++++++++++++--
>> =A0 1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py=20
>> b/tests/acceptance/boot_linux_console.py
>> index e40b84651b0b..aa5b07b1c609 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -51,10 +51,9 @@ class BootLinuxConsole(Test):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 os.chdir(cwd)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return self.workdir + path
>> -=A0=A0=A0 def test_x86_64_pc(self):
>> +=A0=A0=A0 def do_test_x86_64_machine(self):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>> -=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>                        =20
>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>> @@ -70,6 +69,18 @@ class BootLinuxConsole(Test):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 console_pattern =3D 'Kernel command line: %s=
' %=20
>> kernel_command_line
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.wait_for_console_pattern(console_patter=
n)
>> +=A0=A0=A0 def test_x86_64_pc(self):
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>> +=A0=A0=A0=A0=A0=A0=A0 """
>=20
> The test method won't inherit the 'arch' tag from=20
> `do_test_x86_64_machine()`, so you need to explicitly 'arch' tag each=20
> test you created in this series. If you don't do so, Avocado won't=20
> filter out those x86_64 tests in case QEMU is built with non-x86_64=20
> targets.
>=20
> Follows an example, I built QEMU with '--target-list=3Darm-softmmu'. I go=
t:
>=20
> ```
>=20
> (02/18)=20
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:=
=20
> CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
>  =A0(03/18)=20
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_micro=
vm:=20
> CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
>  =A0(04/18)=20
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt:=20
> PASS (1.25 s)
>=20
> ```
>=20
> OK, avocado_qemu was smart enough to skip the tests, but ideally it=20
> should not even consider running them in the first place.

This should be solved by this patch:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07311.html
"tests/acceptance: Use 'machine' tag to check if available in QEMU binary"

>=20
> Thanks!
>=20
> - Wainer
>=20
>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>> +
>> +=A0=A0=A0 def test_x86_64_microvm(self):
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:microvm
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>> +
>> =A0=A0=A0=A0=A0 def test_mips_malta(self):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:mips
>=20


