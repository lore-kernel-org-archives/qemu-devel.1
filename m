Received: from eggs.gnu.org ([2001:4830:134:3::10]:47532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0OCg-0003PD-S3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0OCb-0000ve-6G
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:14:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0OCb-0000tE-02
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:14:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B18E80401A8
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 09:14:04 +0000 (UTC)
Date: Mon, 26 Mar 2018 17:13:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180326091351.GD17789@xz-mi>
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-4-peterx@redhat.com>
	<CAMxuvawX2yzMpMYNsB6b-8NP6iXm-ugjE5TUgj5KkgiEEUApFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvawX2yzMpMYNsB6b-8NP6iXm-ugjE5TUgj5KkgiEEUApFA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/8] monitor: new parameter "x-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 26, 2018 at 11:10:30AM +0200, Marc-Andr=C3=A9 Lureau wrote:

[...]

> > @@ -4568,12 +4569,26 @@ static void monitor_qmp_setup_handlers_bh(voi=
d *opaque)
> >  void monitor_init(Chardev *chr, int flags)
> >  {
> >      Monitor *mon =3D g_malloc(sizeof(*mon));
> > +    bool use_readline =3D flags & MONITOR_USE_READLINE;
> > +    bool use_oob =3D flags & MONITOR_USE_OOB;
> > +
> > +    if (use_oob) {
> > +        if (CHARDEV_IS_MUX(chr)) {
> > +            error_report("Monitor Out-Of-Band is not supported with =
"
> > +                         "MUX typed chardev backend");
> > +            exit(1);
> > +        }
> > +        if (use_readline) {
> > +            error_report("Monitor Out-Of-band is only supported by Q=
MP");
> > +            exit(1);
> > +        }
> > +    }
>=20
> I would rather see the error reporting / exit in vl.c:mon_init_func()
> function, to have a single place for exit()

But there can be other callers for monitor_init() so I would assume
checking it here would be safer (though for now indeed mon_init_func()
is the only one that can pass OOB flag in).

[...]

> Other than that, it looks fine.
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks for your quick reviews!

--=20
Peter Xu
