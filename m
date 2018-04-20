Received: from eggs.gnu.org ([2001:4830:134:3::10]:36494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9c2P-0003xO-72
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9c2K-0001RN-Jh
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:49:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9c2K-0001Qh-CN
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:49:36 -0400
References: <20180420175721.18479-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bf695674-aa5e-e151-d921-225086d35c5d@redhat.com>
Date: Fri, 20 Apr 2018 14:49:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180420175721.18479-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JDIFK9kWoXoFsAadYG5so2cF98H2mjOwB"
Subject: Re: [Qemu-devel] [PATCH] migration: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JDIFK9kWoXoFsAadYG5so2cF98H2mjOwB
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 peter.maydell@linaro.org
Message-ID: <bf695674-aa5e-e151-d921-225086d35c5d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: update docs
References: <20180420175721.18479-1-dgilbert@redhat.com>
In-Reply-To: <20180420175721.18479-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2018 12:57 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Update the migration docs:
>=20
> Among other changes:
>   * Added a general list of advice for device authors
>   * Reordered the section on conditional state (subsections etc)
>     into the order we prefer.
>   * Add a note about firmware
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/devel/migration.rst | 524 +++++++++++++++++++++++++++------------=

>  1 file changed, 370 insertions(+), 154 deletions(-)

> @@ -40,16 +40,16 @@ to do migration:
>  - fd migration: do the migration using an file descriptor that is
>    passed to QEMU.  QEMU doesn't care how this file descriptor is opene=
d.
> =20
> -All these four migration protocols use the same infrastructure to
> +In addition support is included for migration using RDMA migration whi=
ch

The double migration in this phrase sounds redundant.  I think you can:

s/In addition/In addition,/
s/RDMA migration which/RDMA, which/

> +transports the page data using ``RDMA``, where the hardware takes care=
 of
> +transporting the pages, and the load on the CPU is much lower.  While =
the
> +internals of RDMA migration are a bit different, this isn't really vis=
ible
> +outside the RAM migration code.
> +

> +For most devices, the state is saved in a single call to the migration=

> +infrastrucutre; these are *non-iterative* devices.  The data for these=


s/infrastrucutre/infrastructure/

> +devices is sent at the end of precopy migration, when the CPUs are pau=
sed.
> +Where the data associated with the device is very large (e.g. RAM or l=
arge tables)
> +see the iterative device section below.

> +
> +- Migrations timing out or being failed by higher levels of management=
,
> +  or failures of the destination host are not unusual, and care should=

> +  be taken to ensure that the source VM can be restarted up until the =
point
> +  when the destination starts runing.  Valid examples include the mana=
gement

s/runing/running/

> +  layer reverting the migration even though the QEMU level of migratio=
n has
> +  succeeded.  For this reason, the state on the source VM should not b=
e
> +  destroyed during the migration process in normal use.
> +
> +- Busses and devices should be able to explicitly specify addresses wh=
en

s/Busses/Buses/ ? (both spellings are common, but busses can also be
confused with a synonym of kisses)

> +When we migrate a device, we save/load the state as a series
> +of fields.  Some times, due to bugs or new functionality, we need to
> +change the state to store more/different information.  Changing the mi=
gration
> +state saved for a device can break migration comppatibility unless

s/comppatibility/compatibility/

> +care is taken to use the appropriate techniques.  In general QEMU trie=
s
> +to maintain forward migration compaitibility (i.e. migrating from

s/compaitibility/compatibility/

> +QEMU n->n+1) and there are users who benefit from backwards compatibil=
ity
> +as well.

(fun - 3 spellings among 3 uses in 2 sentences - at least the last one
was right)


> +Note that the contents of the sections for iterative migration tend
> +to be open-coded by the devices;  care should be taken in parsing

Why the double space?


> +
> +The ``device data`` in each section consists of the data produced
> +by the code described above.  For non-iterative devices they have a si=
ngle
> +section; iterative devices have an initial and last section and a set
> +of parts inbetween.

s/inbetween/in between/

> +Note that there is very little checking by the common code of the inte=
grity
> +of the ``device data`` contents, that's upto the devices themselves.

s/upto/up to/

> +Only a unidirectional stream is required for normal migration, however=
 a
> +``return path`` can be created when bidirecitonal communication is des=
ired.

s/bidirecitonal/bidirectional/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JDIFK9kWoXoFsAadYG5so2cF98H2mjOwB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlraREUACgkQp6FrSiUn
Q2p42Af9GH6UbtwSdI7FZT+5xI3vHade+A+Z6FDn8WCv48slREwcXgWhs70+QXwb
+tfhVXaNbd+sig9XOHtg89THIcvKFc/hMg+slyfemJLJsZfRUaDNzPh+n1G2wbvt
BcGKkGCciPW8ARxFZrbZQ/mmmgVBih4u8ZU8Owb54YLGR6+DPh4NwFVL0Jj5Z+17
8x+xZeTK8aCmZWiQL2sUuI35aTT5ro5CT/snCFfHjYg3042VWS8tzdzA2lEbPt/h
gZLPolX0+5+QArNEnXK8CmKMt+RssNcN+Nx6mbiK6DiY5YkWsFUX0gvRrLBW2W8M
cZAvecP2Eh19K7E8i6CnAUtDcd82kw==
=cKkG
-----END PGP SIGNATURE-----

--JDIFK9kWoXoFsAadYG5so2cF98H2mjOwB--
