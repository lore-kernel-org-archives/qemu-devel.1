Received: from eggs.gnu.org ([2001:4830:134:3::10]:59413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cHvnj-0001JF-Ae
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cHvnf-0004tf-EJ
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:56:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cHvnf-0004r4-32
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:56:03 -0500
References: <1478265017-5700-1-git-send-email-thuth@redhat.com>
	<87wpg5di5o.fsf@emacs.mitica> <20161117034511.GG18808@umbus.fritz.box>
	<b20c6b22-fc3a-b37a-6ea0-169be815864a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <401600f0-8a1c-22c7-b9f3-7424426ec699@redhat.com>
Date: Fri, 16 Dec 2016 17:55:52 +0100
MIME-Version: 1.0
In-Reply-To: <b20c6b22-fc3a-b37a-6ea0-169be815864a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="xIhoqGhMKftqVloGJxdB8JVtubaVD6siL"
Subject: [Qemu-devel] Is block_save_iterate() dead code? (was: migration:
 Fix return code of ram_save_iterate() )
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Juan Quintela <quintela@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xIhoqGhMKftqVloGJxdB8JVtubaVD6siL
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Juan Quintela <quintela@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <401600f0-8a1c-22c7-b9f3-7424426ec699@redhat.com>
Subject: Is block_save_iterate() dead code? (was: migration: Fix return code
 of ram_save_iterate() )
References: <1478265017-5700-1-git-send-email-thuth@redhat.com>
 <87wpg5di5o.fsf@emacs.mitica> <20161117034511.GG18808@umbus.fritz.box>
 <b20c6b22-fc3a-b37a-6ea0-169be815864a@redhat.com>
In-Reply-To: <b20c6b22-fc3a-b37a-6ea0-169be815864a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.11.2016 09:13, Thomas Huth wrote:
> On 17.11.2016 04:45, David Gibson wrote:
>> On Mon, Nov 14, 2016 at 07:34:59PM +0100, Juan Quintela wrote:
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>> qemu_savevm_state_iterate() expects the iterators to return 1
>>>> when they are done, and 0 if there is still something left to do.
>>>> However, ram_save_iterate() does not obey this rule and returns
>>>> the number of saved pages instead. This causes a fatal hang with
>>>> ppc64 guests when you run QEMU like this (also works with TCG):
>>>>
>>>>  qemu-img create -f qcow2  /tmp/test.qcow2 1M
>>>>  qemu-system-ppc64 -nographic -nodefaults -m 256 \
>>>>                    -hda /tmp/test.qcow2 -serial mon:stdio
>>>>
>>>> ... then switch to the monitor by pressing CTRL-a c and try to
>>>> save a snapshot with "savevm test1" for example.
>>>>
>>>> After the first iteration, ram_save_iterate() always returns 0 here,=

>>>> so that qemu_savevm_state_iterate() hangs in an endless loop and you=

>>>> can only "kill -9" the QEMU process.
>>>> Fix it by using proper return values in ram_save_iterate().
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>
>>> Applied.
>>>
>>> I don't know how we broked this so much.
>>
>> Note that block save iterate has the same bug...
>=20
> I think you're right. Care to send a patch?

Looking at this issue again ... could it be that block_save_iterate() is
currently just dead code?
As far as I can see, the ->save_live_iterate() handlers are only called
from qemu_savevm_state_iterate(), right? And qemu_savevm_state_iterate()
only calls the handlers if se->ops->is_active(se->opaque) returns true.
But block_is_active() seems to only return 0 during savevm, most likely
because qemu_savevm_state() explicitly sets the "blk" and "shared"
MigrationParams to zero.
So to me, it looks like we could also just remove block_save_iterate()
completely ... or did I miss something here?

 Thomas



--xIhoqGhMKftqVloGJxdB8JVtubaVD6siL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYVBydAAoJEC7Z13T+cC21BMQP/iM30WPqh1t2eCFWqZe9DYgr
cImtUTRMwv68lwGsfAHZpfN1mTkyccqdX8DkvmNeUn5cccEVcfCdjcO0vxubzpNV
18O5qg0OvFjeniSzgFIwaMUqxR/API0r1Q0m5rPdAQZi5Fp67J5Gb99PPPCVxxhA
G/GfU07Wgqj+wZS2ILGGBhLebYyF2pJY2YR4Kf+/uDJ5LVW3zbsEHeR0R/EWfcYK
oN3kMLhdpMd23aakOG2drlU7xnVQpt/zF3xFF+ksCSHZnUYo1exlEwF//9tjrwpw
jDqmldzveEP/ifGk93PlSBoxM566KnyM+oR9mf0Si6djnJ6I9HGsIayo4hSoAnOP
a0w4xjw+zveinjp9wpudRKZOS3Vy9D3hr0bYgTtRy+LxL9PRMZGmu/JplSb276u7
+iaTxyIXF5Xp9Tdi6psKTZPRwq9lTRVjoxJUU6RX9QODNaNqZ7yVnkuEEqbYyP4J
1kfcR72DvgZf/u/pmddiNy+vuo0ZZNqNksqQy/kF3FXKwK/lnMJLcSHzpfnFZk4B
T+4SX1HBUxKtMEuMhQRIsvBHeUVake5BxMEZiacEDTgi4GXu5MdV5hPfjzlkY0Vi
5hYN12uSw5o74E5xr40vNvWDp5cUSOaNc3T1y17tSHiAY62Zn00sjUSNLMhtv2Lu
S2D9lNfhhzZ5WlutZggM
=s2Uf
-----END PGP SIGNATURE-----

--xIhoqGhMKftqVloGJxdB8JVtubaVD6siL--
