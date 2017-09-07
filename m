Received: from eggs.gnu.org ([2001:4830:134:3::10]:58620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpwvd-00051Z-2t
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpwvY-0001dw-5o
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:33:09 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-13-eblake@redhat.com>
	<28a1f49b-ed07-8c46-eb0c-be9b92d106fe@redhat.com>
	<1a55f8d5-b4d3-85c7-dab4-472ccc4dca52@redhat.com>
	<a0e0335b-2d2f-6220-e2f7-24ef01bc2bad@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b601702b-1a77-27cb-64f3-ffd6f441d0b3@redhat.com>
Date: Thu, 7 Sep 2017 08:32:41 -0500
MIME-Version: 1.0
In-Reply-To: <a0e0335b-2d2f-6220-e2f7-24ef01bc2bad@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rc06sNRGVPXfGJe2kkIva9n7LTJC6mvd5"
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
--rc06sNRGVPXfGJe2kkIva9n7LTJC6mvd5
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>,
 armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Message-ID: <b601702b-1a77-27cb-64f3-ffd6f441d0b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
 QPCIBus
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-13-eblake@redhat.com>
 <28a1f49b-ed07-8c46-eb0c-be9b92d106fe@redhat.com>
 <1a55f8d5-b4d3-85c7-dab4-472ccc4dca52@redhat.com>
 <a0e0335b-2d2f-6220-e2f7-24ef01bc2bad@redhat.com>
In-Reply-To: <a0e0335b-2d2f-6220-e2f7-24ef01bc2bad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2017 12:35 AM, Thomas Huth wrote:
> On 06.09.2017 23:00, Eric Blake wrote:
>> On 09/05/2017 04:36 AM, Thomas Huth wrote:
>>> On 01.09.2017 20:03, Eric Blake wrote:
>>>> When initializing a QPCIBus, track which QTestState the bus is
>>>> associated with (so that a later patch can then explicitly use
>>>> that test state for all communication on the bus, rather than
>>>> blindly relying on global_qtest).  Update the initialization
>>>> functions to take another parameter, and update all callers to
>>>> pass in state (for now, most callers get away with passing the
>>>> current global_qtest as the current state, although this required
>>>> fixing the order of initialization to ensure qtest_start() is
>>>> called before qpci_init*() in rtl8139-test, and provided an
>>>> opportunity to pass in the allocator in e1000e-test).
>>>>

>>>
>>> Why did you remove the check for qs->alloc?
>>>
>>>> +            qs->pcibus =3D ops->qpci_init(qs->qts, qs->alloc);
>>
>> Because we want to ensure qpci_init() is called to set qs->qts
>> (presumably, whether or not qs->alloc is set).  Furthermore, only two
>> files declare a 'static QOSOps' structure in the first place
>> (libqos-pc.c and libqos-spapr.c); where both files set both the
>> .init_allocator and .qpci_init callbacks; a little bit of auditing sho=
ws
>> that the .init_allocator() never returns NULL (although that requires
>> browsing yet more files for malloc-{pc,spapr}.c).
>=20
> OK, thanks for the explanation! ... but maybe we should
> g_assert(gs->alloc) somewhere instead? ... just an idea, I'm also fine
> if you leave it away.

Users of QOSOps always supply qs->alloc, but there are tests that
successfully use NULL for qs->alloc (because they did not go through
QOSOps).  At any rate, I can certainly update the commit message.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rc06sNRGVPXfGJe2kkIva9n7LTJC6mvd5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxSnkACgkQp6FrSiUn
Q2r1sQf/QrtinnFcggT9xAf/6+fUdtySdAtHqdrOObfmLleRM/YmlQAMVtraW+JD
KkcMIKwAyeRVR0v6KhTxFcXtF91LMySLw7cWuKHKvKwV3oW1vzJVtdM5ByHdYICc
YKdLUTwtdYjczMKPu/84wKtILDCClANgOvYgudo3abc1cobTnBOAGIXQgy4a7Iku
HaOXEI4Xiuk50dAK2xSrttfQ7dYOhqTEPSjoZK0Pd8Qg9FERovGh7TJhdtD8NHQW
CGcWh9tn7iVMnh4gc/aKLMSErYF1O0V4NYmoywis+MfSQzZSt7Z7Db5Pp+BQe7RV
sLrmEInaiyklMeLX6V5DNBz4m6efdg==
=PgTy
-----END PGP SIGNATURE-----

--rc06sNRGVPXfGJe2kkIva9n7LTJC6mvd5--
