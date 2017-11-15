Received: from eggs.gnu.org ([2001:4830:134:3::10]:47788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eF2v9-0000LY-Pm
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eF2v4-0003cL-Tg
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:00:23 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:64137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eF2v4-0003WQ-Iu
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:00:18 -0500
Date: Wed, 15 Nov 2017 20:00:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <cd544495-16c6-5e75-837b-be1deb4e9768@redhat.com>
Message-ID: <alpine.BSF.2.21.1711151930030.26122@zero.eik.bme.hu>
References: <20171114225941.072707456B5@zero.eik.bme.hu>
	<cd544495-16c6-5e75-837b-be1deb4e9768@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] exec: Skip mru section if it's a partial
 page and not resolving subpage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Wed, 15 Nov 2017, Paolo Bonzini wrote:
> This is another possibility:
>
> diff --git a/exec.c b/exec.c
> index 97a24a875e..3bb9fcf257 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -410,22 +410,16 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
> {
>     MemoryRegionSection *section = atomic_read(&d->mru_section);
>     subpage_t *subpage;
> -    bool update;
>
> -    if (section && section != &d->map.sections[PHYS_SECTION_UNASSIGNED] &&
> -        section_covers_addr(section, addr)) {
> -        update = false;
> -    } else {
> +    if (!section || section == &d->map.sections[PHYS_SECTION_UNASSIGNED] ||
> +        !section_covers_addr(section, addr)) {
>         section = phys_page_find(d, addr);
> -        update = true;
> +        atomic_set(&d->mru_section, section);
>     }
>     if (resolve_subpage && section->mr->subpage) {
>         subpage = container_of(section->mr, subpage_t, iomem);
>         section = &d->map.sections[subpage->sub_section[SUBPAGE_IDX(addr)]];
>     }
> -    if (update) {
> -        atomic_set(&d->mru_section, section);
> -    }
>     return section;
> }
>
>
> It will skip the expensive phys_page_find but not the cheap subpage lookup.
> Does it work for you?

This also works but I can't understand why becuase the problematic call to 
this function which got the wrong result from section_covers_addr was with 
resolve_subpage=false and in that case this looks identical to the 
original which did not work. Unless this function is called multiple times 
and another call with resolve_subpage=true now somehow works better with 
this change or replacing the mru_section earlier before subpage lookup 
makes a difference which is not obvious from this function.

Anyway, it fixes the problem I see so you can use this instead of my 
patch.

Thank you,
BALATON Zoltan
