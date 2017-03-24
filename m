Received: from eggs.gnu.org ([2001:4830:134:3::10]:38801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crPJp-0007Pq-Qd
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crPJl-0000NI-SJ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crPJl-0000M7-JQ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97C48624D9
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 13:31:48 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
	<20170323203819.GH5344@noname.redhat.com>
	<87lgrvyy6l.fsf@dusky.pond.sub.org>
	<87lgrvw06q.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8041ed21-f352-ba81-26c2-4a1e6e8c33ef@redhat.com>
Date: Fri, 24 Mar 2017 08:31:40 -0500
MIME-Version: 1.0
In-Reply-To: <87lgrvw06q.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jOmgE9sfwHsmLqDtkkSot3maPxHNu5Jxr"
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: jdurgin@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jOmgE9sfwHsmLqDtkkSot3maPxHNu5Jxr
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: jdurgin@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <8041ed21-f352-ba81-26c2-4a1e6e8c33ef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to extract
 list-valued options
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-4-git-send-email-armbru@redhat.com>
 <20170323203819.GH5344@noname.redhat.com> <87lgrvyy6l.fsf@dusky.pond.sub.org>
 <87lgrvw06q.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgrvw06q.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 03:25 AM, Markus Armbruster wrote:

>>>> -            value =3D host;
>>>> -            if (port) {

>>>> +        host =3D qstring_get_str(qobject_to_qstring(val));
>>>> +        sprintf(keybuf, "server.%d.port", i);
>>>> +        port =3D qdict_get_str(options, keybuf);
>>>
>>> This segfaults if the port option isn't given.
>>
>> @port is mandatory in BlockdevOptionsRbd.  If it's not there here, the=

>> options must have bypassed QAPI.  That would be bad news.  Can you
>> explain how it can happen?
>=20
> Answering myself, please correct mistakes.
>=20
> There are two ways to create @options:
>=20
> 1. -blockdev and blockdev-add
>=20
>    These create @options with a QAPI visitor from the command line
>    option argument or QMP arguments, respectively.  This checks them
>    against the QAPI schema.  Missing @port is rejected.
>=20
> 2. -drive and drive_add
>=20
>    These appear to create @options manually, without checking against
>    the QAPI schema.
>=20
>    Crash reproducer: -drive driver=3Drbd,server.0.host=3Ds0

Yep - and that's why the old code was checking 'if (port)'.

>=20
> In other words, we have *two* specifications for @options: the QAPI
> schema, and the union of all the QemuOptsList that apply.  In case 1, w=
e
> check against both (I think).  In case 2, we only check against the
> latter.
>=20
> I understand how we got into this state, but it's not a good state to b=
e
> in.  We need to have our options defined in one way and one way only.
>=20
> For 2.9, we cope with missing @port.

Maybe for 2.10 we would make port optional rather than mandatory - but
that's a LOT of code to audit to add in appropriate 'has_port=3Dtrue' so
it's too late to do for 2.9.  Or even better, maybe for 2.10 we finally
implement parameter defaults so that we don't need a has_port field (if
port is omitted, it gets assigned the default value).  Except that I
don't know if all the existing users of InetSocketAddress will want the
same default.  Maybe that argues that we want some way to declare a QAPI
subtype that changes the default of a field otherwise inherited from the
base class (so port is mandatory in the base class, but each instance
that wants a default port creates a new subclass with a new default value=
).

>=20
> Post 2.9, we should either finish the QAPIfication of block
> configuration we started with blockdev-add, or back it out, i.e. make
> the QAPI schema accept anything, and rely on the QemuOpts-based
> checking.
>=20
> I want us to finish QAPIfication.

I'd like to finish the QAPIfication as well.  I'm fine if port is
mandatory for QMP and -blockdev-add for 2.9, where only -drive gets away
with the default (but it DOES mean that we have to make sure that
QemuOpts created by -drive is augmented with the default before we pass
it through QAPI validation), so that back-compat of -drive omitting port
doesn't break.


>>> Of course, this also changes the behaviour so that additional options=
 in
>>> server.* and auth-supported.* aren't silently ignored any more, but w=
e
>>> complain that they are unknown. I consider this a bonus bug fix, but =
it
>>> should probably be spelt out in the commit message.
>>
>> Good point.
>=20
> Note to self: this applies to -drive / drive_add, but not to -blockdev =
/
> blockdev_add, because the QAPI schema kicks in there.  Example:
> -drive driver=3Drbd,server.0.host=3Ds0,server.0.port=3Dp0,server.0.foo=3D=
bar

Yep - another instance where -drive parsing is slightly different than
-blockdev-add parsing.  However, while tightening the parse to require
port is not back-compat friendly to -drive, I think that tightening the
parse to reject garbage given to -drive is perfectly acceptable.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jOmgE9sfwHsmLqDtkkSot3maPxHNu5Jxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1R+8AAoJEKeha0olJ0NqcOgH/RNNCZyBDs+Uw/kLFFuBJhU0
39+PGJGLOf4l9frk1ZMhrulfdUaRTvP8yV4/KJhMkEipL2GcMcb3QsuoTbWWAv0E
0EqQgY6PJuSWXsodqars1wxTgrlNp136wHLdkLhIuUlJpPdo7U+RUijeSbMSZoAy
qSpz6fB2AdpHHASKJJckVOZPyJEzrpKOREzzw//nd63QpskWqg8n/affJtoNiZAu
gSwUOmZ9wRlHUw6aCFaRX+pGkGoiL05/CKH+ebFQ+vdHLY9csRA0QlsyW1O3iLr6
lFNTrLx8SQnfiiTA3f/QmFoaEEE4EmhY9HwDADYlomG4kh5W5+T08r+zabPEjo0=
=+fpZ
-----END PGP SIGNATURE-----

--jOmgE9sfwHsmLqDtkkSot3maPxHNu5Jxr--
