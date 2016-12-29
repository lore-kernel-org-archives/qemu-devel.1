Received: from eggs.gnu.org ([2001:4830:134:3::10]:58862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMb8M-0000DV-KC
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMb8H-0001c0-NH
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:52:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cMb8H-0001bg-F0
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:52:37 -0500
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
	<20161219010743.GA2719@lemon>
	<20161219135529.GE17374@stefanha-x1.localdomain>
	<aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
	<4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
	<f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
	<a982da67-2971-3134-de18-7d470b1fb4d2@imatronix.cl>
	<c087ebdd-e266-ceba-1390-66b2d38cab16@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <91b93233-5ba7-cc9b-7ae5-ad07ce9b2885@redhat.com>
Date: Thu, 29 Dec 2016 07:52:34 -0600
MIME-Version: 1.0
In-Reply-To: <c087ebdd-e266-ceba-1390-66b2d38cab16@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wuJ7LVsR0F9F2bNT1UU3BHBRrxEesHHxp"
Subject: Re: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Pereira <kripper@imatronix.cl>, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wuJ7LVsR0F9F2bNT1UU3BHBRrxEesHHxp
From: Eric Blake <eblake@redhat.com>
To: Christopher Pereira <kripper@imatronix.cl>,
 Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <91b93233-5ba7-cc9b-7ae5-ad07ce9b2885@redhat.com>
Subject: Re: [Qemu-devel] Can qemu reopen image files?
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
 <20161219010743.GA2719@lemon>
 <20161219135529.GE17374@stefanha-x1.localdomain>
 <aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
 <4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
 <f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
 <a982da67-2971-3134-de18-7d470b1fb4d2@imatronix.cl>
 <c087ebdd-e266-ceba-1390-66b2d38cab16@redhat.com>
In-Reply-To: <c087ebdd-e266-ceba-1390-66b2d38cab16@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/29/2016 07:42 AM, Eric Blake wrote:
> On 12/28/2016 12:51 PM, Christopher Pereira wrote:
>> Hi Eric,
>>
>> There is something I don't understand.
>>
>> We are doing: "virsh save", "qemu-img convert", "qemu-img rebase" and
>> "virsh restore".
>> We only touch the backing chain by doing the rebase while the VM is do=
wn.
>> Is there any chance this procedure can destroy data?
>=20
> Since there are never two active writers to the file (you have made sur=
e
> that qemu-img and qemu are not both holding the same file open at once)=
,
> there is no chance for corruption on that front.  There's still a
> possibility of corruption if you botch the instructions, and don't
> rebuild the chain in such a way that the guest would see the same data,=

> but that's harder to say without seeing an actual transcript.

Oh, and since you mention virsh, that means you also have libvirt
involved - anything you do to the backing chain with qemu-img is now
behind libvirt's back, so you must also make sure that you are using
'virsh edit' if necessary to update the domain XML to match the changes
you made to the backing chain.  Again, it's hard to say whether that is
a factor in your case without an actual transcript (eventually, libvirt
plans to track full backing chains even for offline domains; at the
moment, however, it only tracks full backing chains for running domains
and only the top-most image of an offline domain, which means qemu-img
changes to intermediate parts of a backing chain don't affect offline
domain XML now, but might in some future libvirt version).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wuJ7LVsR0F9F2bNT1UU3BHBRrxEesHHxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYZRUiAAoJEKeha0olJ0NqUvwH/AktSFfqS+qm/7LLnvrohpBg
3rNUJpoTwBWLqgtqaB7L6tOow3WsR/3OVby6GdDxfKjcoux8hxoPsRFKCNqo0LdH
AWfOM3dIQ0pZxJ38V1dR7Si+FNahWFhvNJ8kbH1/uhfNA3NXY1Sgt2onjKZpjiR+
+vCGMKqE2RX3E+90MazzakqJhu98gA+G5KNabyuV25NVefiRv6PYLoCtzRcTrpB8
vHGzZMA9zq689ix8jaEodOCaQ0ZgrIEsxBeaYjwfg6qePkusIZXjB/jY/u58sDLl
BCJdF5lRll4Iuej6DaMiMfBzK/ODBPZW1CQ9MW9GJIOHbgDkDV5JOhoPfZNv0Pg=
=nCch
-----END PGP SIGNATURE-----

--wuJ7LVsR0F9F2bNT1UU3BHBRrxEesHHxp--
