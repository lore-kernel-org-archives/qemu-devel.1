Received: from eggs.gnu.org ([2001:4830:134:3::10]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpxLM-0003V4-SP
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpxLF-0007WB-3h
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpxLE-0007VM-QL
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:59:37 -0400
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170829110357.GG3783@redhat.com> <20170906094846.GA2215@work-vm>
	<20170906104603.GK15510@redhat.com> <20170906104850.GB2215@work-vm>
	<20170906105414.GL15510@redhat.com> <20170906105704.GC2215@work-vm>
	<20170906110629.GM15510@redhat.com> <20170906113157.GD2215@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1788c2ff-78a0-fcb6-b6aa-6238af7af740@redhat.com>
Date: Thu, 7 Sep 2017 08:59:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170906113157.GD2215@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UTFeF2N8e2lcfb1qBa4d8rhvsiKc9ViHj"
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UTFeF2N8e2lcfb1qBa4d8rhvsiKc9ViHj
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <1788c2ff-78a0-fcb6-b6aa-6238af7af740@redhat.com>
Subject: Re: [RFC v2 0/8] monitor: allow per-monitor thread
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
 <20170829110357.GG3783@redhat.com> <20170906094846.GA2215@work-vm>
 <20170906104603.GK15510@redhat.com> <20170906104850.GB2215@work-vm>
 <20170906105414.GL15510@redhat.com> <20170906105704.GC2215@work-vm>
 <20170906110629.GM15510@redhat.com> <20170906113157.GD2215@work-vm>
In-Reply-To: <20170906113157.GD2215@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 06:31 AM, Dr. David Alan Gilbert wrote:

>> This does imply that you need a separate monitor I/O processing, from =
the
>> command execution thread, but I see no need for all commands to sudden=
ly
>> become async. Just allowing interleaved replies is sufficient from the=

>> POV of the protocol definition. This interleaving is easy to handle fr=
om
>> the client POV - just requires a unique 'serial' in the request by the=

>> client, that is copied into the reply by QEMU.
>=20
> OK, so for that we can just take Marc-Andr=C3=A9's syntax and call it '=
id':
>   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03634.html
>=20
> then it's upto the caller to ensure those id's are unique.

We ALREADY support 'id', and it is already up to the caller to ensure
those id's are unique, even without Marc-Andr=C3=A9's additions.

>=20
> I do worry about two things:
>   a) With this the caller doesn't really know which commands could be
>   in parallel - for example if we've got a recovery command that's
>   executed by this non-locking thread that's OK, we expect that
>   to be doable in parallel.  If in the future though we do
>   what you initially suggested and have a bunch of commands get
>   routed to the migration thread (say) then those would suddenly
>   operate in parallel with other commands that we're previously
>   synchronous.

Presumably, all existing commands are NOT async, and introspection via
query-qmp-schema will let you query which new commands ARE async.  Or
existing commands will gain an optional parameter to opt-in to async
behavior for that command, defaulting to sync by default.  Thus, an old
libvirt will never call an async command, and never notice the
difference, but a new libvirt that is aware of async commands will opt
in to the commands that it wants to use in an async manner.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UTFeF2N8e2lcfb1qBa4d8rhvsiKc9ViHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxUL0ACgkQp6FrSiUn
Q2pU3ggAong6cdwyO0j340Hdpb5ZStyOTQCIz5ahZ9phdWsl11ALdDNDWcNTQiu8
0kjdVZCPQHOT1yZZnmvzZV8BPghMUM3XkGTIkPmxO1CR8t4csOvdQVvESxZuqjXy
l8LVwO+9+oNkW3sCuLqvhZEBievvrbvk7+fH1bE/mgKXcbzjgRBUcnAIPp7FAgB1
Ue8uclgKQSez5hSqy70SRdJy+M4zIVAPAEf/2GQzy+gkDQU5pUxle9GnXEVCBbH8
x9O3L7wqq9hZk4sEM7kOPGCYg2wpxyBwBDO2/TnNYlTQ7Uravq+asw+BnRH3ISRF
VVoAz8dlMrfGOknMbpQ19b9Ujfa7Vg==
=3SYa
-----END PGP SIGNATURE-----

--UTFeF2N8e2lcfb1qBa4d8rhvsiKc9ViHj--
