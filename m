Received: from eggs.gnu.org ([2001:4830:134:3::10]:40225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEdGe-0000Bi-LD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEdGb-0002UZ-Ir
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:36:52 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-4-mreitz@redhat.com>
	<e5fd7f83-b0f6-6029-6dcc-86ac132f59c4@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <91fcf7ad-fba4-344b-1327-7bacdc01fc70@redhat.com>
Date: Tue, 14 Nov 2017 16:36:32 +0100
MIME-Version: 1.0
In-Reply-To: <e5fd7f83-b0f6-6029-6dcc-86ac132f59c4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JwVqJjU2WeJaP6CSioBq4pLMRrNwt3Ecb"
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/5] block: Guard against NULL
 bs->drv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JwVqJjU2WeJaP6CSioBq4pLMRrNwt3Ecb
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <91fcf7ad-fba4-344b-1327-7bacdc01fc70@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/5] block: Guard against NULL
 bs->drv
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-4-mreitz@redhat.com>
 <e5fd7f83-b0f6-6029-6dcc-86ac132f59c4@redhat.com>
In-Reply-To: <e5fd7f83-b0f6-6029-6dcc-86ac132f59c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 22:46, Eric Blake wrote:
> On 11/10/2017 02:31 PM, Max Reitz wrote:
>> We currently do not guard everywhere against a NULL bs->drv where we
>> should be doing so.  Most of the places fixed here just do not care
>> about that case at all.
>>
>> Some care implicitly, e.g. through a prior function call to
>> bdrv_getlength() which would always fail for an ejected BDS.  Add an
>> assert there to make it more obvious.
>>
>> Other places seem to care, but do so insufficiently: Freeing clusters =
in
>> a qcow2 image is an error-free operation, but it may leave the image i=
n
>> an unusable state anyway.  Giving qcow2_free_clusters() an error code =
is
>> not really viable, it is much easier to note that bs->drv may be NULL
>> even after a successful driver call.  This concerns bdrv_co_flush(), a=
nd
>> the way the check is added to bdrv_co_pdiscard() (in every iteration
>> instead of only once).
>>
>> Finally, some places employ at least an assert(bs->drv); somewhere, th=
at
>> may be reasonable (such as in the reopen code), but in
>> bdrv_has_zero_init(), it is definitely not.  Returning 0 there in case=

>> of an ejected BDS saves us much headache instead.
>>
>> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1728660
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +++ b/block/replication.c
>=20
>> =20
>> +    if (!s->hidden_disk->bs->drv) {
>> +        error_setg(errp, "Hidden disk %s is ejected",
>> +                   s->hidden_disk->bs->node_name);
>> +        return;
>> +    }
>=20
> How would the hidden disk ever be ejected?  Could this be an assert ins=
tead?

Maybe? :-)

Isn't the hidden disk usually a qcow2 file?  As such I guess there can
be corruptions in it that make the qcow2 driver eject it (even though
qemu isn't writing to it).

Max

> But what you have is equally safe, so
> Reviewed-by: Eric Blake <eblake@redhat.com>


--JwVqJjU2WeJaP6CSioBq4pLMRrNwt3Ecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLDYASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuwQH/R1PkWzSt4pbrCeZA/YjlaWBR4lgOrN/
P5ECJf189uWXlp1v6eZqkqV68697tApg4mTJVFKeiMQSuT59psowTQ0oJ5vkKeHy
yhk8RS6lpe2TGfbFNhla7kdRg+o749vY55LwjP78tmtzrTnEPSmOUA1Ko8/i3mum
93CmCgown2EBXIRocFgrTKR952JjU/a8uyrUH1cpkEYO/TnVe0oY36goqVhPOJad
AhvWBivD5LYgNggKRVOzUuZUPS+3+DtHN8mgAyyefuHlEzKmb30sL4uj2JDuZBn3
E85xB8Z+x9XrBLn+6m7w5G75BKYXuO1pWPPkkn7YewnbChE1VJB2lRw=
=i0tK
-----END PGP SIGNATURE-----

--JwVqJjU2WeJaP6CSioBq4pLMRrNwt3Ecb--
