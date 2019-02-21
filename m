Received: from eggs.gnu.org ([209.51.188.92]:37191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gwkak-0003o9-Rn
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gwkaj-0003Io-5r
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:24:30 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.maffione@gmail.com>)
	id 1gwkah-00034L-PF
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:24:28 -0500
Received: by mail-qt1-x842.google.com with SMTP id d18so20658915qtg.12
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 01:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20190220104523.22059-1-pbonzini@redhat.com>
	<87o9764dsb.fsf@zen.linaroharston>
	<b3fe812b-62ac-4b28-416b-4780e11528c0@redhat.com>
	<87lg2a4amz.fsf@zen.linaroharston>
	<6c04a73b-b0f3-2a7d-443e-337e8b637c27@redhat.com>
	<20190221091407.6dbwu7zqg77pssk5@steredhat>
In-Reply-To: <20190221091407.6dbwu7zqg77pssk5@steredhat>
From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Thu, 21 Feb 2019 10:24:05 +0100
Message-ID: <CA+_eA9gYR4N41D3MOejA3p4QYPRj9z5DoYhN8qvh07P0hVne7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] shippable: fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>

Hi,
  Yes, we added a static library that to ease application development
(libnetmap.a).
It looks like a configure/Makefile issue. Can you reproduce that?

(I'm CC-ing Giuseppe, who actually added libnetmap).

Cheers,
  Vincenzo

Il giorno gio 21 feb 2019 alle ore 10:14 Stefano Garzarella <
sgarzare@redhat.com> ha scritto:

> CCing Vincenzo, one of the maintainer of Netmap.
>
> On Wed, Feb 20, 2019 at 07:00:19PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 2/20/19 6:45 PM, Alex Benn=C3=A9e wrote:
> > >
> > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> > >
> > >> On 2/20/19 5:37 PM, Alex Benn=C3=A9e wrote:
> > >>> Paolo Bonzini <pbonzini@redhat.com> writes:
> > >>>
> > >>>> It looks like something in netmap has changed and compilation fail=
s:
> > >>>>
> > >>>>    install -D libnetmap.a //usr/local/lib/libnetmap.a
> > >>>>    install: cannot stat libnetmap.a: No such file or directory
> > >>>>
> > >>>> Add an explicit "make" step to fix it.
> > >>>
> > >>> I took an alternate approach as tracking another projects master
> seems
> > >>> like a bad idea:
> > >>>
> > >>> tests/docker: peg netmap code to a specific version
> > >>>
> > >>> Tracking head is always going to be at the whims of the upstream.
> > >>> Let's use a defined release so things don't magically change under
> us.
> > >>
> > >> Oh now I see your reply...
> > >>
> > >>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > >>>
> > >>> 1 file changed, 1 insertion(+)
> > >>> tests/docker/dockerfiles/debian-amd64.docker | 1 +
> > >>>
> > >>> modified   tests/docker/dockerfiles/debian-amd64.docker
> > >>> @@ -33,6 +33,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> > >>>      apt-get install -y --no-install-recommends \
> > >>>          linux-headers-amd64
> > >>>  RUN git clone https://github.com/luigirizzo/netmap.git
> /usr/src/netmap
> > >>> +RUN cd /usr/src/netmap && git checkout v11.3
> > >>
> > >> ... and I notice I forgot to change directory in my previous
> suggestion.
> > >>
> > >> Why do you take v11.3 and not v11.4?
> > >> I agree v11.3 was closer to what I tested when I introduced this
> > >> dependency, but I'd rather use the latest release.
> > >
> > > Hmm github hid the newer releases by default and has a Latest Release
> > > button by v11.3.
> >
> > I don't understand (this GitHub feature)...
> >
> > I'm talking about this release:
> > https://github.com/luigirizzo/netmap/releases/tag/v11.4
> >
> > The date is more recent that the v11.3. This looks like the latest
> > release to me.
> >
> > Anyway I'm fine if you prefer v11.3.
> > Please send a formal patch because I don't want to confuse scripts
> > adding my R-b in Paolo's patch.
> >
> > Regards,
> >
> > Phil.
> >
>
> --
>
> Stefano Garzarella
> Software Engineer @ Red Hat
>


--=20
Vincenzo
