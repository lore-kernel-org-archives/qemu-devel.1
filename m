Received: from eggs.gnu.org ([2001:4830:134:3::10]:46903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzm6G-0002BI-Jr
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzm6F-0006DF-MB
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:00:44 -0400
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
	<e77d7b78-a2ff-51a3-360e-c7d5d4e7006b@redhat.com>
	<7735fee8-dcc0-edc1-2fd3-f2aee7fe2df1@virtuozzo.com>
	<20171003162921.GB2335@work-vm>
	<418e65f7-faae-2e78-2170-2721bd6b2305@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a1df411-c809-cc3e-6471-fd6cc1653bd0@redhat.com>
Date: Wed, 4 Oct 2017 11:00:09 -0500
MIME-Version: 1.0
In-Reply-To: <418e65f7-faae-2e78-2170-2721bd6b2305@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ikH9V3tdX8uKpHe0U1CUp6aA3upaXDKgt"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] virtio: introduce `query-virtio'
 QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ikH9V3tdX8uKpHe0U1CUp6aA3upaXDKgt
From: Eric Blake <eblake@redhat.com>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
Message-ID: <2a1df411-c809-cc3e-6471-fd6cc1653bd0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] virtio: introduce `query-virtio' QMP
 command
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
 <e77d7b78-a2ff-51a3-360e-c7d5d4e7006b@redhat.com>
 <7735fee8-dcc0-edc1-2fd3-f2aee7fe2df1@virtuozzo.com>
 <20171003162921.GB2335@work-vm>
 <418e65f7-faae-2e78-2170-2721bd6b2305@virtuozzo.com>
In-Reply-To: <418e65f7-faae-2e78-2170-2721bd6b2305@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2017 09:26 AM, Jan Dakinevich wrote:

>>>>> +{
>>>>> +    'struct': 'VirtioInfo',
>>>>> +    'data': {
>>>>> +        'feature-names': ['VirtioInfoBit'],
>>>>
>>>> Why is feature-names listed at two different nestings of the return =
value?
>>>>
>>>
>>> These are different feature names. First names are common and predefi=
ned
>>> for all devices. Second names are device-specific.
>>
>> If you can turn these into enums (union'd enums?) then you might
>> be able to get rid of a lot of your array filling/naming conversion
>> boilerplate. (Not sure if it's worth it, but it's worth looking).
>>
>=20
> I would be happy to drop this boilerplate, but how enum could help here=
?
> To respond my requirement it should be something like set, not enum.
> Even so, having set, I would have been needed to declare mapping betwee=
n
> names in set type and bit numbers within feature bitmask.

Instead of returning a bitmask ("mask":123) as well as an array naming
those bits
([{"bit":1,"name":"bit1"},{"bit":2","name":"bit2"},{"bit":4,"name":"bit4}=
,...]),
you could omit the bit numbers and just return an array of named bits
(["bit1", "bit2", "bit4"]).  An enum lets you declare up front what
named bits are supported (and code can introspect when new named bits
are supported in newer qemu).

Perhaps it's easier to first take a step back, and show what the desired
output might be like, and then we can figure out how to represent that
output in QAPI.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ikH9V3tdX8uKpHe0U1CUp6aA3upaXDKgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnVBYkACgkQp6FrSiUn
Q2pxlgf/RknM2Udm+1vj1HG7MKawNEF66M2I98Z3gtKoQLUg2yO60rue9tmUmdMz
rVVmnegz2wM4kKMytIgY2k2T+6VvvAv7LF18WIy1IMUODowPLMGsIcG5/TWkn9hl
mqNdDQ09kTDUKBxfqCkXAMNqFYxFR6tMFlRsxLFwrauefrfRD/orGq8zfZ6IJbaZ
741d7HlK4NUbj1t1zSyY13PZGeSWza7GYgFbmXG6WK7sd0nBru7kkMeYvxTv0RkR
ebi40VROnZRmXfYh31Pqf1Sk0EbnWVCDXNtskFZPAuE2zHUPb3XopdRL+K7Al2gA
C7k/K+LuaaePEA0nyRfzS/hSMjjPmA==
=UxdR
-----END PGP SIGNATURE-----

--ikH9V3tdX8uKpHe0U1CUp6aA3upaXDKgt--
