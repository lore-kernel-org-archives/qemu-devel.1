Received: from eggs.gnu.org ([2001:4830:134:3::10]:40190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1fOIoZ-0004HO-Nm
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1fOIoR-0001QE-50
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:20:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1fOIoQ-0001Nt-R1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:19:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B043476F91
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 08:19:57 +0000 (UTC)
Date: Thu, 31 May 2018 10:19:52 +0200
From: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20180531081952.GD24021@wheatley>
References: <cover.1526913931.git.mkletzan@redhat.com>
	<85e343de944def6154c599ecda53bc70688ab60a.1526913931.git.mkletzan@redhat.com>
	<dce741fa-6e2d-ab5c-a180-467df9ffe20a@redhat.com>
	<20180530210829.GB18402@wheatley>
	<14132ba4-8fec-6082-f77a-7da69069f4a2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
In-Reply-To: <14132ba4-8fec-6082-f77a-7da69069f4a2@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/5] qemu: Move checks for SMM
 from command-line creation into validation phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: John Ferlan <jferlan@redhat.com>, libvir-list@redhat.com, qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 09:33:54AM +0200, Laszlo Ersek wrote:
>adding qemu-devel, Paolo and Gerd; comments below:
>
>On 05/30/18 23:08, Martin Kletzander wrote:
>> On Wed, May 30, 2018 at 11:02:59AM -0400, John Ferlan wrote:
>>>
>>>
>>> On 05/21/2018 11:00 AM, Martin Kletzander wrote:
>>>> We are still hoping all of such checks will be moved there and this
>>>> is one small
>>>> step in that direction.
>>>>
>>>> One of the things that this is improving is the error message you get
>>>> when
>>>> starting a domain with SMM and i440fx, for example.=A0 Instead of
>>>> saying that the
>>>> QEMU binary doesn't support that option, we correctly say that it is
>>>> only
>>>> supported with q35 machine type.
>>>>
>>>> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
>>>> ---
>>>> =A0src/qemu/qemu_capabilities.c | 21 +++++++++++++++------
>>>> =A0src/qemu/qemu_capabilities.h |=A0 4 ++--
>>>> =A0src/qemu/qemu_command.c=A0=A0=A0=A0=A0 | 12 ++----------
>>>> =A0src/qemu/qemu_domain.c=A0=A0=A0=A0=A0=A0 | 12 +++++++++---
>>>> =A04 files changed, 28 insertions(+), 21 deletions(-)
>>>>
>>>
>>> I know it's outside the bounds of what you're doing; however,
>>> qemuDomainDefValidateFeatures could check the capabilities for other
>>> bits too...
>>>
>>
>> Probably, but I mostly wanted to do that because SMM is not only about t=
he
>> capability, but also about the machine.=A0 Good idea for the future, tho=
ugh.
>>
>>> [...]
>>>
>>>> diff --git a/src/qemu/qemu_domain.c b/src/qemu/qemu_domain.c
>>>> index d3beee5d8760..881d0ea46a75 100644
>>>> --- a/src/qemu/qemu_domain.c
>>>> +++ b/src/qemu/qemu_domain.c
>>>> @@ -3430,7 +3430,8 @@ qemuDomainDefGetVcpuHotplugGranularity(const
>>>> virDomainDef *def)
>>>>
>>>>
>>>> =A0static int
>>>> -qemuDomainDefValidateFeatures(const virDomainDef *def)
>>>> +qemuDomainDefValidateFeatures(const virDomainDef *def,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 virQEMUCapsPtr qemuCaps)
>>>> =A0{
>>>> =A0=A0=A0=A0 size_t i;
>>>>
>>>> @@ -3477,6 +3478,12 @@ qemuDomainDefValidateFeatures(const
>>>> virDomainDef *def)
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>>
>>>> +=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_SMM:
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (def->features[i] =3D=3D VIR_TRI=
STATE_SWITCH_ON &&
>>>
>>> Probably should change to !=3D _ABSENT, since qemu_command will supply
>>> smm=3D{on|off}
>>>
>>
>> That makes sense, kind of.=A0 For 'off' we only need to check if we can
>> specify
>> the smm=3D option.=A0 The thing is that you can even specify smm=3Don wi=
th
>> non-q35
>> machine type, but it is unclear what that's going to mean since it doesn=
't
>> really make sense.
>>
>> @Laszlo: What would you say?=A0 Should we allow users to specify smm=3Don
>> for users?
>> Or even better, does it makes sense to allow specifying smm=3Danything f=
or
>> non-q35
>> machine types?=A0 If not, we'll leave it like this, that is smm=3Danythi=
ng is
>> forbidden for non-q35 machine types.
>
>Technically the "smm" machine type property is defined for both i440fx
>and q35:
>
>$ qemu-system-x86_64 -machine pc,\? 2>&1 | grep smm
>pc-i440fx-2.11.smm=3DOnOffAuto (Enable SMM (pc & q35))
>
>$ qemu-system-x86_64 -machine q35,\? 2>&1 | grep smm
>pc-q35-2.11.smm=3DOnOffAuto (Enable SMM (pc & q35))
>
>The "smm" property controls whether system management mode is emulated,
>to my knowledge. That's an x86 processor operating mode, which isn't
>specific to the Q35 board. What's specific to Q35 is the TSEG.
>
>The primary reason why OVMF (built with the edk2 SMM driver stack)
>requires Q35 is not that i440fx does not emulate SMM, it's that i440fx
>doesn't have a large enough SMRAM area. (The legacy SMRAM areas are too
>small for OVMF.)
>
>For example, SeaBIOS too includes some SMM code (optionally, if it's
>built like that), and that runs on i440fx just fine, because the legacy
>SMRAM areas are large enough for SeaBIOS's purposes, AIUI.
>
>(Now, there's at least one other reason why OVMF/SMM needs Q35: because
>the SMI broadcast feature too is only implemented on Q35. But that's
>rather a consequence of the above "primary reason", and not a
>stand-alone reason itself -- we restricted the SMI broadcast feature to
>Q35 *because* OVMF could only run on Q35. Anyhow, you need not care
>about SMI broadcast because it's automatically negotiated between guest
>fw and QEMU.)
>
>Summary:
>
>(1) For making Secure Boot actually secure in OVMF, OVMF needs to be
>built with -D SMM_REQUIRE, so that it include the SMM driver stack.
>
>(2) Booting such a firmware binary requires Q35, because only Q35 offers
>TSEG, and the legacy -- non-TSEG -- SMRAM ranges are too small even for
>a "basic boot" of OVMF.
>
>(3) QEMU has to be configured with "-machine smm=3Don"; this is already
>covered by libvirt via <smm state=3D'on'/>.
>
>(4) QEMU has to be configured to restrict pflash writes to code that
>executes in SMM, with "-global
>driver=3Dcfi.pflash01,property=3Dsecure,value=3Don". Libvirt covers this
>already with the @secure=3Dyes attribute in <loader readonly=3D'yes'
>secure=3D'yes' type=3D'pflash'>.
>
>(5) There are two *quality of service* features related to SMM; with
>both of them being Q35-only. The first feature is SMI broadcast; libvirt
>need not care because it's auto-negotiated.
>
>(6) The second QoS feature is *extended* TSEG (a paravirt feature on top
>of the standard TSEG), which lets the edk2 SMM driver stack scale to
>large RAM sizes and high VCPU counts. Libvirt should let the user
>configure the extended TSEG size, because the necessary minimum is super
>difficult to calculate (and one "maximum size" doesn't fit all either),
>and the user should be allowed to experiment with the size.
>
>Hope this helps... I realize it is annoyingly complex.
>

Oh, it definitely helps.  And I always enjoy when someone explains low level
details of something like you do, it makes me feel very smart after I read =
it =3D)

=2E..something about the shoulders of giants and stuff...

I'll fix this up according to what you described, that is smm=3Don/off will=
 be
possible to be specified whenever -machine supports smm=3D.

>Thanks,
>Laszlo
>
>>> Reviewed-by: John Ferlan <jferlan@redhat.com>
>>>
>>> John
>>>
>>>
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virQEMUCapsCheckSMMSupp=
ort(qemuCaps, def) < 0)
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>> +
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_ACPI:
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_APIC:
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_PAE:
>>>> @@ -3489,7 +3496,6 @@ qemuDomainDefValidateFeatures(const
>>>> virDomainDef *def)
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_CAPABILITIES:
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_PMU:
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_VMPORT:
>>>> -=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_SMM:
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_VMCOREINFO:
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 case VIR_DOMAIN_FEATURE_LAST:
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>> @@ -3612,7 +3618,7 @@ qemuDomainDefValidate(const virDomainDef *def,
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>>> =A0=A0=A0=A0 }
>>>>
>>>> -=A0=A0=A0 if (qemuDomainDefValidateFeatures(def) < 0)
>>>> +=A0=A0=A0 if (qemuDomainDefValidateFeatures(def, qemuCaps) < 0)
>>>> =A0=A0=A0=A0=A0=A0=A0=A0 goto cleanup;
>>>>
>>>> =A0=A0=A0=A0 ret =3D 0;
>>>>
>

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAlsPsCgACgkQCB/CnyQX
ht3KkQ//dEHgRbpzsz9wLwyJpCmVIWpAmOb35Iho4xYCelUdPivDmrkCtMivhd05
avkPWIh0HWgE06icgey6fvBe/7X+fr9uOh/w3z55bJwJIAVLnClJBKhQPcfvkyMd
wbYOZXVOju785Mvi+gf/+sl4iM3zy5cWCtmYBrLF6BpcfCbQQlvYNpP2o0qOaUPF
NAyLunyT9qcvOJSDfPC0XJxdB27fKNxGATygvLRoI0XLO8N4AYk6OUX3orVhXu/6
u1su/3nIetl7TqYuVz5HJE5wafClSO5pui8efZBQ0tTXbpH3Xfy/OXmTP4tnzndc
iOIEFXyQ6eh30cXwKl5iJkSw26LWtraZzlsjzrOm/yHabCeiQKbnB8jdkoqs1PYM
YtV60lnlmTLu9jjtnqJva8P2XwnmucJV1jxUOJUG7pa6jp2Otg5ARasS87c/ANLZ
U/kYqb/pra7ouSxiVPRtKk/DHB05NL6FBedErbhHTzX21Bkm5UY3sAHTbxGhH9sZ
rKIa6zBkJ/nAHrwABN/+lRwCpOO0urODfYHSfvttkJNmuHsqgtdJkaRDu+CwfS7H
NQXqIlzIB1RV8xxdydqVqIEfIpf4dR0navKjfzh3qmrXzEwnO/F62dppGCnceSdK
2YuczZW72FlCdyYtnJ5ojkX+G0PBz91lafSDe62ZaWovRFyeF4M=
=aBe8
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
