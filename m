Received: from eggs.gnu.org ([2001:4830:134:3::10]:48669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzeWF-0007oz-6P
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzeWB-0006Oc-VV
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:59:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fzeWB-0006MZ-On
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:59:31 -0400
Date: Tue, 11 Sep 2018 10:59:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180911085928.rp5drknyoqcvs4xf@sirius.home.kraxel.org>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180829095035.GI31005@redhat.com>
	<CAMxuvayUDC+dZegONEwto36qTqaJFUEF9UrvNiY+1HJ_6nrzYg@mail.gmail.com>
	<CAJ+F1CKcSkd6aKPBss6eNtaD8-NonafNdyLB_66BsH5sKParPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKcSkd6aKPBss6eNtaD8-NonafNdyLB_66BsH5sKParPA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/29] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, David Airlie <airlied@redhat.com>, QEMU <qemu-devel@nongnu.org>

> > >  $ ./vhost-user-gpu --virgl -s vgpu.sock &
> > >  $ qemu...
> > >    -chardev socket,id=chr,path=vgpu.sock
> > >    -object vhost-user-backend,id=vug,chardev=chr
> > >    -device vhost-user-vga,vhost-user=vug
> >
> > That's a bit incovenient for qemu command line users. But who runs
> > qemu this way but some developers? (others have higher-level scripts /
> > tools or libvirt)

In practice this will *allways* run over a unix socket, right?
So I'm wondering whenever it makes sense to take the chardev
indirection here ...

> I suggest the vhost-user binary (vhost-user-gpu or vhost-user-input
> etc), the default binary be in the system PATH, so that libvirt & co
> can find it. Host administrator can use update-alternative or such if
> they are other implementations. (other selections mechanisms can be
> added later)

Might make sense to place them in /usr/libexec instead.

> I thinks the vhost-user backends could have the following common
> options handling:
> - take a "--fd=FDNUM" argument, that would indicate which fd the
> socket has been passed on.

Which is what libvirt would use, right?

> - OR take a "--socket-path=PATH"

Convinient when not using libvirt, looks ok to me.

> - optionally? take a "--pid=PATH" argument, to write out the process PID

Do we need that?  When libvirt forks off the process it knows the PID
without pidfile, right?

> We probably need a way to list the capabilities of the backend.:
> --dump-caps, could list known keywords, one per line? (grab, virgl,
> opengles, etc...)

Hmm, good question.

I'd tend include more information here.  Such as a description of the
capability.  The command line switch to enable it.  Print as json, we
have support in both qemu and libvirt.  Something like

  [ 'name'   : 'vulkan',
    'help'   : 'enable virgl vulkan support',
    'switch' : '--enable-vulkan' ]

What would libvirt like to consume here?  Would it actually be able to
use whatever it finds there?  Or would libvirt look for specific known
features only, matching them with domain xml attributes?

> Other options may vary based on the backend type, for ex:
> - vhost-user-input EVDEV-PATH (required)

I'd go for "--evdev-path=/dev/input/..." syntax even for mandatory
arguments.

> - vhost-user-gpu --render-node=PATH (optional)
> 
> I am not sure how this should be documented.

docs/specs/ ?

cheers,
  Gerd
