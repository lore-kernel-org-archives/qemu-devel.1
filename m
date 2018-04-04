Received: from eggs.gnu.org ([2001:4830:134:3::10]:60655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3jmi-0004gc-EH
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3jmf-0000To-5H
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:53:12 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3jme-0000Sh-RA
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:53:09 -0400
Received: by mail-wm0-x243.google.com with SMTP id g8so18033167wmd.2
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 07:53:08 -0700 (PDT)
Date: Wed, 4 Apr 2018 15:53:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404145305.GV4467@stefanha-x1.localdomain>
References: <20180404065346.3252-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="50RDeE14MEV4qpyy"
Content-Disposition: inline
In-Reply-To: <20180404065346.3252-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] iothread: workaround glib bug
 which hangs qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--50RDeE14MEV4qpyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 02:53:46PM +0800, Peter Xu wrote:
> Free the AIO context earlier than the GMainContext (if we have) to
> workaround a possible Glib bug.  No functional change at all.
>=20
> We encountered a qmp-test hang with oob:
>=20
>   #0  0x00007f35ffe45334 in __lll_lock_wait () from /lib64/libpthread.so.0
>   #1  0x00007f35ffe405d8 in _L_lock_854 () from /lib64/libpthread.so.0
>   #2  0x00007f35ffe404a7 in pthread_mutex_lock () from /lib64/libpthread.=
so.0
>   #3  0x00007f35fc5b9c9d in g_source_unref_internal (source=3D0x24f0600, =
context=3D0x7f35f0000960, have_lock=3D0) at gmain.c:1685
>   #4  0x0000000000aa6672 in aio_context_unref (ctx=3D0x24f0600) at /root/=
qemu/util/async.c:497
>   #5  0x000000000065851c in iothread_instance_finalize (obj=3D0x24f0380) =
at /root/qemu/iothread.c:129
>   #6  0x0000000000962d79 in object_deinit (obj=3D0x24f0380, type=3D0x242e=
960) at /root/qemu/qom/object.c:462
>   #7  0x0000000000962e0d in object_finalize (data=3D0x24f0380) at /root/q=
emu/qom/object.c:476
>   #8  0x0000000000964146 in object_unref (obj=3D0x24f0380) at /root/qemu/=
qom/object.c:924
>   #9  0x0000000000965880 in object_finalize_child_property (obj=3D0x24ec6=
40, name=3D0x24efca0 "mon_iothread", opaque=3D0x24f0380) at /root/qemu/qom/=
object.c:1436
>   #10 0x0000000000962c33 in object_property_del_child (obj=3D0x24ec640, c=
hild=3D0x24f0380, errp=3D0x0) at /root/qemu/qom/object.c:436
>   #11 0x0000000000962d26 in object_unparent (obj=3D0x24f0380) at /root/qe=
mu/qom/object.c:455
>   #12 0x0000000000658f00 in iothread_destroy (iothread=3D0x24f0380) at /r=
oot/qemu/iothread.c:365
>   #13 0x00000000004c67a8 in monitor_cleanup () at /root/qemu/monitor.c:46=
63
>   #14 0x0000000000669e27 in main (argc=3D16, argv=3D0x7ffc8b1ae2f8, envp=
=3D0x7ffc8b1ae380) at /root/qemu/vl.c:4749
>=20
> With glib version 2.28.8-9 (current default version on centos6) we might
> encounter above with the old code. It is verified that glib version
> 2.50.3-3 won't trigger that bug again, but since we are still supporting
> glib 2.28.8-9, we may want this workaround.

This patch does not contain enough information to explain what this
"possible Glib bug" is.  Please provide information on the root cause.

Without understanding the problem, it's hard for anyone to review this
patch and for other developers to avoid regressions in the future.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  iothread.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/iothread.c b/iothread.c
> index e675c38442..d41d661cdf 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -117,16 +117,26 @@ static void iothread_instance_finalize(Object *obj)
>      IOThread *iothread =3D IOTHREAD(obj);
> =20
>      iothread_stop(iothread);
> +    /*
> +     * With glib version 2.28.8-9 (current default version on centos6)
> +     * we might encounter problem of qmp-test OOB hang if we unref the
> +     * AIO context later than the GMainContext below.  Let's free the
> +     * AIO context earlier to bypass that possible glib bug.
> +     *
> +     * It is verified that glib version 2.50.3-3 (or even earlier)
> +     * won't trigger that bug again, but since we are still supporting
> +     * glib 2.28.8-9, we need this workaround.
> +     */
> +    if (iothread->ctx) {
> +        aio_context_unref(iothread->ctx);
> +        iothread->ctx =3D NULL;
> +    }
>      if (iothread->worker_context) {
>          g_main_context_unref(iothread->worker_context);
>          iothread->worker_context =3D NULL;
>      }
>      qemu_cond_destroy(&iothread->init_done_cond);
>      qemu_mutex_destroy(&iothread->init_done_lock);
> -    if (!iothread->ctx) {
> -        return;
> -    }
> -    aio_context_unref(iothread->ctx);
>  }
> =20
>  static void iothread_complete(UserCreatable *obj, Error **errp)
> --=20
> 2.14.3
>=20
>=20

--50RDeE14MEV4qpyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxObRAAoJEJykq7OBq3PI2SIIAJ+ipo0C+g8CTqtZMcY4Wni0
MYhrQR8sd6mY0kflX7jC1E5JZ5LeYfc1EdT/TVIyR19IyQHT1dt/qlNJqfTbxkmO
Mz8VfFxpiDwmnKIelLG84gfUagHES/HQA9Ig09AQrvjOWtc8PxzSf7e5vF7yWdG/
TS77gGFnlGuUwiTUA+YQVYh9gI7gZ0TIxMc+KxSz5p2zy/zFKZqX6/byxlp1w6x/
eNil+m4tKCKETzY6sFiaOr3AhnRqqig85L+sJqYHR7GVx9uXJdsQbwffmAFcy8OJ
oRB8HS1QkCQdz3PJ2RgzQefC5onfvvz+FbzXjCcddtkr3j8VBHH5wq1sNVP9/oA=
=DifE
-----END PGP SIGNATURE-----

--50RDeE14MEV4qpyy--
