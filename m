Received: from eggs.gnu.org ([2001:4830:134:3::10]:34057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRJjp-00051U-A9
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRJjl-0004m8-4W
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:23:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eRJjk-0004lk-UR
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:23:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00EDB7D0F1
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 15:23:20 +0000 (UTC)
Date: Tue, 19 Dec 2017 15:23:04 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171219152304.GC3567@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
	<32374673.1188228.1513695479889.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32374673.1188228.1513695479889.JavaMail.zimbra@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 00/13] Fix VNC server unbounded memory
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

On Tue, Dec 19, 2017 at 09:57:59AM -0500, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
> > In the 2.11 release we fixed CVE-2017-15268, which allowed the VNC we=
bsockets
> > server to consume arbitrary memory when a slow client was connected. =
I have
> > since discovered that this same type of problem can be triggered in s=
everal
> > other ways in the regular (non-websockets) VNC server. This patch ser=
ies
> > attempts to fix this problem by limiting framebuffer updates and othe=
r data
> > sent from server to client. The mitigating factor is that you need to=
 have
> > successfully authenticated with the VNC server to trigger these new f=
laws.
> > This new more general flaw is assigned CVE-2017-15124 by the Red Hat =
security
> > team.
> >=20
> > The key patches containing the security fix are 9, 10, 11.
> >=20
> > Since this code is incredibly subtle & hard to understand though, the=
 first
> > 8 patches do a bunch of independant cleanups/refactoring to make the =
security
> > fixes clearer.  The last two patches are just some extra cleanup / he=
lp for
> > future maint.
>=20
> I already reviewed the series privately, and in general, I'd ack it.
>=20
> Did you manage to run some throttle tests? (I tried to trigger them man=
ually
> by slowing artificially network or calling framebuffer_update_request()=
 in
> gdb, I didn't manage yet :-/)

I used two approaches. First a MITM socket server that just throttles the
rate at which is reads from QEMU. Second, I wrote an intentionally malici=
ous
VNC client to artificially exercise the codepaths & verify they are fixed=
.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
