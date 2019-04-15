Received: from eggs.gnu.org ([209.51.188.92]:38245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFyr7-0006u6-8v
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFyr6-0003bg-8u
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hFyr4-0003ZZ-US
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:28:52 -0400
Date: Mon, 15 Apr 2019 11:28:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190415102838.GH5718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-13-richard.henderson@linaro.org>
	<6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
	<66f73b23-11cc-b5b3-e4ca-34776a4faf32@linaro.org>
	<bed878ef-0ce1-1081-a4cb-88b7775d1433@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bed878ef-0ce1-1081-a4cb-88b7775d1433@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/23] linux-user: Call qcrypto_init if
 not using -seed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On Mon, Apr 15, 2019 at 12:23:18PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 4/13/19 8:44 AM, Richard Henderson wrote:
> > On 4/10/19 11:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> -    if (seed_optarg !=3D NULL) {
> >>> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
> >>> +    {
> >> Since 7be41675f7c we use gnu99 C, so this extra block indentation ca=
n be
> >> removed.
> >>
> >>> +        Error *err =3D NULL;
> >>> +        if (seed_optarg !=3D NULL) {
> >>> +            qemu_guest_random_seed_main(seed_optarg, &err);
> >>> +        } else {
> >>> +            /* ??? Assumes qcrypto is only used by qemu_guest_getr=
andom.  */
> >>> +            qcrypto_init(&err);
> >>> +        }
> >>> +        if (err) {
> >>> +            error_reportf_err(err, "cannot initialize crypto: ");
> >>> +            exit(1);
> >>> +        }
> >>>      }
> >=20
> > I could, but it also limits the scope, which is of more importance to=
 variables
> > who have their address taken.  It means that their storage could (in =
theory) be
> > shared with objects not overlapping in scope.
>=20
> Fine then.
>=20
> I think your '???' comment is appropriate but I'd rather let Daniel
> opinate. Except that comment, for the rest:

In linux-user context, afaik, the random APIs are the only stuff that
will be used, none of the hash or cipher stuff is needed.

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
