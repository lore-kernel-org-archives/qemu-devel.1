Received: from eggs.gnu.org ([2001:4830:134:3::10]:47913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duVjo-0004PR-Ix
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duVjh-0000Kt-Fk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duVjh-0000IY-64
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:31:41 -0400
Date: Wed, 20 Sep 2017 11:31:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920033134.GQ3617@pxdev.xzpeter.org>
References: <20170919180038.26056-1-dgilbert@redhat.com>
	<20170919180038.26056-6-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919180038.26056-6-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

On Tue, Sep 19, 2017 at 07:00:38PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> vmstate_save is called in a few places, and vmstate_save_state is
> called in lots of places.
> 
> Route error returns from the easier cases back up;  there are lots
> of more complex cases where there own error paths need fixing.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

IIUC we are touching up the put()s hooks.  Then do we need this as
well below?

-----
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 3226e8e..70e1e14 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -355,7 +355,10 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                 } else if (field->flags & VMS_STRUCT) {
                     vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
                 } else {
-                    field->info->put(f, curr_elem, size, field, vmdesc_loop);
+                    ret = field->info->put(f, curr_elem, size, field, vmdesc_loop);
+                    if (ret) {
+                        return ret;
+                    }
                 }
 
                 written_bytes = qemu_ftell_fast(f) - old_offset;
-----

Or these errors won't really stop the migration?

> ---
>  hw/display/virtio-gpu.c    |  4 +---
>  hw/virtio/virtio.c         | 13 +++++++------
>  include/hw/virtio/virtio.h |  2 +-
>  migration/vmstate-types.c  | 11 ++++++++---
>  tests/test-vmstate.c       |  6 +++---
>  5 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 622ee300f9..c9494e8a79 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -996,9 +996,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
>      }
>      qemu_put_be32(f, 0); /* end of list */
>  
> -    vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
> -
> -    return 0;
> +    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
>  }
>  
>  static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 464947f76d..860333788b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1899,7 +1899,7 @@ static const VMStateDescription vmstate_virtio = {
>      }
>  };
>  
> -void virtio_save(VirtIODevice *vdev, QEMUFile *f)
> +int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>  {
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> @@ -1949,20 +1949,21 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      }
>  
>      if (vdc->vmsd) {
> -        vmstate_save_state(f, vdc->vmsd, vdev, NULL);
> +        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL);
> +        if (ret) {
> +            return ret;
> +        }
>      }
>  
>      /* Subsections */
> -    vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> +    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
>  }
>  
>  /* A wrapper for use as a VMState .put function */
>  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
>                                VMStateField *field, QJSON *vmdesc)
>  {
> -    virtio_save(VIRTIO_DEVICE(opaque), f);
> -
> -    return 0;
> +    return virtio_save(VIRTIO_DEVICE(opaque), f);
>  }
>  
>  /* A wrapper for use as a VMState .get function */
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 80c45c321e..5abada6966 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -188,7 +188,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
>  void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
>  void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
>  
> -void virtio_save(VirtIODevice *vdev, QEMUFile *f);
> +int virtio_save(VirtIODevice *vdev, QEMUFile *f);
>  
>  extern const VMStateInfo virtio_vmstate_info;
>  
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index c056c98bdb..48184c380d 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -550,13 +550,14 @@ static int put_tmp(QEMUFile *f, void *pv, size_t size, VMStateField *field,
>  {
>      const VMStateDescription *vmsd = field->vmsd;
>      void *tmp = g_malloc(size);
> +    int ret;
>  
>      /* Writes the parent field which is at the start of the tmp */
>      *(void **)tmp = pv;
> -    vmstate_save_state(f, vmsd, tmp, vmdesc);
> +    ret = vmstate_save_state(f, vmsd, tmp, vmdesc);
>      g_free(tmp);
>  
> -    return 0;
> +    return ret;
>  }
>  
>  const VMStateInfo vmstate_info_tmp = {
> @@ -657,12 +658,16 @@ static int put_qtailq(QEMUFile *f, void *pv, size_t unused_size,
>      /* offset of the QTAILQ entry in a QTAILQ element*/
>      size_t entry_offset = field->start;
>      void *elm;
> +    int ret;
>  
>      trace_put_qtailq(vmsd->name, vmsd->version_id);
>  
>      QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
>          qemu_put_byte(f, true);
> -        vmstate_save_state(f, vmsd, elm, vmdesc);
> +        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
> +        if (ret) {
> +            return ret;
> +        }
>      }
>      qemu_put_byte(f, false);
>  
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index e643ac662b..ab3e430c2c 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -70,7 +70,7 @@ static void save_vmstate(const VMStateDescription *desc, void *obj)
>      QEMUFile *f = open_test_file(true);
>  
>      /* Save file with vmstate */
> -    vmstate_save_state(f, desc, obj, NULL);
> +    g_assert(!vmstate_save_state(f, desc, obj, NULL));
>      qemu_put_byte(f, QEMU_VM_EOF);
>      g_assert(!qemu_file_get_error(f));
>      qemu_fclose(f);
> @@ -381,7 +381,7 @@ static void test_save_noskip(void)
>      QEMUFile *fsave = open_test_file(true);
>      TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
>                         .skip_c_e = false };
> -    vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
> +    g_assert(!vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL));
>      g_assert(!qemu_file_get_error(fsave));
>  
>      uint8_t expected[] = {
> @@ -402,7 +402,7 @@ static void test_save_skip(void)
>      QEMUFile *fsave = open_test_file(true);
>      TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
>                         .skip_c_e = true };
> -    vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
> +    g_assert(!vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL));
>      g_assert(!qemu_file_get_error(fsave));
>  
>      uint8_t expected[] = {
> -- 
> 2.13.5
> 

-- 
Peter Xu
