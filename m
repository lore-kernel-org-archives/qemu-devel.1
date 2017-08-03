Received: from eggs.gnu.org ([2001:4830:134:3::10]:41026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddGbG-0003rG-0I
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddGbB-0000Oj-GR
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:55:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddGbB-0000Nj-7O
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:55:37 -0400
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48882fff-563a-52cc-c215-12f0808857cd@redhat.com>
Date: Thu, 3 Aug 2017 08:55:34 -0500
MIME-Version: 1.0
In-Reply-To: <dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LseWh1EXxswdtWu4fI9FbxTdQpO4lGPoj"
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LseWh1EXxswdtWu4fI9FbxTdQpO4lGPoj
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48882fff-563a-52cc-c215-12f0808857cd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
 <dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
In-Reply-To: <dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 08:34 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Greg,
>=20
> On 08/02/2017 11:47 AM, Greg Kurz wrote:
>> Building QEMU on fedora26 with the latest gcc package fails:
>>
>>    CC      ppc64-softmmu/target/ppc/kvm.o
>> In file included from include/sysemu/hw_accel.h:16:0,
>>                   from target/ppc/kvm.c:31:
>> target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=
=80=99:
>> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may =
be used
>> uninitialized

>=20
> This sizeof() use looks unnatural to me. I wonder why not use size_t,
> since this is about sizeof()/ARRAY_SIZE(). The problem seems to come
> from the commit this cast was introduced (61c7bbd236):
>=20
> target-ppc/kvm.c:1302:21: error: comparison of unsigned expression < 0
> is always false [-Werror=3Dtype-limits]
>=20
> So I'd rather suggest this code, which looks more natural to read to me=
:
>=20
>     if (ARRAY_SIZE(args_tmp)) {
>         for (i =3D 0; i < ARRAY_SIZE(args_tmp) && ...

For that matter, the existing code is doing:

int i;
i < (int)ARRAY_SIZE(args_tmp)

but wouldn't that be better as:

size_t i;
i < ARRAY_SIZE(args_temp)

I guess we have both the old compilers (per commit 61c7bbd2) and the new
to worry about; although I was unable to reproduce it on Fedora 26 on
x86_64 (is this an architecture-dependent compiler bug?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LseWh1EXxswdtWu4fI9FbxTdQpO4lGPoj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDK1YACgkQp6FrSiUn
Q2oyDAf/evtKHuRkSGO+D7bEAkIN0bWPlYpKnaTYbiC0ZnozR4+ER74/tZeiAaa9
WKco2m2VlV4/ytlABGypVgKLeSXKLUqP4zSixIyACziyLIQhpaezgPXI1YSymjMf
mGkNQOjR+0bNDMLVLFjzlH2RU0WytJeVGcPLN0nmH+ruhQaI4ujZumI0njTw2mom
lBD3KNOUDJcXJ/oXkMB+oWoNjnxQTi9xQ601ux6q2yp8YhBFcZIWmeO0yB94YyJb
DfxD+8GxRadNBeE3MS7D7vcWURIPUWeloCqvjH7092KqK2tH4q2zKyTq7BHF7Kar
SYXgboO50jg+eHglPEMxJh8ewq2HWA==
=rF/D
-----END PGP SIGNATURE-----

--LseWh1EXxswdtWu4fI9FbxTdQpO4lGPoj--
