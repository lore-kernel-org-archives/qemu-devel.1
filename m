Received: from eggs.gnu.org ([2001:4830:134:3::10]:58333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea6OS-0004ZZ-38
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea6OP-0004UR-1c
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:57:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ea6OO-0004Tb-NT
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:57:36 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-13-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c417f619-aad5-a379-bad5-985b44ab1ebb@redhat.com>
Date: Fri, 12 Jan 2018 14:57:23 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-13-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rSwNNlskSsjl8d6Y9ax6lsB8ecCVImLQI"
Subject: Re: [Qemu-devel] [RFC v6 12/27] qmp: negotiate QMP capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rSwNNlskSsjl8d6Y9ax6lsB8ecCVImLQI
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <c417f619-aad5-a379-bad5-985b44ab1ebb@redhat.com>
Subject: Re: [RFC v6 12/27] qmp: negotiate QMP capabilities
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-13-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-13-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:
> After this patch, we will allow QMP clients to enable QMP capabilities
> when sending the first "qmp_capabilities" command.  Originally we are
> starting QMP session with no arguments like:
>=20
>   { "execute": "qmp_capabilities" }
>=20
> Now we can enable some QMP capabilities using (take OOB as example,
> which is the only one capability that we support):
>=20
>   { "execute": "qmp_capabilities",
>     "argument": { "enable": [ "oob" ] } }
>=20
> When the "argument" key is not provided, no capability is enabled.
>=20
> For capability "oob", the monitor needs to be run on dedicated IO
> thread, otherwise the command will fail.  For example, trying to enable=

> OOB on a MUXed typed QMP monitor will fail.


>=20
> One thing to mention is that, QMP capabilities are per-monitor, and als=
o
> when the connection is closed due to some reason, the capabilities will=

> be reset.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c        | 65 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
>  qapi-schema.json | 15 ++++++++++---
>  2 files changed, 74 insertions(+), 6 deletions(-)
>=20

> @@ -1044,6 +1079,20 @@ void qmp_qmp_capabilities(Error **errp)
>          return;
>      }
> =20
> +    /* Enable QMP capabilities provided by the guest if applicable. */=

> +    if (has_enable) {
> +        qmp_caps_check(cur_mon, enable, &local_err);
> +        if (local_err) {
> +            /*
> +             * Failed check on either of the capabilities will fail

s/either/any/

> +             * the apply of all.

s/apply/application/

or even a more verbose

will fail the entire command (and thus not apply any of the other
capabilities that were also requested).

> @@ -3950,6 +3999,10 @@ static QObject *get_qmp_greeting(void)
>      qmp_marshal_query_version(NULL, &ver, NULL);
> =20
>      for (cap =3D 0; cap < QMP_CAPABILITY__MAX; cap++) {
> +        if (!mon->use_io_thr && cap =3D=3D QMP_CAPABILITY_OOB) {
> +            /* Monitors that are not using IOThread won't support OOB =
*/
> +            continue;
> +        }
>          qlist_append(cap_list, qstring_from_str(QMPCapability_str(cap)=
));

I think this hunk belongs in the previous patch - the server should not
advertise 'oob' in the greeting if it will not be able to honor it.


> +++ b/qapi-schema.json
> @@ -102,21 +102,30 @@
>  #
>  # Enable QMP capabilities.
>  #
> -# Arguments: None.
> +# Arguments:
> +#
> +# @enable:    List of QMPCapabilities to enable, which is optional.

Maybe document that this list must not include any capabilities that
were not mentioned in the server's initial greeting.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rSwNNlskSsjl8d6Y9ax6lsB8ecCVImLQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpZITMACgkQp6FrSiUn
Q2rylggAjbDZAeiuqRBedW/Xcy60J73O1u5y2JzwjGWmvuPSyejkD+3SynIN8wO9
40EEMQQePCDM1UWdW+ztaSxv95iHfis6GYJpHVEd2KNir0uusIr3WO0JPNajG6SI
sANi8Y8AgbSJeugSUfCmxfpE7iOw+M98NGQ0D8BI+q9BrPCqbgfEfBYPr9TGEf8d
wncvF1S4mmDU3h+OUmCBux/7EvAipQfgiuNZnefpolacCM1nZ0h8eeHTzVfBtYrv
1KaIzbmFl186FT+hRRCGzbKIG1NVqj12nCJJpukr0L0EdV1y7chO2AzPqSKp4nYd
6+KmaG8QJnmxy+/w0aRP7vd2EClDDg==
=sl7J
-----END PGP SIGNATURE-----

--rSwNNlskSsjl8d6Y9ax6lsB8ecCVImLQI--
