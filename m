Received: from eggs.gnu.org ([209.51.188.92]:44254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBLB8-0007Fc-BG
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBLB6-0004jg-OU
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:18:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hBLB6-0004hZ-Cf
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:18:20 -0400
Date: Tue, 2 Apr 2019 16:18:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190402151815.GK413@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190402144725.fc998797b28431d714cbacfc@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190402144725.fc998797b28431d714cbacfc@wanadoo.fr>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Unknown X11 keycode mapping  report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Louis SOLATGES <jean-louis.solatges@wanadoo.fr>
Cc: qemu-devel@nongnu.org

On Tue, Apr 02, 2019 at 02:47:25PM +0200, Jean-Louis SOLATGES wrote:
> Bonjour, par tightvnc server sur clipper depuis un linux connect=C3=A9 =
en vncviewer,
>=20
> je lance :
> qemu-system-x86_64 -m 16G -cpu kvm64 -accel kvm,thread=3Dmulti -smp 6,m=
axcpus=3D12 -net nic -net tap -net socket,listen=3D127.0.0.1:1234 -vga ci=
rrus -boot c -hda uis1.img
>=20
>=20
>=20
> root@clipper:/home/jls/data# ** (qemu-system-x86_64:16384): WARNING **:=
 Unknown X11 keycode mapping '<null>'.
> bash: syntax error near unexpected token `qemu-system-x86_64:16384'
>=20
> --=20
> jls** (qemu-system-x86_64:16384): WARNING **: Unknown X11 keycode mappi=
ng '<null>'.
> Please report to qemu-devel@nongnu.org
> including the following information:
>=20
>   - Operating system
>   - X11 Server
>   - xprop -root
>   - xdpyinfo
>=20
> ::::
> Linux clipper 4.4.14 #2 SMP Fri Jun 24 13:38:27 CDT 2016 x86_64 Intel(R=
) Xeon(R) CPU           E5645  @ 2.40GHz GenuineIntel GNU/Linux
>=20
>=20
>=20
> X.Org X Server 1.18.3
> Release Date: 2016-04-04
> X Protocol Version 11, Revision 0
> Build Operating System: Slackware 14.2 Slackware Linux Project
> Current Operating System: Linux clipper 4.4.14 #2 SMP Fri Jun 24 13:38:=
27 CDT 2016 x86_64
> Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D801 vt.default_u=
tf8=3D0
> Build Date: 15 April 2016  11:05:21AM
> =20
> Current version of pixman: 0.34.0
>         Before reporting problems, check http://wiki.x.org
>         to make sure that you have the latest version.
>=20
>=20
>=20
> root@clipper:/home/jls/data# xprop -root
> CUT_BUFFER0(STRING) =3D "root@clipper:/home/jls/data# xprop -root\nCUT_=
BUFFER0(STRING) =3D \"root@clipper:/home/jls/data# name of display:    :1=
\\nbash: name: command not found\\nroot@clipper:/home/jls/data# version n=
umber:    11.0\\nbash: version: command not found\\n\""


So there's no _XKB_RULES_NAMES property set which is what QEMU
wants to see.

>=20
> root@clipper:/home/jls/data# xdpyinfo=20
> name of display:    :1
> version number:    11.0
> vendor string:    AT&T Laboratories Cambridge
> vendor release number:    3332
> maximum request size:  4194300 bytes
> motion buffer size:  256
> bitmap unit, bit order, padding:    32, LSBFirst, 32
> image byte order:    LSBFirst
> number of supported pixmap formats:    2
> supported pixmap formats:supported pixmap formats:
>     depth 1, bits_per_pixel 1, scanline_pad 32
>     depth 24, bits_per_pixel 32, scanline_pad 32
> keycode range:    minimum 8, maximum 255
> focus:  PointerRoot
> number of extensions:    7
>     BIG-REQUESTS
>     MIT-SHM
>     MIT-SUNDRY-NONSTANDARD
>     SHAPE
>     SYNC
>     XC-MISC
>     XTEST

The  XKEYBOARD extension is missing which is why we dont' see the
XKB property above.

We have a heuristic that tries to deal with this by checking what
keycode  "XK_Page_Up" maps to, but that has failed for you too.

So I'm puzzlled what key map this X server is actually using.


I don't have SLackware handy, but can't reproduce on Fedora with
TigerVNC.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
