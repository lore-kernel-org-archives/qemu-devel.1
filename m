Received: from eggs.gnu.org ([2001:4830:134:3::10]:58387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxzqZ-0002j7-GO
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxzqY-00064B-D9
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:44:55 -0400
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-10-eblake@redhat.com>
	<87k26q50ml.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10864569-1d04-6ea7-9507-85ddb35122d2@redhat.com>
Date: Tue, 11 Apr 2017 12:44:42 -0500
MIME-Version: 1.0
In-Reply-To: <87k26q50ml.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dgv0tLpsUCUtK0teMP8ccssQP5aSnOEAk"
Subject: Re: [Qemu-devel] [PATCH v3 09/13] qobject: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, Stefano Stabellini <sstabellini@kernel.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dgv0tLpsUCUtK0teMP8ccssQP5aSnOEAk
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alexander Graf <agraf@suse.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <10864569-1d04-6ea7-9507-85ddb35122d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/13] qobject: Use simpler QDict/QList
 scalar insertion macros
References: <20170405194741.18956-1-eblake@redhat.com>
 <20170405194741.18956-10-eblake@redhat.com>
 <87k26q50ml.fsf@dusky.pond.sub.org>
In-Reply-To: <87k26q50ml.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 12:12 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> We now have macros in place to make it less verbose to add a scalar
>> to QDict and QList, so use them.  To make this patch smaller to
>> review, a couple of subdirectories were done in earlier patches.
>>
>> Patch created mechanically via:
>>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>>     --macro-file scripts/cocci-macro-file.h --dir . --in-place
>> and needed only one touch-up in monitor.c to avoid a long line.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block.c                   | 45 +++++++++++++++++++-------------------=
-------
>>  blockdev.c                | 30 +++++++++++++-----------------
>>  hw/block/xen_disk.c       |  2 +-
>>  hw/usb/xen-usb.c          | 12 ++++++------
>>  monitor.c                 | 23 +++++++++++------------
>>  qapi/qmp-event.c          |  2 +-
>>  qemu-img.c                |  6 +++---
>>  qemu-io.c                 |  2 +-
>>  qemu-nbd.c                |  2 +-
>>  qobject/qdict.c           |  2 +-
>>  target/s390x/cpu_models.c |  4 ++--
>>  util/qemu-option.c        |  2 +-
>>  12 files changed, 60 insertions(+), 72 deletions(-)
>=20
> Looks like you intent is to split the application of qobject.cocci into=

> block [PATCH 07], tests [PATCH 08] and rest [PATCH 09, i.e. this one].
> Okay, although everything on one patch would also be okay for me.
> However, this patch also contains block stuff: block.c blockdev.c
> qemu-{img,io,nbd}.c.  Move to PATCH 07?

Can do either way, although I'd have to tweak the commit message's
sample command lines I used for the split if you like it kept separate.
Maybe even just a comment in patch 07 that 'only files under block/ are
touched here; other block-related patches will be fixed in the remaining
global cleanup'.

Do you have a preference?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dgv0tLpsUCUtK0teMP8ccssQP5aSnOEAk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7RYKAAoJEKeha0olJ0Nq2iAH/2ACoGmfI5+4dIZv55+uTcOo
5+8JwtVIXTMmD0mOfqg0MyAOF2p4gZWWCy7bDsTJ/6lWim754UsEI1c92kHhqB63
3O/iL3hIKkY2gR36bU2y+TvpkHSfkPneyIqW5RvxdcAIMslpAes0ywvhdROtj0Dc
g1apztKXnmFDSG2qCPyidPYCA9Hb+DH0GPceIGHUAYKg/bOxC4F8EhPnKBcJ4z63
vO43A+J+ha7XUvKEr5zNz3T+cGg9a7DuF6uVMHoMSpjATW0+GFk9dJ2Hzh5gC0fx
3IywywY9dkeRLBfx3fyw8Ok0mqJZMQSJQHmDGNVaoJPM+mDP7Azkyy7fgYHbwmU=
=6zAQ
-----END PGP SIGNATURE-----

--dgv0tLpsUCUtK0teMP8ccssQP5aSnOEAk--
