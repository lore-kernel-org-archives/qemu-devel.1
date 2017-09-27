Received: from eggs.gnu.org ([2001:4830:134:3::10]:50817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx8JN-0000tn-BY
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx8JJ-0000rB-Ch
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dx8JJ-0000qq-6H
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:07:17 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170925112917.21340-7-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 25 Sep 2017 12:29:17 +0100")
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-7-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Sep 2017 11:07:19 +0200
Message-ID: <87fub8bjco.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 6/6] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> vmstate_save is called in a few places, and vmstate_save_state is
> called in lots of places.
>
> Route error returns from the easier cases back up;  there are lots
> of more complex cases where their own error paths need fixing.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

But .....

> -void virtio_save(VirtIODevice *vdev, QEMUFile *f)
> +int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>  {
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> @@ -1947,20 +1947,21 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
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

We add error code, good.

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

And we add the error code.  But are the callers ready to use it?

...
                } else {
                    field->info->put(f, curr_elem, size, field, vmdesc_loop);
                }

No, we need to fix it on the callers also.  Yeap, that is can be fixed
in a posterios series.

Later, Juan.
