Received: from eggs.gnu.org ([2001:4830:134:3::10]:40902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwVHE-0005kl-MC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwVHB-0003k3-EX
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:54:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cwVHB-0003jx-5V
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:54:13 -0400
References: <20170407143254.22061-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9e3490a-0a70-7b9d-53cb-0a2fd389c796@redhat.com>
Date: Fri, 7 Apr 2017 09:54:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170407143254.22061-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tNOTWamHJXxt4HjsqTjIuAjvqBAqSVCLe"
Subject: Re: [Qemu-devel] [PATCH for 2.10] slirp/smb: Replace constant
 strings by glib string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tNOTWamHJXxt4HjsqTjIuAjvqBAqSVCLe
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com,
 berrange@redhat.com
Message-ID: <a9e3490a-0a70-7b9d-53cb-0a2fd389c796@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] slirp/smb: Replace constant strings
 by glib string
References: <20170407143254.22061-1-dgilbert@redhat.com>
In-Reply-To: <20170407143254.22061-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2017 09:32 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> gcc 7 (on fedora 26) objects to many of the snprintf's
> in the smb path and command creation because it can't
> figure out that the smb_dir (i.e. the /tmp dir for the configuration)
> is known to be short.
>=20
> Replace all these fixed length buffers by g_str* functions that dynamic=
ally
> allocate and use g_dir_make_tmp to make the directory.
> (It's fairly new glib but we have a compat function for it).
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  net/slirp.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/net/slirp.c b/net/slirp.c
> index f97ec23345..9f6521190b 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -80,7 +80,7 @@ typedef struct SlirpState {
>      Slirp *slirp;
>      Notifier exit_notifier;
>  #ifndef _WIN32
> -    char smb_dir[128];
> +    gchar *smb_dir;

Does it really have to be gchar? That's one of the more pointless
typedefs in glib; and I think 'char *' is just fine.


> =20
> -    snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
> +    smb_cmdline =3D g_strdup_printf("%s -l %s -s %s",
>               CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);

Gross that we're parsing a command line through a shell, but
pre-existing and looks like CONFIG_SMBD_COMMAND, s->smb_dir, and
smb_conf should all be enough under our control to ensure that there are
no shell metacharacters and therefore exploits possible.

The cleanup is useful, and resolves one of the build issues I pointed
out earlier on Rawhide (looks like it is now Fedora 26 in addition to
Rawhide that have new-enough gcc).  In that thread, we argued that it's
not going to be essential to get this in for 2.9, but as more and more
people move to newer gcc, it will probably be a candidate for
qemu-stable for 2.9.1 in addition to 2.10.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tNOTWamHJXxt4HjsqTjIuAjvqBAqSVCLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY56gNAAoJEKeha0olJ0NqHQ4IAKbJg+GGXfH01W3sXAz07iI/
DTAXYVWu0brChYzGQVfesFOJIPPZVlnXzctSyIvcGF+lXGaPpEzkthsQlgmoQVVw
oJF+nGcjm1hOx5vwLgpHR47QL77whUducuHyfBbjsWyzaKU/JUzY6cgEKohej+Hr
cidJkbbwu2+9Gko0fhv5p+DnQW+W+6qlL6WAhFvl/XRTNeAF1luQAfFp2a3wUBCM
Pw4bZoXA016xyAe/yvMPGL3nh+qNPeDytOlg3MLYAgoZRlfboUJ6+3Z+Jb3k5+gg
LWqAaZo4bLILxkFCK5K67CpO0ZVREO6KgYeBn7swsTUv9pdKBWekGW1fMHuZ9FA=
=o/+R
-----END PGP SIGNATURE-----

--tNOTWamHJXxt4HjsqTjIuAjvqBAqSVCLe--
