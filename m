Received: from eggs.gnu.org ([209.51.188.92]:51051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghzb3-0002pU-RI
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghzb2-0007Ao-CU
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:23:49 -0500
References: <20190110191901.5082-1-eblake@redhat.com>
	<20190110191901.5082-2-eblake@redhat.com>
	<ee3dcc5c-23f6-e953-36f1-643c86bccbc0@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <236fdb34-e6e6-77bc-87e8-832ad2a6f1bd@redhat.com>
Date: Fri, 11 Jan 2019 10:23:26 -0600
MIME-Version: 1.0
In-Reply-To: <ee3dcc5c-23f6-e953-36f1-643c86bccbc0@janustech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="adeih1k2bNNG0HCTF1NtB6aUtmOLQKfVH"
Subject: Re: [Qemu-devel] [PATCH v3 1/6] qemu-option: Allow integer defaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--adeih1k2bNNG0HCTF1NtB6aUtmOLQKfVH
From: Eric Blake <eblake@redhat.com>
To: Leonid Bloch <lbloch@janustech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <236fdb34-e6e6-77bc-87e8-832ad2a6f1bd@redhat.com>
Subject: Re: [PATCH v3 1/6] qemu-option: Allow integer defaults
References: <20190110191901.5082-1-eblake@redhat.com>
 <20190110191901.5082-2-eblake@redhat.com>
 <ee3dcc5c-23f6-e953-36f1-643c86bccbc0@janustech.com>
In-Reply-To: <ee3dcc5c-23f6-e953-36f1-643c86bccbc0@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 8:14 AM, Leonid Bloch wrote:
> On 1/10/19 9:18 PM, Eric Blake wrote:
>> Set the framework up for declaring integer options with an integer
>> default, instead of our current insane approach of requiring the
>> default value to be given as a string (which then has to be reparsed
>> at every use that wants a number).  git grep '[^.]def_value_str' says
>> that we have done a good job of NOT abusing the internal field
>> outside of the implementation in qemu-option.c; therefore, it is not
>> too hard to audit that all code can either handle the new integer
>> defaults correctly or abort because a caller violated constraints.
>> Sadly, we DO have a constraint that qemu_opt_get() should not be
>> called on an option that has an integer type, because we have no
>> where to stash a cached const char * result; but callers that want
>> an integer should be using qemu_opt_get_number() and friends
>> anyways.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   include/qemu/option.h | 12 ++++++++
>>   util/qemu-option.c    | 69 +++++++++++++++++++++++++++++++++++++----=
--
>>   2 files changed, 72 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/qemu/option.h b/include/qemu/option.h
>> index 844587cab39..46b80d5a6e1 100644
>> --- a/include/qemu/option.h
>> +++ b/include/qemu/option.h
>> @@ -46,6 +46,18 @@ typedef struct QemuOptDesc {
>>       const char *name;
>>       enum QemuOptType type;
>>       const char *help;
>> +    /*
>> +     * For QEMU_OPT_STRING: Leave def_value_int 0, and set def_value_=
str
>> +     * to a default value or leave NULL for no default.
>> +     *
>> +     * For other types: Initialize at most non-zero def_value_int or =
a
>> +     * parseable def_value_str for a default (must use a string for a=
n
>> +     * explicit default of 0, although an implicit default generally
>> +     * works).  If setting def_value_int, calling qemu_opt_get() on
>> +     * that option will abort(); instead, call qemu_opt_get_del() or =
a
>> +     * typed getter.
>> +     */
>> +    uint64_t def_value_int;
>>       const char *def_value_str;
>>   } QemuOptDesc;
>>

>=20
> If I understand correctly, the number will still be compiled into the=20
> binary as an expression string, but will be printed correctly during=20
> runtime?

Anyone that uses .def_value_int will compile into the binary as an
8-byte integer (regardless of how that number was spelled in C, either
as a single constant, or as a constant expression), and NOT as a decimal
string.  String conversions for code that asks for a string will happen
by a runtime printf() (ideally, such code is limited to the case of
printing out information during help output).  Code that is smart enough
to request a number now gets the default value directly, rather than the
old way of having to strtoll() decode a decimal string back into a
number.  No one should ever be using .def_value_str =3D stringify(macro),=

when they can instead just use .def_value_int =3D macro (which is what th=
e
next patch fixes).

I split the addition of def_value_int from the use in order to ease revie=
w.

> If so, it still doesn't feel right to put expressions in binaries, but =
I=20
> agree that it's more elegant than my solution with the lookup table. I'=
d=20
> say the table would be more elegant if there would be more cases in=20
> which it's needed, but that's not the case.
>=20
> The solution which Markus described as "attractively stupid" also could=
=20
> work, as there are exactly 2 places (which I know of) where it's really=
=20
> needed. Also, absolutely no changes is an option, as was mentioned befo=
re.


Markus' suggestion boils down to forgoing patch 1 and 2, rewriting patch
3 and 4 to use hard-coded strings in the two spots that need them (more
of a maintenance burden - if we ever change the macro's value, we have
to also remember to change the string), but keeping patch 5 and 6 as-is.
 It's a smaller diffstat, but less type-safe, and thus a slightly larger
maintenance burden (more technical debt).  My approach is to get rid of
the technical debt (use more type safety, so that we can catch bugs
sooner, and avoid the risk of duplicated values getting out of sync ifa
future patch changes a macro but not the corresponding string). I also
replied to my thread about how we can make further enhancements by even
more patches to FORCE that all integer-typed defaults use only
def_value_int, all string-typed defaults use only def_value_str, at
which point we could switch to using a union for def_value_str/int once
we are sure our code base properly follows the safe typing rules.  But
of course, doing it right costs more time up front (we're avoiding
technical debt, but the patch is bigger and has to be reviewed).  So now
it boils down to Markus' opinion on whether adding type-safe defaults to
QemuOpts is worth it for less technical debt, or if it is adding too
much burden to the fact that we already know that QemuOpts is a hack and
we want to get rid of it in favor of QAPI.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--adeih1k2bNNG0HCTF1NtB6aUtmOLQKfVH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4wv4ACgkQp6FrSiUn
Q2o5Zwf/Uun3sC4weNw+Oy3NOzwbuy5K1Tw9N7nwXmrnRJ6HivynOIHhfuQi6+C4
vuJHZc5uI+cTad1m49l05/UmzeSVyuEVpOG4VvtoYh7awCa4MzpvhpFTYFD1kfeK
7xrY1wjdf8dkD/rhEOe4uYD9UDivX6rE9TONtW71d/CIePjKTVQYY+zW1EIp4lli
lt4iZIDePOjXZLVFgi6QiFCpXvNtugMLqV8nF2R+xJxjxbOWHQ5K3u/gxqK1G3zo
T2+vI/HYoA1aK2oQqsAJ/bJEpG7odAx0j8LJjABOUmoSoTrXIcAmi1nscw5a8yCh
GqM7S+zPc13G+JvqlTwoP+G7MXRHWA==
=5SF6
-----END PGP SIGNATURE-----

--adeih1k2bNNG0HCTF1NtB6aUtmOLQKfVH--
