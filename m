Received: from eggs.gnu.org ([2001:4830:134:3::10]:43112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f4KFc-00043a-46
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 01:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f4KFZ-0002Fj-2W
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 01:49:28 -0400
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
	<1522938923-96058-2-git-send-email-spopovyc@redhat.com>
	<20180406035249.GA10482@in.ibm.com>
From: Serhii Popovych <spopovyc@redhat.com>
Message-ID: <1d1893fc-1484-86e0-ed1b-f9cf7b35fbb5@redhat.com>
Date: Fri, 6 Apr 2018 08:48:55 +0300
MIME-Version: 1.0
In-Reply-To: <20180406035249.GA10482@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="bQnCCfBUqY2IatVVq7ozwWoa5YqsdGKqE"
Subject: Re: [Qemu-devel] [PATCH for 2.13 1/2] Revert "spapr: Don't allow
 memory hotplug to memory less nodes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bQnCCfBUqY2IatVVq7ozwWoa5YqsdGKqE
From: Serhii Popovych <spopovyc@redhat.com>
To: bharata@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Message-ID: <1d1893fc-1484-86e0-ed1b-f9cf7b35fbb5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 1/2] Revert "spapr: Don't allow
 memory hotplug to memory less nodes"
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
 <1522938923-96058-2-git-send-email-spopovyc@redhat.com>
 <20180406035249.GA10482@in.ibm.com>
In-Reply-To: <20180406035249.GA10482@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bharata B Rao wrote:
> On Thu, Apr 05, 2018 at 10:35:22AM -0400, Serhii Popovych wrote:
>> This reverts commit b556854bd8524c26b8be98ab1bfdf0826831e793.
>>
>> Leave change @node type from uint32_t to to int from reverted commit
>> because node < 0 is always false.
>>
>> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
>> ---
>>  hw/ppc/spapr.c | 22 ----------------------
>>  1 file changed, 22 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 2c0be8c..3ad4545 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3477,28 +3477,6 @@ static void spapr_machine_device_plug(HotplugHa=
ndler *hotplug_dev,
>>              return;
>>          }
>>
>> -        /*
>> -         * Currently PowerPC kernel doesn't allow hot-adding memory t=
o
>> -         * memory-less node, but instead will silently add the memory=

>> -         * to the first node that has some memory. This causes two
>> -         * unexpected behaviours for the user.
>> -         *
>> -         * - Memory gets hotplugged to a different node than what the=
 user
>> -         *   specified.
>> -         * - Since pc-dimm subsystem in QEMU still thinks that memory=
 belongs
>> -         *   to memory-less node, a reboot will set things accordingl=
y
>> -         *   and the previously hotplugged memory now ends in the rig=
ht node.
>> -         *   This appears as if some memory moved from one node to an=
other.
>> -         *
>> -         * So until kernel starts supporting memory hotplug to memory=
-less
>> -         * nodes, just prevent such attempts upfront in QEMU.
>> -         */
>> -        if (nb_numa_nodes && !numa_info[node].node_mem) {
>> -            error_setg(errp, "Can't hotplug memory to memory-less nod=
e %d",
>> -                       node);
>> -            return;
>> -        }
>> -
>=20
> If you remove this unconditionally, wouldn't it be a problem in case
> of newer QEMU with older guest kernels ?

Yes, that definitely would affect guest kernels without such support. We
probably need to add some capability to test for guest kernel
functionality presence.

>=20
> Regards,
> Bharata.
>=20
>=20


--=20
Thanks,
Serhii


--bQnCCfBUqY2IatVVq7ozwWoa5YqsdGKqE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJaxwpOAAoJEBTawMmQ61bBt2sIAINMKolu1qzu0n3afg0nrQZN
VhblmS9v53c4w8Za2ZDz3olrjZoFDYESXRE0ZH2Nh3q6j3UP1KEkFV8DZ5R3POLV
uMXWXOj3ShACHkARUcjxcHlZwDkDbFDrnyuDbnyFm9RPC6a1oNWajkZmmuMRaHCM
4BOPj0p3rg7THwUxdm9GoG+BH/ZdwBQnuA0tcligj/QcAuw302vANx6+HgFZBWms
P6L+qpU9UFXrKhKL8PwC5hUAQso1gd+3f+8NVvDmWYOmNvdQ/2GJO8wtV7EP4k1A
tFdYE5xViBGk1vMhTJUtkMVLVoQJAlGlDpTQBmdkJsbGvE6tKjjqaUIKSx6Oi+A=
=ioKx
-----END PGP SIGNATURE-----

--bQnCCfBUqY2IatVVq7ozwWoa5YqsdGKqE--
