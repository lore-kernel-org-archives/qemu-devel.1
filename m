Received: from eggs.gnu.org ([2001:4830:134:3::10]:56610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctxDL-0005Q6-H8
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctxDH-0003gG-DC
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:07:43 -0400
References: <1490967529-4767-1-git-send-email-peter.maydell@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2a187f00-1dc9-b633-887c-f6909ccb1617@redhat.com>
Date: Fri, 31 Mar 2017 16:07:32 +0200
MIME-Version: 1.0
In-Reply-To: <1490967529-4767-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CXPeqkTSAM0cNuQpQ4MAKooC4lMPcXhG6"
Subject: Re: [Qemu-devel] [PATCH] qemu-io-cmds: Assert that global and
 nofile commands don't use ct->perms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CXPeqkTSAM0cNuQpQ4MAKooC4lMPcXhG6
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <2a187f00-1dc9-b633-887c-f6909ccb1617@redhat.com>
Subject: Re: [PATCH] qemu-io-cmds: Assert that global and nofile commands
 don't use ct->perms
References: <1490967529-4767-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490967529-4767-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 15:38, Peter Maydell wrote:
> It would be a bug for a command with the CMD_NOFILE_OK or
> CMD_FLAG_GLOBAL flags set to also set the ct->perms field,
> because the former says "OK for a file not to be open"
> but the latter is a check on a file.
>=20
> Add an assertion in qemuio_add_command() so we can catch that
> sort of buggy command definition immediately rather than it
> being a bug that only manifests when a particular set of
> command line options is used.
>=20
> (Coverity gets confused about this (CID 1371723) and reports
> that we might dereference a NULL blk pointer in this case,
> because it can't tell that that code path never happens with
> the cmdinfo_t that we have. This commit won't help unconfuse
> it, but it does fix the underlying issue.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We could also try to add some kind of assert in command() to
> persuade coverity that it can't get there with a NULL block
> and ct->perms non-zero, but I think I'd rather just mark the
> issue as a false-positive and move on.

I think having the assertion in qemuio_add_command() is nicer because if
we break it we will definitely notice just by launching qemu-io.

>  qemu-io-cmds.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--CXPeqkTSAM0cNuQpQ4MAKooC4lMPcXhG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljeYqUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxiUH/Rb9ndNCHUCpaSD3XlTzZGKyv8e3xO9S
njFrP3WfSaYWYN87V5mObtMNybMKGQ7ioj+c2AuPwMf9vuW0DvTUUP0D0KMC+pXa
qyFNzNqOB9JMnnTUof2i9aZzy6srX49PWC2nr5OItHZpmo1xkj8Za3NUocI5aTBN
U0J/N1szxozSjXMwQaLayIWMO/o63OVzCWIWuRbQl8AFXPJN2Dj5mmwPyYUITxZO
LugtDfG8diPEfUA5KUJy8uitzg6UtxOOvsgO9zUjGAkbV5PtNJ3jVN9x+orX9MPV
+jNeEzM2IAFLN9C9bpnTrkn7oX0WNOJMBRz2aJw8D0JK54H9jOxq/Wk=
=A7QK
-----END PGP SIGNATURE-----

--CXPeqkTSAM0cNuQpQ4MAKooC4lMPcXhG6--
