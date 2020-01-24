Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D564C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B6E2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFG7i9QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B6E2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1CQ-0005UE-Be
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 10:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iv1Bn-00055N-Eb
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iv1Bm-00067X-4F
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iv1Bm-00066v-0v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579880884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=0CKebukJeq2+4vg53JO3/Y9GjXMAiZ3GyTl2FJ2zM5s=;
 b=UFG7i9QMuUV1bI2dkX3AaQIl+7l4CPtVLOWn1TBed/qySxFJc0pKNLFEQ+wD7E3pkfYOcT
 7AwCAnxBicOhb5K9t4MIFn5+WLjWG1y7rW/u30k6dV8C1eeNTGeXlhiJZPkn+NtiRdYrdC
 wK6+0Chhztekk6Z8b+Xs1MDT7VuSEQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-wi_Tx3twOg6eVENLoAqcxw-1; Fri, 24 Jan 2020 10:47:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CAEF10B1654;
 Fri, 24 Jan 2020 15:47:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-156.ams2.redhat.com [10.36.116.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA398DC1A;
 Fri, 24 Jan 2020 15:47:46 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] tests/acceptance: boot_linux_console: Add boot
 Linux with kvm tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 crosa@redhat.com
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-3-wainersm@redhat.com>
 <75a9cd31-a978-0b31-1d6d-1b34800e13a6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fa900afa-3bcc-11d3-ad2e-d756ec6ef6b3@redhat.com>
Date: Fri, 24 Jan 2020 16:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <75a9cd31-a978-0b31-1d6d-1b34800e13a6@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wi_Tx3twOg6eVENLoAqcxw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/2020 16.45, Philippe Mathieu-Daud=C3=A9 wrote:
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
>> diff --git a/tests/acceptance/boot_linux_console.py
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
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '/vmlinu=
z')
>> @@ -70,6 +66,22 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pattern =
=3D 'Kernel command line: %s' %
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
>=20
> Isn't it possible to have something clever/simpler?
>=20
> =C2=A0=C2=A0 def test_x86_64_pc(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:x86_64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:pc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Daccel:kvm
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Daccel:tcg
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_x86_64_pc()
>=20
> And use a mux config?
>=20
> Because else we are duplicating a lot of code, and there are various
> accelerators available:
>=20
> $ git grep ACCEL_CLASS_NAME
> accel/qtest.c:41:#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
> accel/tcg/tcg-all.c:46:#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
> hw/xen/xen-common.c:200:#define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
> include/sysemu/hvf.h:100:#define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
> include/sysemu/kvm_int.h:36:#define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm"=
)
> target/i386/hax-all.c:1127:=C2=A0=C2=A0=C2=A0 .name =3D ACCEL_CLASS_NAME(=
"hax"),
> target/i386/whpx-all.c:1533:=C2=A0=C2=A0=C2=A0 .name =3D ACCEL_CLASS_NAME=
("whpx"),
>=20
> And also pending:
> target/i386/nvmm-all.c:=C2=A0=C2=A0 .name =3D ACCEL_CLASS_NAME("nvmm"),
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg668697.html

Is anybody running any of these in a CI environment?

 Thomas


