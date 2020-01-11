Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB50C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 08:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814C72077C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 08:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBCW55pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814C72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqCaU-0002Ms-Jh
	for qemu-devel@archiver.kernel.org; Sat, 11 Jan 2020 03:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iqCZn-0001wt-0J
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 03:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iqCZk-0006Fr-9N
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 03:56:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32995
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iqCZj-00069k-OO
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 03:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578733014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=NKccIZg3YFAbW+Mf/uOLAt4+HOxTtpv+pg9kNYIB1S8=;
 b=XBCW55pYa56Ynp3iQ+uUedn/mXAtwIC6CaxEhqrQL8FTXx+L8AmgOFxI3FWY/oFSOok60V
 iKunHoZv5fbXfZgips5KhTTgTmvE+vzXvnwJU+nVlAOZ5qGvbqafpxZzLNgc6NYeKW9vuK
 y7LLSWC+a4S9OGFQxFQE2wOAJbJoDS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-JKrMqt4COcGlpHCsc0kHQQ-1; Sat, 11 Jan 2020 03:56:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D6DC63CC1
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2020 08:56:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-21.ams2.redhat.com [10.36.116.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ACC59A84;
 Sat, 11 Jan 2020 08:56:46 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] tests/acceptance: avocado_qemu: Introduce the
 'accel' test parameter
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191218170003.31356-1-wainersm@redhat.com>
 <20191218170003.31356-2-wainersm@redhat.com>
 <a95fe33b-2767-4e43-0a0e-424b90446623@redhat.com>
 <bbfb286a-87b1-f985-7239-d2d5f236d536@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7f28281a-ef68-dddf-1347-0e1f7a13c244@redhat.com>
Date: Sat, 11 Jan 2020 09:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bbfb286a-87b1-f985-7239-d2d5f236d536@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: JKrMqt4COcGlpHCsc0kHQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/2020 21.02, Wainer dos Santos Moschetta wrote:
> Hi Thomas,
>=20
> On 12/18/19 4:48 PM, Thomas Huth wrote:
>> On 18/12/2019 18.00, Wainer dos Santos Moschetta wrote:
>>> The test case may need to boot the VM with an accelerator that
>>> isn't actually enabled on the QEMU binary and/or present in the host. I=
n
>>> this case the test behavior is undefined, and the best course of
>>> action is to skip its execution.
>>>
>>> This change introduced the 'accel' parameter (and the handler of
>>> tag with same name) used to indicate the test case requires a
>>> given accelerator available. It was implemented a mechanism to
>>> skip the test case if the accelerator is not available. Moreover,
>>> =C2=A0 the QEMU --accel argument is set automatically to any VM
>>> launched if the parameter is present.
>>>
>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> ---
>>> =C2=A0 docs/devel/testing.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
16 ++++++++++++++++
>>> =C2=A0 tests/acceptance/avocado_qemu/__init__.py | 23 +++++++++++++++++=
++++++
>>> =C2=A0 2 files changed, 39 insertions(+)
>>>
>>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>>> index 27f286858a..6c2e0718e1 100644
>>> --- a/docs/devel/testing.rst
>>> +++ b/docs/devel/testing.rst
>>> @@ -757,6 +757,17 @@ name.=C2=A0 If one is not given explicitly, it wil=
l
>>> either be set to
>>> =C2=A0 ``None``, or, if the test is tagged with one (and only one)
>>> =C2=A0 ``:avocado: tags=3Dmachine:VALUE`` tag, it will be set to ``VALU=
E``.
>>> =C2=A0 +accel
>>> +~~~~~
>>> +The accelerator that will be set to all QEMUMachine instances created
>>> +by the test.
>>> +
>>> +The ``accel`` attribute will be set to the test parameter of the same
>>> +name.=C2=A0 If one is not given explicitly, it will either be set to
>>> +``None``, or, if the test is tagged with one (and only one)
>>> +``:avocado: tags=3Daccel:VALUE`` tag, it will be set to ``VALUE``.
>>> Currently
>>> +``VALUE`` should be either ``kvm`` or ``tcg``.
>>> +
>>> =C2=A0 qemu_bin
>>> =C2=A0 ~~~~~~~~
>>> =C2=A0 @@ -798,6 +809,11 @@ machine
>>> =C2=A0 The machine type that will be set to all QEMUMachine instances c=
reated
>>> =C2=A0 by the test.
>>> =C2=A0 +accel
>>> +~~~~~
>>> +The accelerator that will be set to all QEMUMachine instances created
>>> +by the test. In case the accelerator is not available (both QEMU
>>> +binary and the host system are checked) then the test is canceled.
>>> =C2=A0 =C2=A0 qemu_bin
>>> =C2=A0 ~~~~~~~~
>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py
>>> b/tests/acceptance/avocado_qemu/__init__.py
>>> index 6618ea67c1..aff32668d9 100644
>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>> @@ -20,6 +20,7 @@ SRC_ROOT_DIR =3D
>>> os.path.join(os.path.dirname(__file__), '..', '..', '..')
>>> =C2=A0 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>>> =C2=A0 =C2=A0 from qemu.machine import QEMUMachine
>>> +from qemu.accel import kvm_available, tcg_available
>>> =C2=A0 =C2=A0 def is_readable_executable_file(path):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return os.path.isfile(path) and os.acces=
s(path, os.R_OK | os.X_OK)
>>> @@ -111,6 +112,8 @@ class Test(avocado.Test):
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def setUp(self):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._vms =3D {}
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # VM argumments that are ma=
pped from parameters
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._param_to_vm_args =3D =
[]
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.arch=
 =3D self.params.get('arch',
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
>>> default=3Dself._get_unique_tag_val('arch'))
>>> @@ -124,10 +127,30 @@ class Test(avocado.Test):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.qemu_bin=
 is None:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 self.cancel("No QEMU binary defined or found in the
>>> source tree")
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.accel =3D self.=
params.get('accel',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> default=3Dself._get_unique_tag_val('accel'))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.accel:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ava=
il =3D False
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
self.accel =3D=3D 'kvm':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if kvm_available(self.arch, self.qemu_bin):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._param_to_vm_args.append=
('-enable-kvm')
>> Could you please use "-accel kvm" instead? "-accel" is now our official
>> way to configure an accelerator ... so we should not use the old
>> wrappers in new code anymore if possible.
> Sure, I am going to adjust that on v3.
>>
>> =C2=A0 Thanks,
>> =C2=A0=C2=A0 Thomas
>>
>>
>> PS: Travis supports KVM now, too (with some tweaking of the permissions)
>> ... maybe we should now try to get some QEMU tests running with KVM
>> there, too...
>=20
> I heard that but I failed miserably to enable nested virt on Travis.
> Actually I was expecting it enabled by default but not the case. I did
> not find documentation so I tried some tweaks like setting
> 'sudo:required' and using bionic but none of that worked out.
>=20
> Do you know what needs to be done?

Yes, I recently enabled it for the kvm-unit-tests ... and yes, it's a
bit ugly: The user has to be in the "kvm" group which is not the case
for the user that runs the travis scripts. Tweaking the access rights of
/dev/kvm unfortunately does not work (at least not directly via chmod
o+rwx /dev/kvm ... but maybe there is a way via udev or something
similar?), so I ended up with:

      sudo chgrp kvm /usr/bin/qemu-system-*
      sudo chmod g+s /usr/bin/qemu-system-*

With that, the kvm-unit-tests are running now fine with KVM on Travis.

 Thomas


