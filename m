Received: from eggs.gnu.org ([2001:4830:134:3::10]:46286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDwLy-0005bs-4o
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDwLu-00068Q-Vz
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:42:58 -0500
References: <E8B64B53-09F0-4B1E-9F11-48CC3957C4E1@gmail.com>
	<cfcf1388-0366-99ed-7800-b7c1fe152001@redhat.com>
	<F5D2D047-AD72-4378-AD8A-F411D3453CAF@gmail.com>
	<6041592b-e6a4-084e-50da-e69fee04de82@twiddle.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f9c876b-6d37-e448-8a8c-05c6b7af4e44@redhat.com>
Date: Mon, 5 Dec 2016 10:42:44 -0600
MIME-Version: 1.0
In-Reply-To: <6041592b-e6a4-084e-50da-e69fee04de82@twiddle.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cFFUok2VbIlwxEBXVhtg6LQ9GQhLwfLia"
Subject: Re: [Qemu-devel] [RFC] target-ppc/fpu_helper.c: Use C99 code to
 speed up floating point unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cFFUok2VbIlwxEBXVhtg6LQ9GQhLwfLia
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
 Programmingkid <programmingkidx@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <8f9c876b-6d37-e448-8a8c-05c6b7af4e44@redhat.com>
Subject: Re: [Qemu-devel] [RFC] target-ppc/fpu_helper.c: Use C99 code to speed
 up floating point unit
References: <E8B64B53-09F0-4B1E-9F11-48CC3957C4E1@gmail.com>
 <cfcf1388-0366-99ed-7800-b7c1fe152001@redhat.com>
 <F5D2D047-AD72-4378-AD8A-F411D3453CAF@gmail.com>
 <6041592b-e6a4-084e-50da-e69fee04de82@twiddle.net>
In-Reply-To: <6041592b-e6a4-084e-50da-e69fee04de82@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2016 07:32 PM, Richard Henderson wrote:
> On 12/03/2016 09:07 AM, Programmingkid wrote:
>> Yes it would be. The commit message never stated why he wanted to swit=
ch
>> to floating point softfloat routines. These are my guesses:
> ...
>> - Different hosts produced different results and instead wanted
>> consistency?
>=20
> This is the correct answer.  There are quite a lot of differences
> between floating point across different cpus.  Which means that it's
> actually rare that the host and guest floating point are exactly alike.=


Or to frame it in different words:

qemu's goal is to be an architecturally-accurate emulator.  fma() has
specific C99 semantics (mapping to what IEEE floating point requires),
but USUALLY those semantics are not fully implemented in hardware;
rather, the hardware implements 90% and has specific flags or traps that
let the C library recognize when it has to manually perform the 10% of
special cases. But the special cases differ by hardware.

If all hardware implemented C99 semantics 100% of the time, then using
C99 to emulate hardware would be correct.  But since that is not true,
emulating C99 semantics instead of hardware semantics will be WRONG in
the special cases, and cause programs to misbehave under qemu where they
would behave correctly on bare metal. So the decision was that accurate
emulation (guaranteed by using soft-float operations that are tailored
to each hardware's specific quirks on the special cases) is more
important that speed (where the behavior can be different from hardware
on the special cases, even if that behavior is accurate to IEEE and C99
semantics).

If you can completely describe ALL special cases that ANY particular
platform has quirks for, and kick to softmmu for those cases while still
sticking to C99 for the common cases, you may have success. But at this
point, I doubt you have properly identified all the quirks where native
fma instructions differ from C99 fma() requirements, let alone the
differences in emulation that will be required to properly quirk all
possible floating point hardware.  And it's not even guaranteed that
identifying all the inputs that need special casing for various guest
hardware, before calling out to fma() in the remainder of cases, will
not slow things down (since fma() will have its own set of additional
quirking conditionals based on host hardware).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--cFFUok2VbIlwxEBXVhtg6LQ9GQhLwfLia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRZkFAAoJEKeha0olJ0NqF9YIAIeiBOi65ERsvXrJhB6yL1zQ
IRs50hnUl+jZjwRsaf559ZGY9a4rzd4PHSNbfYdJ6yc81II9/+PMecMeNkcLsNhY
0wnW7Ci7vGi0qj+GorGb2fxL1+9N3oN5gh2Y/diUpoUWjs3MNqVKQ7ABUMHAeJ5J
SlnLdtgbCMt1q/2I2EiVlEUKU4oaV3xcUAVIBDm7KfarENX/mA3RZLlMkSU6OtQw
4q+4NEAah6nJZdJ1UjOef4qhEsMa1iglPSyqF00a0rN/42be124nCS20W0CLpHD+
fPqGLquzYwnjlGzHChqsKO/VRCcK+hTKqeAM3FbyZwfhfJGVkWw2W/h3hc+fzZs=
=seKe
-----END PGP SIGNATURE-----

--cFFUok2VbIlwxEBXVhtg6LQ9GQhLwfLia--
