Received: from eggs.gnu.org ([2001:4830:134:3::10]:58077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5WS-0006JE-Cr
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5WR-0006wE-1X
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:30:16 -0400
References: <20170703180950.9895-1-eblake@redhat.com>
	<20170808135407.GK4850@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3458a2d-3643-d69e-611f-3832ad8f24b4@redhat.com>
Date: Tue, 8 Aug 2017 09:29:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170808135407.GK4850@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CwH42Qkpk7nkWRbR8sumhtausm9Dm2W8W"
Subject: Re: [Qemu-devel] [PATCH v4] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CwH42Qkpk7nkWRbR8sumhtausm9Dm2W8W
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, stefanha@redhat.com,
 mreitz@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <b3458a2d-3643-d69e-611f-3832ad8f24b4@redhat.com>
Subject: Re: [PATCH v4] tests: Avoid non-portable 'echo -ARG'
References: <20170703180950.9895-1-eblake@redhat.com>
 <20170808135407.GK4850@dhcp-200-186.str.redhat.com>
In-Reply-To: <20170808135407.GK4850@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 08:54 AM, Kevin Wolf wrote:
> Am 03.07.2017 um 20:09 hat Eric Blake geschrieben:
>> POSIX says that backslashes in the arguments to 'echo', as well as
>> any use of 'echo -n' and 'echo -e', are non-portable; it recommends
>> people should favor 'printf' instead.  This is definitely true where
>> we do not control which shell is running (such as in makefile snippets=

>> or in documentation examples).  But even for scripts where we
>> require bash (and therefore, where echo does what we want by default),=

>> it is still possible to use 'shopt -s xpg_echo' to change bash's
>> behavior of echo.  And setting a good example never hurts when we are
>> not sure if a snippet will be copied from a bash-only script to a
>> general shell script (although I don't change the use of non-portable
>> \e for ESC when we know the running shell is bash).
>>

>> +++ b/tests/multiboot/run_test.sh
>> @@ -26,7 +26,7 @@ run_qemu() {
>>      local kernel=3D$1
>>      shift
>>
>> -    echo -e "\n\n=3D=3D=3D Running test case: $kernel $@ =3D=3D=3D\n"=
 >> test.log
>> +    printf %b "\n\n=3D=3D=3D Running test case: $kernel $@ =3D=3D=3D\=
n\n" >> test.log
>>
>>      $QEMU \
>>          -kernel $kernel \
>=20
> Not completely sure why, but this broke the test with whitespace change=
s
> like this:
>=20
> -=3D=3D=3D Running test case: mmap.elf -m 1.1M =3D=3D=3D
> +=3D=3D=3D Running test case: mmap.elf -m1.1M =3D=3D=3D

I guess that means I'm not regularly running tests/multiboot?  Is it not
part of 'make check' or qemu-iotests?

Ah, I see the problem, and it's insidious.  We're using "...$@...", but
want to be using "...$*...".  $@ causes multiple arguments to be passed,
but printf %b is not concatenating those arguments; while $* uses only a
single argument.  We didn't notice it with echo -e, because echo inserts
a space between multiple arguments, just as you'd get a space with $*.

Fix coming up.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CwH42Qkpk7nkWRbR8sumhtausm9Dm2W8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJyuYACgkQp6FrSiUn
Q2qhBQf/TP2Yr/to2JogQb5ylBzDp/uxHRxDjRg01dASZeZ43TsVv6c7HEi2HwO1
+4L+dRIfpkbdh2EGa20v1wfnLsi9JtumuR6Wdnp90amz0SwGcak3IJqlNzw2uaFb
scC+x5txP6rbo1HCfCOQuU93Rp2TYN//zZmX9VzonXsEJSBS9QigcS3p+Ld7CdIO
MezNzFUAJp0qTCAb5vKHh1KN/9FYI5817My839KDPX7zvWlr247uoiJkKsRgiCqh
+r7ddH6u7DMxCZCTLXksWE+rnn9De+gUJ8byUibXqSxbvwbmTgqHOSp+JUW9EdRE
Cw9D7yDuovVimLSzXtnA1AYxa5LeWw==
=PTOa
-----END PGP SIGNATURE-----

--CwH42Qkpk7nkWRbR8sumhtausm9Dm2W8W--
