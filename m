Received: from eggs.gnu.org ([2001:4830:134:3::10]:39084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diNTj-0001EI-5U
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diNTg-0008O9-24
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diNTf-0008Ng-Rr
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:16:59 -0400
References: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e763f07-c688-ce55-2824-c2d0d7562edb@redhat.com>
Date: Thu, 17 Aug 2017 18:16:53 +0200
MIME-Version: 1.0
In-Reply-To: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10???] fix build failure in
 nbd_read_reply_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org

On 17/08/2017 18:14, Igor Mammedov wrote:
> travis builds fail at HEAD at rc3 master with
>=20
>   block/nbd-client.c: In function =E2=80=98nbd_read_reply_entry=E2=80=99=
:
>   block/nbd-client.c:110:8: error: =E2=80=98ret=E2=80=99 may be used un=
initialized in this function [-Werror=3Duninitialized]
>=20
> fix it by initializing 'ret' to 0

This is a false positive, but it's understandably impossible for the
compiler to figure it out.

Even though we disable -Werror on release builds, it may be worth fixing
this in 2.10 if it doesn't delay the release.  Peter, what do you think
about applying this on top of -rc3 without doing a fourth candidate?

Paolo

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  block/nbd-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 422ecb4..02c8e20 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -70,7 +70,7 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
>  {
>      NBDClientSession *s =3D opaque;
>      uint64_t i;
> -    int ret;
> +    int ret =3D 0;
>      Error *local_err =3D NULL;
> =20
>      while (!s->quit) {
>=20
