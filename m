Received: from eggs.gnu.org ([2001:4830:134:3::10]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW7RI-0005Wt-Hr
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW7RE-0005XU-GS
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:11:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cW7RE-0005X9-7X
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:11:32 -0500
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c070ecd4-77e9-f4fd-fab6-c51b50220aa2@redhat.com>
Date: Tue, 24 Jan 2017 14:11:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170124110151.937-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BcDWmBJcD6FAis1jF79OhNklQ9TVJ98KE"
Subject: Re: [Qemu-devel] [PATCH v3 1/8] make: move top level dir to end of
 include search path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BcDWmBJcD6FAis1jF79OhNklQ9TVJ98KE
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?=
 <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c070ecd4-77e9-f4fd-fab6-c51b50220aa2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] make: move top level dir to end of
 include search path
References: <20170124110151.937-1-berrange@redhat.com>
 <20170124110151.937-2-berrange@redhat.com>
In-Reply-To: <20170124110151.937-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2017 05:01 AM, Daniel P. Berrange wrote:
> Currently the search path is
>=20
>   1. source dir corresponding to input file (implicit by compiler)
>   2. top level build dir
>   3. top level source dir
>   4. top level source include/ dir
>   5. source dir corresponding to input file
>   6. build dir corresponding to output file
>=20
> This causes a semantic difference in behaviour for builds
> where srcdir =3D=3D builddir vs srcdir !=3D builddir, because
> item 5 moves from end to start, when srcdir =3D=3D builddir.

Rather, item 5 is a no-op (because it duplicated 1), and item 6 moves
from the end to the beginning when srcdir =3D=3D builddir

>=20
> As a general rule we also want to move to have all shared
> headers in the include/ dir, so move that ahead of the
> top level dirs in the search order.

Wait - are you proposing that you swap 4 to occur earlier than 2/3?...

>=20
> Thus we now have:
>=20
>   1. source dir corresponding to input file
>   2. build dir corresponding to output file
>   3. top level build dir
>   4. top level source dir
>   5. top level source include/ dir

=2E..because this doesn't match that swap, and I don't see it in the patc=
h
body (but I may have missed it; I'm not as strong at reviewing make as I
am at C)

>=20
> and items 1+2 and 4+5 collapse into a single dir when srcdir=3D=3Dbuild=
dir

Isn't that items 3+4 (not 4+5) that collapse?

> so overall order remains the same.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  rules.mak | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)


>=20
> diff --git a/rules.mak b/rules.mak
> index d5c516c..e09aabe 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -26,8 +26,10 @@ QEMU_CXXFLAGS =3D -D__STDC_LIMIT_MACROS $(filter-out=
 -Wstrict-prototypes -Wmissing
>  # Flags for dependency generation
>  QEMU_DGFLAGS +=3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> =20
> -# Same as -I$(SRC_PATH) -I., but for the nested source/object director=
ies
> -QEMU_INCLUDES +=3D -I$(<D) -I$(@D)

In particular, this is the old code for 5 and 6,

> +# Compiler searches the source file dir first, but in vpath builds
> +# we need to make it search the build dir too, before any other
> +# explicit search paths.
> +QEMU_LOCAL_INCLUDES =3D -I$(BUILD_DIR)/$(@D)

while this is the new code for 2, plus documentation that 1 is implicit.

> =20
>  WL_U :=3D -Wl,-u,
>  find-symbols =3D $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
> @@ -61,7 +63,7 @@ expand-objs =3D $(strip $(sort $(filter %.o,$1)) \
>                    $(filter-out %.o %.mo,$1))
> =20
>  %.o: %.c
> -	$(call quiet-command,$(CC) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGF=
LAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
> +	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) $(=
QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CC","$(T=
ARGET_DIR)$@")

And the pre-pending of QEMU_LOCAL_INCLUDES is what changes the position
of the local directory from last to first, thus delaying the top level
dir to the end, but I don't see top/include/ moving.

These are now some long lines; is it worth taking the time to add \ line
splitting for legibility, either in this patch or as an add-on?

> @@ -359,6 +361,7 @@ define unnest-vars
>                  $(eval $(o:%.mo=3D%$(DSOSUF)): module-common.o $($o-ob=
js)),
>                  $(error $o added in $v but $o-objs is not set)))
>          $(shell mkdir -p ./ $(sort $(dir $($v))))
> +        $(shell cd $(BUILD_DIR) && mkdir -p ./ $(sort $(dir $($v))))
>          # Include all the .d files

Okay, this change makes sense (make sure all the build directories exist
in time; no-op for in-tree build, but helpful for VPATH), but seems
unrelated to the commit message.  Rebase snafu?

It looks like you're on the right track, but there's enough
discrepancies between the commit message and actual change that I'd
prefer a v4 before I grant R-b.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BcDWmBJcD6FAis1jF79OhNklQ9TVJ98KE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYh7TxAAoJEKeha0olJ0Nqg64H/3eamSjUnSU5bbXmpwa4nLP1
82GWhInGS4CIOBqQqMHYUxUGkfv2F9tAKKb15vrSiOFzF7bjgtPgnBViTue0FYwc
NmPUySxtPwyn2EQ4jPFYI5kC8Hk9Q8I/DOu0T5baxJUia4QditYASljo3pGkFk9+
H3zyurAQvDHT15cgcQZFFgnk8qpuS7mFIqye8O2c0jU849FEFiN8TCCIlK/8loiC
bzw1qn3GevOEpJ3NQ+oiiHZlDocSflrjBOw2GZTAeilGKXdgSPDxqMse8mZFnwog
/TmGdiryA4cmTt+VvaVq+uy3nnxTF7UdWtmXNNIvTdvKN3eGzJtYGoPPvKIRwXg=
=O2hN
-----END PGP SIGNATURE-----

--BcDWmBJcD6FAis1jF79OhNklQ9TVJ98KE--
