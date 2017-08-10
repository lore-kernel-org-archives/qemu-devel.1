Received: from eggs.gnu.org ([2001:4830:134:3::10]:39469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfs74-0005Qi-At
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfs70-0005bL-6K
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:23:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfs6z-0005ao-Th
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:23:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3C1772FF1
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 18:23:12 +0000 (UTC)
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c6d31b3-6d1f-f8de-c9bd-74b7e1b324f1@redhat.com>
Date: Thu, 10 Aug 2017 13:23:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170810155522.31099-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8LqpBLUFMc73l5tLT1i5jWohipNaScMP5"
Subject: Re: [Qemu-devel] [PATCH 01/15] ui: add keycodemapdb repository as a
 GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8LqpBLUFMc73l5tLT1i5jWohipNaScMP5
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <7c6d31b3-6d1f-f8de-c9bd-74b7e1b324f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/15] ui: add keycodemapdb repository as a
 GIT submodule
References: <20170810155522.31099-1-berrange@redhat.com>
 <20170810155522.31099-2-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 10:55 AM, Daniel P. Berrange wrote:
> The https://gitlab.com/keycodemap/keycodemapdb/ repo contains a
> data file mapping between all the different scancode/keycode/keysym
> sets that are known, and a tool to auto-generate lookup tables for
> different combinations.
>=20
> It is used by GTK-VNC, SPICE-GTK and libvirt for mapping keys.
> Using it in QEMU will let us replace many hand written lookup
> tables with auto-generated tables from a master data source,
> reducing bugs. Adding new QKeyCodes will now only require the
> master table to be updated, all ~20 other tables will be
> automatically updated to follow.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +
> +ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) ui/Makefile.o=
bjs
> +	$(call quiet-command,\
> +	    $(PYTHON) $(KEYCODEMAP_GEN) \
> +	          --lang glib2 \
> +	          --varname qemu_input_map_$$(echo $@ | sed -e "s,^ui/input-k=
eymap-,," -e "s,\.c$$,,") \
> +	          code-map $(KEYCODEMAP_CSV) \
> +	          $$(echo $@ | sed -E -e "s,^ui/input-keymap-([a-zA-Z0-9]+)2(=
[a-zA-Z0-9]+)\.c$$,\1,") \
> +	          $$(echo $@ | sed -E -e "s,^ui/input-keymap-([a-zA-Z0-9]+)2(=
[a-zA-Z0-9]+)\.c$$,\2,") \

Can this text transformation be done using intrinsic make functions,
instead of requiring the shell to spawn external processes?

The regex looks fragile: if we ever have one keymap named '2abc' and
another named 'xyz2', then the input-keymap-xyz222abc may be difficult
to extract based on greedy matching favoring 'xyz22' 2 'abc'.  Would it
be better to have 'xyz2-to-2abc' as the preferred naming in the
keycodemapdb project, to make sure the conversion names are unambiguous?
 But as this is dependent on keymap names, I don't think it's a
showstopper for this patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8LqpBLUFMc73l5tLT1i5jWohipNaScMP5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMpIwACgkQp6FrSiUn
Q2rcXwgAmwzBQS/4jAAoqHFnWEItF5xfP8dqIULpF2vVqmR+VUjTHDrn3dY5H1Xa
RIJeqVe/ooi5kP7Xt/xJd/h4bslNgxRYBz/bsCruLrVb7RtOKQiWdkVj82furkdj
WZf0H8/ypT2FhRAqIRnvjHEQcCfpn2MagQcziNFlx32hmAt4uLJJySz5K5UCH9zM
fm42WfxgubOE0PNBHQqWF0ZXlLcMxbNdvE9KE+cP6K0lBeDB8VC6tyydk4Z6H/9O
eHI6Xto98rAGK7DmbVAZucXbj22OiK1jmlNDxkV7xS8g1Bjb9fwap5dQmElkFbrv
UO0HkvDUhVdn5NYWU7sQjeeyFJSCFw==
=fM7Q
-----END PGP SIGNATURE-----

--8LqpBLUFMc73l5tLT1i5jWohipNaScMP5--
