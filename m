Received: from eggs.gnu.org ([208.118.235.92]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gf0e1-0006K8-1N
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gf0dx-00020S-Jg
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:54:32 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gf0dw-0001zJ-Kt
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:54:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id y185so34581546wmd.1
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 02:54:27 -0800 (PST)
Date: Thu, 3 Jan 2019 10:54:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190103105425.GF7733@stefanha-x1.localdomain>
References: <20181214105642.673-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline
In-Reply-To: <20181214105642.673-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2018 at 11:56:42AM +0100, Christophe Fergeau wrote:
> +static void qemu_log_func(const gchar *log_domain,
> +                          GLogLevelFlags log_level,
> +                          const gchar *message,
> +                          gpointer user_data)
> +{
> +    switch (log_level & G_LOG_LEVEL_MASK) {
> +    case G_LOG_LEVEL_DEBUG:
> +        /* Use same G_MESSAGES_DEBUG logic as glib to enable/disable debug
> +         * messages
> +         */
> +        if (qemu_glog_domains == NULL) {
> +            break;
> +        }
> +        if (strcmp(qemu_glog_domains, "all") != 0 &&
> +          (log_domain == NULL || !strstr(qemu_glog_domains, log_domain))) {
> +            break;
> +        }
> +        /* Fall through */
> +    case G_LOG_LEVEL_INFO:
> +        /* Fall through */
> +    case G_LOG_LEVEL_MESSAGE:
> +        info_report("%s: %s", log_domain, message);

QEMU itself uses glib, so what happens if *_report() emit more log
messages?  Can this result in an infinite loop?

Stefan

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLenhAAoJEJykq7OBq3PIWoEH/RL6mUlQz3KaffL5WOP8CLDz
Us9TjLzw8ZServRTl3tcA3tX3bqRQeHEhRQNQGovEns3f6T0nzzLguYZ20mBezYT
YkYBvRFCf69H0143oCrYGWEsJHayfiFdpzj3vXAJeqolOGcvsMsunOg7u3eSwcXE
jXHLDiGBqmf27IBDZ+Kaxv4Qbzz9MXAWy7AZFcPAsG3eMOxo4xPJAOACrh3azvSG
KbfxvNlik8L5ZiTPm7/bxivajVumw6fJnQujkx/pDIXvi+PqHNgQBJrGpkV6OwzN
81vT5JhaP0NuYhWhL18wOHijfPD4g4ECY2N/42aaKMmCmLWwkyJR4Va8UqrN/Mc=
=uA7H
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
