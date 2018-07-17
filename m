Received: from eggs.gnu.org ([2001:4830:134:3::10]:35304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTdf-00014E-Oo
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTdb-00025x-JX
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:19:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffTdb-00025S-De
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:19:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D16EA4021FC9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 17:19:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180717141905.7ead8dd7.cohuck@redhat.com> (Cornelia Huck's
	message of "Tue, 17 Jul 2018 14:19:05 +0200")
References: <20180717120414.5852-1-quintela@redhat.com>
	<20180717120414.5852-10-quintela@redhat.com>
	<20180717141905.7ead8dd7.cohuck@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 17 Jul 2018 19:19:42 +0200
Message-ID: <87o9f5ye35.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/14] check: Only test virtio-balloon when
 it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, 17 Jul 2018 14:04:09 +0200
> Juan Quintela <quintela@redhat.com> wrote:
>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  hw/virtio/virtio-pci.c | 5 ++++-
>>  tests/Makefile.include | 6 +++---
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>> 
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 3a01fe90f0..bdbc7ab78d 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -2287,7 +2287,7 @@ static const TypeInfo vhost_vsock_pci_info = {
>>  #endif
>>  
>>  /* virtio-balloon-pci */
>> -
>> +#ifdef CONFIG_VIRTIO_BALLOON
>>  static Property virtio_balloon_pci_properties[] = {
>>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
>>      DEFINE_PROP_END_OF_LIST(),
>> @@ -2341,6 +2341,7 @@ static const TypeInfo virtio_balloon_pci_info = {
>>      .instance_init = virtio_balloon_pci_instance_init,
>>      .class_init    = virtio_balloon_pci_class_init,
>>  };
>> +#endif
>>  
>>  /* virtio-serial-pci */
>>  
>> @@ -2711,7 +2712,9 @@ static void virtio_pci_register_types(void)
>>      type_register_static(&vhost_user_blk_pci_info);
>>  #endif
>>      type_register_static(&virtio_scsi_pci_info);
>> +#ifdef CONFIG_VIRTIO_BALLOON
>>      type_register_static(&virtio_balloon_pci_info);
>> +#endif
>>      type_register_static(&virtio_serial_pci_info);
>>      type_register_static(&virtio_net_pci_info);
>>  #ifdef CONFIG_VHOST_SCSI
>
> You only make virtio-balloon-pci conditional...
>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 9193945c24..bb30c56795 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -191,8 +191,8 @@ gcov-files-virtioserial-y += hw/char/virtio-console.c
>>  gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio.c
>>  check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
>>  gcov-files-virtio-y += i386-softmmu/hw/net/virtio-net.c
>> -check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
>> -gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio-balloon.c
>> +check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) +=
>> tests/virtio-balloon-test$(EXESUF)
>> +gcov-files-virtio-$(CONFIG_VIRTIO_BALLOON) +=
>> i386-softmmu/hw/virtio/virtio-balloon.c
>>  check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
>>  gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
>>  check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
>> @@ -397,7 +397,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) +=
>> tests/test-netfilter$(EXESUF)
>>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
>>  check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
>> -check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
>> +check-qtest-s390x-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
>
> ...but the test uses virtio-balloon-ccw on s390x.

I didn't compile check on s390x, you can guess.

>>  check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
>>  check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
>>  check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
>
> Same for the other virtio device types.

I put somewhere on the cover letter that usb & virtio are a mess.
Virtio devices:
- are pci in everything
- except on s390 (kind of)
- and some old arm boards (kind of)

Add test stuff there, and it is a royal mess.  I don't really know what
is the best way to test this kind of thing without complicating (still
more) the testing directory.  This is an RFC to agree about how to go
from here.  Notice that Paolo said that there is GSOC student to do
something on this area.

Thanks, Juan.
