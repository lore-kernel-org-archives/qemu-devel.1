Received: from eggs.gnu.org ([2001:4830:134:3::10]:55117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fmdmW-0008Fn-1V
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fmdmS-0006Cv-BU
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:34:35 -0400
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
	<20180805182832.3012-6-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fedd812b-df9c-b610-c78b-fe02f9869660@redhat.com>
Date: Mon, 6 Aug 2018 13:34:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180805182832.3012-6-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] target/s390x: fix PACK reading 1 byte
 less and writing 1 byte more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

On 05.08.2018 20:28, Pavel Zbitskiy wrote:
> PACK fails on the test from the Principles of Operation: F1F2F3F4
> becomes 0000234C instead of 0001234C due to an off-by-one error.
> Furthermore, it overwrites one extra byte to the left of F1.
>=20
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/mem_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 704d0193b5..bacae4f503 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1019,15 +1019,15 @@ void HELPER(pack)(CPUS390XState *env, uint32_t =
len, uint64_t dest, uint64_t src)
>      len_src--;
> =20
>      /* now pack every value */
> -    while (len_dest >=3D 0) {
> +    while (len_dest > 0) {
>          b =3D 0;
> =20
> -        if (len_src > 0) {
> +        if (len_src >=3D 0) {
>              b =3D cpu_ldub_data_ra(env, src, ra) & 0x0f;
>              src--;
>              len_src--;
>          }
> -        if (len_src > 0) {
> +        if (len_src >=3D 0) {
>              b |=3D cpu_ldub_data_ra(env, src, ra) << 4;
>              src--;
>              len_src--;
>=20

In the SS format with two length fields, and in the
RSL format, L1 specifies the number of additional
operand bytes to the right of the byte designated by
the first-operand address. Therefore, the length in
bytes of the first operand is 1-16, corresponding to a
length code in L1 of 0-15. Similarly, L2. specifies the
number of additional operand bytes to the right of the
location designated by the second-operand address.
Results replace the first operand and are never
stored outside the field specified by the address and
length. If the first operand is longer than the second,
the second operand is extended on the left with zeros
up to the length of the first operand. This extension
does not modify the second operand in storage.

Doesn't this imply that we have always length + 1, and therefore the
current code is fine? ("length code vs length")

(e.g. len_dest =3D 0 implies one byte?)

--=20

Thanks,

David / dhildenb
