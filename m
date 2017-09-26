Received: from eggs.gnu.org ([2001:4830:134:3::10]:52370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwfpk-0001DF-Sk
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwfph-0000c1-11
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwfpg-0000bh-Nu
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:42:48 -0400
Date: Tue, 26 Sep 2017 10:42:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170926024241.GH19505@pxdev.xzpeter.org>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925112917.21340-4-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] migration: Check field save returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

On Mon, Sep 25, 2017 at 12:29:14PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Check the return values from vmstate_save_state for fields and also the
> return values from 'put' for fields that use that.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/vmstate.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index ae8abd3c32..848e8448c6 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -347,6 +347,7 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>              }
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
> +                ret = 0;
>  
>                  vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
>                  old_offset = qemu_ftell_fast(f);
> @@ -357,11 +358,19 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                  if (!curr_elem && size) {
>                      /* if null pointer write placeholder and do not follow */
>                      assert(field->flags & VMS_ARRAY_OF_POINTER);
> -                    vmstate_info_nullptr.put(f, curr_elem, size, NULL, NULL);
> +                    ret = vmstate_info_nullptr.put(f, curr_elem, size, NULL,
> +                                                   NULL);
>                  } else if (field->flags & VMS_STRUCT) {
> -                    vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
> +                    ret = vmstate_save_state(f, field->vmsd, curr_elem,
> +                                             vmdesc_loop);
>                  } else {
> -                    field->info->put(f, curr_elem, size, field, vmdesc_loop);
> +                    ret = field->info->put(f, curr_elem, size, field,
> +                                     vmdesc_loop);
> +                }
> +                if (ret) {
> +                    error_report("Save of field %s/%s failed",
> +                                 vmsd->name, field->name);

I would prefer to prefix the function name (also there is one
error_report in previous patch) but that's optional.

Reviewed-by: Peter Xu <peterx@redhat.com>

> +                    return ret;
>                  }
>  
>                  written_bytes = qemu_ftell_fast(f) - old_offset;
> -- 
> 2.13.5
> 

-- 
Peter Xu
