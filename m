Received: from eggs.gnu.org ([2001:4830:134:3::10]:52263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGiYN-0005Fz-ST
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGiYK-000285-MD
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:12:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fGiYK-00027t-I2
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:12:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3C4C8185344
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 10:11:59 +0000 (UTC)
Date: Thu, 10 May 2018 11:11:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510101158.GQ1296@stefanha-x1.localdomain>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DCA/C9WSnDtl50zu"
Content-Disposition: inline
In-Reply-To: <20180509041734.14135-3-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] monitor: protect mon->fds with
 mon_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--DCA/C9WSnDtl50zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 12:17:32PM +0800, Peter Xu wrote:
> mon->fds were protected by BQL.  Now protect it by mon_lock so that it
> can even be used in monitor iothread.

Only monitor_get_fd() can safely be called from the monitor iothread
(oob).

The other functions call close(2), which may block, and therefore aren't
allowed in oob code.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DCA/C9WSnDtl50zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9BruAAoJEJykq7OBq3PIomkH+wVjqiEcxb+YtuRlcuAPKk81
nSBFCHFmLy1dOTEKKVznOiShHvcNz+drsfvdQf4VLdC8ivCrZLe07u4dkQEtMbAP
fa3E6PtEFc9IliYNmvcAW2Xiv5bsyOWB8gkMFYPiO+BY/xoz9RzkyQn6u6gOf9du
pjXgAyuohpg3tZyvVmYWIxjxXqlnml79H3ZnIgekZr1TuEQvHhCZFoxzC1VNdWES
npycA9BoRQWuD2z9nVzenaJZg/gAehA1FAcsgIg3dnavGc2y2cC7mEP5hjbYRHbe
723UH8sfigKy8XHN0f64LVqcYKPp4M5p3JbUlWgqO9vgxl5KPShQ9kKPfKAoQhw=
=hkwH
-----END PGP SIGNATURE-----

--DCA/C9WSnDtl50zu--
