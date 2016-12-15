Received: from eggs.gnu.org ([2001:4830:134:3::10]:36873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHW5r-0000wm-QO
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHW5q-0002rM-Mp
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:29:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHW5q-0002qu-E7
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:29:06 -0500
Date: Thu, 15 Dec 2016 13:29:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161215132901.GJ2509@work-vm>
References: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
	<20161108095603.72301-7-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108095603.72301-7-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/8] migration/vmstate: split up
 vmstate_base_addr
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
> Currently vmstate_base_addr does several things: it pinpoints the field
> within the struct, possibly allocates memory and possibly does the first
> pointer dereference. Obviously allocation is needed only for load.
> 
> Let us split up the functionality in vmstate_base_addr and move the
> address manipulations (that is everything but the allocation logic) to
> load and save so it becomes more obvious what is actually going on. Like
> this all the address calculations (and the handling of the flags
> controlling these) is in one place and the sequence is more obvious.
> 
> The newly introduced function vmstate_handle_alloc also fixes the
> allocation for the unused VMS_VBUFFER| VMS_MULTIPLY scenario and is
> substantially simpler than the original vmstate_base_addr.
> 
> In load and save some asserts are added so it's easier to debug
> situations where we would end up with a null pointer dereference.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  migration/vmstate.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index a86fb7e..10a7645 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -50,29 +50,15 @@ static int vmstate_size(void *opaque, VMStateField *field)
>      return size;
>  }
>  
> -static void *vmstate_base_addr(void *opaque, VMStateField *field, bool alloc)
> -{
> -    void *base_addr = opaque + field->offset;
> -
> -    if (field->flags & VMS_POINTER) {
> -        if (alloc && (field->flags & VMS_ALLOC)) {
> -            gsize size = 0;
> -            if (field->flags & VMS_VBUFFER) {

OK, that test isn't really needed because vmstate_size already has it.

> -                size = vmstate_size(opaque, field);
> -            } else {
> -                int n_elems = vmstate_n_elems(opaque, field);
> -                if (n_elems) {
> -                    size = n_elems * field->size;
> -                }
> -            }
> -            if (size) {
> -                *(void **)base_addr = g_malloc(size);
> -            }
> +static void vmstate_handle_alloc(void *ptr, VMStateField *field, void *opaque)
> +{
> +    if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
> +        gsize size = vmstate_size(opaque, field);
> +        size *= vmstate_n_elems(opaque, field);
> +        if (size) {
> +            *(void **)ptr = g_malloc(size);
>          }
> -        base_addr = *(void **)base_addr;
>      }
> -
> -    return base_addr;
>  }
>  
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> @@ -108,10 +94,15 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>               field->field_exists(opaque, version_id)) ||
>              (!field->field_exists &&
>               field->version_id <= version_id)) {
> -            void *first_elem = vmstate_base_addr(opaque, field, true);
> +            void *first_elem = opaque + field->offset;
>              int i, n_elems = vmstate_n_elems(opaque, field);
>              int size = vmstate_size(opaque, field);
>  
> +            vmstate_handle_alloc(first_elem, field, opaque);
> +            if (field->flags & VMS_POINTER) {
> +                first_elem = *(void **)first_elem;
> +                assert(first_elem);
> +            }
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
>  
> @@ -310,12 +301,16 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>      while (field->name) {
>          if (!field->field_exists ||
>              field->field_exists(opaque, vmsd->version_id)) {
> -            void *first_elem = vmstate_base_addr(opaque, field, false);
> +            void *first_elem = opaque + field->offset;
>              int i, n_elems = vmstate_n_elems(opaque, field);
>              int size = vmstate_size(opaque, field);
>              int64_t old_offset, written_bytes;
>              QJSON *vmdesc_loop = vmdesc;
>  
> +            if (field->flags & VMS_POINTER) {
> +                first_elem = *(void **)first_elem;
> +                assert(first_elem);

Can you make that   assert(first_elem || !n_elems) please.
and same above.

Dave

> +            }
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
>  
> -- 
> 2.8.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
