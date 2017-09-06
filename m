Received: from eggs.gnu.org ([2001:4830:134:3::10]:59902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dphQz-0005Rh-KS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dphQy-00029Q-Ga
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:00:29 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-13-eblake@redhat.com>
	<28a1f49b-ed07-8c46-eb0c-be9b92d106fe@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a55f8d5-b4d3-85c7-dab4-472ccc4dca52@redhat.com>
Date: Wed, 6 Sep 2017 16:00:06 -0500
MIME-Version: 1.0
In-Reply-To: <28a1f49b-ed07-8c46-eb0c-be9b92d106fe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wv8QlqHUme5KXPQ4PupFMKlIrwFwI5Bur"
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
 QPCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wv8QlqHUme5KXPQ4PupFMKlIrwFwI5Bur
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>,
 armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Message-ID: <1a55f8d5-b4d3-85c7-dab4-472ccc4dca52@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
 QPCIBus
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-13-eblake@redhat.com>
 <28a1f49b-ed07-8c46-eb0c-be9b92d106fe@redhat.com>
In-Reply-To: <28a1f49b-ed07-8c46-eb0c-be9b92d106fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 04:36 AM, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> When initializing a QPCIBus, track which QTestState the bus is
>> associated with (so that a later patch can then explicitly use
>> that test state for all communication on the bus, rather than
>> blindly relying on global_qtest).  Update the initialization
>> functions to take another parameter, and update all callers to
>> pass in state (for now, most callers get away with passing the
>> current global_qtest as the current state, although this required
>> fixing the order of initialization to ensure qtest_start() is
>> called before qpci_init*() in rtl8139-test, and provided an
>> opportunity to pass in the allocator in e1000e-test).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
> [...]
>> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
>> index 6226546c28..c95428e1cb 100644
>> --- a/tests/libqos/libqos.c
>> +++ b/tests/libqos/libqos.c
>> @@ -26,8 +26,8 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdli=
ne_fmt, va_list ap)
>>          if (ops->init_allocator) {
>>              qs->alloc =3D ops->init_allocator(ALLOC_NO_FLAGS);
>>          }
>> -        if (ops->qpci_init && qs->alloc) {
>> -            qs->pcibus =3D ops->qpci_init(qs->alloc);
>> +        if (ops->qpci_init) {
>=20
> Why did you remove the check for qs->alloc?
>=20
>> +            qs->pcibus =3D ops->qpci_init(qs->qts, qs->alloc);

Because we want to ensure qpci_init() is called to set qs->qts
(presumably, whether or not qs->alloc is set).  Furthermore, only two
files declare a 'static QOSOps' structure in the first place
(libqos-pc.c and libqos-spapr.c); where both files set both the
=2Einit_allocator and .qpci_init callbacks; a little bit of auditing show=
s
that the .init_allocator() never returns NULL (although that requires
browsing yet more files for malloc-{pc,spapr}.c).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Wv8QlqHUme5KXPQ4PupFMKlIrwFwI5Bur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwYdYACgkQp6FrSiUn
Q2oBBAf9FzZ7GON3qaSqeshuSR+dzSijCkVaQ3quuZKaCj8ecErnLrsGnLenAHVG
+NLxnegjTNsEckxxN8eUssYj9qEkOo+YDz0u6bhrAbnwrEKBxEkt+dbeLe/XbPXc
Ynqt41144os3TR2jxWGuJE+xvyORjYfOstM81EzuTam84q5YdnWLN8P83S63B70X
bwhdfEH66hoZ+rQpmYe5Q2naVHP1E437minuN92NYJZoYLe3E025GDGnaRlAyWFF
3fNr77M0zQ7tdkcVNpsrtc4kSGuxKxJa8iji2Xqf2m5FOWctmqHopau8PRGDo5hQ
fW9j8AIjLq+K6KnYkML1W9nsKRFaBw==
=IIFj
-----END PGP SIGNATURE-----

--Wv8QlqHUme5KXPQ4PupFMKlIrwFwI5Bur--
