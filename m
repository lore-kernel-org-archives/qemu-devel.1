Received: from eggs.gnu.org ([2001:4830:134:3::10]:37845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6tk-0001Fc-9A
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6tj-00067t-4t
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:30:40 -0500
References: <20180124061728.GA99621@localhost>
	<d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
	<20180125045926.GA4720@localhost>
	<b54574f8-ff1a-24bd-f86f-d908447c3459@redhat.com>
	<20180126064647.GA12068@localhost>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6f06c50-8b50-809c-0c7d-770db232d762@redhat.com>
Date: Fri, 26 Jan 2018 08:04:08 -0600
MIME-Version: 1.0
In-Reply-To: <20180126064647.GA12068@localhost>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hk8jEKSXcRzlkHWM2XcNLdowlYbOgkP6Q"
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM
 has heavy BLK IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liliang.opensource@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hk8jEKSXcRzlkHWM2XcNLdowlYbOgkP6Q
From: Eric Blake <eblake@redhat.com>
To: Liang Li <liliang.opensource@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <b6f06c50-8b50-809c-0c7d-770db232d762@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM has
 heavy BLK IO
References: <20180124061728.GA99621@localhost>
 <d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
 <20180125045926.GA4720@localhost>
 <b54574f8-ff1a-24bd-f86f-d908447c3459@redhat.com>
 <20180126064647.GA12068@localhost>
In-Reply-To: <20180126064647.GA12068@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 12:46 AM, Liang Li wrote:
> The current QMP command is:
>=20
> { 'command': 'block-job-cancel', 'data': { 'device': 'str', '*force': '=
bool' } }
>=20
> 'force' has other meaning which is not used by libvirt, for the change,=
 there
> are 3 options:
>=20
> a. Now that 'force' is not used by libvirt and it current semantic is n=
ot very useful,
> we can change it's semantic to force-quit without syncing.

The current semantics are:

# @force: whether to allow cancellation of a paused job (default
#         false).  Since 1.3.

You are right that libvirt is not using it at the moment; but that
doesn't tell us whether someone else is using it.  On the other hand, it
is a fairly easy argument to make that "a job which is paused is not
complete, so forcing it to cancel means an unclean image left behind",
which can then be reformulated as "the force flag says to cancel
immediately, whether the job is paused or has pending data, and thus
leave an unclean image behind".  In other words, I don't think it is too
bad to just tidy up the wording, and allow the existing 'force':true
parameter to be enabled to quit a job that won't converge.

>=20
> b. change 'force' from bool to flag, and bit 0 is used for it's origina=
l meaning.

Not possible.  You can't change from 'force':true to 'force':1 in JSON,
at least not without rewriting the command to use an alternate that
accepts both bool and int (actually, I seem to recall that we tightened
QAPI to not permit alternates that might be ambiguous when parsed by
QemuOpts, which may mean that is not even possible - although I haven't
tried to see if it works or gives an error).

>=20
> c. add another bool parameter.

Also doable, if we are concerned that existing semantics of 'force'
affecting only paused jobs must be preserved.

>=20
>=20
> which is the best one?

1 is slightly less code, but 3 is more conservative.  I'd be okay with
option 1 if no one else can provide a reason why it would break something=
=2E

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hk8jEKSXcRzlkHWM2XcNLdowlYbOgkP6Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprNVgACgkQp6FrSiUn
Q2oQTwf+PCpwdpeeB8dNtVbjl3ZRbZLDW+QF7kqvAHeBbzy9ZeTCU6N4Y7E11kn4
llFBMvZvK8yUpgCY+GIkUhLuCPOzbkKIW73dnURwHp0dhfv1BBj7vyU7GHe6v38W
Wr5O99bQUvl+QiAjbQk9YDL265HpB+jE5X3rSH0cWbpmV2gRWtByOTycBKC74dnd
LKE2fEZNXXiPWQcW7rkbqQ/R0z7V94ofxNYaRZHk8eExTg6v9h9mmI/Zf4AHzWdB
7ZiC08tBpYPuEn43EznYFf0GxDwzeoPYit2KGBFosqgagpowzKJP4bDFKPbou836
a2xJTxk8p0+oVcUeqfzAlXog3y7YaA==
=zO9Y
-----END PGP SIGNATURE-----

--Hk8jEKSXcRzlkHWM2XcNLdowlYbOgkP6Q--
