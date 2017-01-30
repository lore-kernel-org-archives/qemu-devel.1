Received: from eggs.gnu.org ([2001:4830:134:3::10]:57774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYF4E-0006FU-Pz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYF4B-0005iI-LB
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:44:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYF4B-0005i8-CT
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:44:31 -0500
References: <20170128035929.10168-1-nirsof@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3cd5e07-6120-0540-cd77-5a0562270bb2@redhat.com>
Date: Mon, 30 Jan 2017 10:44:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170128035929.10168-1-nirsof@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6Rlka3Jg5jF0I386raDsThPdgwrG7WIsQ"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu-io: Return non-zero exit code
 on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Rlka3Jg5jF0I386raDsThPdgwrG7WIsQ
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Message-ID: <b3cd5e07-6120-0540-cd77-5a0562270bb2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu-io: Return non-zero exit code on
 failure
References: <20170128035929.10168-1-nirsof@gmail.com>
In-Reply-To: <20170128035929.10168-1-nirsof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2017 09:59 PM, Nir Soffer wrote:
> From: Nir Soffer <nsoffer@redhat.com>
>=20
> The result of openfile was not checked, leading to failure deep in the
> actual command with confusing error message, and exiting with exit code=
 0.
>=20

When posting a series, please ensure that your messages are all marked
In-Reply-To a 0/3 cover letter (it may help if you do 'git config
format.coverletter auto').

> Here is a simple example - trying to read with the wrong format:
>=20
>     $ touch file
>     $ qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
>     can't open device file: Image is not in qcow2 format
>     no file open, try 'help open'
>     0
>=20
> With this patch, we fail earlier with exit code 1:
>=20
>     $ ./qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
>     can't open device file: Image is not in qcow2 format
>     1
>=20
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>=20
> Changes since v2:
> - Adding missing signed-off-by
> - Fix tests expecting the wrong output

I don't see any tests changed...

>=20
>  qemu-io.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

=2E..in this diffstat.  If something really changed in this particular
patch since v2, then you should drop the Reviewed-by lines in order to
make sure I re-review it.  Or, if the changes you mention here are to
other patches in the series, then the 0/3 cover letter would have been a
better place to put that information.

>=20
> diff --git a/qemu-io.c b/qemu-io.c
> index 23a229f..427cbae 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -595,13 +595,17 @@ int main(int argc, char **argv)
>                  exit(1);
>              }
>              opts =3D qemu_opts_to_qdict(qopts, NULL);
> -            openfile(NULL, flags, writethrough, opts);
> +            if (openfile(NULL, flags, writethrough, opts)) {
> +                exit(1);
> +            }
>          } else {
>              if (format) {
>                  opts =3D qdict_new();
>                  qdict_put(opts, "driver", qstring_from_str(format));
>              }
> -            openfile(argv[optind], flags, writethrough, opts);
> +            if (openfile(argv[optind], flags, writethrough, opts)) {
> +                exit(1);
> +            }
>          }
>      }
>      command_loop();
>=20

At any rate, I'm happy with this current patch, even if its presentation
in a series is less than ideal, so you can keep my R-b.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6Rlka3Jg5jF0I386raDsThPdgwrG7WIsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj21sAAoJEKeha0olJ0NqH6EH/jjsBfjz8jzT5lAtBctVjdJm
3KrwvETZiyD4Cz8NIcm/V8+augDbJfWuufoBS06TJgEfL1utHANCEtmpCA80yU8F
2fdgIEwjvPegd1qiqgyznCoQAYBxwJnZMX3ksYrHY6UzjS8dg6kKXbTfpQmPPwfz
xeoaModXgRDJiDE2IGv5KGz09MFvYEwW6Bwh0mOpBFj4FP6VhUll5i35y/sATqgt
7GzysrtyLgG8aKV3xK5F2w5BExF7pcbSsNp0VPaE4Y9NBUZ+f5HdJyoDV62PzXFG
c0Myvj2Pc7IFhQW5BETF+M02LkOdbg0zO0hwD+0/U/fN1yB39qpVJ1n9N0SFwSk=
=7swj
-----END PGP SIGNATURE-----

--6Rlka3Jg5jF0I386raDsThPdgwrG7WIsQ--
