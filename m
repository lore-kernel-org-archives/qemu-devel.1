Received: from eggs.gnu.org ([2001:4830:134:3::10]:45737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmiQn-0007jw-SB
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmiQk-0001ZE-M9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dmiQk-0001Yi-EI
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:27:54 -0400
Date: Tue, 29 Aug 2017 18:27:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170829182742-mutt-send-email-mst@kernel.org>
References: <20170829144805.28872-1-marcandre.lureau@redhat.com>
	<20170829144805.28872-3-marcandre.lureau@redhat.com>
	<20170829180219-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLnwVRAKLPW8xBNCe0Asjh+BVuZXHA0WLDtpYpGWim9Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLnwVRAKLPW8xBNCe0Asjh+BVuZXHA0WLDtpYpGWim9Xw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost-user-bridge: fix resume
 regression (since 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Victor Kaplansky <victork@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, Aug 29, 2017 at 05:22:28PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Aug 29, 2017 at 5:02 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > On Tue, Aug 29, 2017 at 04:48:05PM +0200, Marc-Andr=E9 Lureau wrote:
> >> Commit e10e798c85c2331 switched to libvhost-user which lacked suppor=
t
> >> for resuming the avail_idx based on used_idx.
> >>
> >> Fixes:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D1485867
> >>
> >> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> > Can we add a test for reconnect to catch the regression?
>=20
> There is no automated tests for vhost-user-bridge yet. We could
> probably make one based on "[PATCH v2 0/5] tests/pxe-test: add
> testcase using vhost-user-bridge" series.

Exactly.

> We could also add seperate libvhost-user tests, that's not existent
> yet, partly because libvhost-user was born as a test itself ;).
>=20
> >
> >> ---
> >>  tests/vhost-user-bridge.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> >> index 1e5b5ca3da..dca48512ba 100644
> >> --- a/tests/vhost-user-bridge.c
> >> +++ b/tests/vhost-user-bridge.c
> >> @@ -466,11 +466,18 @@ vubr_panic(VuDev *dev, const char *msg)
> >>      vubr->quit =3D 1;
> >>  }
> >>
> >> +static bool
> >> +vubr_queue_resume_to_used(VuDev *dev, int qidx)
> >> +{
> >> +    return true;
> >> +}
> >> +
> >>  static const VuDevIface vuiface =3D {
> >>      .get_features =3D vubr_get_features,
> >>      .set_features =3D vubr_set_features,
> >>      .process_msg =3D vubr_process_msg,
> >>      .queue_set_started =3D vubr_queue_set_started,
> >> +    .queue_resume_to_used =3D vubr_queue_resume_to_used,
> >>  };
> >>
> >>  static void
> >> --
> >> 2.14.1.146.gd35faa819
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
