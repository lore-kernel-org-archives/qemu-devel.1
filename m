Received: from eggs.gnu.org ([2001:4830:134:3::10]:48018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df4EU-0004DM-SD
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df4EP-0008Eg-Me
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1df4EP-0008EP-Bp
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:07:33 -0400
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
	<20170717102642.GG2106@work-vm>
	<c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
	<CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
	<9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
	<20170808125337.GO16801@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <973607aa-a7b3-523c-7983-8a7dd254ff1d@redhat.com>
Date: Tue, 8 Aug 2017 15:07:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170808125337.GO16801@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ARuQBsCCHc1kTaUQtguOAcb9m85Thv7EU"
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Prasad Pandit <ppandit@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ARuQBsCCHc1kTaUQtguOAcb9m85Thv7EU
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Message-ID: <973607aa-a7b3-523c-7983-8a7dd254ff1d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
References: <20170713190116.21608-1-dgilbert@redhat.com>
 <20170717101703.GH7163@stefanha-x1.localdomain>
 <20170717102642.GG2106@work-vm>
 <c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
 <CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
 <9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
 <20170808125337.GO16801@stefanha-x1.localdomain>
In-Reply-To: <20170808125337.GO16801@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 14:53, Stefan Hajnoczi wrote:
> On Fri, Aug 04, 2017 at 01:46:17PM +0200, Paolo Bonzini wrote:
>> On 04/08/2017 11:58, Stefan Hajnoczi wrote:
>>>> the root cause of this bug is related to this as well:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02945.html
>>>>
>>>> From commit 99723548 we started assuming (incorrectly?) that blk_
>>>> functions always WILL have an attached BDS, but this is not always t=
rue,
>>>> for instance, flushing the cache from an empty CDROM.
>>>>
>>>> Paolo, can we move the flight counter increment outside of the
>>>> block-backend layer, is that safe?
>>> I think the bdrv_inc_in_flight(blk_bs(blk)) needs to be fixed
>>> regardless of the throttling timer issue discussed below.  BB cannot
>>> assume that the BDS graph is non-empty.
>>
>> Can we make bdrv_aio_* return NULL (even temporarily) if there is no
>> attached BDS?  That would make it much easier to fix.
>=20
> There are many blk_aio_*() callers.  Returning NULL forces them to
> perform extra error handling.

Most of them either are for non-removable devices and check for a
non-empty BB at startup.  The others (ide-cd and scsi-cd, sd) check the
BlockBackend's blk_is_available or blk_is_inserted state themselves.

It does require some auditing of course, remember that anything that
would return NULL, would now be crashing already in bdrv_inc_in_flight.
We'd be seeing NULL pointer dereferences left and right, if it were so ba=
d.

> When you say "temporarily" do you mean it returns NULL but schedules a
> one-shot BH to invoke the callback?  I wonder if we can use a singleton=

> aiocb instead of NULL for -ENOMEDIUM errors.

No, I mean undoing that in 2.11.

Paolo


--ARuQBsCCHc1kTaUQtguOAcb9m85Thv7EU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlmJt4UACgkQv/vSX3jH
roOzGAf/Q1e58ZaEvl7b0C8yYTFapBxsQASpR4ATABiLvfM0EP4eipRnnr+2VH5T
zO5ZsS3a5d/WWUKWDy1RZOFOQoIIPZRB3OvEt7tztsZ0CZ64/XY9ypbQcjuckuIp
iIFt8AhbXS8h/h0wHIxz+5HdOrSw9xcBiLfFdbfnsXt9H8yuTzHAf5HG506+jdQw
G+djrXJ4o2uuMkfJluOvwVSPPkTq3LZ9sE5q0E0Gdu1Jg4B8yNXxgHW5xqd7U0Wq
F0CF00TJeNLMmZbhec+PZV1I+DZXMamd3h2sEzySd3tAUoCtMlh/vK8/iny5fOxl
CWEwIBRgS4wsx/q/l0rGRjhITjHTjA==
=u3fP
-----END PGP SIGNATURE-----

--ARuQBsCCHc1kTaUQtguOAcb9m85Thv7EU--
