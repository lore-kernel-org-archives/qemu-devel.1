Received: from eggs.gnu.org ([2001:4830:134:3::10]:44855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnnDF-0008Lc-Ba
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnnDE-0002Is-9p
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:14:09 -0400
Date: Tue, 14 Mar 2017 14:13:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170314141356.GK2445@work-vm>
References: <20170310044402.38880-1-haoqf@linux.vnet.ibm.com>
	<20170310044402.38880-2-haoqf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310044402.38880-2-haoqf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] vmstate: fix failed iotests case 68
 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, quintela@redhat.com

* QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
> This problem affects s390x only if we are running without KVM.
> Basically, S390CPU.irqstate is unused if we do not use KVM,
> and thus no buffer is allocated.
> This causes size=0, first_elem=NULL and n_elems=1 in
> vmstate_load_state and vmstate_save_state. And the assert fails.
> With this fix we can go back to the old behavior and support
> VMS_VBUFFER with size 0 and nullptr.
> 
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Thanks, and fixes problem with vmxnet3 migration.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave

> ---
>  migration/vmstate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 78b3cd4..7b4a607 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -109,7 +109,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>              vmstate_handle_alloc(first_elem, field, opaque);
>              if (field->flags & VMS_POINTER) {
>                  first_elem = *(void **)first_elem;
> -                assert(first_elem  || !n_elems);
> +                assert(first_elem || !n_elems || !size);
>              }
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
> @@ -117,7 +117,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      curr_elem = *(void **)curr_elem;
>                  }
> -                if (!curr_elem) {
> +                if (!curr_elem && size) {
>                      /* if null pointer check placeholder and do not follow */
>                      assert(field->flags & VMS_ARRAY_OF_POINTER);
>                      ret = vmstate_info_nullptr.get(f, curr_elem, size, NULL);
> @@ -325,7 +325,7 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
>              if (field->flags & VMS_POINTER) {
>                  first_elem = *(void **)first_elem;
> -                assert(first_elem  || !n_elems);
> +                assert(first_elem || !n_elems || !size);
>              }
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
> @@ -336,7 +336,7 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                      assert(curr_elem);
>                      curr_elem = *(void **)curr_elem;
>                  }
> -                if (!curr_elem) {
> +                if (!curr_elem && size) {
>                      /* if null pointer write placeholder and do not follow */
>                      assert(field->flags & VMS_ARRAY_OF_POINTER);
>                      vmstate_info_nullptr.put(f, curr_elem, size, NULL, NULL);
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
