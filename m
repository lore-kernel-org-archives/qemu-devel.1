Received: from eggs.gnu.org ([2001:4830:134:3::10]:40194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEEzo-0005VH-RW
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEEzl-0005Pd-Fw
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:09:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dEEzl-0005PD-70
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:09:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CCF33DBEF
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 13:09:32 +0000 (UTC)
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97bb0fa8-eddf-5721-6578-7223bc6e6bed@redhat.com>
Date: Fri, 26 May 2017 08:08:59 -0500
MIME-Version: 1.0
In-Reply-To: <1495649128-10529-2-git-send-email-vyasevic@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fWtHMmFxlUJom0o3JiDo4NvNMsUtCIhfM"
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, kashyap@redhat.com, jdenemar@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fWtHMmFxlUJom0o3JiDo4NvNMsUtCIhfM
From: Eric Blake <eblake@redhat.com>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, mst@redhat.com,
 jasowang@redhat.com, armbru@redhat.com, kashyap@redhat.com,
 jdenemar@redhat.com
Message-ID: <97bb0fa8-eddf-5721-6578-7223bc6e6bed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
 <1495649128-10529-2-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-2-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 01:05 PM, Vladislav Yasevich wrote:
> Add parameters that control RARP/GARP announcement timeouts.
> The parameters structure is added to the QAPI and a qmp command
> is added to set/get the parameter data.
>=20
> Based on work by "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> ---

Just an interface review for now:

> +++ b/qapi-schema.json
> @@ -569,6 +569,90 @@
>  ##
>  { 'command': 'query-events', 'returns': ['EventInfo'] }
> =20
> +
> +##
> +# @AnnounceParameter:
> +#
> +# @AnnounceParameter enumeration
> +#
> +# @initial: Initial delay (in ms) before sending the first GARP/RARP
> +#       announcement
> +#
> +# @max: Maximum delay (in ms) to between GARP/RARP announcemnt packets=


s/announcemnt/announcement/

> +#
> +# @rounds: Number of self-announcement attempts
> +#
> +# @step: Delay increate (in ms) after each self-announcment attempt

s/increate/increase/
s/announcment/announcement/

> +#
> +# Since: 2.10
> +##
> +{ 'enum' : 'AnnounceParameter',
> +  'data' : [ 'initial', 'max', 'rounds', 'step' ] }

Why are we creating an enum here?  Without reading further, it looks
like you plan on using the enum to delineate members of a union? But
that feels like it will be overly complicated.  A struct should be
sufficient (each parameter being an optional member of the struct, where
you can supply as many or as few on input, but all are reported on output=
).

> +
> +##
> +# @AnnounceParameters:
> +#
> +# Optional members may be omited on input, but all values will be pres=
ent

s/omited/omitted/

> +# on output.
> +#          =20
> +# @initial: Initial delay (in ms) before sending the first GARP/RARP
> +#       announcement
> +#
> +# @max: Maximum delay (in ms) to between GARP/RARP announcemnt packets=


s/announcemnt/announcement/

> +#
> +# @rounds: Number of self-announcement attempts
> +#
> +# @step: Delay increate (in ms) after each self-announcment attempt

s/increate/increase/
s/announcment/announcement/

> +#
> +# Since: 2.10
> +##
> +
> +{ 'struct': 'AnnounceParameters',
> +  'data': { '*initial': 'int',
> +            '*max': 'int',
> +            '*rounds': 'int',
> +            '*step': 'int' } }
> +
> +##
> +# @announce-set-parameters:
> +#
> +# Set qemu announce parameters.
> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "execute": "announce-set-parameters",
> +#      "arguments": { "announce-rounds": 10 } }
> +#
> +##
> +{ 'command': 'announce-set-parameters', 'boxed': true,
> +  'data': 'AnnounceParameters' }
> +
> +##
> +# @query-announce-parameters:
> +#
> +# Returns information about the current announce parameters
> +#
> +# Returns: @AnnounceParameters
> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "execute": "query-announce-parameters" }
> +# <- { "return": {
> +#          "initial": 50,
> +#          "max": 500,
> +#          "rounds": 5,
> +#          "step": 100
> +#       }
> +#    }
> +#
> +##
> +{ 'command': 'query-announce-parameters',
> +  'returns': 'AnnounceParameters' }

Yep, I'm right. The enum is bogus.  The struct is sufficient, so you
don't need the enum.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fWtHMmFxlUJom0o3JiDo4NvNMsUtCIhfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKCjsAAoJEKeha0olJ0Nq/9AH/3cZ2VBNZdj1QB4mGX/IZBAj
geiV31YHTG77Ep3ZmrTL+aiIK2cVu8a99IHXpeKDFHvuOTKwPYNMbIaNXKmi3tbw
mZNPNPNwP6aN/rU86CLh7xpHoQS+cyRXG+hytz76ZgT/luTUdCm531vumFOXp2bI
MDtfDMzpGpPOH5ba657aS8eCIrcwHfdx6EwSyV1QLnzmttou4QupQhY4jijc/il7
aaVe+GJzR/OWMrhYY1eW0SXjfl0VJLULz8wvTbib3DtxwyZXoQJt+0aHSfgMFLG9
osPselLVVfOtiQdkZviXRN/ar+T83T1IxCCDULQzbkfUMk+ZpebCINN33rQoFQY=
=wx2/
-----END PGP SIGNATURE-----

--fWtHMmFxlUJom0o3JiDo4NvNMsUtCIhfM--
