Received: from eggs.gnu.org ([2001:4830:134:3::10]:40087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVedb-0003Pm-JC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVedY-0005Gt-8B
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:58:39 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVedY-0005Gd-3g
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:58:36 -0400
Received: by mail-vk0-f41.google.com with SMTP id r126so30399716vkg.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:58:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713134002.GB18623@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-3-lprosek@redhat.com>
	<20170713134002.GB18623@stefanha-x1.localdomain>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 15:58:34 +0200
Message-ID: <CABdb736O3U5CBQkARp5ozwR++NoOCH2rnDbuM934S1bjPCGc-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/8] virtio: enhance virtio_error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

On Thu, Jul 13, 2017 at 3:40 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Thu, Jul 13, 2017 at 01:02:31PM +0200, Ladi Prosek wrote:
>> +static const char *virtio_get_device_id(VirtIODevice *vdev)
>> +{
>> +    DeviceState *qdev = DEVICE(vdev);
>> +    while (qdev) {
>> +        /* Find the proxy object corresponding to the vdev backend */
>> +        Object *prop = object_property_get_link(OBJECT(qdev),
>> +                                                VIRTIO_PROP_BACKEND, NULL);
>> +        if (prop == OBJECT(vdev)) {
>> +            return qdev->id;
>> +        }
>> +        qdev = qdev->parent_bus->parent;
>> +    }
>> +    return NULL;
>> +}
>> +
>>  void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
>>  {
>>      va_list ap;
>>
>> +    error_report_nolf("%s (id=%s): ", vdev->name, virtio_get_device_id(vdev));
>
> virtio_get_device_id() can return NULL.  POSIX does not guarantee that
> the printf(3) family functions handle "%s", NULL safely.  glibc prints
> "(null)" but other libc implementations crash (e.g. Solaris).
>
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/fprintf.html
>
> Should the return NULL above have g_assert_not_reached()?  That would
> communicate the assumption that we never reach return NULL and it might
> silence static checkers like Coverity but I'm not sure.

virtio_get_device_id is expected to return NULL if the device has no
id assigned and I kind of liked the "(null)" output. I just failed to
realize that not all printf's will handle it. I'll definitely fix
this, thanks!
