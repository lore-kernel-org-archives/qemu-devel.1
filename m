Received: from eggs.gnu.org ([2001:4830:134:3::10]:53268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjplq-0001lb-1w
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjplm-0002jP-Qx
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:09:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjplm-0002i5-HY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:09:26 -0500
References: <1488517304-23131-1-git-send-email-he.chen@linux.intel.com>
	<20170303135704.GX2778@thinpad.lan.raisama.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d93b2ebb-c5a3-a774-30fd-2d92c7703549@redhat.com>
Date: Fri, 3 Mar 2017 10:09:22 -0600
MIME-Version: 1.0
In-Reply-To: <20170303135704.GX2778@thinpad.lan.raisama.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9Ac96HR0eE0RuMqecGrmtGNQ0hjvVFlwK"
Subject: Re: [Qemu-devel] [RFC] x86: Allow to set NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, He Chen <he.chen@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Ac96HR0eE0RuMqecGrmtGNQ0hjvVFlwK
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, He Chen <he.chen@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>
Message-ID: <d93b2ebb-c5a3-a774-30fd-2d92c7703549@redhat.com>
Subject: Re: [RFC] x86: Allow to set NUMA distance for different NUMA nodes
References: <1488517304-23131-1-git-send-email-he.chen@linux.intel.com>
 <20170303135704.GX2778@thinpad.lan.raisama.net>
In-Reply-To: <20170303135704.GX2778@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 07:57 AM, Eduardo Habkost wrote:

>> With this patch, when a user wants to create a guest that contains
>> several vNUMA nodes and also wants to set distance among those nodes,
>> the QEMU command would like:
>>
>> ```
>> -object memory-backend-ram,size=3D1G,prealloc=3Dyes,host-nodes=3D0,pol=
icy=3Dbind,id=3Dnode0 \
>> -numa node,nodeid=3D0,cpus=3D0,memdev=3Dnode0,distance=3D10,distance=3D=
21,distance=3D31,distance=3D41 \

>=20
> It would be nice to have a more intuitive syntax to represent
> ordered lists in QemuOpts. But this is what we have today.
>=20

Markus has the discussion on representing arrays via the command line;
particularly since this array is very tightly coupled to the order in
which values are presented, it may be worth having:

-numa
node,nodeid=3D0,cpus=3D0,memdev=3Dnod0,distance.0=3D10,distance.1=3D21,di=
stance.2=3D31,distance.3=3D41

with the explicit distance.0=3D suffixes to distance making it more
obvious that we are dealing with an array.

> I think the proposal makes sense. I would like the semantics of the new=
 option
> to be documented at qapi-schema.json and qemu-options.hx.
>=20
> I would call the new NumaNodeOptions field "distances", as it is
> a list of distances.

Indeed, Markus is trying (with his work on -blockdev for 2.9) to get the
command line to a point where it is identical to the QMP code, by
reusing qapi-schema.json, so we should very much keep that in mind with
whatever we add to -numa in 2.10.


> but in the future we could support something like:
>=20
>   -numa node,nodeid=3D0,cpus=3D0,memdev=3Dnode0 \
>   -numa node,nodeid=3D1,cpus=3D1,memdev=3Dnode1 \
>   -numa node,nodeid=3D2,cpus=3D2,memdev=3Dnode2 \
>   -numa node,nodeid=3D3,cpus=3D3,memdev=3Dnode3 \
>   -numa distances,distances[0][0]=3D10,distances[0][1]=3D21,distances[0=
][2]=3D31,distances[0][3]=3D41,\
>                   distances[1][0]=3D21,distances[1][1]=3D10,distances[1=
][2]=3D21,distances[1][3]=3D31,\
>                   distances[2][0]=3D31,distances[2][1]=3D21,distances[2=
][2]=3D10,distances[2][3]=3D21,\
>                   distances[3][0]=3D41,distances[3][1]=3D31,distances[3=
][2]=3D21,distances[3][3]=3D10

Except that [] requires special shell quoting, so the proposal would be
more like:

-numa distances.0.0=3D10,distances.0.1=3D21

Right now, QMP doesn't support 2-D arrays (although this may be a good
reason to introduce support), so that's also something to think about
(not insurmountable, but makes the task more complex).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9Ac96HR0eE0RuMqecGrmtGNQ0hjvVFlwK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuZUzAAoJEKeha0olJ0NqRWQIAIeM70cmDR96eSIc2sKDB0YT
WexV2wFc/qQ0S5wT3lYfScQW2MEklhSPzE7JWWAlbvNuRV3Bl3OJtYmPWauGtK8w
MbdN52FFY3q7B7+qYvhFPoo9dVy8GFW2VMxyzmmHYaAAdKlOHgoKbTuezFb+osUR
CtnPC+RlFUwvQ3FZaxDwAtF3PbNIOhgFjdYQ+KVuulBwSScvHEFIC9yZHKF47C/T
URp3C447kggX0H/08fJBTfov0oJa8tQLkiwrXjWEcdnbM11H834G/ejYAkWr6BLw
LbF/lmDchVkqoOSZiUIl8mUqRfsuHPYfwkuq6jd/kkF81OkETNg84YVhp+wJb8s=
=7whn
-----END PGP SIGNATURE-----

--9Ac96HR0eE0RuMqecGrmtGNQ0hjvVFlwK--
