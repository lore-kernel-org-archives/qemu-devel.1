Received: from eggs.gnu.org ([2001:4830:134:3::10]:55111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3LtP-0007xB-QF
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3LtK-0005bZ-S6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:17:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3LtK-0005b9-Mb
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:17:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170426102503.20345.45815.malonedeb@soybean.canonical.com>
Date: Wed, 26 Apr 2017 14:17:51 +0200
In-Reply-To: <20170426102503.20345.45815.malonedeb@soybean.canonical.com>
	(Richard Jones's message of "Wed, 26 Apr 2017 10:25:02 -0000")
Message-ID: <871ssfxt00.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1686364] [NEW] qemu -readconfig/-writeconfig
 cannot handle quotes in values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Jones <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, Bug 1686364 <1686364@bugs.launchpad.net>

Richard Jones <rjones@redhat.com> writes:

> Public bug reported:
>
> $ qemu-system-x86_64 -drive file=3D/tmp/foo\" -writeconfig -
> # qemu config file
>
> [drive]
> =C2=A0=C2=A0file =3D "/tmp/foo""
>
> For bonus points, try to construct a valid qemu config file that
> contains a quoted value.  It's pretty clear (from looking at the code
> also) that this is not possible.
>
> Also:
>
> - maximum value length is hard-coded in the parser at 1023 characters
> (for no apparent reason)
>
> - the format is undocumented

Perhaps for the better, as -readconfig and -writeconfig are seriously
limited in serveral ways.

The format is Windows INI, which is as poorly specified as it's
widespread.

I intend to work on more capable configuration file support, but it'll
take some time.

> - don't use sscanf for parsing!
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> ** Description changed:
>
>   $ qemu-system-x86_64 -drive file=3D/tmp/foo\" -writeconfig -
>   # qemu config file
>=20=20=20
>   [drive]
> -   file =3D "/tmp/foo""
> + =C2=A0=C2=A0file =3D "/tmp/foo""
>=20=20=20
> - For bonus points, try to construct a value qemu config file that
> + For bonus points, try to construct a valid qemu config file that
>   contains a quoted value.  It's pretty clear (from looking at the code
>   also) that this is not possible.
>=20=20=20
>   Also:
>=20=20=20
>   - maximum value length is hard-coded in the parser at 1023 characters
>   (for no apparent reason)
>=20=20=20
>   - the format is undocumented
>=20=20=20
>   - don't use sscanf for parsing!
