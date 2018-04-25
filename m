Received: from eggs.gnu.org ([2001:4830:134:3::10]:56150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPkO-0005Wn-F3
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPkN-0002b6-98
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:06:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPkN-0002am-2x
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:06:31 -0400
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<20180425124620.17182.7251.stgit@pasha-VirtualBox>
From: Eric Blake <eblake@redhat.com>
Message-ID: <52eea29c-15e2-ee6e-22d5-ffcdffac5706@redhat.com>
Date: Wed, 25 Apr 2018 14:06:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180425124620.17182.7251.stgit@pasha-VirtualBox>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2ItppaJ1d8pjt2LzsQiMR6D73TuMiiHJB"
Subject: Re: [Qemu-devel] [RFC PATCH 08/17] replay: introduce info hmp/qmp
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ItppaJ1d8pjt2LzsQiMR6D73TuMiiHJB
From: Eric Blake <eblake@redhat.com>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org,
 dgilbert@redhat.com, rth@twiddle.net
Message-ID: <52eea29c-15e2-ee6e-22d5-ffcdffac5706@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 08/17] replay: introduce info hmp/qmp
 command
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
 <20180425124620.17182.7251.stgit@pasha-VirtualBox>
In-Reply-To: <20180425124620.17182.7251.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 07:46 AM, Pavel Dovgalyuk wrote:
> This patch introduces 'info replay' monitor command and
> corresponding qmp request.
> These commands request the current record/replay mode, replay log file =
name,
> and the execution step (number or recorded/replayed instructions).
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---

Focusing on the QMP portion:


> +++ b/qapi/misc.json
> @@ -3449,3 +3449,39 @@
>  ##
>  { 'command': 'x-oob-test', 'data' : { 'lock': 'bool' },
>    'allow-oob': true }
> +
> +##
> +# @ReplayInfo:
> +#
> +# Status of the record/replay mode.
> +#
> +# @mode: current mode.
> +#
> +# @filename: name of the record/replay log file.
> +#
> +# @step: current step number.
> +#
> +# Since: 2.13
> +#
> +##
> +{ 'struct': 'ReplayInfo',
> +  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'step': 'int' } =
}
> +
> +
> +##
> +# @info_replay:

Please call this 'query-replay', for consistency with other QMP commands
(your version looks too much like an HMP command).

> +#
> +# Retrieves the status of the execution record/replay.
> +#
> +# Returns: structure with the properties of the record/replay.
> +#
> +# Since: 2.13
> +#
> +# Example:
> +#
> +# -> { "execute": "info_replay" }
> +# <- { "return": { "mode": "play", "filename": "log.rr", "step": 22041=
4 } }
> +#
> +##
> +{ 'command': 'info_replay',
> +  'returns': 'ReplayInfo' }

Please put these additions to misc.json be grouped closer to the
existing ReplayMode definition

> diff --git a/replay/Makefile.objs b/replay/Makefile.objs
> index cee6539..6694e3e 100644
> --- a/replay/Makefile.objs
> +++ b/replay/Makefile.objs
> @@ -6,4 +6,5 @@ common-obj-y +=3D replay-input.o
>  common-obj-y +=3D replay-char.o
>  common-obj-y +=3D replay-snapshot.o
>  common-obj-y +=3D replay-net.o
> -common-obj-y +=3D replay-audio.o
> \ No newline at end of file

Eww, that's an existing trivial bug that we should fix (POSIX says that
Makefiles should be text files, and that text files should end in a
newline).  Just because GNU make handles a missing trailing newline on
makefile include fragments doesn't mean we should rely on it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2ItppaJ1d8pjt2LzsQiMR6D73TuMiiHJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg0bQACgkQp6FrSiUn
Q2rtbQf/QW9Jq/qG7LbhbehMyzR/SNcFdMtIjCAaR0fc3FYBpXtkFq/fFEXqQpoX
lvoJ3M2sUJ/TlG9SShB8VttZ5PCeCgDsbK+wW9aT2T27W2lCad9oczbUdbIuWMyW
+Um0u/2YPzvy+uVngrP7Cg6hB8Dn9u+sIUZmwFdz5UZFDs/yZsAPLfAaYk7JduAH
AOfCiVpm0kRmhlS+iuDa8BQVPA8MF8GwbXxPfacD8o3BqT/RbcADGA/d7hgTZBnb
DHBLs9EkV10OvJ7hG8bIPL6veamvppR4eZ33OFDzibP0MpY9BtdrL5UGhdw0NjMz
ucJdUwoMMZ9qdBsMyhM1oQX238uO2w==
=vCdq
-----END PGP SIGNATURE-----

--2ItppaJ1d8pjt2LzsQiMR6D73TuMiiHJB--
