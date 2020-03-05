Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84FAC3F2CE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 03:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7034420870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 03:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7034420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9gyb-0002mB-He
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 22:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j9gxo-0002Js-0u
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 22:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j9gxm-00080e-CU
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 22:14:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3182 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j9gxl-0007gd-W6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 22:14:18 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 60E58C25FE4236341AD0;
 Thu,  5 Mar 2020 11:14:08 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 5 Mar 2020
 11:13:58 +0800
Subject: Re: [PATCH] virtio-serial-bus: do cleanup on the error path in
 realize() to avoid memleaks
To: Markus Armbruster <armbru@redhat.com>
References: <20200302040933.21789-1-pannengyuan@huawei.com>
 <874kv4o4mp.fsf@dusky.pond.sub.org>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <cfe9a09d-f39b-3e6d-22bf-db0588810714@huawei.com>
Date: Thu, 5 Mar 2020 11:13:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <874kv4o4mp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 amit@kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/4/2020 5:23 PM, Markus Armbruster wrote:
> Pan Nengyuan <pannengyuan@huawei.com> writes:
> 
>> port->bh forgot to delete on the error path, this patch add it to fix memleaks. It's easy to reproduce as follow(add a same nr port):
>>     {'execute': 'device_add', 'arguments': {'id': 'virtio_serial_pci0', 'driver': 'virtio-serial-pci', 'bus': 'pci.0', 'addr': '0x5'}, 'id': 'yVkZcGgV'}
>>     {'execute': 'device_add', 'arguments': {'id': 'port1', 'driver': 'virtserialport', 'name': 'port1', 'chardev': 'channel1', 'bus': 'virtio_serial_pci0.0', 'nr': 1}, 'id': '3dXdUgJA'}
>>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'virtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_serial_pci0.0', 'nr': 1}, 'id': 'qLzcCkob'}
>>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'virtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_serial_pci0.0', 'nr': 2}, 'id': 'qLzcCkob'}
>>
>> The leak stack:
>> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f04a8008ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
>>     #1 0x7f04a73cf1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>>     #2 0x56273eaee484 in aio_bh_new /mnt/sdb/backup/qemu/util/async.c:125
>>     #3 0x56273eafe9a8 in qemu_bh_new /mnt/sdb/backup/qemu/util/main-loop.c:532
>>     #4 0x56273d52e62e in virtser_port_device_realize /mnt/sdb/backup/qemu/hw/char/virtio-serial-bus.c:946
>>     #5 0x56273dcc5040 in device_set_realized /mnt/sdb/backup/qemu/hw/core/qdev.c:891
>>     #6 0x56273e5ebbce in property_set_bool /mnt/sdb/backup/qemu/qom/object.c:2238
>>     #7 0x56273e5e5a9c in object_property_set /mnt/sdb/backup/qemu/qom/object.c:1324
>>     #8 0x56273e5ef5f8 in object_property_set_qobject /mnt/sdb/backup/qemu/qom/qom-qobject.c:26
>>     #9 0x56273e5e5e6a in object_property_set_bool /mnt/sdb/backup/qemu/qom/object.c:1390
>>     #10 0x56273daa40de in qdev_device_add /mnt/sdb/backup/qemu/qdev-monitor.c:680
>>     #11 0x56273daa53e9 in qmp_device_add /mnt/sdb/backup/qemu/qdev-monitor.c:805
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93
> 
>> ---
>>  hw/char/virtio-serial-bus.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
>> index 941ed5aca9..563b845f71 100644
>> --- a/hw/char/virtio-serial-bus.c
>> +++ b/hw/char/virtio-serial-bus.c
>> @@ -957,13 +957,13 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
>>      if (find_port_by_id(port->vser, port->id)) {
>>          error_setg(errp, "virtio-serial-bus: A port already exists at id %u",
>>                     port->id);
>> -        return;
>> +        goto fail;
>>      }
>>  
>>      if (port->name != NULL && find_port_by_name(port->name)) {
>>          error_setg(errp, "virtio-serial-bus: A port already exists by name %s",
>>                     port->name);
>> -        return;
>> +        goto fail;
>>      }
>>  
>>      if (port->id == VIRTIO_CONSOLE_BAD_ID) {
>> @@ -974,7 +974,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
>>              if (port->id == VIRTIO_CONSOLE_BAD_ID) {
>>                  error_setg(errp, "virtio-serial-bus: Maximum port limit for "
>>                                   "this device reached");
>> -                return;
>> +                goto fail;
>>              }
>>          }
>>      }
>> @@ -983,16 +983,20 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
>>      if (port->id >= max_nr_ports) {
>>          error_setg(errp, "virtio-serial-bus: Out-of-range port id specified, "
>>                           "max. allowed: %u", max_nr_ports - 1);
>> -        return;
>> +        goto fail;
>>      }
>>  
>>      vsc->realize(dev, &err);
>>      if (err != NULL) {
>>          error_propagate(errp, err);
>> -        return;
>> +        goto fail;
>>      }
>>  
>>      port->elem = NULL;
>> +    return;
>> +
>> +fail:
>> +    qemu_bh_delete(port->bh);
>>  }
>>  
>>  static void virtser_port_device_plug(HotplugHandler *hotplug_dev,
> 
> Looks correct to me.
> 
> However, I wonder whether we could simply create port->bh later.  It's
> for use by virtio_serial_throttle_port(), called on incoming migration
> via virtio_serial_load_device(), virtio_load(), virtio_device_get().  It
> runs flush_queued_data(), which does nothing unless
> virtio_queue_ready(port->ovq).
> 
> Note that virtio_queue_ready() dereferences its argument.  It's safe
> only after virtser_port_device_plug() set port->ovq.  I'd expect that to
> be possible only while the device is realized.  If that's correct, we
> could simply create port->bh last in virtser_port_device_realize().

Yes, it looks correct. If there is no other points, I will change it.

Thanks.

> 
> .
> 

