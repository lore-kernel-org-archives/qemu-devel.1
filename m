Received: from eggs.gnu.org ([2001:4830:134:3::10]:52013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fzemj-0000S5-SO
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fzemi-0001aC-Rm
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:16:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fzemi-0001ZK-K1
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:16:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id v17-v6so24900903wrr.9
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 02:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180829095035.GI31005@redhat.com>
	<CAMxuvayUDC+dZegONEwto36qTqaJFUEF9UrvNiY+1HJ_6nrzYg@mail.gmail.com>
	<CAJ+F1CKcSkd6aKPBss6eNtaD8-NonafNdyLB_66BsH5sKParPA@mail.gmail.com>
	<20180911085928.rp5drknyoqcvs4xf@sirius.home.kraxel.org>
In-Reply-To: <20180911085928.rp5drknyoqcvs4xf@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 11 Sep 2018 13:16:22 +0400
Message-ID: <CAJ+F1CKPz=qnez+_9g6rDVrgW8bQTL9A90kJwO2TB7N6G1nGSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/29] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, David Airlie <airlied@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Sep 11, 2018 at 12:59 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > >  $ ./vhost-user-gpu --virgl -s vgpu.sock &
> > > >  $ qemu...
> > > >    -chardev socket,id=3Dchr,path=3Dvgpu.sock
> > > >    -object vhost-user-backend,id=3Dvug,chardev=3Dchr
> > > >    -device vhost-user-vga,vhost-user=3Dvug
> > >
> > > That's a bit incovenient for qemu command line users. But who runs
> > > qemu this way but some developers? (others have higher-level scripts =
/
> > > tools or libvirt)
>
> In practice this will *allways* run over a unix socket, right?
> So I'm wondering whenever it makes sense to take the chardev
> indirection here ...

The management layer can set things up and pass fd around, avoiding
socket paths etc.

>
> > I suggest the vhost-user binary (vhost-user-gpu or vhost-user-input
> > etc), the default binary be in the system PATH, so that libvirt & co
> > can find it. Host administrator can use update-alternative or such if
> > they are other implementations. (other selections mechanisms can be
> > added later)
>
> Might make sense to place them in /usr/libexec instead.

ok (slightly less convenient for command line users though)

>
> > I thinks the vhost-user backends could have the following common
> > options handling:
> > - take a "--fd=3DFDNUM" argument, that would indicate which fd the
> > socket has been passed on.
>
> Which is what libvirt would use, right?

yes (see the related libvirt series / branch)

>
> > - OR take a "--socket-path=3DPATH"
>
> Convinient when not using libvirt, looks ok to me.
>
> > - optionally? take a "--pid=3DPATH" argument, to write out the process =
PID
>
> Do we need that?  When libvirt forks off the process it knows the PID
> without pidfile, right?

Yes I am not sure it is strictly necessary (that's why I put
optionally). The helper could fork itself, for various reasons.

>
> > We probably need a way to list the capabilities of the backend.:
> > --dump-caps, could list known keywords, one per line? (grab, virgl,
> > opengles, etc...)
>
> Hmm, good question.
>
> I'd tend include more information here.  Such as a description of the
> capability.  The command line switch to enable it.  Print as json, we
> have support in both qemu and libvirt.  Something like
>
>   [ 'name'   : 'vulkan',
>     'help'   : 'enable virgl vulkan support',
>     'switch' : '--enable-vulkan' ]
>

I wouldn't go so far as describing the command line arguments here. Or
else, we will have to specify the argument type etc.
Instead, I would use a  list of well-known keywords, described in the
specification.

"vulkan" caps would mean that --enable-vulkan (without argument) is
accepted and has an expected behaviour (to handle vulkan commands /
rendering etc)

I don't see a problem putting the list in a json array, but I don't
see much benefit either doing it.

> What would libvirt like to consume here?  Would it actually be able to
> use whatever it finds there?  Or would libvirt look for specific known
> features only, matching them with domain xml attributes?

I am not sure I understand the qestion. libvirt would deal with the
binary capabilities like it deals with qemu capabilities.

It would use the best combination of options given a domain XML and
the capabilities.

If the domain XML requests a feature that the backend is not able to
support, it would provide a sensible error.

Unknown capabilities would be ignored.

>
> > Other options may vary based on the backend type, for ex:
> > - vhost-user-input EVDEV-PATH (required)
>
> I'd go for "--evdev-path=3D/dev/input/..." syntax even for mandatory
> arguments.

ok

>
> > - vhost-user-gpu --render-node=3DPATH (optional)
> >
> > I am not sure how this should be documented.
>
> docs/specs/ ?

ok, I suppose I can start some document and include libvir-list for discuss=
ion.


--=20
Marc-Andr=C3=A9 Lureau
