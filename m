Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF23C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9532C2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxrI2n5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9532C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz5j1-00023S-R4
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 16:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iz5i1-0001WS-Hd
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iz5hy-00062x-Jv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:26:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iz5hy-0005yc-DB
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580851565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ugf0hOAug47Ysq+4N/ZhBMMeO5GcATezY+KP9ir+g9A=;
 b=OxrI2n5MGq449CBj6QdAbgm+iFtY8rR2Pv++BJOoX9MaA1Blx8xK4WUDJGLUB9Nze5r7o/
 WJWQ/vQffwi1MFnjljMYCL7jRG/FQsIxIvxTr9qSty9sWwjmLA4BQjNbP+FNEjjjFj4BqV
 82YuV5g4xiWeRdAyRzZWUSICmtSqyms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-QnB8me10Neuxnaq54fn4Vg-1; Tue, 04 Feb 2020 16:25:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B75C4107B7D5;
 Tue,  4 Feb 2020 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3F3C857A8;
 Tue,  4 Feb 2020 21:25:50 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] tests/acceptance: boot_linux_console: Add boot
 Linux with kvm tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, crosa@redhat.com
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-3-wainersm@redhat.com>
 <75a9cd31-a978-0b31-1d6d-1b34800e13a6@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <10433721-2784-b88a-2ee0-c4600b52503d@redhat.com>
Date: Tue, 4 Feb 2020 19:25:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <75a9cd31-a978-0b31-1d6d-1b34800e13a6@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: QnB8me10Neuxnaq54fn4Vg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 alex.bennee@linaro.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/24/20 1:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
>> Added boot Linux test cases that launch QEMU with kvm
>> enabled. Likewise it was added tests for tcg.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>> =C2=A0 tests/acceptance/boot_linux_console.py | 88 ++++++++++++++++++++-=
-----
>> =C2=A0 1 file changed, 68 insertions(+), 20 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py=20
>> b/tests/acceptance/boot_linux_console.py
>> index e40b84651b..a36eae630c 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -51,11 +51,7 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.workd=
ir + path
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 def test_x86_64_pc(self):
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:x86_64
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:pc
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 def do_test_x86_64_pc(self):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D=20
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '/vmlinu=
z')
>> @@ -70,6 +66,22 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pattern =
=3D 'Kernel command line: %s' %=20
>> kernel_command_line
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_con=
sole_pattern(console_pattern)
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 def test_x86_64_pc_kvm(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:x86_64
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:pc
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Daccel:kvm
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_x86_64_pc()
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_x86_64_pc_tcg(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:x86_64
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:pc
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Daccel:tcg
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_x86_64_pc()
> [...]
> So you want to test a binary linked with multiple accelerators.
>
> Isn't it possible to have something clever/simpler?


It is feasible using Avocado's CIT [1] or PICT [2] plug-ins. This work=20
is suggested by Cleber in [3] and I've it on my radar for future work.

But, for the moment, I would like to have those simple boot with KVM=20
tests merged so that they are executed in our Travis CI.

[1]=20
https://avocado-framework.readthedocs.io/en/75.1/plugins/optional/varianter=
_cit.html

[2]=20
https://avocado-framework.readthedocs.io/en/75.1/plugins/optional/varianter=
_pict.html

[3]=20
https://trello.com/c/1wvzcxHY/105-create-cit-parameter-for-acceptance-tests

>
>
> =C2=A0=C2=A0 def test_x86_64_pc(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:x86_64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:pc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Daccel:kvm
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Daccel:tcg
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_x86_64_pc()
>
> And use a mux config?
>
> Because else we are duplicating a lot of code, and there are various=20
> accelerators available:
>
> $ git grep ACCEL_CLASS_NAME
> accel/qtest.c:41:#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
> accel/tcg/tcg-all.c:46:#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
> hw/xen/xen-common.c:200:#define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
> include/sysemu/hvf.h:100:#define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
> include/sysemu/kvm_int.h:36:#define TYPE_KVM_ACCEL=20
> ACCEL_CLASS_NAME("kvm")
> target/i386/hax-all.c:1127:=C2=A0=C2=A0=C2=A0 .name =3D ACCEL_CLASS_NAME(=
"hax"),
> target/i386/whpx-all.c:1533:=C2=A0=C2=A0=C2=A0 .name =3D ACCEL_CLASS_NAME=
("whpx"),

Unfortunately I don't have enough time, resources and knowledge to work=20
on accelerators other than kvm and tcg. I appreciate if others could=20
contribute here, and I'm happy to review the patches.

Another point is how those tests could be ran on our CI.

Thanks for bringing those points!

- Wainer

>
>
> And also pending:
> target/i386/nvmm-all.c:=C2=A0=C2=A0 .name =3D ACCEL_CLASS_NAME("nvmm"),
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg668697.html
>


