Received: from eggs.gnu.org ([2001:4830:134:3::10]:55552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMC3-0003ya-KR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMC2-0002i7-MF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:56:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRMC2-0002hu-Gb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:56:10 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5D0331B315
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:56:10 +0000 (UTC)
Date: Wed, 11 Jan 2017 16:56:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170111165602.GD9269@stefanha-x1.localdomain>
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20170104132625.28059-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-thread: introduce QemuLockCnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2017 at 02:26:17PM +0100, Paolo Bonzini wrote:
> +/* Decrement a counter, and return locked if it is decremented to zero.
> + * It is impossible for the counter to become nonzero while the mutex
> + * is taken.
> + */
> +bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt)
> +{
> +    int val = atomic_read(&lockcnt->count);

I think I've figured out the answer to my question why this isn't an
atomic_mb_read():

The following accesses use atomic_cmpxchg() or atomic_fetch_dec().
There is no adverse effect if we read an outdated value here since the
cmpxchg/fetch_dec are sequentially consistent and explicitly require us
to handle the old value.

> +    while (val > 1) {
> +        int old = atomic_cmpxchg(&lockcnt->count, val, val - 1);
> +        if (old != val) {
> +            val = old;
> +            continue;
> +        }
> +
> +        return false;
> +    }
> +
> +    qemu_lockcnt_lock(lockcnt);
> +    if (atomic_fetch_dec(&lockcnt->count) == 1) {
> +        return true;
> +    }
> +
> +    qemu_lockcnt_unlock(lockcnt);
> +    return false;

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdmOiAAoJEJykq7OBq3PIF3kH/1oHyxgXbFYSG9xAQyrLhyvX
jWs8jN9VVG784bg/isnA9FW9pdKi703CT3n7pg+kbz4KzApZSqnYf1YlQvyS//jh
rZqhrgiilrpdJ189b8dfwRJ1R1iIqY/e7OFmL/XQJ/XpgGNHFxI5TZc5Uqj9wy6D
jfxx/YVolMIpQh6yBlG2n5RsPuU6xRfvbHGg7eVjHSIP/opVWoUwYLxp5xdeug+V
1u9JJkdzijNcl9GM3lTVM1Ykpg5cMwTgSjAFAbFPMxIVQfIV6KDavlrpILc8/OJZ
owQjmHZMdEcjlQY1YaJ5u/euartHbD9W6J80fpULMmUC71DAoSdRIjJLW0ffD9E=
=CoLD
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
