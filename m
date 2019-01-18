Received: from eggs.gnu.org ([209.51.188.92]:35500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWoD-0000p5-3G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWoC-00064X-5t
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:15:53 -0500
References: <20190117153321.29749-1-eblake@redhat.com>
	<20190117153321.29749-3-eblake@redhat.com>
	<38115456-3a5e-4a5f-d836-fab3aa666114@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f12cf058-3236-0456-0588-301cae9889b5@redhat.com>
Date: Fri, 18 Jan 2019 10:15:32 -0600
MIME-Version: 1.0
In-Reply-To: <38115456-3a5e-4a5f-d836-fab3aa666114@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NW9VfrLRAoKLA0iD7cqwYK9nYHTmZNoij"
Subject: Re: [Qemu-devel] [PATCH 2/3] file: Expose some protocol-specific
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:raw" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NW9VfrLRAoKLA0iD7cqwYK9nYHTmZNoij
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "open list:raw"
 <qemu-block@nongnu.org>
Message-ID: <f12cf058-3236-0456-0588-301cae9889b5@redhat.com>
Subject: Re: [PATCH 2/3] file: Expose some protocol-specific information
References: <20190117153321.29749-1-eblake@redhat.com>
 <20190117153321.29749-3-eblake@redhat.com>
 <38115456-3a5e-4a5f-d836-fab3aa666114@virtuozzo.com>
In-Reply-To: <38115456-3a5e-4a5f-d836-fab3aa666114@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 8:08 AM, Vladimir Sementsov-Ogievskiy wrote:

>>
>> +##
>> +# @ImageInfoSpecificFile:
>> +#
>> +# Details about a file protocol BDS.
>> +#
>> +# @align: Alignment in use
>> +#
>> +# @discard: True if discard operations can be attempted
>> +#
>> +# @write-zero: True if efficient write zero operations can be attempt=
ed
>> +#
>> +# @discard-zero: True if discarding is known to read back as zero
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'struct': 'ImageInfoSpecificFile',
>> +  'data': { 'align': 'int', 'discard': 'bool', 'write-zero': 'bool',
>> +            '*discard-zero': 'bool' } }
>=20
> Not sure if this works, as I remember raw-posix will adjust these field=
s
> on first failed write, and without this first write, we will not actual=
ly
> know are they supported.

Indeed. We could make them a tri-state enum instead of a bool (unknown,
supported, unsupported) - but it would require code tweaks to use the
tri-state in the code too (basically, treat unknown and supported as a
request to try on the first write that needs it; and change unknown to
supported or unsupported after that first write).  Then again, I worded
it as "can be attempted", not "known to work", so while it is indeed
non-helpful for 'qemu-img info' (because the attempt wasn't resolved
into something known for sure), it DOES help a long-running qemu process
when querying the same information over QMP (where such writes have
probably been attempted in the past).

Again, this series is more of an RFC on what do we really want to expose
to the user, and when; and not necessarily a hard commitment that this
is the best struct.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NW9VfrLRAoKLA0iD7cqwYK9nYHTmZNoij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxB+6QACgkQp6FrSiUn
Q2pfqAf/SdpXc8IYcn/SlC6bB6ga8YWl/ee7dWScfbkseap2TR8/HazJ8R2OuQ6E
EFUfqV+wRH1tOjFwoWiubNdV40eAEKe5bJmIilfeOpCt7D0vwO1xLFtAIgQX2gP3
9u4Nc8boOV/VgcIvhMdbBAtgl703w4f6pvBqWaY7vg7U38bcz+in9tb9l99PcpZk
tioaBGS8y2GAToSavC9VRW3mjeG1BT+iaX8JTte6KybKnBEa762EwTsX63cVSeif
yr8uKJgzHH7VQ66NFM0LpzlyiBG6gW7U9IzBI7XW3tnv+OZrg0Jg8mWgITPZhcVQ
rNnciY4KjeiFegwV9UCL2y5Uo/IiHw==
=YNFF
-----END PGP SIGNATURE-----

--NW9VfrLRAoKLA0iD7cqwYK9nYHTmZNoij--
