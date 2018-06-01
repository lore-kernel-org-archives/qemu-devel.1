Received: from eggs.gnu.org ([2001:4830:134:3::10]:39352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOks0-0002vo-91
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOkrz-0005rl-42
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:17:32 -0400
Date: Fri, 1 Jun 2018 22:17:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180601141721.GC24752@lemon.usersys.redhat.com>
References: <20180601091835.21620-1-famz@redhat.com>
	<20180601124345.GC3458@redhat.com>
	<20180601133359.GA24752@lemon.usersys.redhat.com>
	<20180601140032.GH3458@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180601140032.GH3458@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] file-posix: Consolidate the locking error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, armbru@redhat.com

On Fri, 06/01 15:00, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 01, 2018 at 09:33:59PM +0800, Fam Zheng wrote:
> > On Fri, 06/01 13:43, Daniel P. Berrang=E9 wrote:
> > > On Fri, Jun 01, 2018 at 05:18:35PM +0800, Fam Zheng wrote:
> > > > When hot-plugging a block device fails due to image locking error=
s,
> > > > users won't see the helpful 'Is another process using the image?'
> > > > message in QMP because currently the error hint is not carried ov=
er
> > > > there.
> > > >=20
> > > > Even though extending QMP to include hint is a conceivably easy t=
ask,
> > > > Libvirt will need some change to consume that data.
> > > >=20
> > > > Before that is fully sorted out, let's just do the easy fix by jo=
ining
> > > > the two lines.
> > >=20
> > > There are many places in QEMU which uses error hints and these are =
all
> > > invisible to libvirt. Arbitrarily picking one hint to remove, while
> > > leaving everything else unfixed is not a very satisfactory approach=
.
> > >=20
> > > If QEMU passes the hint in QMP, it is trivial for libvirt to be cha=
nged
> > > to append the hint when reporting its own error message, so can we =
just
> > > focus on fixing the root cause instead of special casing file-posix=
.c
> >=20
> > The plan was to work on the QMP change in parallel, while this simple=
 patch can
> > mitigate the confusion caused by the relatively vague message (the te=
xt itself
> > is going a bit on the cryptic side for people who don't know QEMU int=
ernals).
>=20
> I still don't think that it makes sense to remove the use of hints in t=
he
> block layer.

I have no inclination to changing any other hints in the block layer. See
below..

>=20
> If we don't care about improved error messages for existing libvirt
> versions, we can just add a 'hint' field in QMP and let new libvirt
> use that:
>=20
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 935f9e159c..82eb823f1f 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -132,9 +132,15 @@ static QObject *do_qmp_dispatch(QmpCommandList *cm=
ds, QObject *request,
> =20
>  QObject *qmp_build_error_object(Error *err)
>  {
> -    return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
> -                              QapiErrorClass_str(error_get_class(err))=
,
> -                              error_get_pretty(err));
> +    const char *hint =3D error_get_hint(err);
> +    if (hint)
> +        return qobject_from_jsonf("{ 'class': %s, 'desc': %s, 'hint': =
%s }",
> +                                  QapiErrorClass_str(error_get_class(e=
rr)),
> +                                  error_get_pretty(err), hint);
> +    else
> +        return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
> +                                  QapiErrorClass_str(error_get_class(e=
rr)),
> +                                  error_get_pretty(err));
>  }
> =20
>  /*
>=20
>=20
> there's no error_get_hint method right now, but its impl is essentially
> the same as error_get_pretty.
>=20
>=20
> If, however, we want to get better error messages for existing libvirt,
> then, we should do:
>=20
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 935f9e159c..bf6f92375a 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -132,9 +132,18 @@ static QObject *do_qmp_dispatch(QmpCommandList *cm=
ds, QObject *request,
> =20
>  QObject *qmp_build_error_object(Error *err)
>  {
> -    return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
> -                              QapiErrorClass_str(error_get_class(err))=
,
> -                              error_get_pretty(err));
> +    const char *hint =3D error_get_hint(err);
> +    const char *msg;
> +    if (hint) {
> +        msg =3D g_strdup_printf("%s: %s", error_get_pretty(), hint);
> +    } else {
> +        msg =3D g_strdup(error_get_pretty());
> +    }
> +    QObject *ret =3D qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
> +                                      QapiErrorClass_str(error_get_cla=
ss(err)),
> +                                      msg);
> +    g_free(msg);
> +    return ret;
>  }
> =20
>  /*
>=20
> Personally I'd just go for the first case and only care about new libvi=
rts.

Yes I think that is the plan. And that's the reason for exceptional cases=
 like
this patch, for older libvirts (which of course is subjective).

Fam
