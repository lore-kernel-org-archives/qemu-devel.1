Received: from eggs.gnu.org ([209.51.188.92]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghgwP-00086l-29
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghgwN-0001PJ-2O
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:28:36 -0500
References: <20190110191901.5082-1-eblake@redhat.com>
	<edb4aed4-d032-2a8d-62d0-b5277ca137d5@redhat.com>
	<23bcf66e-a485-0155-d808-ef7f436b56c8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <acebd481-9666-c3e4-527f-a291b4b047e2@redhat.com>
Date: Thu, 10 Jan 2019 14:28:24 -0600
MIME-Version: 1.0
In-Reply-To: <23bcf66e-a485-0155-d808-ef7f436b56c8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7IwbSvSTAbtlVVK9Jywh219IGAQDkUHF3"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/6] include: Auto-generate
 the sizes lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, lbloch@janustech.com, armbru@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7IwbSvSTAbtlVVK9Jywh219IGAQDkUHF3
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, lbloch@janustech.com, armbru@redhat.com,
 qemu-block@nongnu.org
Message-ID: <acebd481-9666-c3e4-527f-a291b4b047e2@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 0/6] include: Auto-generate the sizes
 lookup table
References: <20190110191901.5082-1-eblake@redhat.com>
 <edb4aed4-d032-2a8d-62d0-b5277ca137d5@redhat.com>
 <23bcf66e-a485-0155-d808-ef7f436b56c8@redhat.com>
In-Reply-To: <23bcf66e-a485-0155-d808-ef7f436b56c8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 2:21 PM, Eric Blake wrote:
> On 1/10/19 1:26 PM, Eric Blake wrote:
>> On 1/10/19 1:18 PM, Eric Blake wrote:
>>> Patches speak louder than words.  This is my counter-proposal to
>>> Leonid's thread on how best to respresent the S_*iB macros in units.h=
,
>>> where my proposal is that we don't need them at all. (hence my subjec=
t
>>> line, even though it is completely unrelated to the series)
>>>
>>> True, my diffstat is even bigger, but I think it is more maintainable=

>>> in the long run (if calling QemuOpts maintainable is even appropriate=
).
>>
>> I wasn't brave enough to assert that def_value_str was used only with
>> QEMU_OPT_STRING, and that all uses of QEMU_OPT_{BOOL,NUMBER,SIZE} with=
 a
>> default value are either defaulting to 0 or using def_value_int; that'=
s
>> a bigger auditing task followup that could be given as a BiteSizedTask=
,
>> if you like this series.
>=20
> Hmm - I wonder if Coccinelle is powerful enough to find all QemuOptDesc=

> initializers that .type to something other than QEMU_OPT_STRING and als=
o
> set .def_value_str; including initializers that did not use C99
> named-member initialization (if we have any of those). (Those are the
> candidates to start using .def_value_int)

Then again, if we were consistent at C99 initializers, a grep may be
powerful enough:

$ git grep -A3 '\.type *=3D *QEMU_OPT_\(BOOL\|NUMBER\|SIZE\)' | grep -B3
def_value_str
--
block/parallels.c:            .type =3D QEMU_OPT_SIZE,
block/parallels.c-            .help =3D "Preallocation size on image
expansion",
block/parallels.c-            .def_value_str =3D "128M",
--
--
block/qcow2.c:            .type =3D QEMU_OPT_BOOL,
block/qcow2.c-            .help =3D "Postpone refcount updates",
block/qcow2.c-            .def_value_str =3D "off"
--
--
block/qcow2.c:            .type =3D QEMU_OPT_NUMBER,
block/qcow2.c-            .help =3D "Width of a reference count entry in
bits",
block/qcow2.c-            .def_value_str =3D "16"
--
--
block/vdi.c:            .type =3D QEMU_OPT_BOOL,
block/vdi.c-            .help =3D "VDI static (pre-allocated) image",
block/vdi.c-            .def_value_str =3D "off"
--
--
block/vmdk.c:            .type =3D QEMU_OPT_BOOL,
block/vmdk.c-            .help =3D "VMDK version 6 image",
block/vmdk.c-            .def_value_str =3D "off"
--
--
block/vxhs.c:            .type =3D QEMU_OPT_NUMBER,
block/vxhs.c-            .help =3D "port number on which VxHSD is
listening (default 9999)",
block/vxhs.c-            .def_value_str =3D "9999"


and where the def_value_str =3D "off" defaults can probably be deleted.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7IwbSvSTAbtlVVK9Jywh219IGAQDkUHF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3qugACgkQp6FrSiUn
Q2qqHwf9Hw0aiw/dCcIMXF/BUN9Vw3pK2wWxzg8ePcHud6YUPHT2A/jERnuUdNM/
r4cpYICIn9HtRbRK2D4/WCJxYeu07pgoZrzSGe/Caa+GW37kkimGAIeDyrnzF7Vm
DIdC07ofi7taHcMMucB9kjW6zrusrIWNvJVWUfOOnviUNQ/ayQ41JC1o2WgHd+CE
8MCkfpqd6qFfVrV33LayTfCzOp0JJQGEDuqy7w9Y4kdzVQjmKqorMbUX/cvp+2i9
gxuvCISfVgxKMBvAv1uJAvY/JN5G4dzFJskFKPyHRD0+FIAY1RxJKXPuspfaW78+
riuYqSbV4tsif81Akhdv5NqQo0RPmg==
=wLJx
-----END PGP SIGNATURE-----

--7IwbSvSTAbtlVVK9Jywh219IGAQDkUHF3--
