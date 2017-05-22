Received: from eggs.gnu.org ([2001:4830:134:3::10]:42685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCuv6-00020h-E8
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCuv1-0007Cl-Rp
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCuv1-0007CY-IH
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CCA3883A4
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 21:31:10 +0000 (UTC)
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
	<20170113144135.5150-15-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ec5271f-67c2-119a-9a01-95275e6b683d@redhat.com>
Date: Mon, 22 May 2017 16:31:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170113144135.5150-15-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IlWnVdWJOT0vQgeEckQGPqHE2FQTihD7J"
Subject: Re: [Qemu-devel] [PATCH v8 14/21] (SQUASHED) move doc to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IlWnVdWJOT0vQgeEckQGPqHE2FQTihD7J
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <7ec5271f-67c2-119a-9a01-95275e6b683d@redhat.com>
Subject: Re: [PATCH v8 14/21] (SQUASHED) move doc to schema
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
 <20170113144135.5150-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 08:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> qmp-commands: move 'add_client' doc to schema
>=20

Sadly, the squashed version introduced some documentation regressions.
For example, the documentation for blockdev-snapshot (got merged as
commit 3282eca4):

> @@ -983,9 +1193,31 @@
>  #
>  # Generates a snapshot of a block device.
>  #
> +# Create a snapshot, by installing 'node' as the backing image of
> +# 'overlay'. Additionally, if 'node' is associated with a block
> +# device, the block device changes to using 'overlay' as its new activ=
e
> +# image.
> +#
>  # For the arguments, see the documentation of BlockdevSnapshot.
>  #
>  # Since: 2.5
> +#
> +# Example:
> +#
> +# -> { "execute": "blockdev-add",
> +#      "arguments": { "options": { "driver": "qcow2",
> +#                                  "node-name": "node1534",
> +#                                  "file": { "driver": "file",
> +#                                            "filename": "hd1.qcow2" }=
,
> +#                                  "backing": "" } } }
> +#
> +# <- { "return": {} }
> +#
> +# -> { "execute": "blockdev-snapshot",
> +#      "arguments": { "node": "ide-hd0",
> +#                     "overlay": "node1534" } }
> +# <- { "return": {} }
> +#

reintroduced the bogus 'options' layer, which was not present in the
pre-move text:

> -blockdev-snapshot
> ------------------
> -Since 2.5
> -
> -Create a snapshot, by installing 'node' as the backing image of
> -'overlay'. Additionally, if 'node' is associated with a block
> -device, the block device changes to using 'overlay' as its new active
> -image.
> -
> -Arguments:
> -
> -- "node": device that will have a snapshot created (json-string)
> -- "overlay": device that will have 'node' as its backing image (json-s=
tring)
> -
> -Example:
> -
> --> { "execute": "blockdev-add",
> -                "arguments": { "driver": "qcow2",
> -                               "node-name": "node1534",
> -                               "file": { "driver": "file",
> -                                         "filename": "hd1.qcow2" },
> -                               "backing": "" } }
> -
> -<- { "return": {} }
> -
> --> { "execute": "blockdev-snapshot", "arguments": { "node": "ide-hd0",=

> -                                                    "overlay": "node15=
34" } }
> -<- { "return": {} }
> -

where 'options' had been cleaned up in commit 0153d2f.

I really don't feel like auditing what other doc changes were
inadvertently regressed (probably anything that changed between when
Marc-Andr=C3=A9 first branched his work, and when Markus finally merged i=
t -
which could be several months of commits to double-check); it might be
sufficient to just review commits 65ce54f..c08d644 to look for any
differences?  Is that something we can automate by script?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IlWnVdWJOT0vQgeEckQGPqHE2FQTihD7J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZI1iaAAoJEKeha0olJ0NqYLwH/2eRdhQIJUY1TezRsPuJ5W6J
7gY3B3oTVMzkOjK4/Xr3oHm2qlQoSSC8U1fQ+SiCtpYejq+ZSll/qE0mFKWQQm7f
mibFWl2gzMCXQ3w1djmdgvKzUfuscJawd7DziKUxrFCt2x6ydPGGmWhG+QBpObgI
1vfZIa2flGDotVRmCq2C3Zw91Rm0kWxxaAt3Zh4/iuWZyKg6JVZX8IvSRu8Ay+CC
tM8rNwDyKswtCLg9Uc+Q8oKt+fESe6dS6K11dj+2ovdQDUU9qIcH0Y4cbwjs7ATq
D1Sk8q6vKUj5AzyZx+iOA5VqA/JkxVW0qn3C0z1y7m6NgkW5SZRWtOKf7pihu3M=
=AWYN
-----END PGP SIGNATURE-----

--IlWnVdWJOT0vQgeEckQGPqHE2FQTihD7J--
