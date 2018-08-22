Received: from eggs.gnu.org ([2001:4830:134:3::10]:47147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsN3f-0000Mo-NE
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 02:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsN3Z-0006HY-KY
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 02:55:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fsN3X-0006EM-H4
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 02:55:53 -0400
Date: Wed, 22 Aug 2018 14:55:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180822065543.GH3324@xz-x1>
References: <20180817135224.22971-1-marcandre.lureau@redhat.com>
	<20180820024504.GA7953@xz-mi>
	<CAJ+F1C+J1mUeP8YbsCg=-VU15adxKZoM2acxEJUVtEBUTJsuBQ@mail.gmail.com>
	<20180821062951.GE19915@xz-mi>
	<CAJ+F1C+qTV6gQa6SZJ_HLUP1YO0Nm2C-momg0nAZcV6TWPaREw@mail.gmail.com>
	<3842a5df-b3ed-08b3-b627-a89cd3c7c1ce@redhat.com>
	<20180822034632.GB3324@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822034632.GB3324@xz-x1>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Fix socket chardev regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Aug 22, 2018 at 11:46:32AM +0800, Peter Xu wrote:
> On Tue, Aug 21, 2018 at 04:16:27PM +0200, Paolo Bonzini wrote:
> > On 21/08/2018 16:04, Marc-Andr=C3=A9 Lureau wrote:
> > >> If you don't like the way I proposed, another thing I am
> > >> thinking is that whether we can assign the gcontext for the charde=
v
> > >> backend before initialization of it (or by parsing the backend &
> > >> frontend relationships before init of backends), then we assure th=
at
> > >> we never change the gcontext of any chardev backends.  Though that
> > > Yes, I think that's a cleaner solution. I suggested to use an iothr=
ead
> > > argument in the cover letter.
> >=20
> > That would be nice, but isn't it already too late for the monitor cha=
rdev?
>=20
> I think, yes, if we want to do this automatically.

Sorry I forgot to mention some more details here.  If to do it
automatically, IMHO we can just split the mon_init_func() into parsing
and init, then we do:

(1) parse monitors, setup gcontext/... for chardev
(2) init chardevs with the gcontext/... setup
(3) init monitors

Benefit is that we don't need to introduce new interface then.

> Though if as
> Marc-Andr=C3=A9 suggested (which I didn't really notice first when read=
ing
> the cover letter), then maybe that's not a problem since user need to
> manually specify the iothread for a chardev backend, then chardev
> context will not depend on monitor code any more.
>=20
> Marc-Andr=C3=A9, do you want to propose your iothread interface?  That
> should be the easy way AFAIU, though that'll make the command line for
> monitor out-of-band much longer (but it seems fine at least to me).
>=20
> Adding Markus too.
>=20
> >=20
> > In any case, I don't see a reason to dislike this patch, especially
> > since it comes with a testcase.
>=20
> AFAIU the test case didn't really test the non-NULL gcontext case, so
> it fixed A (vhost-user reconnect) however it might break B (non-NULL
> gcontext with a potential race).
>=20
> Regards,
>=20
> --=20
> Peter Xu

Regards,

--=20
Peter Xu
