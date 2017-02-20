Received: from eggs.gnu.org ([2001:4830:134:3::10]:39308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cfuq1-00039S-O9
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cfupw-0000gu-UB
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:45:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cfupw-0000gk-LX
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:45:32 -0500
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
	<3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
	<20170220201923.GM2372@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d51d4a21-5558-d4e5-5b7e-08f729fc1a5e@redhat.com>
Date: Mon, 20 Feb 2017 14:45:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170220201923.GM2372@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J0qJUpL2JFjJIJmpkND02HlABwenbjFWw"
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J0qJUpL2JFjJIJmpkND02HlABwenbjFWw
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, ben@skyportsystems.com, mst@redhat.com
Message-ID: <d51d4a21-5558-d4e5-5b7e-08f729fc1a5e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine Generation
 ID support
References: <cover.1487286467.git.ben@skyportsystems.com>
 <88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
 <20170217114321.6c8577e1@nial.brq.redhat.com>
 <918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
 <20170220102304.GC2372@work-vm>
 <3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
 <20170220201923.GM2372@work-vm>
In-Reply-To: <20170220201923.GM2372@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 02:19 PM, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> On 02/20/2017 04:23 AM, Dr. David Alan Gilbert wrote:
>>> * Laszlo Ersek (lersek@redhat.com) wrote:
>>>> CC Dave
>>>
>>> This isn't an area I really understand; but if I'm
>>> reading this right then=20
>>>    vmgenid is stored in fw_cfg?
>>>    fw_cfg isn't migrated
>>>
>>> So why should any changes to it get migrated, except if it's already
>>> been read by the guest (and if the guest reads it again aftwards what=
's
>>> it expected to read?)
>>
>> Why are we expecting it to change on migration?  You want a new value
>=20
> I'm not; I was asking why a change made prior to migration would be
> preserved across migration.

Okay, so you're asking what happens if the source requests the vmgenid
device, and sets an id, but the destination of the migration does not
request anything - how does the guest on the destination see the same id
as was in place on the source at the time migration started.

>=20
>=20
>> when you load state from disk (you don't know how many times the same
>> state has been loaded previously, so each load is effectively forking
>> the VM and you want a different value), but for a single live migratio=
n,
>> you aren't forking the VM and don't need a new generation ID.
>>
>> I guess it all boils down to what command line you're using: if libvir=
t
>> is driving a live migration, it will request the same UUID in the
>> command line of the destination as what is on the source; while if
>> libvirt is loading from a [managed]save to restore state from a file, =
it
>> will either request a new UUID directly or request auto to let qemu
>> generate the new id.
>=20
> Hmm now I've lost it a bit; I thought we would preserve the value
> transmitted from the source, not the value on the command line of the d=
estination.

I guess I'm trying to figure out whether libvirt MUST read the current
id and explicitly tell the destination of migration to reuse that id, or
if libvirt can omit the id on migration and everything just works
because the id was migrated from the source.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--J0qJUpL2JFjJIJmpkND02HlABwenbjFWw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq1VpAAoJEKeha0olJ0Nq6gYIALAcNS9sesQ4zfXrfNXnwJro
lvgWGFPpVVB1DEv1OEEYbT+OqLLXcTy4xekZTViiiTi3XwSTSMcXASyIXt4qJc6K
24/RenNF0lzUcORMi5R3FYkihPfeCNdBqgQv5hRziyTtQhzI/z9SacWUWMIQ0Dej
BhCkMv1rWGtU2ScPMRu6j060mhCp6ozzioyXjREdA4fvLBCNdYjpexN5JbXbT5dm
xzheLLaF/6VSslvMWsR/wArk8JvGo0hKjp/Xg408F58j14Tg0MTxIH4i9F72bTpA
dlHHhW0a9vVdWjkuPGLWxwmqnXcWsDl59LiUT4U8q/B6GgLC38f3UTCLx4zV+Mg=
=rbmc
-----END PGP SIGNATURE-----

--J0qJUpL2JFjJIJmpkND02HlABwenbjFWw--
