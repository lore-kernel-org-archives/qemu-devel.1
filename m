Received: from eggs.gnu.org ([2001:4830:134:3::10]:47337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAi5H-0000uF-7i
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 16:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAi5E-0005D3-3k
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 16:29:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42122 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fAi5D-0005Cu-UY
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 16:29:08 -0400
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
	<20180423162142.GG1980@perard>
	<23262.3101.567189.675156@mariner.uk.xensource.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4402483b-17fd-60e0-4f00-05887a11320d@redhat.com>
Date: Mon, 23 Apr 2018 15:28:54 -0500
MIME-Version: 1.0
In-Reply-To: <23262.3101.567189.675156@mariner.uk.xensource.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pxJ9cOQl3vS3mdTW0LXmco02irVWCjfD8"
Subject: Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some
 extra info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, "Kent R. Spillner" <kspillner@acm.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pxJ9cOQl3vS3mdTW0LXmco02irVWCjfD8
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@citrix.com>,
 Anthony PERARD <anthony.perard@citrix.com>
Cc: Juergen Gross <jgross@suse.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Kent R. Spillner" <kspillner@acm.org>, qemu-devel@nongnu.org,
 Ross Lagerwall <ross.lagerwall@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Message-ID: <4402483b-17fd-60e0-4f00-05887a11320d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some
 extra info under bash
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
 <20180423162142.GG1980@perard>
 <23262.3101.567189.675156@mariner.uk.xensource.com>
In-Reply-To: <23262.3101.567189.675156@mariner.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/23/2018 11:38 AM, Ian Jackson wrote:

> You are right.  Perhaps my testing was inadequate.  I wrote this a
> long while ago, and if there was a syntax along these lines that DTRT
> in both bash and dash in my tests it is long gone.  Starting de novo,
> the following code works for me:
>=20
>     (echo >>config.log "
>  funcs: ${FUNCNAME[*]}
>  lines: ${BASH_LINENO[*]}
>  files: ${BASH_SOURCE[*]}") 2>/dev/null ||:

That's still fork-heavy.  You could do:

test -n "$BASH_VERSION" && eval '
echo >>config.log "
funcs: ${FUNCNAME[*]}
lines: ${BASH_LINENO[*]}
files: ${BASH_SOURCE[*]}"'

which avoids the fork, but remains silent on dash.

>=20
> With bash I get the expected information in config.log, which looks
> like this:
>=20
>  funcs: do_compiler do_cc compile_prog cc_has_warning_flag main
>  lines: 91 124 1720 1724 0
>  files: ./configure ./configure ./configure ./configure ./configure

Is files: really useful information?  The other two are (as it gives a
full stack trace), but if we aren't actively sourcing lots of other
files, seeing a bunch of ./configure doesn't add much.

>=20
> With dash the script runs but there is nothing from this segment in
> the log.  Without the 2>/dev/null, it prints
>   ./configure: 63: ./configure: Bad substitution
> so the syntax error is indeed being suprresed and ignored.
>=20
> The ( ) is necessary because syntax errors are not like set -e errors:
> they cause the shell process to exit.

See above - a well-quoted eval is sufficient to avoid a subshell.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pxJ9cOQl3vS3mdTW0LXmco02irVWCjfD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlreQgYACgkQp6FrSiUn
Q2otVAf9FsAjb18IqkNI4RD/AGpwEVf0wWminFqWjxT/7qWTse7ClwoYdu8P3+7v
a1UgTXD6oFEeCSHNvArIDv2wYGSZ9OwOcZkmp5zICcRBG+zberM2EM1of97jCEUn
uD5GZPUIvwjaGKHBin70mbmWXNcqiYGhgkSB3yGXKRfyr6GbW0bxynaDbRvtg6hD
+N+RliJQytMVr5JZk6Y0wdzqS9P4LR8SzVXPB/POandE20ca/WWXLcnB/8ci24BF
0+f/lIBZw4cVXKJ2Lu6oYWX/4AYVHye13O+/6HiGYoJYeme6JqgH3waz+Qxeguwp
gsG8GIUahMr89Y0fLp71eBB8eZZzhA==
=uxB0
-----END PGP SIGNATURE-----

--pxJ9cOQl3vS3mdTW0LXmco02irVWCjfD8--
