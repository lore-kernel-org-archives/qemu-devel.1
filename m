Received: from eggs.gnu.org ([2001:4830:134:3::10]:50132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQejq-0004ya-4W
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQejm-0006xf-Tj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQejm-0006xI-Bt
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:04:22 -0400
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-2-pasic@linux.vnet.ibm.com>
	<20170607095127.GB2099@work-vm>
	<8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
	<f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
Date: Thu, 29 Jun 2017 14:04:19 -0500
MIME-Version: 1.0
In-Reply-To: <f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MTXVoOcUKXFOJrBnRIjpaKTk0SLTPbHbI"
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed
 equal checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MTXVoOcUKXFOJrBnRIjpaKTk0SLTPbHbI
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 "Jason J . Herne" <jjherne@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed equal
 checks
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
 <20170606165510.33057-2-pasic@linux.vnet.ibm.com>
 <20170607095127.GB2099@work-vm>
 <8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
 <f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
In-Reply-To: <f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/14/2017 08:51 AM, Halil Pasic wrote:

[apologies for the delayed response, and also adding Markus]


>>
>> One reason I choose error_report_err is to be consistent about hint
>> reporting (the other one is that was what Connie suggested). I do
>> not understand why do we omit hints if QMP, but I figured that's
>> our policy. So the hint I'm adding must not be printed in QMP
>> context -- because that's our policy. I was pretty sure what I
>> want to do is add a hint (and not make a very long 'core' error
>> message).
>>
>> Can you (or somebody else)  explain why are hints dropped in QMP
>> context?
>>
>> Don't misunderstand I'm open towards your proposal, it's just
>> that:
>> 1) I would like to understand.
>> 2) I would like to get the very same result as produced by
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg01472.html=
=20
>>
>> Regards,
>> Halil
>>
>>
>=20
> ping.
>=20
> I would like to do a v2, but I want this sorted out first.
>=20
> 'This' basically boils down to the question and
> 'Why aren't hints reported in QMP context?'

QMP is supposed to be machine-parseable.  Hints are supposed to be
human-readable. If you have a machine managing the monitor, the hint
adds nothing but bandwidth consumption, because machine should not be
parsing the human portion of the error message in the first place (as it
is, libvirt already just logs the human-readable portion of a message,
and bases its actions solely on the machine-stable portions of an error
reply: namely, whether an error was sent at all, and occasionally, what
error class was used for that error - there's no guarantee a human will
be reading the log, though).

There's also the question of whether the hints are even useful (telling
the user to do something differently doesn't help if it wasn't the user,
but libvirt, that was doing things wrong to cause the error in the first
place).

So while those points may or may not be the original rationale for why
hints are not used in QMP, but it is an explanation that works for me
now.  Markus may also have an opinion on the matter.

> and 'Why is this
> case special (a hint should be reported
> even in QMP context?'

If something absolutely must be reported, then it is not a hint, and
shouldn't be using the hint mechanism.

>=20
> Regarding the first question hints being reported via
> error_printf_unless_qmp seems to come from commit
> 50b7b000c9 ("hmp: Allow for error message hints on HMP")
> --> Cc-ing Eric maybe he can help.
>=20
> Regards,
> Halil
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MTXVoOcUKXFOJrBnRIjpaKTk0SLTPbHbI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVU8zAAoJEKeha0olJ0NqlD0H/2CpNbEgXpYZuyK2X+AZ+cRO
/YhoxUIkiIhKGW7SdptrLmKL0x+CFWAicwMIW45SQINUsHn2KK8njGFEH/v9X9F7
4cl3GzzgoNtRXvqO8XcL34v3Ds9mt8IzLhFC2vepEVrSsxDeAXERij1+XpLbdobh
7YjUrotzQ1hld/QGmleIR9H7BVer5uwctrwErMY46yhe+hxYg19z/+oPZzEALS4y
BXv2J2FbPTLdlAdB02vv9ZDV3ag2FvfzwwSd2RQKL+fgpB4uSnh7+Yu6Ge7397ax
l9x34InvUFZY/4llwLFUvgs8RJhjxVxh27L1qGppf5MRhiptR26gEZwMSrXCj+Q=
=u641
-----END PGP SIGNATURE-----

--MTXVoOcUKXFOJrBnRIjpaKTk0SLTPbHbI--
