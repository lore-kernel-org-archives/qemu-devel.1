Received: from eggs.gnu.org ([2001:4830:134:3::10]:59189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fmz1J-0003ns-0M
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fmz1F-0006ZX-W2
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:15:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fmz1F-0006ZR-P9
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:15:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 658D8402242D
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 10:15:13 +0000 (UTC)
Date: Tue, 7 Aug 2018 11:15:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180807101505.GF7335@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180803173614.12358-11-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] display: add -display app launching
 external application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Aug 03, 2018 at 07:36:14PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Add a new display backend that will configure Spice to allow a remote
> client to control QEMU in a similar fashion as other display backend
> like GTK.
>=20
> For this to work, we set up Spice server with a unix socket, and
> register a VC chardev that will be exposed as Spice ports. A QMP
> monitor is also exposed as a Spice port, this allows the remote client
> fuller qemu control and state handling.
>=20
> - doesn't handle VC set_echo() - this doesn't seem a strong
>   requirement, very few front-end use it
> - spice options can be tweaked with other -spice arguments
> - Windows support shouldn't be hard to do, but will probably use a TCP
>   port instead
> - we may want to watch the child process to quit automatically if it
>   crashed
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +    type_register(&char_vc_type_info);
> +
> +    sock_path =3D g_strjoin("", tmp_dir, "/", "spice.sock", NULL);
> +    qopts =3D qemu_opts_create(qemu_find_opts("spice"), NULL, 0, &erro=
r_abort);
> +    qemu_opt_set(qopts, "disable-ticketing", "on", &error_abort);
> +    qemu_opt_set(qopts, "unix", "on", &error_abort);
> +    qemu_opt_set(qopts, "addr", sock_path, &error_abort);
> +    qemu_opt_set(qopts, "image-compression", "off", &error_abort);
> +    qemu_opt_set(qopts, "streaming-video", "off", &error_abort);
> +    qemu_opt_set(qopts, "gl", opts->has_gl ? "on" : "off", &error_abor=
t);

Hmm, so ultimately "-display app" is just syntactic sugar for a hardcoded
set of "-display spice" arguments, plus automatic launching of the client
app.  I'm thinking users may well ask for ability to control some of thos=
e
spice arguments over time.  So if we want auto-launching of a remote app,
I think it is preferrable to do it via extra args to the existing
"-display spice" format. eg we could add a "client=3Dyes|no" to control
launching the client

   -display spice,client=3Dyes

would do what your "-display app" proposes, and still let users tweak
all the other spice args as desired.  Another option "autoquit=3Dyes|no"
could control whether QEMU automatically exits when the client quits,
vs whether it stays alive.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
