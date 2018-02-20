Received: from eggs.gnu.org ([2001:4830:134:3::10]:35895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1eo7YC-00007t-GO
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1eo7Y8-0000BL-IG
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:01:40 -0500
Received: from mout.web.de ([212.227.15.14]:44767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1eo7Y8-0000Ao-6l
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:01:36 -0500
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-10-git-send-email-pbonzini@redhat.com>
	<3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
	<acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
	<20180219191518.74bde3bc@p-imbrenda.boeblingen.de.ibm.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <16fb2dd1-7edf-e95c-42da-5c13d0bbb7d1@web.de>
Date: Tue, 20 Feb 2018 14:01:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180219191518.74bde3bc@p-imbrenda.boeblingen.de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HZR3W29LywObf9YpzSv8fUoBZLWAaODFg"
Subject: Re: [Qemu-devel] [PULL 09/23] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HZR3W29LywObf9YpzSv8fUoBZLWAaODFg
From: Jan Kiszka <jan.kiszka@web.de>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <16fb2dd1-7edf-e95c-42da-5c13d0bbb7d1@web.de>
Subject: Re: [PULL 09/23] gdbstub: Fix vCont behaviour
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
 <1487255507-106654-10-git-send-email-pbonzini@redhat.com>
 <3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
 <acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
 <20180219191518.74bde3bc@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20180219191518.74bde3bc@p-imbrenda.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-19 19:15, Claudio Imbrenda wrote:
> On Sat, 17 Feb 2018 10:07:38 +0100
> Jan Kiszka <jan.kiszka@web.de> wrote:
>=20
> [...]
>=20
>>> Seems like no one is doing guest debugging with kvm on x86 except
>>> me, and I'm only doing it too infrequently now: This one broke that
>>> use case for SMP guests long ago. How was it tested?
>>>
>>> To reproduce the bug: set up an x86-64 guest kernel with > 1 core,
>>> break on some prominent syscall entry (e.g. sys_execve), continue
>>> the guest on hit and it will quickly lock up, even after disabling
>>> the breakpoint again. Kernel version doesn't matter (was my first
>>> guess), gdb is 7.7.50.20140604-cvs (OpenSUSE) here.
>=20
> [...]
>=20
>> Sending packet: $Hg1#e0...Ack
>> Packet received: OK
>> Sending packet: $mffffc90000c0bf30,8#83...Ack
>> Packet received: ae180081ffffffff
>> Sending packet: $mffffc90000c0bf30,8#83...Ack
>> Packet received: ae180081ffffffff
>> Breakpoint 1, SyS_execve (filename=3D7029648, argv=3D7583376,
>> envp=3D7598304) at ../fs/exec.c:1923 (gdb) c
>> Continuing.
>> Sending packet: $vCont;s:1#23...Ack
>>
>> ...and now the guest is dead. I can still interrupt it, but it's
>> otherwise not working properly.
>=20
> I tried, but I could not reproduce this bug neither on s390x nor on
> amd64. in both cases I used recent enough versions of qemu so that
> they have the patch you mentioned, and qemu was started with several
> cpus (I tried 64 on s390x, and 4 on amd64).
>=20
> in particular on amd64:
> host: 4.4.0-112-generic (ubuntu 16.04)
> QEMU version 2.10.0  (vanilla from git)
> gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1
>=20
> I also used the gdb script you provided but everything worked both with=

> -smp 1 and with -smp 4
>=20
> the only issue I had was that I had to disable kaslr in the guest to be=

> able to do anything, but that does not seem to be the problem you have.=

>=20
> my primary suspicion at this point would be an issue in KVM, and not
> in qemu. have you tried running it without KVM? what is the version of
> qemu and kernel in the host?

Yes, debugging works without KVM. But that is a completely different
setup for various reasons (no parallelism, no guest-visible
modifications by soft-breakpoints and continuations). But I would not
exclude that the issue is caused by KVM, and your patch just surfaced it.=


Jan


--HZR3W29LywObf9YpzSv8fUoBZLWAaODFg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlqMHCEACgkQitSsb3rl5xT4MQCgp1pt/9H1/BqBw6sqkPnLzq3R
BUEAniqOfmAFJmfIPkOXzc8b68CyL9f6
=5xKM
-----END PGP SIGNATURE-----

--HZR3W29LywObf9YpzSv8fUoBZLWAaODFg--
