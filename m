Received: from eggs.gnu.org ([2001:4830:134:3::10]:55605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEyBC-0003vQ-AX
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEyB6-0003mZ-Lu
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:56:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEyB6-0003m3-Er
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:56:32 -0500
References: <20171114225941.072707456B5@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd544495-16c6-5e75-837b-be1deb4e9768@redhat.com>
Date: Wed, 15 Nov 2017 14:56:23 +0100
MIME-Version: 1.0
In-Reply-To: <20171114225941.072707456B5@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 14/11/2017 23:42, BALATON Zoltan wrote:
> This fixes a crash caused by picking the wrong memory region in
> address_space_lookup_region seen with client code accessing a device
> model that uses alias memory regions.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/exec.c b/exec.c
> index 97a24a8..e5f2b9a 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -413,6 +413,7 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
>      bool update;
>  
>      if (section && section != &d->map.sections[PHYS_SECTION_UNASSIGNED] &&
> +        (resolve_subpage || !section->offset_within_region) &&
>          section_covers_addr(section, addr)) {
>          update = false;
>      } else {
> 

This is another possibility:

diff --git a/exec.c b/exec.c
index 97a24a875e..3bb9fcf257 100644
--- a/exec.c
+++ b/exec.c
@@ -410,22 +410,16 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
 {
     MemoryRegionSection *section = atomic_read(&d->mru_section);
     subpage_t *subpage;
-    bool update;
 
-    if (section && section != &d->map.sections[PHYS_SECTION_UNASSIGNED] &&
-        section_covers_addr(section, addr)) {
-        update = false;
-    } else {
+    if (!section || section == &d->map.sections[PHYS_SECTION_UNASSIGNED] ||
+        !section_covers_addr(section, addr)) {
         section = phys_page_find(d, addr);
-        update = true;
+        atomic_set(&d->mru_section, section);
     }
     if (resolve_subpage && section->mr->subpage) {
         subpage = container_of(section->mr, subpage_t, iomem);
         section = &d->map.sections[subpage->sub_section[SUBPAGE_IDX(addr)]];
     }
-    if (update) {
-        atomic_set(&d->mru_section, section);
-    }
     return section;
 }
 

It will skip the expensive phys_page_find but not the cheap subpage lookup.
Does it work for you?

Paolo
