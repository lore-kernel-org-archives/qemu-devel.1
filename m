Received: from eggs.gnu.org ([2001:4830:134:3::10]:58607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d5uiy-0001K3-JQ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d5uiu-0000Jc-TN
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:53:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d5uiu-0000JQ-KK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:53:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BBA9C04B94E
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 13:53:43 +0000 (UTC)
Date: Wed, 3 May 2017 14:53:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170503135339.GE14647@stefanha-x1.localdomain>
References: <20170426153900.21066-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline
In-Reply-To: <20170426153900.21066-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: disallow more than 10 arguments per
 trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 04:39:00PM +0100, Daniel P. Berrange wrote:
> The UST trace backend can only cope with upto 10 arguments. To ensure we
> don't exceed the limit when UST is not compiled in, disallow more than
> 10 arguments upfront.
>=20
> This prevents the case where:
>=20
>   commit 0fc8aec7de64f2bf83a274a2a38b938ce03425d2
>   Author: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>   Date:   Tue Apr 18 10:20:20 2017 +0800
>=20
>     COLO-compare: Optimize tcp compare trace event
>=20
>     Optimize two trace events as one, adjust print format make
>     it easy to read. rename trace_colo_compare_pkt_info_src/dst
>     to trace_colo_compare_tcp_info.
>=20
> regressed the fix done in
>=20
>   commit 2dfe5113b11ce0ddb08176ebb54ab7ac4104b413
>   Author: Alex Benn=E9e <alex.bennee@linaro.org>
>   Date:   Fri Oct 28 14:25:59 2016 +0100
>=20
>     net: split colo_compare_pkt_info into two trace events
>=20
>     It seems there is a limit to the number of arguments a UST trace event
>     can take and at 11 the previous trace command broke the build. Split =
the
>     trace into a src pkt and dst pkt trace to fix this.
>=20
>     Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>     Message-id: 20161028132559.8324-1-alex.bennee@linaro.org
>     Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Now we get an immediate fail even when UST is disabled:
>=20
>   GEN     net/trace.h
> Traceback (most recent call last):
>   File "/home/berrange/src/virt/qemu/scripts/tracetool.py", line 154, in =
<module>
>     main(sys.argv)
>   File "/home/berrange/src/virt/qemu/scripts/tracetool.py", line 145, in =
main
>     events.extend(tracetool.read_events(fh))
>   File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", line=
 307, in read_events
>     event =3D Event.build(line)
>   File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", line=
 244, in build
>     event =3D Event(name, props, fmt, args)
>   File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", line=
 196, in __init__
>     "argument count" % name)
> ValueError: Event 'colo_compare_tcp_info' has more than maximum permitted=
 argument count
> Makefile:96: recipe for target 'net/trace.h-timestamp' failed
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> Obviously dont apply this until 0fc8aec7de64f2bf83a274a2a38b938ce03425d2 =
has
> been reverted :-)
>=20
>  scripts/tracetool/__init__.py | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCeDjAAoJEJykq7OBq3PIHxUH/RbK2Dxblv7K9eDPaH1AFFCG
Uh7SKyrgbWsf1pwmaF3zW8M4txikNECiFdGjcyAJIvScj0eN3GSfBz6rp4v3l/eb
Ovfk73EvSnSUw5OV5O9QtpOwps4GrRUKnIi0rVylc1GuFZ50Z3+ZAx7PRvSowZ1Y
dHAn3TzEQLP2h5SXCF8YgmuBjmCo8Wn46YE4+UfDW30jXKm9SaA22Va2oiHUCx5r
rBa+1wrLV6XlEhg5vr47QnAWunT8enaECIPqmenQBQM21SHBi+zF9p2GIO2bzSdB
qKWkkdnlZgDocwMgb6TNgd5eqPdxHLBIvXbgaDOuUTyL6AaT50LmR3PVPjWB4Rk=
=JXTN
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
