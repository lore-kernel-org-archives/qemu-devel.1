Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnRWb-0003lC-M3
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnRWY-0005iG-JG
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnRWY-0005hd-9C
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:36:54 -0400
References: <1504190408-11143-1-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <612870af-f8a4-039c-3e97-7590388b9e77@redhat.com>
Date: Thu, 31 Aug 2017 17:36:45 +0200
MIME-Version: 1.0
In-Reply-To: <1504190408-11143-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests: Enable the drive_del test also
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


>  static void test_drive_del_device_del(void)
>  {
> +    char *args;
> +
>      /* Start with a drive used by a device that unplugs instantaneously */
> -    qtest_start("-drive if=none,id=drive0,file=null-co://,format=raw"
> -                " -device virtio-scsi-pci"
> -                " -device scsi-hd,drive=drive0,id=dev0");
> +    args = g_strdup_printf("-drive if=none,id=drive0,file=null-co://,format=raw"
> +                           " -device virtio-scsi-%s"
> +                           " -device scsi-hd,drive=drive0,id=dev0",

Would look better with the spaces at the end of the previous line (so
all "-device" are aligned), but just my taste.

> +                           qvirtio_get_dev_type());
> +    qtest_start(args);
>  
>      /*
>       * Delete the drive, and then the device
> @@ -104,6 +109,7 @@ static void test_drive_del_device_del(void)
>      device_del();
>  
>      qtest_end();
> +    g_free(args);
>  }
>  
>  int main(int argc, char **argv)
> @@ -114,9 +120,10 @@ int main(int argc, char **argv)
>  
>      qtest_add_func("/drive_del/without-dev", test_drive_without_dev);
>  
> -    /* TODO I guess any arch with PCI would do */
> +    /* TODO I guess any arch with a hot-pluggable virtio bus would do */
>      if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64") ||
> -        !strcmp(arch, "ppc") || !strcmp(arch, "ppc64")) {
> +        !strcmp(arch, "ppc") || !strcmp(arch, "ppc64") ||
> +        !strcmp(arch, "s390x")) {
>          qtest_add_func("/drive_del/after_failed_device_add",
>                         test_after_failed_device_add);
>          qtest_add_func("/blockdev/drive_del_device_del",
> diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
> index 9880a69..0879a62 100644
> --- a/tests/libqos/virtio.c
> +++ b/tests/libqos/virtio.c
> @@ -339,3 +339,20 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
>      /* vq->avail->used_event */
>      writew(vq->avail + 4 + (2 * vq->size), idx);
>  }
> +
> +/*
> + * qvirtio_get_dev_type:
> + * Returns: the preferred virtio bus/device type for the current architecture.
> + */
> +const char *qvirtio_get_dev_type(void)
> +{
> +    const char *arch = qtest_get_arch();
> +
> +    if (g_str_equal(arch, "arm") || g_str_equal(arch, "aarch64")) {
> +        return "device";  /* for virtio-mmio */
> +    } else if (g_str_equal(arch, "s390x")) {
> +        return "ccw";
> +    } else {
> +        return "pci";
> +    }

You could drop the else case and do it unconditionally.

> +}
> diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
> index 8fbcd18..0a04740 100644
> --- a/tests/libqos/virtio.h
> +++ b/tests/libqos/virtio.h
> @@ -143,4 +143,7 @@ void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head);
>  bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx);
>  
>  void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
> +
> +const char *qvirtio_get_dev_type(void);
> +
>  #endif
> 


Looks good to me!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
