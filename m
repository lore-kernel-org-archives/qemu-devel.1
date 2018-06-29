Received: from eggs.gnu.org ([2001:4830:134:3::10]:43222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYrnw-00062U-3U
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYrns-0003k5-6H
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:43:08 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:49317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fYrnr-0003iD-Vp
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:43:04 -0400
Received: from player774.ha.ovh.net (unknown [10.109.120.85])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 48812184887
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:43:02 +0200 (CEST)
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
	<20180629130701.6ab5d88a@bahia.lan>
	<29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
	<20180629111405.GG27016@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fe804632-393f-3499-10c2-425a3bf51485@kaod.org>
Date: Fri, 29 Jun 2018 13:42:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180629111405.GG27016@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/29/2018 01:14 PM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 29, 2018 at 01:08:38PM +0200, Paolo Bonzini wrote:
>> On 29/06/2018 13:07, Greg Kurz wrote:
>>>>>> Also asserting current_machine !=3D NULL is not necessary, since y=
ou're
>>>>>> immediately dereferencing it. =20
>>>>> Is there a practical way to simply initialize the accelerators earl=
ier
>>>>> in startup sequence, so we just remove or at least reduce, the likl=
ihood
>>>>> of accessing it too early ? =20
>>>> We can try, though not for 3.0 of course.
>>>>
>>> FWIW, the motivation for this patch was kvm_enabled() being called un=
der
>>> the class_init function of the machine TypeInfo. This happens way ear=
lier
>>> than accelerator init. Not sure this is doable, but I can have a look=
.
>>>
>>
>> Probably not, that's way too early indeed.
>=20
> Yeah, doing anything non-trivial in class_init is just asking for troub=
le,
> as conceivably nothing is initialized at that point.=20

May be we should consider having a set of binaries for each accelerator,
KVM, TCG, etc. That would simplify a lot of the init path of the machines
and also of some of the models which are trying to initialize in one mode=
=20
or the other.

Hybrid machines would still be possible, like using KVM for the CPUs and
an emulated model for some device. But the definitions would be static,=20
not guessed from what is available or not.=20

C. =20
