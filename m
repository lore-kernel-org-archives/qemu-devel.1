Received: from eggs.gnu.org ([2001:4830:134:3::10]:43012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdI4R-0001Ax-1r
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdI4N-0005IP-Qh
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:57:39 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdI4N-0005IK-Je
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:57:35 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so19911156wmv.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 06:57:35 -0800 (PST)
Date: Mon, 13 Feb 2017 14:57:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213145732.GN10361@stefanha-x1.localdomain>
References: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dPW7zu3hTOhZvCDO"
Content-Disposition: inline
In-Reply-To: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com


--dPW7zu3hTOhZvCDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 08:18:13PM -0800, Ashish Mittal wrote:
> +static int vxhs_parse_uri(const char *filename, QDict *options)
> +{
> +    URI *uri =3D NULL;
> +    char *hoststr, *portstr;
> +    char *port;
> +    int ret =3D 0;
> +
> +    trace_vxhs_parse_uri_filename(filename);
> +    uri =3D uri_parse(filename);
> +    if (!uri || !uri->server || !uri->path) {
> +        uri_free(uri);
> +        return -EINVAL;
> +    }
> +
> +    hoststr =3D g_strdup(VXHS_OPT_SERVER".host");
> +    qdict_put(options, hoststr, qstring_from_str(uri->server));
> +    g_free(hoststr);
> +
> +    portstr =3D g_strdup(VXHS_OPT_SERVER".port");
> +    if (uri->port) {
> +        port =3D g_strdup_printf("%d", uri->port);
> +        qdict_put(options, portstr, qstring_from_str(port));
> +        g_free(port);
> +    }
> +    g_free(portstr);
> +
> +    if (strstr(uri->path, "vxhs") =3D=3D NULL) {
> +        qdict_put(options, "vdisk-id", qstring_from_str(uri->path));
> +    }
> +
> +    trace_vxhs_parse_uri_hostinfo(1, uri->server, uri->port);

What is the purpose of the first argument?

> +    str =3D g_strdup_printf(VXHS_OPT_SERVER".");
> +    qdict_extract_subqdict(options, &backing_options, str);
> +
> +    /* Create opts info from runtime_tcp_opts list */
> +    tcp_opts =3D qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abo=
rt);
> +    qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
> +    if (local_err) {
> +        qdict_del(backing_options, str);

What is qdict_del(backing_options, VXHS_OPT_SERVER".") supposed to do?
The same call is made further down too.

> +        qemu_opts_del(tcp_opts);
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> +
> +    server_host_opt =3D qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
> +    if (!server_host_opt) {
> +        error_setg(&local_err, QERR_MISSING_PARAMETER,
> +                   VXHS_OPT_SERVER"."VXHS_OPT_HOST);
> +        ret =3D -EINVAL;
> +        goto out;

Missing qemu_opts_del(tcp_opts).

> +    }
> +
> +    if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
> +        error_setg(errp, "server.host cannot be more than %d characters",
> +                   MAXHOSTNAMELEN);
> +        ret =3D -EINVAL;
> +        goto out;

Missing qemu_opts_del(tcp_opts).

> @@ -5114,6 +5147,7 @@ echo "tcmalloc support  $tcmalloc"
>  echo "jemalloc support  $jemalloc"
>  echo "avx2 optimization $avx2_opt"
>  echo "replication support $replication"
> +echo "VxHS block device $vxhs"
> =20
>  if test "$sdl_too_old" =3D "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL suppor=
t"
> @@ -5729,6 +5763,12 @@ if test "$pthread_setname_np" =3D "yes" ; then
>    echo "CONFIG_PTHREAD_SETNAME_NP=3Dy" >> $config_host_mak
>  fi
> =20
> +if test "$vxhs" =3D "yes" ; then
> +  echo "CONFIG_VXHS=3Dy" >> $config_host_mak
> +  echo "VXHS_CFLAGS=3D$vxhs_cflags" >> $config_host_mak

Please drop this unused variable.

--dPW7zu3hTOhZvCDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYoclcAAoJEJykq7OBq3PI5nIH+QFvwDTqdAay43jpRTW3lzDX
DkiiQF4Xo+3x8IXmnufceF7Pk+Bsn0/yxy1rDb6qTq8tcc0sG4ad3EAmPIoSOur5
9VDLz7iDHG7RO6JqLNGRQrBNjFLg9AHElcLpspXIO/YWbDDl1UeAgdJ1hed2ZDUP
Jj2IczyVY5NmYHyPVbYTi0TTuMThMGj58a+YvrF8tZWQlQRq8hnPoLE355BhdGtc
FyrYfzPOa9bW4R6duyL0eg4Nr33ZUEsJ2kz1rD4GDWZyK8QoTHhajQ0mEX6BeS7z
qkk/93g3K5Ps/nraaIC83ynxt2gFtY3aZiAtY1cvV0SQmF6aw26UaQRm4vxMDHA=
=NeZo
-----END PGP SIGNATURE-----

--dPW7zu3hTOhZvCDO--
