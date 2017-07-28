Received: from eggs.gnu.org ([2001:4830:134:3::10]:47131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8CR-0004cL-RC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8CO-0007Qv-JS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:33:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db8CO-0007Q5-9W
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:33:12 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
	<20170728125759.GO12364@stefanha-x1.localdomain>
	<eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
Date: Fri, 28 Jul 2017 11:33:03 -0500
MIME-Version: 1.0
In-Reply-To: <eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mwIxTbSBSAMnLHl15VHGXSJqktDXFjF1q"
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mwIxTbSBSAMnLHl15VHGXSJqktDXFjF1q
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, armbru@redhat.com
Message-ID: <7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-8-eblake@redhat.com>
 <20170728125759.GO12364@stefanha-x1.localdomain>
 <eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
In-Reply-To: <eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:06 AM, Eric Blake wrote:
> On 07/28/2017 07:57 AM, Stefan Hajnoczi wrote:
>> On Tue, Jul 25, 2017 at 04:15:18PM -0500, Eric Blake wrote:
>>> +QDict *qtest_qmp_cmd(QTestState *s, const char *cmd, QObject *args)
>>> +{
>>> +    QDict *dict =3D qdict_new();
>>> +
>>> +    qdict_put_str(dict, "execute", cmd);
>>> +    if (args) {
>>> +        qdict_put_obj(dict, "arguments", args);
>>> +    }
>>> +    return qtest_qmp(s, "%p", QOBJECT(dict));
>>> +}
>>
>> qtest_qmp(s, "%p", QOBJECT(dict)) takes ownership of dict?
>=20
> Hmm, I documented that for qtest_qmp_cmd(), but you have a good
> question.  I need to double-check that it is true for
> qobject_from_jsonf("%p", obj), but my recollection is that yes, wrappin=
g
> one object inside the other means freeing the outer object also reclaim=
s
> the inner (that is, qobject_from_jsonf wasn't increasing refcount).  At=

> any rate, I'll probably have to submit a followup patch (either to fix
> the leak if I'm wrong, or to improve the documentation about %p
> reference management if I'm right).

$ valgrind --leak-check=3Dfull ./tests/check-qjson
=2E..
=3D=3D10596=3D=3D LEAK SUMMARY:
=3D=3D10596=3D=3D    definitely lost: 0 bytes in 0 blocks
=2E..
$ grep -C5 %p tests/check-qjson.c
            {}}));

    embedded_obj =3D qobject_from_json("[32, 42]", &error_abort);
    g_assert(embedded_obj !=3D NULL);

    obj =3D qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
    g_assert(compare_litqobj_to_qobj(&decoded, obj) =3D=3D 1);

    qobject_decref(obj);
}

So given the clean bill of health from valgrind, we definitely DO turn
over responsibility for freeing on object to its new wrapper, once it is
passed through %p.  Documentation could be improved to make that clear.

Eww, what happens if qobject_from_jsonf() can fail halfway through? If
you mix %p with other stuff, how do you know on failure whether the
reference was taken or not yet reached?  Maybe the testsuite needs an
enhancement.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mwIxTbSBSAMnLHl15VHGXSJqktDXFjF1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7Zz8ACgkQp6FrSiUn
Q2rwsQf9HRFM32CoZaYpLhXTNLTQnXSvcFd0XAkuCFgmW44tM2LNcfpxn+o0RAWi
KDS4NOjT7TickS75aoM4CbxxNwvZkheVM5co5mLVNHhBR0S1fTFxqQAw+mwpMydJ
B0BZ9PFln2nrtty50TUpnLIBK+4a6+jOK1GYnOdl0+ogWOQ/PcQNa0UXj9M952Cp
JtPXvXoPAHh5RORXGbC7WAwGxy/2NpVzE5/5IpfalZhyMC3YHXo9VfxDF3iD4RCi
T8G01eX2C06u8/vC471BKiRb/NlL6ycE92fVCgoPiniBUxhDAnSO+MUfJ8hxh8Pb
LLF4Gx6K1LOb53yJPlLl6ZX3J5Q3vQ==
=qcte
-----END PGP SIGNATURE-----

--mwIxTbSBSAMnLHl15VHGXSJqktDXFjF1q--
