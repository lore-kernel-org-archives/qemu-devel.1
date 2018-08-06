Received: from eggs.gnu.org ([2001:4830:134:3::10]:52622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fmdWw-0003wB-MD
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fmdWs-0000FE-KY
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:18:30 -0400
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
	<20180805182832.3012-4-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9550b8d2-0498-8798-e0b9-fd9c239bc5ea@redhat.com>
Date: Mon, 6 Aug 2018 13:18:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180805182832.3012-4-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] target/s390x: fix ipm polluting
 irrelevant bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "open list:S390" <qemu-s390x@nongnu.org>

On 05.08.2018 20:28, Pavel Zbitskiy wrote:
> Suppose psw.mask=3D0x0000000080000000, cc=3D2, r1=3D0 and we do "ipm 1"=
.
> This command must touch only bits 32-39, so the expected output
> is r1=3D0x20000000. However, currently qemu yields r1=3D0x20008000,
> because irrelevant parts of PSW leak into r1 during program mask
> transfer.
>=20
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index f318fb6e4e..05442dff36 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2442,8 +2442,8 @@ static DisasJumpType op_ipm(DisasContext *s, Disa=
sOps *o)
>      tcg_gen_andi_i64(o->out, o->out, ~0xff000000ull);
> =20
>      t1 =3D tcg_temp_new_i64();
> -    tcg_gen_shli_i64(t1, psw_mask, 20);
> -    tcg_gen_shri_i64(t1, t1, 36);
> +    tcg_gen_andi_i64(t1, psw_mask, 0x00000f0000000000);

ull?

> +    tcg_gen_shri_i64(t1, t1, 16);
>      tcg_gen_or_i64(o->out, o->out, t1);
> =20
>      tcg_gen_extu_i32_i64(t1, cc_op);
>=20


--=20

Thanks,

David / dhildenb
