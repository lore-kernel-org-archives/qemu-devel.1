Received: from eggs.gnu.org ([2001:4830:134:3::10]:50013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dfaggioli@suse.com>) id 1gOmAI-0005Bm-0z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dfaggioli@suse.com>) id 1gOmAE-0000nB-OD
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:12:45 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:52155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dfaggioli@suse.com>) id 1gOmAC-0000in-Se
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:12:41 -0500
Message-ID: <27f907253ba78277b268e3bd6775db10b90bce1f.camel@suse.com>
From: Dario Faggioli <dfaggioli@suse.com>
Date: Mon, 19 Nov 2018 17:12:27 +0100
In-Reply-To: <CAAdtpL4nkWZ4_p=Vo=Smz9TpL97eYxDLrd8OGXWhGEn=92C_kw@mail.gmail.com>
References: <154238824601.3534.13597728205342770469.stgit@wayrath>
	<87k1lai2vo.fsf@linaro.org>
	<177817734b4def66a3a0641ad2fba1ec9a4092cb.camel@suse.com>
	<CAAdtpL4nkWZ4_p=Vo=Smz9TpL97eYxDLrd8OGXWhGEn=92C_kw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-MzwP4q5pYEMHYXX9VN8E"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] docker: dockerfile for openSUSE Leap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>


--=-MzwP4q5pYEMHYXX9VN8E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-19 at 01:02 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Dario,
>=20
Hi,

> On Sun, Nov 18, 2018 at 10:54 PM Dario Faggioli <dfaggioli@suse.com>
> wrote:
> > On Sun, 2018-11-18 at 19:47 +0000, Alex Benn=C3=A9e wrote:
> > > This hasn't been tested because the docker image fails to build
> > > due
> > > to
> > > continuation breakage.
> > >=20
> > It is indeed broken.
> >=20
> > Basically, I tested it thoroughly, and I'm quite sure it works ok
> > (although, I'm no docker expert).
>=20
> I quickly fixed/tried it.
>
Cool, thanks for having a look. :-)

> First this package list pulls many unuseful system packages.
> I added '--no-recommends' to reduce a bit:
>=20
> RUN zypper ref && \
>     zypper up -y && \
>     zypper install -y --no-recommends $PACKAGES
>=20
Right, that makes sense. I'll add it.

> This still install a bunch of unnecessary stuffs:
>=20
> Creating group systemd-journal with gid 485.
> Creating group systemd-network with gid 484.
> Creating user systemd-network (systemd Network Management) with uid
> 484 and gid 484.
> Creating group systemd-coredump with gid 483.
> Creating user systemd-coredump (systemd Core Dumper) with uid 483 and
> gid 483.
> Creating group systemd-timesync with gid 482.
> Creating user systemd-timesync (systemd Time Synchronization) with
> uid
> 482 and gid 482.
> Failed to connect to bus: No such file or directory
>=20
> Then the resulting image takes the same than without --no-recommends:
> 1.1GB. No idea why.
>
So, my "model" was the fedora.docker dockerfile, where quite a few
package are also installed, much more than the bare minimum necessary
for a build to succeed (AFAICT, at least).

The idea would be to enable and include support for as many
features/backends/integrations/etc as possible, in order to test them.

Basically, I did this by trial-and-error, i.e., adding packages related
to entries in `./configure' which looked like 'no', and keeping them
(only) if they turned such entry to 'yes'.

Now, this is what I see on my system, and that's why size did not
concerned me: :-)

REPOSITORY   TAG             IMAGE ID       CREATED       SIZE
qemu         opensuse-leap   6bd6bc2ac139   4 hours ago   1.09GB
qemu         fedora          1b05e254d0d9   5 hours ago   2.02GB

If this is not ok, I'm happy to try to shrink the image size a bit
(e.g., I'll double check if there are useless packages left in place),
and/or to put together another dockerfile (something like opensuse-
leap_minimal), with just what is necessary for the build (and the
tests) to succeed.

> At some point some package tried to talk to the network manager via
> DBus to start sshd...
>=20
Ah, interesting. :-P

So, from where did you see this (as well as the logs above) logs?
Running `make docker-***' with 'V=3D1', I'm guessing?

> Second, while this works on x86_64, it fails on aarch64:
>=20
> Problem: libcurl-devel-7.59.0-lp150.1.2.aarch64 requires libcurl4 =3D
> 7.59.0, but this requirement cannot be provided
>   not installable providers: libcurl4-7.59.0-lp150.1.2.aarch64[repo-
> oss]
>  Solution 1: downgrade of libcurl4-7.60.0-lp150.2.15.1.aarch64 to
> libcurl4-7.59.0-lp150.1.2.aarch64
>  Solution 2: do not install libcurl-devel-7.59.0-lp150.1.2.aarch64
>  Solution 3: break libcurl-devel-7.59.0-lp150.1.2.aarch64 by ignoring
> some of its dependencies
>=20
Ok, I see.

> Not your fault. So I suppose you are planning to use this image to
> compile QEMU for openSUSE/x86_64 only, is this correct?
>=20
Yes, basically, x86_64 is my main usecase, and the (only) setup I can
test quickly and easily enough. However, I'm certainly up for trying to
improve this, and make this dockerfile useful for other arches as well.

I'll try to look into this. How did you test this on aarch64? On a
native ARM host, or using QEMU?

Thanks again and Regards,
Dario
--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/

--=-MzwP4q5pYEMHYXX9VN8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlvy4OsACgkQFkJ4iaW4
c+5DtBAAkSR4w9qMkNB4bL254/W/JeONHIL+7ixWAD4LbVnGYV3xroBj5tNBVs4N
/yreVRQMFWIrtdOdS2cG2Wp6qGjLj9oJhREMpM0h4BwRJFiGyYttvCVpE3pZhYmF
2u1FhV49AcGsBmskGH9tTk/F/ZNYAb9kXOVHC8+scK4Fz8TRsCh0z8ktlU1onu0R
mHXec3I9TWiVDEcdItSWXhM6naOuusn4oiS859cplw9xyXyCXmnrXJciyEcd8hKZ
EGIeSG5RcV9kZZE/si4o5iyAG8WDLR+NUQ/x5BK6yt/nI2GgLhEQXaaGHUHvhzSw
h25MiiG3Fujs4Gh+K3dxN7WfVlbyvbOT9kRbBxL+wsdrtRldwqTBYGUMgPJhq1np
B+sNYnEfud7OcW8L/Ijf+3EqPfp2rZiBrAjXmE5+hzRS/DIeIKZDSyicdWXAWD7G
u/ASWszdaKVoIwAKz57DSutihAmG6ciV3xiCD/Cc8eg3/2ZP62hlyiKE485TKsol
dEmVZy1ye4z5xEVI4A8SmZ7x3Xn+JWG5tCYkWE7x7Px4u1z3GdcUCOoaqaj6c9Vk
NPFGPpDXuUApz9tZDKUiw6pfC4wnr0luB088R4ssuPtb93zxGS+6NSbi+TCLNMVw
Ti8Hkpt3hBeYnef+X2FQGcANWMFHwzoswEF214WgA4LkxCzu1Ug=
=jvxG
-----END PGP SIGNATURE-----

--=-MzwP4q5pYEMHYXX9VN8E--
