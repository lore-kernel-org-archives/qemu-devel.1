Received: from eggs.gnu.org ([2001:4830:134:3::10]:38855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHr9d-0006Zr-9l
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHr9X-0004Hm-NT
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:02:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHr9X-0004Gs-F6
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:02:51 -0500
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
	<8cd1c0b3-8386-d41e-ccfb-1a2073cdf4fb@redhat.com>
	<16011ac4-77c4-af75-5754-5f9586d6d629@redhat.com>
	<20171123130908.6ab004d3.cohuck@redhat.com>
	<b3b9837e-c6b0-d718-faaf-1ef198256634@redhat.com>
	<20171123133924.60e9f616.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1519a9dc-5f0b-7ddd-18ac-d1f33782656d@redhat.com>
Date: Thu, 23 Nov 2017 14:02:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171123133924.60e9f616.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, sergio.g.delreal@gmail.com, alex@alex.org.uk

On 23/11/2017 13:39, Cornelia Huck wrote:
> I'm wondering how many people want to run e.g. x86_64-on-x86_64
> _without_ using an available kvm (and I expect those people to
> explicitly specify tcg).

I disagree.  I expect them to be "power users" enough to know that
qemu-system-x86_64 defaults to TCG.

Another possibility is that users come here asking for help, we tell
them to test qemu.git, and they are confused by the lack of a qemu-kvm
binary.  Ok, maybe not that likely, but it's a category which we want to
have a smooth experience.

>> And in fact that is the main reason why have never bothered switching
>> the default... only RHEL does it, because it ships the QEMU binary as
>> qemu-kvm rather than qemu-system-xxx plus a wrapper script.
>>
>> Perhaps we could:
>>
>> 1) look for "qemu-{kvm,hvf,hax}" in argv[0] and change the "-accel" de=
fault?
>>
>> 2) change "make install" to install one or more of qemu-kvm/hvf/hax
>> based on target architecture and OS.
>>
>> Then distros can do away with the script and Windows/Mac users can lea=
rn
>> to use qemu-hvf and qemu-hax.
>=20
> I'm not sure I like that. For me, qemu-kvm comes with the connotation
> of "there used to be a fork of qemu for kvm usage, and we stuck with
> the name because it is likely scattered through scripts".

In theory I don't like it either (and I hadn't thought about it until
today).  In practice, qemu-kvm is not going away from
blogs/scripts/tutorials in a decade, so we might as well embrace it...
especially since it has fewer issues than the alternative and even some
advantages:

1) scripts that hardcode qemu-system-x86_64 expecting to use TCG keep to
work

2) it ensures that qemu-kvm works even for those who compile their own QE=
MU

3) it keeps behavior consistent across all qemu-system-* binaries

4) it reserves the unwieldy name for the thing that you don't want
(think of "exit" vs "_exit" in the C library)

5) we don't have to think about including hax or hvf in the -accel defaul=
t

Paolo
