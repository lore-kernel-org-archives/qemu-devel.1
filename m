Received: from eggs.gnu.org ([2001:4830:134:3::10]:57568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk9Px-0005V8-SE
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk9Pv-0002Vv-8v
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:40:29 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170822132255.23945-12-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-12-marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:40:24 +0200
Message-ID: <w51wp5vg1pz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/54] quorum: use qapi_enum_parse() in
 quorum_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open
	list:Quorum" <qemu-block@nongnu.org>

On Tue 22 Aug 2017 03:22:12 PM CEST, Marc-Andr=C3=A9 Lureau wrote:

> @@ -925,7 +908,13 @@ static int quorum_open(BlockDriverState *bs, QDict *=
options, int flags,
>          goto exit;
>      }
>=20=20
> -    ret =3D parse_read_pattern(qemu_opt_get(opts, QUORUM_OPT_READ_PATTER=
N));
> +    if (!qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN)) {
> +        ret =3D QUORUM_READ_PATTERN_QUORUM;
> +    } else {
> +        ret =3D qapi_enum_parse(QuorumReadPattern_lookup,
> +                              qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN=
),
> +                              QUORUM_READ_PATTERN__MAX, -EINVAL, NULL);
> +    }

I don't like so much that you call qemu_opt_get() twice with the same
parameters, but else the change makes sense.

Berto
