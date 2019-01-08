Received: from eggs.gnu.org ([209.51.188.92]:55353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggtAW-0004av-2R
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggtAR-0008QT-SL
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:19:51 -0500
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<8736q3ebs2.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <17bd6776-5c17-e337-3faa-ef119bc66212@redhat.com>
Date: Tue, 8 Jan 2019 09:19:35 -0600
MIME-Version: 1.0
In-Reply-To: <8736q3ebs2.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2mdwM9tjCvjw07ZG0QMKL5UmtBnBad7hS"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2mdwM9tjCvjw07ZG0QMKL5UmtBnBad7hS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <17bd6776-5c17-e337-3faa-ef119bc66212@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
References: <20190103213320.2653-1-lbloch@janustech.com>
 <20190103213320.2653-2-lbloch@janustech.com>
 <8736q3ebs2.fsf@dusky.pond.sub.org>
In-Reply-To: <8736q3ebs2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/8/19 3:31 AM, Markus Armbruster wrote:
> Copying our resident shell script guru Eric.

Who already expressed a desire to keep things hard-coded on v1 ;)

And I've also already expressed a dislike for the entire S_XXXiB macro
list, thinking that a nicer solution would instead be teaching QemuOpt
that instead of encoding all defaults as strings (where we are using
S_XXXiB strings in order to work around the fact that we have to store
the stringized value of an integer as the default), we should instead
encode defaults as an appropriate type (and then do a runtime conversion
of that type into a string when displaying the help output that shows
the default value).  But I don't know who wants to sign up for that
work, as that is already putting lipstick on a pig (we'd rather be using
Markus' work on converting command-line parsing to QAPI, rather than
expanding QemuOpts even more).  The more work we put into the S_XXXiB
table, the harder it will be to rip it out later when we do come up with
a nicer solution that does not require users to store integer defaults
as a correctly-spelled string.

>=20
> Leonid Bloch <lbloch@janustech.com> writes:
>=20
>> The lookup table for power-of-two sizes is now auto-generated during t=
he
>> build, and not hard-coded into the units.h file.
>>
>> This partially reverts commit 540b8492618eb.
>>

>=20
> I'd leave it hard-coded.  Replacing a few trivial defines by an arguabl=
y
> less trivial script doesn't feel like an improvement.  In this case, it=

> doesn't even save lines.  But I'm not the maintainer.

That's several people that have leaned towards not having a generator
script.


>> +++ b/include/qemu/units.h
>> @@ -17,77 +17,4 @@
>>  #define PiB     (INT64_C(1) << 50)
>>  #define EiB     (INT64_C(1) << 60)
>> =20
>> -/*
>> - * The following lookup table is intended to be used when a literal s=
tring of
>> - * the number of bytes is required (for example if it needs to be str=
ingified).
>> - * It can also be used for generic shortcuts of power-of-two sizes.
>> - * This table is generated using the AWK script below:
>> - *
>> - *  BEGIN {
>> - *      suffix=3D"KMGTPE";
>> - *      for(i=3D10; i<64; i++) {
>> - *          val=3D2**i;
>> - *          s=3Dsubstr(suffix, int(i/10), 1);
>> - *          n=3D2**(i%10);
>> - *          pad=3D21-int(log(n)/log(10));
>> - *          printf("#define S_%d%siB %*d\n", n, s, pad, val);
>> - *      }
>> - *  }
>=20
> If we decide not keep the defines hard-coded, I think we can delete the=

> AWK script.

Kevin also pointed out that if we keep things hard-coded, we still need
to fix the hard-coding to use correct types for the second half of the
table:

>> -#define S_4GiB            4294967296
>> -#define S_8GiB            8589934592

and even if we write a generator instead of hard-coding, our generator
also needs to make that change, which makes the generator a bit more
complicated.

>> +++ b/scripts/gen-sizes.sh
>=20
> I'm not sure I'd use shell for this, but since you already wrote it and=

> it works...
>=20
>> @@ -0,0 +1,66 @@
>> +#!/bin/sh

Note that this selects 'sh',...

>> +
>> +size_suffix() {
>> +    case ${1} in
>> +        1)
>> +            printf "KiB"
>> +            ;;
>> +        2)
>> +            printf "MiB"
>> +            ;;
>> +        3)
>> +            printf "GiB"
>> +            ;;
>> +        4)
>> +            printf "TiB"
>> +            ;;
>> +        5)
>> +            printf "PiB"
>> +            ;;
>> +        6)
>> +            printf "EiB"
>> +            ;;
>> +    esac
>> +}
>=20
> Terser:
>=20
>        suf=3D('' 'K' 'M' 'G' 'T' 'P' 'E')
>        printf "${suf[$1]}iB"

=2E..but this terser representation depends on a bash-ism, so if we did g=
o
with a generator, you'd have to fix the shebang to be bash.  The list
starts at S_1KiB, so the '' entry in suf is being used as a filler to
get indexing to work as desired.

Or, sticking to POSIX shell, you could do a similar lookup using sed:

echo XKMGTPE | sed "s/^.\{$1\}\(.\).*/\1/"

>=20
>> +
>> +print_sizes() {
>> +    local p=3D10

local is a bash-ism. So your script is already dependent on bash, unless
you drop the use of local, even without the above paragraph on
shortening the case statement into a one-liner.

>> +    while [ ${p} -lt 64 ]
>> +    do
>> +        local pad=3D' '
>> +        local n=3D$((p % 10))
>> +        n=3D$((1 << n))
>> +        [ $((n / 100)) -eq 0 ] && pad=3D'  '
>> +        [ $((n / 10)) -eq 0 ] && pad=3D'   '
>> +        local suff=3D$((p / 10))
>> +        printf "#define S_%u%s%s%20u\n" ${n} "$(size_suffix ${suff})"=
 \
>> +            "${pad}" $((1 << p))
>> +        p=3D$((p + 1))
>> +    done
>=20
> Rule of thumb: when you compute blank padding strings, you're not fully=

> exploiting printf :)
>=20
>     local p
>     for ((p=3D10; p < 64; p++))
>     do
>         local n=3D$((1 << (p % 10)))
> 	local sym=3D$(printf "S_%u%s" $n "$(size_suffix $((p / 10)))")
>         printf "#define %-8s %20u\n" $sym $((1 << p))
>     done
>=20
>> +}
>> +
>> +print_header() {
>> +    cat <<EOF
>> +/* AUTOMATICALLY GENERATED, DO NOT MODIFY.
>> + *
>> + * The following lookup table is intended to be used when a literal s=
tring of
>> + * the number of bytes is required (for example if it needs to be str=
ingified).
>> + * It can also be used for generic shortcuts of power-of-two sizes.
>> + *
>> + * Authors:
>> + *   Leonid Bloch  <lbloch@janustech.com>
>> + */

Do we still need Authors: lines in files, or can we just trust git
history (which is going to be more accurate anyway)?

>> +
>> +#ifndef QEMU_SIZES_H
>> +#define QEMU_SIZES_H
>> +
>> +EOF
>> +}
>> +
>> +print_footer() {
>> +    printf "\n#endif  /* QEMU_SIZES_H */\n"
>> +}
>> +
>> +print_header  > "${1}"
>> +print_sizes  >> "${1}"
>> +print_footer >> "${1}"
>=20
> Unchecked use of command-line arguments is not nice:
>=20
>     $ scripts/gen-sizes.sh=20
>     scripts/gen-sizes.sh: line 64: : No such file or directory
>     scripts/gen-sizes.sh: line 65: : No such file or directory
>     scripts/gen-sizes.sh: line 66: : No such file or directory
>=20
> You should error out if $# -ne 1.  But in such a simple script, I'd
> dispense with arguments and print to stdout.  Matter of taste.
> Rejecting $# -ne 0 is still nice then.

Also, do you really need to break the work into functions that get
called exactly once?  Just do the work directly.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2mdwM9tjCvjw07ZG0QMKL5UmtBnBad7hS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw0v4cACgkQ3g5py3or
ov36XAf9FHkXFktSAIacZukGTExqn/dXi8NTdo2nc5nQdfxTagO9l26d3hW/IgWd
qxbaFVgOKMBgXraDNvEqFzL0UwdzN2kn+8GTqn/cncUsNqAjtC4lwbv+0J6xxBOh
Wje9Hk08tCuI7YL+/0kuB3+cFEvVc0HX0ITEz1OjppdhQpHyw6cPwy/OczkuiTFN
ShqQnGjaCfTbtwzW1FIXeJvg/Pp+dMKtPeVQDti+QIB6sxr5YOVFYBtgEKoYsvyW
49dLRJcOxW3XYdPKynhVgzrS9pHgzWekzYpRKzLQaRvq9wlnrA8ek0rBavCdDFas
8GpH9DoCmZLfn+5TjFIApPktjFjylQ==
=Cle0
-----END PGP SIGNATURE-----

--2mdwM9tjCvjw07ZG0QMKL5UmtBnBad7hS--
