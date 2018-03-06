Received: from eggs.gnu.org ([2001:4830:134:3::10]:43636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etCG3-0006Ts-BP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etCFx-0003Rn-MQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:03:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etCFx-0003RL-HT
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:03:49 -0500
Date: Tue, 6 Mar 2018 14:03:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180306130340.cbng5f4sserabwxn@sirius.home.kraxel.org>
References: <20180306083832.8144-1-kraxel@redhat.com>
	<20180306083832.8144-4-kraxel@redhat.com>
	<CAJ+F1CLiB6aMmSopdf3NwH6KN3y=rcY6XQaCciEYnA55d_75Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLiB6aMmSopdf3NwH6KN3y=rcY6XQaCciEYnA55d_75Fw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] spice: add cursor_dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Tue, Mar 06, 2018 at 12:56:55PM +0100, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Mar 6, 2018 at 9:38 AM, Gerd Hoffmann <kraxel@redhat.com> wrote=
:
> > Add support for cursor dmabufs.  qemu has to render the cursor for
> > that, so in case a cursor is present qemu allocates a new dmabuf, bli=
ts
> > the scanout, blends in the pointer and passes on the new dmabuf to
> > spice-server.  Without cursor qemu continues to simply pass on the
> > scanout dmabuf as-is.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> What about client side rendering mode? (for responsiveness etc)

Note that client side cursor rending needs guest support.  Intel added
some extra paravirtual registers for the hotspot location (on physical
hardware this isn't needed).  So client-side cursor rendering will only
work for guests which have support for those extra registers, and we
will need the current rendering code *anyway* in case we don't get the
hotspot location from the guest.  So I figured I go with this code base
for now, put it into shape and run for 2.12 merge.

> Why not read the cursor data and pass it as regular cursor update? I
> don't think such a small and infrequent CPU read will impact
> performance much.

Well, it's not *that* infrequent.  Cursor shape might have changed even
if the dmabuf is still the same (i.e. guest didn't place the cursor
elsewhere in memory).  Also note that Intel uses a 256x256 cursor sprite
(with most of it being unused), so it isn't that small either.

But, yes, I plan to check that out and try to send the cursor as regular
spice cursor update.  Will probably not make 2.12 though, too much
higher priority stuff in the pipeline ...

cheers,
  Gerd
