Received: from eggs.gnu.org ([2001:4830:134:3::10]:39698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHUdG-0002vr-OF
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHUdC-0007On-OF
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:55:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHUdC-0007OL-Fh
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:55:26 -0500
Date: Thu, 15 Dec 2016 11:55:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161215115521.GG2509@work-vm>
References: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
	<20161108095603.72301-6-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108095603.72301-6-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/8] migration/vmstate: renames in
 (load|save)_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> The vmstate_(load|save)_state start out with an a void *opaque pointing
> to some struct, and manipulate one or more elements of one field within
> that struct.
> 
> First the field within the struct is pinpointed as opaque + offset, then
> if this is a pointer the pointer is dereferenced to obtain a pointer to
> the first element of the vmstate field. Pointers to further elements if
> any are calculated as first_element + i * element_size (where i is the
> zero based index of the element in question).
> 
> Currently base_addr and addr is used as a variable name for the pointer
> to the first element and the pointer to the current element being
> processed. This is suboptimal because base_addr is somewhat
> counter-intuitive (because obtained as base + offset) and both base_addr
> and addr not very descriptive (that we have a pointer should be clear
> from the fact that it is declared as a pointer).
> 
> Let make things easier to understand by renaming base_addr to first_elem
> and addr to curr_elem. This has the additional benefit of harmonizing
> with other names within the scope (n_elems, vmstate_n_elems).
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> --
> 
> This patch roots in the difficulties I faced when trying to figure out
> the code in question. In the meanwhile I'm quite fine with the current
> names because I have it already figured out (after a couple of months
> not looking on this code however, who knows). Thus my main motivation
> is making things easier for the next new guy, but if the old guys say
> not worth it I can very well accept that too.
> ---
>  migration/vmstate.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 8767e40..a86fb7e 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -108,21 +108,21 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>               field->field_exists(opaque, version_id)) ||
>              (!field->field_exists &&
>               field->version_id <= version_id)) {
> -            void *base_addr = vmstate_base_addr(opaque, field, true);
> +            void *first_elem = vmstate_base_addr(opaque, field, true);
>              int i, n_elems = vmstate_n_elems(opaque, field);
>              int size = vmstate_size(opaque, field);
>  
>              for (i = 0; i < n_elems; i++) {
> -                void *addr = base_addr + size * i;
> +                void *curr_elem = first_elem + size * i;
>  
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> -                    addr = *(void **)addr;
> +                    curr_elem = *(void **)curr_elem;
>                  }
>                  if (field->flags & VMS_STRUCT) {
> -                    ret = vmstate_load_state(f, field->vmsd, addr,
> +                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
>                                               field->vmsd->version_id);
>                  } else {
> -                    ret = field->info->get(f, addr, size);
> +                    ret = field->info->get(f, curr_elem, size);
>  
>                  }
>                  if (ret >= 0) {
> @@ -310,25 +310,25 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>      while (field->name) {
>          if (!field->field_exists ||
>              field->field_exists(opaque, vmsd->version_id)) {
> -            void *base_addr = vmstate_base_addr(opaque, field, false);
> +            void *first_elem = vmstate_base_addr(opaque, field, false);
>              int i, n_elems = vmstate_n_elems(opaque, field);
>              int size = vmstate_size(opaque, field);
>              int64_t old_offset, written_bytes;
>              QJSON *vmdesc_loop = vmdesc;
>  
>              for (i = 0; i < n_elems; i++) {
> -                void *addr = base_addr + size * i;
> +                void *curr_elem = first_elem + size * i;
>  
>                  vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
>                  old_offset = qemu_ftell_fast(f);
> -
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> -                    addr = *(void **)addr;
> +                    assert(curr_elem);
> +                    curr_elem = *(void **)curr_elem;
>                  }
>                  if (field->flags & VMS_STRUCT) {
> -                    vmstate_save_state(f, field->vmsd, addr, vmdesc_loop);
> +                    vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
>                  } else {
> -                    field->info->put(f, addr, size);
> +                    field->info->put(f, curr_elem, size);
>                  }
>  
>                  written_bytes = qemu_ftell_fast(f) - old_offset;
> -- 
> 2.8.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
