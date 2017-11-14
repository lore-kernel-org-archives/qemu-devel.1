Received: from eggs.gnu.org ([2001:4830:134:3::10]:43174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEfZI-0002NA-Lx
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEfZD-0005oJ-VL
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:04:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEfZD-0005na-Mp
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:04:11 -0500
References: <20171021124213.84AEC7456EF@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eba4f539-3474-57a2-a44c-6c60f55d90ac@redhat.com>
Date: Tue, 14 Nov 2017 19:04:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171021124213.84AEC7456EF@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] exec: Fix section_covers_addr() for
 sections with non-zero offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 21/10/2017 13:24, BALATON Zoltan wrote:
> When a section with non-0 offset_within_region field is tested to
> cover an address the offset should be taken into account as well.
>=20
> This fixes a crash caused by picking the wrong memory region in
> address_space_lookup_region seen with client code accessing a device
> model that uses alias memory regions.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This seems to fix the problem described in
> http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03356.html
> but I'm not completely sure about it. This seems to be introduced in
> 729633c exec: Introduce AddressSpaceDispatch.mru_section and the patch
> before that which split off section_covers_addr from phys_page_find so
> this patch also changes that caller. Is that OK to do? It appears to
> work but I don't know this part of QEMU.
>=20
> Also the bug seems to be caused by section_covers_addr accepting
> sii3112.bar5 when that's the mru_section instead of picking
> sii3112.bar0 (which it picks when going through phys_page_find) when
> client code is accessing 0xc08001006 from this address map (full
> address map is at above URL):
>=20
> address-space: memory
>     0000000c08000000-0000000c0800ffff (prio 0, i/o): alias isa_mmio @io=
 0000000000000000-000000000000ffff
>=20
> address-space: I/O
>   0000000000000000-000000000000ffff (prio 0, i/o): io
>     0000000000001000-0000000000001007 (prio 1, i/o): alias sii3112.bar0=
 @sii3112.bar5 0000000000000080-0000000000000087
>     0000000000001008-000000000000100b (prio 1, i/o): alias sii3112.bar1=
 @sii3112.bar5 0000000000000088-000000000000008b
>     0000000000001010-0000000000001017 (prio 1, i/o): alias sii3112.bar2=
 @sii3112.bar5 00000000000000c0-00000000000000c7
>     0000000000001018-000000000000101b (prio 1, i/o): alias sii3112.bar3=
 @sii3112.bar5 00000000000000c8-00000000000000cb
>     0000000000001020-000000000000102f (prio 1, i/o): alias sii3112.bar4=
 @sii3112.bar5 0000000000000000-000000000000000f
>=20
> which this patch fixes but would the same problem happen if the
> mru_section is bar5 but bar4 is accessed? I could not reproduce that
> case but then the offset is 0 but in this case the address would be
> above 0xc08001020 and size is 0xf so they probably won't match. But
> this is only because of the size of the region. Could that mean the
> bug is caused by something else and should be fixed elsewhere?
>=20
> ---
>  exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/exec.c b/exec.c
> index db5ae23..a915817 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -370,7 +370,8 @@ static inline bool section_covers_addr(const Memory=
RegionSection *section,
>       * the section must cover the entire address space.
>       */
>      return int128_gethi(section->size) ||
> -           range_covers_byte(section->offset_within_address_space,
> +           range_covers_byte(section->offset_within_address_space +
> +                             section->offset_within_region,
>                               int128_getlo(section->size), addr);
>  }

Sorry, this is incorrect.  addr is an address in the address space, and
range_covers_byte checks if it is between
section->offset_within_address_space and
section->offset_within_address_space + section->size.  I am not sure how
things don't explode completely by adding section->offset_within_region
(probably it's just because section->offset_within_region is usually 0).

Paolo
