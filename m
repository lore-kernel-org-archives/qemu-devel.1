Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0400C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E522166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQ6wAWvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E522166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz5ny-0003Yi-MU
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 16:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iz5ma-000361-7f
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iz5mY-0007U9-0g
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:30:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iz5mX-0007RO-Rz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580851852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeHPZq4c8y4/FCcPqJTNmgONJ0M4OOKX//CeE05JZ6U=;
 b=YQ6wAWvAoM8o5a35YSQ0v0NpEO4NkdEBi4KgoWzvGQLYxxWBsTQ73G0WdmKyqN/z5DohqU
 fyGb99ikuc3z6/Agp/Dv/LOo144s1eXl10X1jcIf+QUYTZjQm39zEyReGg+xQmVTVlOy6G
 9FCJkP1BxE8ZCc8+UzTOIIAo1I3OfiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-VR8pP9sgNbqwIiT17WZXCw-1; Tue, 04 Feb 2020 16:30:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1C071922964;
 Tue,  4 Feb 2020 21:30:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A149D867FE;
 Tue,  4 Feb 2020 21:30:33 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] tests/acceptance: avocado_qemu: Introduce the
 'accel' test parameter
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-2-wainersm@redhat.com>
 <49356b32-5530-a2dc-9c7a-5a86e74b8cb6@redhat.com>
 <705772ab-9326-5dcb-20c6-37ab748bef4e@redhat.com>
 <8e544dd9-4d0b-be56-382d-25fd413c476c@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <ed2eeaa7-aafc-d3bc-8bb8-04b9db0feba2@redhat.com>
Date: Tue, 4 Feb 2020 19:30:31 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8e544dd9-4d0b-be56-382d-25fd413c476c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: VR8pP9sgNbqwIiT17WZXCw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/30/20 8:51 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/27/20 8:28 PM, Wainer dos Santos Moschetta wrote:
>> On 1/24/20 7:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
>>>> The test case may need to boot the VM with an accelerator that
>>>> isn't actually enabled on the QEMU binary and/or present in the=20
>>>> host. In
>>>> this case the test behavior is undefined, and the best course of
>>>> action is to skip its execution.
>>>>
>>>> This change introduced the 'accel' parameter (and the handler of
>>>> tag with same name) used to indicate the test case requires a
>>>> given accelerator available. It was implemented a mechanism to
>>>> skip the test case if the accelerator is not available. Moreover,
>>>> =C2=A0 the QEMU -accel argument is set automatically to any VM
>>>> launched if the parameter is present.
>>>>
>>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>>> ---
>>>> =C2=A0 docs/devel/testing.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 16 ++++++++++++++++
>>>> =C2=A0 tests/acceptance/avocado_qemu/__init__.py | 23=20
>>>> +++++++++++++++++++++++
>>>> =C2=A0 2 files changed, 39 insertions(+)
>>>>
>>>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>>>> index ab5be0c729..d17d0e90aa 100644
>>>> --- a/docs/devel/testing.rst
>>>> +++ b/docs/devel/testing.rst
>>>> @@ -759,6 +759,17 @@ name.=C2=A0 If one is not given explicitly, it wi=
ll=20
>>>> either be set to
>>>> =C2=A0 ``None``, or, if the test is tagged with one (and only one)
>>>> =C2=A0 ``:avocado: tags=3Dmachine:VALUE`` tag, it will be set to ``VAL=
UE``.
>>>> =C2=A0 +accel
>>>> +~~~~~
>>>> +The accelerator that will be set to all QEMUMachine instances created
>>>> +by the test.
>>>> +
>>>> +The ``accel`` attribute will be set to the test parameter of the same
>>>> +name.=C2=A0 If one is not given explicitly, it will either be set to
>>>> +``None``, or, if the test is tagged with one (and only one)
>>>> +``:avocado: tags=3Daccel:VALUE`` tag, it will be set to ``VALUE``.=20
>>>> Currently
>>>> +``VALUE`` should be either ``kvm`` or ``tcg``.
>>>> +
>>>> =C2=A0 qemu_bin
>>>> =C2=A0 ~~~~~~~~
>>>> =C2=A0 @@ -800,6 +811,11 @@ machine
>>>> =C2=A0 The machine type that will be set to all QEMUMachine instances=
=20
>>>> created
>>>> =C2=A0 by the test.
>>>> =C2=A0 +accel
>>>> +~~~~~
>>>> +The accelerator that will be set to all QEMUMachine instances created
>>>> +by the test. In case the accelerator is not available (both QEMU
>>>> +binary and the host system are checked) then the test is canceled.
>>>> =C2=A0 =C2=A0 qemu_bin
>>>> =C2=A0 ~~~~~~~~
>>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py=20
>>>> b/tests/acceptance/avocado_qemu/__init__.py
>>>> index 6618ea67c1..c83a75ccbc 100644
>>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>>> @@ -20,6 +20,7 @@ SRC_ROOT_DIR =3D=20
>>>> os.path.join(os.path.dirname(__file__), '..', '..', '..')
>>>> =C2=A0 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>>>> =C2=A0 =C2=A0 from qemu.machine import QEMUMachine
>>>> +from qemu.accel import kvm_available, tcg_available
>>>> =C2=A0 =C2=A0 def is_readable_executable_file(path):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return os.path.isfile(path) and os.acce=
ss(path, os.R_OK |=20
>>>> os.X_OK)
>>>> @@ -111,6 +112,8 @@ class Test(avocado.Test):
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def setUp(self):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._vms =3D {=
}
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # VM argumments that are m=
apped from parameters
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._param_to_vm_args =3D=
 []
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.arc=
h =3D self.params.get('arch',
>>>> default=3Dself._get_unique_tag_val('arch'))
>>>> @@ -124,10 +127,30 @@ class Test(avocado.Test):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.qemu_bi=
n is None:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 self.cancel("No QEMU binary defined or found in the=20
>>>> source tree")
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.accel =3D self=
.params.get('accel',
>>>> + default=3Dself._get_unique_tag_val('accel'))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.accel:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 av=
ail =3D False
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 self.accel =3D=3D 'kvm':
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if kvm_available(self.arch, self.qemu_bin):
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail =3D True
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
if self.accel =3D=3D 'tcg':
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if tcg_available(self.qemu_bin):
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail =3D True
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.cancel("Unknown accelerator: %s" % self.accel)
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 avail:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self._param_to_vm_args.extend(['-accel', self.accel])
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.cancel("%s is not available" % self.accel)
>>>
>>> Why refuse to test the other accelerators?
>>>
>>> Isn't it better to QMP-ask QEMU which accelerator it supports, and=20
>>> SKIP if it isn't available?
>>
>>
>> python/qemu/accel.py:list_accel(qemu_bin) can be used for that end.=20
>> For example:
>>
>> if self.accel not in list_accel(self.qemu_bin):
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 self.cancel("%s is not available" % self.accel)
>>
>> However checking the support only on QEMU's binary may be very weak=20
>> (take KVM as an example). I implemented checkers for kvm and tcg on=20
>> python/qemu/accel.py. Given that I have zero knowledge on the other=20
>> accelerators,=C2=A0 I simply did not touch on them.
>>
>> That said, IMHO it needs to implement checkers for those others=20
>> accelerator before they get reliably handled by avocado_qemu=20
>> automatically. And test writers can still run tests with those=20
>> accelerators as long as 'accel' tag is not used.
>>
>> What do you think Philippe?
>
> Can you have a look at the binary_get_accels() method which aims to be=20
> more generic?
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07312.html
> "python/qemu: Add binutils::binary_get_accels()"
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07313.html
> "python/qemu/accel: Use binutils::binary_get_accels()"


Sure, I will have a look at those.

But I prefer to stick with the implementation proposed on this patch.=20
IMHO if avocado_qemu is going to set the accelerator from the tag, then=20
it should/could go further with additional checks (e.g. if kvm is=20
enabled at host, not just at QEMU binary).

- Wainer

>
>>
>> Thanks, good point!
>>
>> - Wainer
>>
>>
>>>
>>>
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def _new_vm(self, *args):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm =3D QEMUMach=
ine(self.qemu_bin, sock_dir=3Dtempfile.mkdtemp())
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if args:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 vm.add_args(*args)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self._param_to_vm_args:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm=
.add_args(*self._param_to_vm_args)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vm
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @property
>>>>
>>>
>>
>


