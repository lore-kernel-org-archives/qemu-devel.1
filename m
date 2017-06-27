Received: from eggs.gnu.org ([2001:4830:134:3::10]:59418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgRu-00086X-UA
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgRr-000410-P0
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPgRr-00040g-FP
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:41:51 -0400
References: <20170615141715.17708-1-sferdjao@redhat.com>
	<20170615141715.17708-2-sferdjao@redhat.com>
	<2bb5a8a3-37c9-3dd2-4483-c8a2fed5bb4d@redhat.com>
	<20170618031516.GN22043@thinpad.lan.raisama.net>
	<8965c06b-0859-0819-1fc4-d09dd287fec8@redhat.com>
	<20170627022421.GT12152@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ecaf1a4-1308-0669-3468-f9883172da61@redhat.com>
Date: Mon, 26 Jun 2017 21:41:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170627022421.GT12152@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AHMvLwXGX9eqwortULvJ1Um4KRBxkogvD"
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu: add capability for vhost-net
 busy polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Laine Stump <laine@redhat.com>, libvir-list@redhat.com, sferdjao@redhat.com, berrange@redhat.com, Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AHMvLwXGX9eqwortULvJ1Um4KRBxkogvD
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Laine Stump <laine@redhat.com>, libvir-list@redhat.com,
 sferdjao@redhat.com, berrange@redhat.com,
 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Message-ID: <5ecaf1a4-1308-0669-3468-f9883172da61@redhat.com>
Subject: Re: [PATCH 1/3] qemu: add capability for vhost-net busy polling
References: <20170615141715.17708-1-sferdjao@redhat.com>
 <20170615141715.17708-2-sferdjao@redhat.com>
 <2bb5a8a3-37c9-3dd2-4483-c8a2fed5bb4d@redhat.com>
 <20170618031516.GN22043@thinpad.lan.raisama.net>
 <8965c06b-0859-0819-1fc4-d09dd287fec8@redhat.com>
 <20170627022421.GT12152@localhost.localdomain>
In-Reply-To: <20170627022421.GT12152@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/26/2017 09:24 PM, Eduardo Habkost wrote:
>> I've posted patches in the past (qemu 2.6 timeframe, if I recall) that=

>> changed netdev_add into a fully-advertised interface, but we didn't ta=
ke
>> it then because we weren't sure how to handle the fact that netdev_add=

>> can currently accept both an integer (1) and a string ("1") as
>> identical, and we didn't want to risk breaking clients that passed a
>> string when the promoted command would only accept integers.  I guess =
we
>> should revive that.
>>
>>>
>>> Markus, Eric, Michael: is there any way libvirt can query the
>>> definition of union Netdev from the schema with current QEMU?
>>
>> Really, we need to promote netdev_add to a full-fledged QMP command.

Remember, netdev_add and object_add are the only two outlier QMP
commands that have NOT been converted to use QAPI.  We've already done
most of the work at making QMP netdev_add and command line -netdev be
compatible, it is just the last bit of switching on full QAPI support
that has some interface ramifications that we were not comfortable
making during a release freeze, and haven't had time to revisit since.
object_add is much further away from being introspectible.

>=20
> This may be enough for -netdev, but do we want to make command-line
> option introspection always depend on having the same struct being used=

> in a QMP command to work?  What if the arguments for the command-line
> option don't match precisely the input of a QMP command?

Then that's arguably a poor user interface, and only something we should
do for back-compat reasons, and not for new design. We WANT to make the
command-line introspectible, and the easiest way to do that is to make
the command-line and QMP share common guts (see the recent -blockdev
addition in qemu 2.9, along with Dan and Markus' work at tweaking
visitors so that the command line directly feeds into the QObject
representation used by QMP commands rather than the hackish QemuOpts
that is already too bloated with workarounds).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AHMvLwXGX9eqwortULvJ1Um4KRBxkogvD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUcXlAAoJEKeha0olJ0NqtCoH/icYuMUUYJciOC/MRfrc5CCM
AV7UujpBp06/W+J82Q9ofauh3G2CW32YnkSAt1MNpsxcLYsIBTF8g1xL3W/YMIYz
1S3JcPacNb6rSF04Dof5+LHMAqwQbg+R9j4wlVfW96XvJNzPqNPUlG9U10JRP7J6
sBSwLHwm+vilKsKfsPKfkUBJPplBer+bothl2KnnIKXW6f6JILOPfkh63pogLK9M
miky9hV1laQ0Jroo8CdtorSMcbStDuuGIhTeh8xdzH195M/OZiaKdybIOcnj+KY3
kVezqYX63nFYjcDXZb1xNy1M5d05/hVPIrR9k2QlnDRudUzl/Lx6i3RLUB1tSiI=
=VQrt
-----END PGP SIGNATURE-----

--AHMvLwXGX9eqwortULvJ1Um4KRBxkogvD--
