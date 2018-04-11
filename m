Received: from eggs.gnu.org ([2001:4830:134:3::10]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f64pe-0000t5-0l
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f64pa-0005e3-VA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:45:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f64pa-0005dn-Pn
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:45:50 -0400
Date: Wed, 11 Apr 2018 09:45:32 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180411014532.GB28698@stefanha-x1.localdomain>
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20180410124913.10832-3-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 10, 2018 at 08:49:13PM +0800, Peter Xu wrote:
> cur_mon was only used in main loop so we don't really need that to be
> per-thread variable.  Now it's possible that we have more than one
> thread to operate on it.  Let's start to let it be per-thread variable.

Trying to understand the reason for this patch:

Are there any users of per-thread cur_mon?

or

Does this patch fix a bug?

> In case we'll create threads within a valid cur_mon setup, we'd better
> let the child threads to inherit the cur_mon from parent thread too.  Do
> that for both posix and win32 threads.

Without actual users I don't like this.  It sounds like "let's make it
global just in case something needs it some day".

It's ugly for QEMU's thread API to know about the monitor - that's a
layering violation.

If there's a legitimate need I think this patch might be necessary, but
I don't see enough justification to do this yet.

Stefan

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazWi7AAoJEJykq7OBq3PI+qkH/1VrA8IpjF+1RN0dg0q1f4v+
L6G81XQ0QRvll/pDw6S4FfutIe6ukxo0bdVd77OSUyJcFxcgVgWCOp5vbcl9RLFo
QVRAARySKMCk1XaJljblI7mu+/eTx2gN5BrH8lZFjkdDiv1vb9BqLtGMhMB97oaL
z5D2g1gpdx0kJZuBE8p+6Ch+1vKfbVe1Z4O2UCMjB+kj75hoHN/Cbk/0wjwDS1OI
fsVIdKsQcqtVDHd1H6XSMXdNK9dPsUWhBPDLrVsuYBXxYT8Hp53eU6vD2/JXzqL4
cWaUcewXBiF3DpGIz3CdxmBaXdy6NQ1ep/bjGrAvZuCpqCaeW629J7wSVYCyX3w=
=zBJ7
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
