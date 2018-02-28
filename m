Received: from eggs.gnu.org ([2001:4830:134:3::10]:56158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er2Jr-0003PI-3C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er2Jp-0000sH-UR
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:02:55 -0500
Date: Wed, 28 Feb 2018 14:02:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228140242.GP17774@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228131315.30194-1-mreitz@redhat.com>
	<20180228131315.30194-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228131315.30194-3-mreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Test preallocated truncate of
 2G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org

On Wed, Feb 28, 2018 at 02:13:15PM +0100, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/106     | 24 ++++++++++++++++++++++++
>  tests/qemu-iotests/106.out | 10 ++++++++++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
> index bfe71f4e60..5e51f88a78 100755
> --- a/tests/qemu-iotests/106
> +++ b/tests/qemu-iotests/106
> @@ -86,6 +86,30 @@ for growth_mode in falloc full off; do
>      $QEMU_IMG resize -f "$IMGFMT" --shrink --preallocation=3D$growth_m=
ode "$TEST_IMG" -${GROWTH_SIZE}K
>  done
> =20
> +echo
> +echo '=3D=3D=3D Testing image growth on 2G empty image =3D=3D=3D'
> +
> +for growth_mode in falloc full; do
> +    echo
> +    echo "--- growth_mode=3D$growth_mode ---"
> +
> +    # Maybe we want to do an lseek() to the end of the file before the
> +    # preallocation; if the file has a length of 2 GB, that would
> +    # return an integer that overflows to negative when put into a
> +    # plain int.  We should use the correct type for the result, and
> +    # this tests we do.
> +
> +    _make_test_img 2G
> +    $QEMU_IMG resize -f "$IMGFMT" --preallocation=3D$growth_mode "$TES=
T_IMG" +${GROWTH_SIZE}K
> +
> +    actual_size=3D$($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" | grep 'di=
sk size')
> +    actual_size=3D$(echo "$actual_size" | sed -e 's/^[^0-9]*\([0-9]\+\=
).*$/\1/')
> +
> +    if [ $actual_size -lt $GROWTH_SIZE ]; then
> +        echo "ERROR: Image should have at least ${GROWTH_SIZE}K, but h=
as ${actual_size}K"
> +    fi
> +done
> +
>  # success, all done
>  echo '*** done'
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/106.out b/tests/qemu-iotests/106.out
> index 0a42312301..c459957660 100644
> --- a/tests/qemu-iotests/106.out
> +++ b/tests/qemu-iotests/106.out
> @@ -47,4 +47,14 @@ qemu-img: Preallocation can only be used for growing=
 images
> =20
>  --- growth_mode=3Doff ---
>  Image resized.
> +
> +=3D=3D=3D Testing image growth on 2G empty image =3D=3D=3D
> +
> +--- growth_mode=3Dfalloc ---
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2147483648
> +Image resized.
> +
> +--- growth_mode=3Dfull ---
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2147483648
> +Image resized.
>  *** done

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
