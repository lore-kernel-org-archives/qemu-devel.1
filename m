Received: from eggs.gnu.org ([2001:4830:134:3::10]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDukZ-0002WW-6B
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDukX-0004eH-JS
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:32:31 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDukX-0004e2-84
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:32:29 -0400
Received: by mail-lf0-x244.google.com with SMTP id 99so13706178lfu.2
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 08:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <1494338586-13416-1-git-send-email-wangyunjian@huawei.com>
	<CAJ+F1CKL3vgJSSb8JGzNNBDS0xGKhtuP+2JEy1tsszauBMAUyA@mail.gmail.com>
	<34EFBCA9F01B0748BEB6B629CE643AE60BB56000@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60BB56000@DGGEMA505-MBX.china.huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 May 2017 15:32:16 +0000
Message-ID: <CAJ+F1CK61iRRtq7G_AiS5efhYK+VLJUzkGG8mtju00tOzDve0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix watcher need be removed
 when vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangyunjian <wangyunjian@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, caihe <caihe@huawei.com>, "mst@redhat.com" <mst@redhat.com>

On Wed, May 10, 2017 at 5:55 AM wangyunjian <wangyunjian@huawei.com> wrote:

> On Tue, May 9, 2017 at 5:04 PM Yunjian Wang <wangyunjian@huawei.com>
> wrote:
>
> > > From: w00273186 <wangyunjian@huawei.com>
> > >
> > > "nc" is freed after hotplug vhost-user, but the watcher don't be
> removed.
> > >
> >
> >
> > > The QEMU crash when the watcher access the "nc" on socket disconnect.
> > >
> > >
> > Do you have a reproducer? thanks
> >
>
> reproduce steps:
>
> 1. virsh attach-device vm0 vhost-user.xml
> 2. virsh detach-device vm0 vhost-user.xml
> 3. virsh attach-device vm0 vhost-user.xml
> 4. service openvswitch restart
> 5. repeat step 2~4
>
> The vhost-user xml:
>
>     <interface type=3D'vhostuser'>
>       <mac address=3D'00:01:01:00:10:41'/>
>       <source type=3D'unix' path=3D'/var/run/vhost-user/tap1' mode=3D'cli=
ent'/>
>       <model type=3D'virtio'/>
>       <driver queues=3D'8'/>
> </interface>
>
> Thanks
>
> >
> > > Call Trace:
> > >     #0  object_get_class (obj=3Dobj@entry=3D0x2) at qom/object.c:751
> > >     #1  0x00007fc031c79f41 in qemu_chr_fe_disconnect (be=3D<optimized
> out>)
> > > at chardev/char.c:1048
> > >     #2  0x00007fc031bd62e0 in net_vhost_user_watch (chan=3D<optimized
> out>,
> > > cond=3D<optimized out>, opaque=3D<optimized out>) at net/vhost-user.c=
:191
> > >     #3  0x00007fc02c23e99a in g_main_context_dispatch () from
> > > /lib64/libglib-2.0.so.0
> > >     #4  0x00007fc031ccfc0c in glib_pollfds_poll () at
> util/main-loop.c:213
> > >     #5  os_host_main_loop_wait (timeout=3D<optimized out>) at
> > > util/main-loop.c:261
> > >     #6  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at
> > > util/main-loop.c:517
> > >     #7  0x00007fc03193bc87 in main_loop () at vl.c:1899
> > >     #8  main (argc=3D<optimized out>, argv=3D<optimized out>,
> envp=3D<optimized
> > > out>) at vl.c:4719
> > >
> > > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > > ---
> > >  net/vhost-user.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > > index 00a0c1c..5cc2178 100644
> > > --- a/net/vhost-user.c
> > > +++ b/net/vhost-user.c
> > > @@ -155,6 +155,10 @@ static void vhost_user_cleanup(NetClientState *n=
c)
> > >
> > >          qemu_chr_fe_deinit(&s->chr);
> > >          object_unparent(OBJECT(chr));
> > > +        if (s->watch) {
> > > +            g_source_remove(s->watch);
> > > +            s->watch =3D 0;
> > > +        }
> > >      }
>

This change looks ok, and happens because libvirt calls netdev_del before
the chardev is closed or removed.

I would move the chunk before deinit/unparent though, since that's when the
close happens.

> >
> > >      qemu_purge_queued_packets(nc);
> > > --
> > > 1.8.3.1
> > >
> > >
> > >
> > > --
> > Marc-Andr=C3=A9 Lureau
>
--=20
Marc-Andr=C3=A9 Lureau
