Received: from eggs.gnu.org ([2001:4830:134:3::10]:44295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckuyX-0008JT-LX
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckuyU-0000vc-Jb
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:55:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckuyU-0000vH-AT
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:55:02 -0500
References: <20170306071721.26708-1-ppandit@redhat.com>
	<20170306071721.26708-2-ppandit@redhat.com>
	<CAFEAcA-hOsVBnw9gh-VBCr3Q7-+_m-2X3zHRuRnmzDLF8CmsZQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5956035-b60b-2d34-5353-64424e187f23@redhat.com>
Date: Mon, 6 Mar 2017 09:54:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hOsVBnw9gh-VBCr3Q7-+_m-2X3zHRuRnmzDLF8CmsZQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="co45fEbdpGkd6FniRboxlMBGQ55IvBwJf"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: limit number of
 arguments to execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Prasad J Pandit <pjp@fedoraproject.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--co45fEbdpGkd6FniRboxlMBGQ55IvBwJf
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio
 <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Message-ID: <b5956035-b60b-2d34-5353-64424e187f23@redhat.com>
Subject: Re: [PATCH v2 1/2] linux-user: limit number of arguments to execve
References: <20170306071721.26708-1-ppandit@redhat.com>
 <20170306071721.26708-2-ppandit@redhat.com>
 <CAFEAcA-hOsVBnw9gh-VBCr3Q7-+_m-2X3zHRuRnmzDLF8CmsZQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-hOsVBnw9gh-VBCr3Q7-+_m-2X3zHRuRnmzDLF8CmsZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 09:42 AM, Peter Maydell wrote:
> On 6 March 2017 at 07:17, P J P <ppandit@redhat.com> wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> Limit the number of arguments passed to execve(2) call from
>> a user program, as large number of them could lead to a bad
>> guest address error.
>>
>> Reported-by: Jann Horn <jannh@google.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  linux-user/syscall.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>

>>          {
>> +#define ARG_MAX 65535
>>              char **argp, **envp;
>>              int argc, envc;
>>              abi_ulong gp;
>> @@ -7794,6 +7795,11 @@ abi_long do_syscall(void *cpu_env, int num, abi=
_long arg1,
>>                  envc++;
>>              }
>>
>> +            if (argc > ARG_MAX || envc > ARG_MAX) {
>> +                gemu_log("argc(%d), envc(%d) exceed %d\n", argc, envc=
, ARG_MAX);
>> +                ret =3D -TARGET_E2BIG;
>> +                break;
>> +            }
>>              argp =3D alloca((argc + 1) * sizeof(void *));
>>              envp =3D alloca((envc + 1) * sizeof(void *));
>=20
>=20
> We need to fix this by not using alloca(), not by imposing
> an arbitrary limit that's still rather over-large for an
> alloca allocation, as Eric suggested.

And patch 2/2 does that. Does that patch in isolation fix the problem?
In which case, we don't want this patch.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--co45fEbdpGkd6FniRboxlMBGQ55IvBwJf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvYZTAAoJEKeha0olJ0NqeaYH/0101NQVd3n2fn/4aQhQoub4
QmAblwi6Tnd1vg+8yY/LtoomyJERZteOOh4WsA72scHbOEvvrP8GgJpomdg1/jOO
2ucolGUwfVTllIWg3Y0e8o0ys1IP24rVynKsc3V7qH3KIMIZqvgV6M355RD+BMh+
ODLcuRmsJZ31WuXRLrfXqpcTI0YjfI7EaYH1NvGr6RSLJ77gbO2X52leSAsyQR46
e3qqRw0Zi9y8SZqQoUB+rpkbBlcwFLoT46OFc8aweNVVGbgXFLDXiOc0y896BL56
UN53U17JribOQCskPMQiup0gMPnx/2acy8YjEAk3mr3VhibsLv+S4ITyOPVswHA=
=akZK
-----END PGP SIGNATURE-----

--co45fEbdpGkd6FniRboxlMBGQ55IvBwJf--
