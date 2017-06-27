Received: from eggs.gnu.org ([2001:4830:134:3::10]:52593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPtkX-0007Cb-0p
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPtd5-0004df-0m
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:46:20 -0400
References: <20170627163145.GC4792@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71a641e8-4701-58bf-29c5-090f30d59d91@redhat.com>
Date: Tue, 27 Jun 2017 11:46:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170627163145.GC4792@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lakpal7WdcOFKAVHJm8JrX7J5pc0FRlgG"
Subject: Re: [Qemu-devel] [RFC] QMP design: Fixing query-block and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lakpal7WdcOFKAVHJm8JrX7J5pc0FRlgG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com,
 stefanha@redhat.com
Message-ID: <71a641e8-4701-58bf-29c5-090f30d59d91@redhat.com>
Subject: Re: [RFC] QMP design: Fixing query-block and friends
References: <20170627163145.GC4792@noname.redhat.com>
In-Reply-To: <20170627163145.GC4792@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2017 11:31 AM, Kevin Wolf wrote:
> Hi,
>=20
> I haven't really liked query-block for a long time, but now that
> blockdev-add and -blockdev have settled, it might finally be the time t=
o
> actually do something about it. In fact, if used together with these
> modern interfaces, our query commands are simply broken, so we have to
> fix something.

Agreed.

>=20
> However, it appears to me that I dislike so many thing about our curren=
t
> query commands that I'm tempted to say: Throw it all away and start
> over.

I'm somewhat leaning this direction as well. We have to keep the old
commands for a while longer (if we don't want to break existing
clients), but libvirt has definitely felt some of the pain of how many
commands and parsing are required in tandem to reconstruct which BDS
node name to use for setting threshold events.

>=20
> If that's what we're going to do, I think I can figure out something
> nice for block nodes. That shouldn't be too hard. The only question
> would be whether we want a command to query one node or whether we woul=
d
> keep returning all of them.

The age-old filtering question. It's also plausible to have a single
command, with an optional argument, and which always returns an array:
the full array if the argument was omitted, or an array of one matching
the argument when one was provided.  Adding filtering is an easy patch
on top once it is proven to make life easier for a client, and I'm okay
with a first approach that does not filter.

>=20
> I am, however, a bit less confident about BBs. As I said above, I
> consider them part of the qdev devices. As far as I know, there is no
> high-level infrastructure to query runtime state of devices and qdev
> properties are supposed to be read-only. Maybe non-qdev QOM properties
> can be used somehow? But QOM isn't really nice to use as you need to
> query each property individually.
>=20
> Another option would be to have a QMP command that takes a qdev ID of a=

> block device and queries its BB. Or maybe it should stay like
> query-block and return an array of all of them, but include the qdev
> device name. Actually, maybe query-block can stay as it contains only
> two fields that are useless in the new world.

Being able to query all the devices (with their BB's, and only a name
reference to the top-level BDS in use by the BB), separately from being
able to query all BDS, seems like a reasonable thing.  After all,
sometimes you care about what the guest sees (what devices have a BB),
and sometimes you care about what the host is exposing (what BDS are in
use).

> I think this has become long enough now, so any opinions? On anything I=

> said above, but preferably also about what a new interface should look
> like?

Our existing interface is definitely awkward, with lots of redundancy in
some places and missing information in others, and a new interface does
seem like we can do better at designing it right up front rather than
bolting on yet more information to the existing queries (which results
in that much more noise to churn through to get to the desired informatio=
n).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lakpal7WdcOFKAVHJm8JrX7J5pc0FRlgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUovSAAoJEKeha0olJ0NqF6oH/A2I3NjArOWzclNfgG16nrUw
5JV+hjFzUfVCKx+cX7Ndc5mliUOH/di151sR6uVgJfkbIJaea2HCsi+SR/zjO6eq
dddKTLcBwaltyRm8Cwc5dVEBAPJLm6o4h3q026hMMqlQrEc9PO/DDv8Sfvqq9Hiu
AvRobwaIQEhR1mtYHWtpDRFQ8g8RK6sP9FVS+kHCOQaSsFpUOeJYSS/0e21ZkeEQ
39P4XTPaAZwKfYVGRzNOUsBuyzKFfU3wDnAODMxxrwDTTAYKxGk9HuRFsGrymbDf
ZAFkOpv39ugjyp+HPAgkc5MouuWBd21gdMtrGaq9SVV/9RXbNf/MV5eunX9aEq4=
=33m9
-----END PGP SIGNATURE-----

--lakpal7WdcOFKAVHJm8JrX7J5pc0FRlgG--
