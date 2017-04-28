Received: from eggs.gnu.org ([2001:4830:134:3::10]:59017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d47hT-0005S9-Qa
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d47hR-0001iL-BK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:20:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d47hR-0001hk-18
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:20:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ACCE8005C
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 15:20:47 +0000 (UTC)
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-7-quintela@redhat.com>
	<20170428144729.GB3276@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04eb0f88-4e4b-ffcf-8f5a-e1d5f3414ce9@redhat.com>
Date: Fri, 28 Apr 2017 10:20:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170428144729.GB3276@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FWcrPEsNruB6QmktQuMP9ARw9TsI24eLi"
Subject: Re: [Qemu-devel] [PATCH 6/6] migration: Pass Error ** argument to
 {save, load}_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FWcrPEsNruB6QmktQuMP9ARw9TsI24eLi
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com
Message-ID: <04eb0f88-4e4b-ffcf-8f5a-e1d5f3414ce9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] migration: Pass Error ** argument to
 {save, load}_vmstate
References: <20170425102446.4008-1-quintela@redhat.com>
 <20170425102446.4008-7-quintela@redhat.com> <20170428144729.GB3276@work-vm>
In-Reply-To: <20170428144729.GB3276@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 09:47 AM, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> This way we use the "normal" way of printing errors for hmp commands.
>>
>> --

>>      if (!bdrv_all_can_snapshot(&bs)) {
>> -        error_report("Device '%s' is writable but does not support sn=
apshots",
>> -                     bdrv_get_device_name(bs));
>> +        error_setg(errp, "Device '%s' is writable but does not suppor=
t "
>> +                   "snapshots", bdrv_get_device_name(bs));
>>          return ret;
>>      }
>> =20
>>      /* Delete old snapshots of the same name */
>>      if (name) {
>> -        ret =3D bdrv_all_delete_snapshot(name, &bs1, &local_err);
>> +        ret =3D bdrv_all_delete_snapshot(name, &bs1, errp);
>>          if (ret < 0) {
>> -            error_reportf_err(local_err,
>> -                              "Error while deleting snapshot on devic=
e '%s': ",
>> -                              bdrv_get_device_name(bs1));
>> +            error_prepend(errp, "Error while deleting snapshot on dev=
ice "
>> +                          "'%s': ", bdrv_get_device_name(bs1));
>=20
> I thought the rule was that you had to use a local_err and use error_pr=
opagate?
> (I hate that rule)

The rule is that if you want to make code conditional on whether an
error occurred, you can't do it by checking errp (because the caller may
have passed NULL), so you instead have to use local_err and
error_propagate(). But if there are other ways to tell if an error
occurred (such as a return value), then passing errp directly through is
fine (error_prepend does the right thing even if errp is NULL because
the caller doesn't care about an error).

include/qapi/error.h has some good examples, and if it is missing
something, we'd be glad to patch it further to serve as a good reference.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FWcrPEsNruB6QmktQuMP9ARw9TsI24eLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA13IAAoJEKeha0olJ0Nq0IkH/Rp6Y9orFgv9PdovWEX86Jho
RJ2PPB6va5p/XriHhAhsKlGLPUA+/RE3hFBoXyIRHLB7elxa49k5rk0zUHsVPVD1
dcB3AB5EGuwEHxTA5wT6ylI93TOhapoePmvLBoETzBVow1lwKJztpbAsLXFx5hTf
1kl6dMyyuDxB+5RYdK6GWEg/1kbyA65XBK6DfvFe2AaI8TniCh6kEQfT2zspNCAj
tTKSNcUzDClE2uukEVF6QW/P3oJFgGo8Ph5SGXcVKA3D7dLDkBoB2kvfFwNPL4nM
rWlTVKiqS5FAahI/n0DIHOKgOEoQdOKiaTSm/Sdk8Obgh6sAGWoPOR4quJarFOo=
=O7SD
-----END PGP SIGNATURE-----

--FWcrPEsNruB6QmktQuMP9ARw9TsI24eLi--
