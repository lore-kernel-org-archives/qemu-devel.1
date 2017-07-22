Received: from eggs.gnu.org ([2001:4830:134:3::10]:39126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dYiNt-0004AS-PB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dYiNq-0000HO-Eb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:35:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dYiNq-0000GP-4i
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:35:02 -0400
Date: Sat, 22 Jul 2017 03:34:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170722033348-mutt-send-email-mst@kernel.org>
References: <1500614191-13392-1-git-send-email-wangyunjian@huawei.com>
	<CAJ+F1CJ2FWZdY3xN2NOgQxZKYPOE4ykLXhcke+hFt6YDKuYiSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJ2FWZdY3xN2NOgQxZKYPOE4ykLXhcke+hFt6YDKuYiSw@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: w00273186 <wangyunjian@huawei.com>, qemu-devel@nongnu.org, jasowang@redhat.com, caihe@huawei.com

On Fri, Jul 21, 2017 at 11:19:04AM +0000, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Fri, Jul 21, 2017 at 7:18 AM w00273186 <wangyunjian@huawei.com> wrot=
e:
>=20
>     From: Yunjian Wang <wangyunjian@huawei.com>
>=20
>     "nc" is freed after hotplug vhost-user, but the watcher don't be re=
moved.
>     The QEMU crash when the watcher access the "nc" on socket disconnec=
t.
>=20
>=20
>=20
> This is actually your 3rd iteration on the patch
>=20
> Could your describe your changes since:
> "[PATCH v2] vhost-user: fix watcher need be removed when vhost-user hot=
plug"
>=20
> Thanks

Yes but it's a 3-liner. That's way below the limit where you need
detailed change history. Does the patch make sense to you?

>=20
>     =A0 =A0 Program received signal SIGSEGV, Segmentation fault.
>     =A0 =A0 #0=A0 object_get_class (obj=3Dobj@entry=3D0x2) at qom/objec=
t.c:750
>     =A0 =A0 #1=A0 0x00007f9bb4180da1 in qemu_chr_fe_disconnect (be=3D<o=
ptimized out>)
>     at chardev/char-fe.c:372
>     =A0 =A0 #2=A0 0x00007f9bb40d1100 in net_vhost_user_watch (chan=3D<o=
ptimized out>,
>     cond=3D<optimized out>, opaque=3D<optimized out>) at net/vhost-user=
.c:188
>     =A0 =A0 #3=A0 0x00007f9baf97f99a in g_main_context_dispatch () from=
 /usr/lib64/
>     libglib-2.0.so.0
>     =A0 =A0 #4=A0 0x00007f9bb41d7ebc in glib_pollfds_poll () at util/ma=
in-loop.c:213
>     =A0 =A0 #5=A0 os_host_main_loop_wait (timeout=3D<optimized out>) at=
 util/
>     main-loop.c:261
>     =A0 =A0 #6=A0 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) =
at util/
>     main-loop.c:515
>     =A0 =A0 #7=A0 0x00007f9bb3e266a7 in main_loop () at vl.c:1917
>     =A0 =A0 #8=A0 main (argc=3D<optimized out>, argv=3D<optimized out>,=
 envp=3D<optimized
>     out>) at vl.c:4786
>=20
>     Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
>     ---
>     =A0net/vhost-user.c | 4 ++++
>     =A01 file changed, 4 insertions(+)
>=20
>     diff --git a/net/vhost-user.c b/net/vhost-user.c
>     index 36f32a2..c23927c 100644
>     --- a/net/vhost-user.c
>     +++ b/net/vhost-user.c
>     @@ -151,6 +151,10 @@ static void vhost_user_cleanup(NetClientState =
*nc)
>     =A0 =A0 =A0 =A0 =A0s->vhost_net =3D NULL;
>     =A0 =A0 =A0}
>     =A0 =A0 =A0if (nc->queue_index =3D=3D 0) {
>     +=A0 =A0 =A0 =A0 if (s->watch) {
>     +=A0 =A0 =A0 =A0 =A0 =A0 g_source_remove(s->watch);
>     +=A0 =A0 =A0 =A0 =A0 =A0 s->watch =3D 0;
>     +=A0 =A0 =A0 =A0 }
>     =A0 =A0 =A0 =A0 =A0qemu_chr_fe_deinit(&s->chr, true);
>     =A0 =A0 =A0}
>=20
>     --
>     1.8.3.1
>=20
>=20
>=20
>=20
> --
> Marc-Andr=E9 Lureau
