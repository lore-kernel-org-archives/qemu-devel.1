Received: from eggs.gnu.org ([2001:4830:134:3::10]:41064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciNze-0001cO-QW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciNzb-00023r-Jp
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:17:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciNzb-00023k-Cq
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:17:43 -0500
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<05abc81a-febc-11e6-601f-8d9ee30922eb@redhat.com>
	<87varv8wjh.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5907368e-1945-2109-93c3-a587654e430c@redhat.com>
Date: Mon, 27 Feb 2017 17:17:40 +0100
MIME-Version: 1.0
In-Reply-To: <87varv8wjh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/24] MTTCG Base enabling patches with ARM
 enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org



On 27/02/2017 16:48, Alex Benn=C3=A9e wrote:
> Currently the code does:
>=20
>   static bool default_mttcg_enabled(void)
>   {
>       QemuOpts *icount_opts =3D qemu_find_opts_singleton("icount");
>       const char *rr =3D qemu_opt_get(icount_opts, "rr");
>=20
>       if (rr || TCG_OVERSIZED_GUEST) {
>           return false;
>=20
> I suspect I should just fail if any icount options are set.

Yes.

> However
> qemu_find_opts_singleton always returns the structure. How do I test
> for any icount options?

use_icount !=3D 0 if configure_icount has been called already.

>> 2) "-icount auto -accel tcg,thread=3Dsingle" hangs fairly early, print=
ing
>> this on the serial console.  It's okay if it hangs at
>>
>> [Bds]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DEnd Load Options Dumping=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [Bds]BdsWait ...Zzzzzzzzzzzz...
>> [Bds]BdsWait(3)..Zzzz...
>>
>> (pressing Enter a few times then seems to unhang it), but it now hangs
>> much earlier than that.
>=20
> Hmm I can see a hang on linux booting like that. It looks like a vCPU
> get stuck in waitio and never schedules the others.

I don't know if it's the same. For OVMF it fails in many different ways
and it complains about unexpected expensions too.

>> Also, x86 "-accel tcg,thread=3Dmulti" prints the scary message on memo=
ry
>> ordering.
>
> That is expected until x86 is properly tested and we submit the default
> enabling patch for x86 on x86. To be honest we could submit the MO patc=
h
> now to make that warning go away.

Yeah, this is just the message being unnecessarily specific.

Paolo
