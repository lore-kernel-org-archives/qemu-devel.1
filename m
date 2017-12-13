Received: from eggs.gnu.org ([2001:4830:134:3::10]:50780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9lv-0007xn-Of
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9lq-0007Eb-MI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP9lq-0007E5-Dj
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:20:34 -0500
Date: Wed, 13 Dec 2017 16:20:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213162022.GJ7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CxDuMX1Cv2n9FQfo"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-10-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 09/26] monitor: create monitor dedicate
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--CxDuMX1Cv2n9FQfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:43PM +0800, Peter Xu wrote:
> @@ -208,6 +209,12 @@ struct Monitor {
>      QTAILQ_ENTRY(Monitor) entry;
>  };
> =20
> +struct MonitorGlobal {
> +    IOThread *mon_iothread;
> +};
> +
> +static struct MonitorGlobal mon_global;

structs can be anonymous.  That avoids the QEMU coding style violation
(structs must be typedefed):

  static struct {
      IOThread *mon_iothread;
  } mon_global;

In general global variables are usually top-level variables in QEMU.
I'm not sure why wrapping globals in a struct is useful.

> @@ -4117,6 +4136,16 @@ void monitor_cleanup(void)
>  {
>      Monitor *mon, *next;
> =20
> +    /*
> +     * We need to explicitly stop the iothread (but not destroy it),
> +     * cleanup the monitor resources, then destroy the iothread.  See
> +     * again on the glib bug mentioned in 2b316774f6 for a reason.
> +     *
> +     * TODO: the bug is fixed in glib 2.28, so we can remove this hack
> +     * as long as we won't support glib versions older than it.
> +     */

I find this comment confusing.  There is no GSource .finalize() in
monitor.c so why does monitor_cleanup() need to work around the bug?

I see that monitor_data_destroy() is not thread-safe so the IOThread
must be stopped first.  That is unrelated to glib.

> +    iothread_stop(mon_global.mon_iothread);
> +
>      qemu_mutex_lock(&monitor_lock);
>      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
>          QTAILQ_REMOVE(&mon_list, mon, entry);
> @@ -4124,6 +4153,9 @@ void monitor_cleanup(void)
>          g_free(mon);
>      }
>      qemu_mutex_unlock(&monitor_lock);
> +
> +    iothread_destroy(mon_global.mon_iothread);
> +    mon_global.mon_iothread =3D NULL;
>  }
> =20
>  QemuOptsList qemu_mon_opts =3D {
> --=20
> 2.14.3
>=20

--CxDuMX1Cv2n9FQfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMVNGAAoJEJykq7OBq3PIBAEH/Ah/OFMGfWyDSv8VuYy9StxL
MH2GEjoYYqQwMohFAueQPKQ76SFPjsuylunVOVICqPi78IV5o+l0gMITfdvJu4XZ
yM4imLahKjL/fSRiAtPk4wYrMjMFoE8PRmN70RSYeZ1NqXPpSb1SMp+Y3EUB168q
EriBh9Cin6uei7Q7NbYmoViNkx7EIwz2K9+meHd9S9CRaunbRirOpmvfAhp+pcN4
eDrS89xczSCCnL6+TAY0YNn1w9efe/fpecUG9pN5Uq3kY7A8kZhHH0jScxmTlV3l
zKlpmDMeeszmo+OkKfRrMcUiKt6zWgpHPeuFmYTFx961t6s9II3DDsd/CD0kCoU=
=OMJH
-----END PGP SIGNATURE-----

--CxDuMX1Cv2n9FQfo--
