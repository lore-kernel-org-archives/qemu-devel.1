Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0118BC10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25E720674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrFoFj83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25E720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDbe-0003aB-0u
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBDas-00034k-A2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBDaq-0004sp-N7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:16:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBDaq-0004sS-Hn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583741815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59jDVvG/Nho+g7lZARJyWGJk0iHAlFZ8ugTprTRey1k=;
 b=YrFoFj83FUPdNWIl9YnV3FK3tEMToD9XlP0n+GhhS0oNbgcPuj6LFn25KfLexe3oEEA7UC
 PwJbV7l2Aod6cu9Qv3dNR38+eS1tftKnUzwE0PcnNw3Ydf0qfNLBFCvjKgV4bBXx3hphud
 ion2sYAGprn/CThiFbJS3kOzcBZO+5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-1OMxcmpgOCGGLjOXoOnpLw-1; Mon, 09 Mar 2020 04:16:53 -0400
X-MC-Unique: 1OMxcmpgOCGGLjOXoOnpLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9EDE107ACC7;
 Mon,  9 Mar 2020 08:16:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F41C3271A1;
 Mon,  9 Mar 2020 08:16:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4836411386A6; Mon,  9 Mar 2020 09:16:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio-serial-bus: Plug memory leak on realize() error
 paths
References: <20200309021738.30072-1-pannengyuan@huawei.com>
 <20200309030140-mutt-send-email-mst@kernel.org>
Date: Mon, 09 Mar 2020 09:16:45 +0100
In-Reply-To: <20200309030140-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Mon, 9 Mar 2020 03:02:05 -0400")
Message-ID: <87imjeaqoi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, amit@kernel.org,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, euler.robot@huawei.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Mar 09, 2020 at 10:17:38AM +0800, Pan Nengyuan wrote:
>> We neglect to free port->bh on the error paths.  Fix that.
>> Reproducer:
>>     {'execute': 'device_add', 'arguments': {'id': 'virtio_serial_pci0', =
'driver': 'virtio-serial-pci', 'bus': 'pci.0', 'addr': '0x5'}, 'id': 'yVkZc=
GgV'}
>>     {'execute': 'device_add', 'arguments': {'id': 'port1', 'driver': 'vi=
rtserialport', 'name': 'port1', 'chardev': 'channel1', 'bus': 'virtio_seria=
l_pci0.0', 'nr': 1}, 'id': '3dXdUgJA'}
>>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'vi=
rtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_seria=
l_pci0.0', 'nr': 1}, 'id': 'qLzcCkob'}
>>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'vi=
rtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_seria=
l_pci0.0', 'nr': 2}, 'id': 'qLzcCkob'}
>>=20
>> The leak stack:
>> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f04a8008ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefa=
e8)
>>     #1 0x7f04a73cf1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>>     #2 0x56273eaee484 in aio_bh_new /mnt/sdb/backup/qemu/util/async.c:12=
5
>>     #3 0x56273eafe9a8 in qemu_bh_new /mnt/sdb/backup/qemu/util/main-loop=
.c:532
>>     #4 0x56273d52e62e in virtser_port_device_realize /mnt/sdb/backup/qem=
u/hw/char/virtio-serial-bus.c:946
>>     #5 0x56273dcc5040 in device_set_realized /mnt/sdb/backup/qemu/hw/cor=
e/qdev.c:891
>>     #6 0x56273e5ebbce in property_set_bool /mnt/sdb/backup/qemu/qom/obje=
ct.c:2238
>>     #7 0x56273e5e5a9c in object_property_set /mnt/sdb/backup/qemu/qom/ob=
ject.c:1324
>>     #8 0x56273e5ef5f8 in object_property_set_qobject /mnt/sdb/backup/qem=
u/qom/qom-qobject.c:26
>>     #9 0x56273e5e5e6a in object_property_set_bool /mnt/sdb/backup/qemu/q=
om/object.c:1390
>>     #10 0x56273daa40de in qdev_device_add /mnt/sdb/backup/qemu/qdev-moni=
tor.c:680
>>     #11 0x56273daa53e9 in qmp_device_add /mnt/sdb/backup/qemu/qdev-monit=
or.c:805
>>=20
>> Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Amit Shah <amit@kernel.org>
>> ---
>> v1->v2:
>> - simply create port->bh last in virtser_port_device_realize() to fix me=
mleaks.(Suggested by Markus Armbruster)
>
>
> Markus, Amit do your Reviewed-by tags still stand?

Mine does.


