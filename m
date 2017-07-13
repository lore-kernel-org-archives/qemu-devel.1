Received: from eggs.gnu.org ([2001:4830:134:3::10]:60516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVeEA-00041e-7E
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVeE5-0003WQ-GU
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVeE5-0003VD-BJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:32:17 -0400
Date: Thu, 13 Jul 2017 14:32:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170713133206.GA18623@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-2-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20170713110237.6712-2-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] qemu-error: introduce
 error_report_nolf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2017 at 01:02:30PM +0200, Ladi Prosek wrote:
> +/*
> + * Print an error message to current monitor if we have one, else to stderr.
> + * Format arguments like sprintf().  The resulting message should be a
> + * single phrase, with no trailing punctuation.  The no-LF version allows
> + * additional text to be appended with error_printf() or error_vprintf().
> + * Make sure to always close with a newline after all text is printed.
> + * Prepends the current location.
> + * It's wrong to call this in a QMP monitor.  Use error_setg() there.
> + */
> +void error_report_nolf(const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    error_vreport_nolf(fmt, ap);
> +    va_end(ap);
>  }

Each call to this function prepends the timestamp, so it cannot really
be used for a sequence of prints in a single line.

It's a little ugly but I expected something along the lines of
g_strdup_vprintf() in virtio_error():

  char *msg;

  va_start(ap, fmt);
  msg = g_strdup_vprintf(fmt, ap);
  va_end(ap);

  error_report("%s: %s", DEVICE(vdev)->id, msg);

  g_free(msg);

https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.html#g-strdup-vprintf

Stefan

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZ3ZWAAoJEJykq7OBq3PIsEgIAItwFdDBhGOwztLztQ6dCXxy
gOxxcQ6Rl1zpaOznJ8ZYzf10s9R5lXLgf+0+BOXjZbymjlyhY1e9WgpaCM4uIoE6
EZUAsGZoKg4NoKdbqTknvcIiJPZwv7NqHqxb35EKwtNKgIzKCHvTVact783S70Ge
1qHQ0BvUycHIRz7XVMzgOR2SWlNzngKJnClBBCh+sPm5lvPiKsHoCvVtLWJGBikj
xpmi6NXATrLp2ygG5JWhrt3KfAM8cCxLXloNK2DSxVn5EyZI2sznwleWVvlJoiLk
UoJmH5KWWOzWfB7m3Lmx9QjF6H6gwNxe4MBJOmJD2iciJlzETBt9vwkkDKHE8A4=
=f4KK
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
