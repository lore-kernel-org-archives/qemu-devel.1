Received: from eggs.gnu.org ([2001:4830:134:3::10]:48573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dV2XW-0005pw-0M
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dV2XS-0003Cv-Qv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:17:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dV2XS-0003CU-HS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:17:46 -0400
References: <20170709175422.30185-1-peter.maydell@linaro.org>
	<20170711162943.GF2223@work-vm>
	<CAFEAcA-JXT3B0uXbxbh9oex4gngsz350Sq+P4QK=aqAS9q1dcA@mail.gmail.com>
	<20170711190846.GA3138@work-vm>
	<CAFEAcA-vXYOTm0o4V1XHf1ScuLO9RZesgM+v9FTA71qa9MeBwQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53d067d6-b52a-a532-9f54-7d079e292a52@redhat.com>
Date: Tue, 11 Jul 2017 16:17:42 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vXYOTm0o4V1XHf1ScuLO9RZesgM+v9FTA71qa9MeBwQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="soeQHUnpu2MoiFNqVfkorc1mfh2ULQkrt"
Subject: Re: [Qemu-devel] [PATCH] slirp: fork_exec(): Don't close() a
 negative number in fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--soeQHUnpu2MoiFNqVfkorc1mfh2ULQkrt
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "patches@linaro.org" <patches@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <53d067d6-b52a-a532-9f54-7d079e292a52@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: fork_exec(): Don't close() a negative
 number in fork_exec()
References: <20170709175422.30185-1-peter.maydell@linaro.org>
 <20170711162943.GF2223@work-vm>
 <CAFEAcA-JXT3B0uXbxbh9oex4gngsz350Sq+P4QK=aqAS9q1dcA@mail.gmail.com>
 <20170711190846.GA3138@work-vm>
 <CAFEAcA-vXYOTm0o4V1XHf1ScuLO9RZesgM+v9FTA71qa9MeBwQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-vXYOTm0o4V1XHf1ScuLO9RZesgM+v9FTA71qa9MeBwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2017 03:40 PM, Peter Maydell wrote:
>>>
>>> The problem is you can only bail while you're in the parent
>>> before forking. Once you've started the child there's no
>>> mechanism for dealing with failure.
>>
>> Well, you can always exit the child before anything worse can happen.
>=20
> You need a mechanism then for causing the parent to notice.
> The current code would leave the parent in a blocking
> accept() call forever (this is what all the XXX comments
> in the current code are about).

You can have the parent create a pipe before forking and does a blocking
read, the child then manages fds and writes success (or failure) to its
end of the pipe (or an early exit causes the parent to read EOF); when
the parent finally gets word on the pipe, then it knows whether the
child is dead-on-arrival due to early setup failures, or whether it is
now safe to block on accept().  But it can easily get more and more
complex the more you want to handle; and if the parent is
multi-threaded, you have to be careful that you only call
async-signal-safe functions in the child between the fork and exec.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--soeQHUnpu2MoiFNqVfkorc1mfh2ULQkrt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZUB2AAoJEKeha0olJ0NqGfIH/jdg4rv50J4fsfgdrAudupXz
ynLLoGFbEILilkS4Ca0jXskaOuSDD3E++B3XS/uT59y3guQaPsaCTVy+lJ5Xtfg5
UVfagBGLOCCZuACxjwc8LDOlIgFQJz5YKmANZeRw8XLw9jnObE1JFrn8t5g1Hy0R
qLANkX03zi5c1hSJDHOlWJzN94uARt8YGbcrFm0rlqKKt/eO3Yby9glUabMmxv+C
3pHx5IoDnU0EZIsX7AgTinX0KTlMu9YRRa3ZSceXMSeWcpAdxroyBa9i89OIWHFy
04ePwV8r6dKJuu/+YPlfD8IfaIrRKgZ+9sPKZa4Nc8be0cTbCL4SprFq/QSPl5E=
=hAnI
-----END PGP SIGNATURE-----

--soeQHUnpu2MoiFNqVfkorc1mfh2ULQkrt--
