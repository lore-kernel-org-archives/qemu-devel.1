Received: from eggs.gnu.org ([2001:4830:134:3::10]:48636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFk7N-0005UV-OK
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFk7M-0000ee-Ix
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:07:53 -0500
References: <20171117162536.23225-1-kchamart@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78f4339b-bbe5-18d1-6555-b2c3196a6f7c@redhat.com>
Date: Fri, 17 Nov 2017 11:07:41 -0600
MIME-Version: 1.0
In-Reply-To: <20171117162536.23225-1-kchamart@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UA1g4NXDVdOkNUs48SxB5uDDJCpBQP7LK"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11] QAPI & interop: Clarify events
 emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UA1g4NXDVdOkNUs48SxB5uDDJCpBQP7LK
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com
Message-ID: <78f4339b-bbe5-18d1-6555-b2c3196a6f7c@redhat.com>
Subject: Re: [PATCH v3 for-2.11] QAPI & interop: Clarify events emitted by
 'block-job-cancel'
References: <20171117162536.23225-1-kchamart@redhat.com>
In-Reply-To: <20171117162536.23225-1-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 10:25 AM, Kashyap Chamarthy wrote:
> When you cancel an in-progress live block operation with QMP
> `block-job-cancel`, it emits the event: BLOCK_JOB_CANCELLED.  However,
> when `block-job-cancel` is issued after `drive-mirror` has indicated (b=
y
> emitting the event BLOCK_JOB_READY) that the source and destination
> remain synchronized:
>=20

> But this is expected behaviour, where the _COMPLETED event indicates
> that synchronization has successfully ended (and the destination has a
> point-in-time copy, which is at the time of cancel).
>=20
> So add a small note to this effect in 'block-core.json'.  While at it,
> also update the "Live disk synchronization -- drive-mirror and
> blockdev-mirror" section in 'live-block-operations.rst'.
>=20
> (Thanks: Max Reitz for reminding me of this caveat on IRC.)

Sorry for not wordsmithing on earlier versions:

>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---

> +.. note::
> +
> +    When you cancel an in-progress 'mirror' job *before* the source an=
d
> +    target are synchronized, ``block-job-cancel`` will emit the event
> +    ``BLOCK_JOB_CANCELLED``.  However, note that if you cancel a
> +    'mirror' job *after* it has indicated (by emitting the event
> +    ``BLOCK_JOB_READY``) that the source and target now remain
> +    synchronized, then ``block-job-cancel`` will emit the event

Might read slightly nicer as:

the source and target have reached synchronization,


> +++ b/qapi/block-core.json
> @@ -2065,6 +2065,14 @@
>  # BLOCK_JOB_CANCELLED event.  Before that happens the job is still vis=
ible when
>  # enumerated using query-block-jobs.
>  #
> +# Note that the 'block-job-cancel' command will emit the event
> +# BLOCK_JOB_COMPLETED if you issue it ('block-job-cancel') after 'driv=
e-mirror'
> +# has indicated (by emitting the event BLOCK_JOB_READY) that the sourc=
e and
> +# destination remain synchronized.  In this case, the BLOCK_JOB_COMPLE=
TED
> +# event indicates that synchronization (from 'drive-mirror') has succe=
ssfully
> +# ended and the destination now has a point-in-time copy, which is at =
the time
> +# of cancel.


Accurate, but a bit hard to follow the flow of the sentence.  Might read
nicer as:

Note that if you issue 'block-job-cancel' after 'drive-mirror' has
indicated (via the event BLOCK_JOB_READY) that the source and
destination are synchronized, then the event triggered by this command
changes to BLOCK_JOB_COMPLETED, to indicate that the mirroring has ended
and the destination now has a point-in-time copy tied to the time of the
cancellation.

Documentation is worth of inclusion in 2.11.  Whether you keep your
wording, or incorporate mine in a v4, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UA1g4NXDVdOkNUs48SxB5uDDJCpBQP7LK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloPF10ACgkQp6FrSiUn
Q2pMsAgAno0hkHw4qcYylEr4ZOy1Qq6m+a7fK2wYpEoRxGNL4ALa6YFpebrMmQnR
Pb09DS8tLvylbdbRwFXFaBMTaQ79m0ya2s03WlZYLNKb/ZFjVUmFwyHrMitDaIvr
XjODnF4+kedQt4KqqU4671uFAxenhIPHB5Ri8+v710RUNfjYIK3tTPyGiC9wXAtE
RHlO7/cMZnuRkBl8T2yHI+Y4hhB+0JEsHL82o/zKtSdUtawHhMRzao6+pHLkQJdV
liC0UdWLq+zBNg83PpbOHzgrj0BUtuZqagpWw1vB1QyvqDD9jqDCq1DuXABvYaPt
zQCboV0nivdKWx4JXz5YNc7/G2NY/A==
=/S9k
-----END PGP SIGNATURE-----

--UA1g4NXDVdOkNUs48SxB5uDDJCpBQP7LK--
