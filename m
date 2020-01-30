Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB38C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654932063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHig2WOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654932063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIfb-0005VM-G0
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixIer-0004wm-Ju
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixIep-0006gb-Cf
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:51:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58472
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixIep-0006g9-9G
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580424690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dH4tuU7ZeHs37QTcTeqNwkYooFaBP7DN1+4CQM3dXI8=;
 b=fHig2WOeYSRqeL+nhkpojvcttj8xgWLnde8Pf9uibCdKpYrXg3EQnmjZVS1K1hvC5e1dQg
 2mfFYg0SBFLpjkPrFJ6xBZljNtpJkeSRxJhtH2itH4lXRN28caA62Cq198rDbdbEU93FiF
 +a9OH2L7DQAZK3fc+qtSxAKrBWxEpEs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-LVr0Hp3NN4C-W9cnpRbYAg-1; Thu, 30 Jan 2020 17:51:26 -0500
Received: by mail-wr1-f70.google.com with SMTP id z14so2412457wrs.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RhUyvQDo608GPzkmT0DzUov8MjblqTz3cyKEBuUoLI4=;
 b=rFfCT0AAF3d3u+4Ac4JEEZEBwq7IjyYDGBKtjgViqQ/ugR2l03+UZbEDhG1l9CZgRX
 gPptm0A4+Ydpf73QJwH/XHsQExu9vXBI3KjbEJWZDytOizQ47dPphQMA64bS9YA7wi/Z
 dFmKvEAwtYAMOR7PUhtu4/OcKtkuL2JOm/ooWCYkFc8uY8YP9P6pzycYpTaNjoiKvGK0
 tg8AqRhkv5yxyH/+l5oFVHjuDeMs726KEoBbn3IloAkdrW4vny2zcEvXiPzJpTK5RLBI
 Unqqbv99E7jQDf5+jb1qgxQ5OgRvZG6DBKR5ce8WrV5eQ/aMaWcJmlVWKPsTmk+gL8np
 ZPMQ==
X-Gm-Message-State: APjAAAWrZOMaxfSSgqu7lWs7yGp3Jtiux5kcvw3LarK5/KqdEQkQdhdh
 F+y0ncus5Lo3fA3a/m8E3U30kCyTXO0hFa299wKngnWlcDGv1CgUgFvV+YF8vZElnEJuDfDDV0h
 PNW0YBdUGL9QEA+A=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr8515531wmb.137.1580424684886; 
 Thu, 30 Jan 2020 14:51:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/bpwPg2pfU7g967qhNTs710q/kyPPHhqfiHMsXGEnSX/whhNuAky8vmAToz/biJgsNRdMow==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr8515499wmb.137.1580424684537; 
 Thu, 30 Jan 2020 14:51:24 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w8sm8274996wmm.0.2020.01.30.14.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:51:23 -0800 (PST)
Subject: Re: [PATCH v3 1/4] tests/acceptance: avocado_qemu: Introduce the
 'accel' test parameter
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-2-wainersm@redhat.com>
 <49356b32-5530-a2dc-9c7a-5a86e74b8cb6@redhat.com>
 <705772ab-9326-5dcb-20c6-37ab748bef4e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8e544dd9-4d0b-be56-382d-25fd413c476c@redhat.com>
Date: Thu, 30 Jan 2020 23:51:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <705772ab-9326-5dcb-20c6-37ab748bef4e@redhat.com>
Content-Language: en-US
X-MC-Unique: LVr0Hp3NN4C-W9cnpRbYAg-1
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 8:28 PM, Wainer dos Santos Moschetta wrote:
> On 1/24/20 7:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
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
>>> =C2=A0 the QEMU -accel argument is set automatically to any VM
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
>>> index ab5be0c729..d17d0e90aa 100644
>>> --- a/docs/devel/testing.rst
>>> +++ b/docs/devel/testing.rst
>>> @@ -759,6 +759,17 @@ name.=C2=A0 If one is not given explicitly, it wil=
l=20
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
>>> +``:avocado: tags=3Daccel:VALUE`` tag, it will be set to ``VALUE``.=20
>>> Currently
>>> +``VALUE`` should be either ``kvm`` or ``tcg``.
>>> +
>>> =C2=A0 qemu_bin
>>> =C2=A0 ~~~~~~~~
>>> =C2=A0 @@ -800,6 +811,11 @@ machine
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
>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py=20
>>> b/tests/acceptance/avocado_qemu/__init__.py
>>> index 6618ea67c1..c83a75ccbc 100644
>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>> @@ -20,6 +20,7 @@ SRC_ROOT_DIR =3D=20
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
>>> default=3Dself._get_unique_tag_val('arch'))
>>> @@ -124,10 +127,30 @@ class Test(avocado.Test):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.qemu_bin=
 is None:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 self.cancel("No QEMU binary defined or found in the=20
>>> source tree")
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.accel =3D self.=
params.get('accel',
>>> + default=3Dself._get_unique_tag_val('accel'))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.accel:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ava=
il =3D False
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
self.accel =3D=3D 'kvm':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if kvm_available(self.arch, self.qemu_bin):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail =3D True
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eli=
f self.accel =3D=3D 'tcg':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if tcg_available(self.qemu_bin):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail =3D True
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 els=
e:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.cancel("Unknown accelerator: %s" % self.accel)
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
avail:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self._param_to_vm_args.extend(['-accel', self.accel])
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 els=
e:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.cancel("%s is not available" % self.accel)
>>
>> Why refuse to test the other accelerators?
>>
>> Isn't it better to QMP-ask QEMU which accelerator it supports, and=20
>> SKIP if it isn't available?
>=20
>=20
> python/qemu/accel.py:list_accel(qemu_bin) can be used for that end. For=
=20
> example:
>=20
> if self.accel not in list_accel(self.qemu_bin):
>=20
>  =C2=A0=C2=A0=C2=A0 self.cancel("%s is not available" % self.accel)
>=20
> However checking the support only on QEMU's binary may be very weak=20
> (take KVM as an example). I implemented checkers for kvm and tcg on=20
> python/qemu/accel.py. Given that I have zero knowledge on the other=20
> accelerators,=C2=A0 I simply did not touch on them.
>=20
> That said, IMHO it needs to implement checkers for those others=20
> accelerator before they get reliably handled by avocado_qemu=20
> automatically. And test writers can still run tests with those=20
> accelerators as long as 'accel' tag is not used.
>=20
> What do you think Philippe?

Can you have a look at the binary_get_accels() method which aims to be=20
more generic?

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07312.html
"python/qemu: Add binutils::binary_get_accels()"

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07313.html
"python/qemu/accel: Use binutils::binary_get_accels()"

>=20
> Thanks, good point!
>=20
> - Wainer
>=20
>=20
>>
>>
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def _new_vm(self, *args):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm =3D QEMUMachi=
ne(self.qemu_bin, sock_dir=3Dtempfile.mkdtemp())
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if args:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 vm.add_args(*args)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self._param_to_vm_args:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.=
add_args(*self._param_to_vm_args)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vm
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @property
>>>
>>
>=20


