Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB466C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 00:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B71206E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 00:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCQy09a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B71206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz8FO-0006RW-V1
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 20:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jz8Eh-0005t0-Me
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 20:40:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21218
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jz8Ef-0001pn-0x
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 20:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595637619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5oRo3prR9nChCtrrpgIcxCbnN5FJRw1tUBtlnkVpI5o=;
 b=eCQy09a7h7wCY7WXntvCa7DnO5Qy9tnJU754CjpWZCZEbbEVNIYHHqDsgidZiGEuH0lljV
 5o5PELMS1KYszYr/rY/i/GVPnIYVHS5P3a80U/xhEQspg3USRebVjhswjaeOisxdL4hhAH
 0FulV1YRSPv+ZbvpRjK7zhYpQCBE2Ak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-E9qhJtNPPFySyu4dZ_MWdw-1; Fri, 24 Jul 2020 20:40:17 -0400
X-MC-Unique: E9qhJtNPPFySyu4dZ_MWdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1065F58;
 Sat, 25 Jul 2020 00:40:16 +0000 (UTC)
Received: from [10.72.12.56] (ovpn-12-56.pek2.redhat.com [10.72.12.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4597110013C4;
 Sat, 25 Jul 2020 00:40:08 +0000 (UTC)
Subject: Re: [BUG] vhost-vdpa: qemu-system-s390x crashes with second
 virtio-net-ccw device
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200724152718.4e1cbc9e.cohuck@redhat.com>
 <20200724092906-mutt-send-email-mst@kernel.org>
 <20200724165627.70c6dfd6.cohuck@redhat.com>
 <20200724111512-mutt-send-email-mst@kernel.org>
 <20200724173448.18773aec.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5a0dfa0b-5a1d-e7d2-1785-8cca6ddb9db8@redhat.com>
Date: Sat, 25 Jul 2020 08:40:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724173448.18773aec.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------8ED6C34AE94E99B62194916F"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 19:18:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------8ED6C34AE94E99B62194916F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2020/7/24 下午11:34, Cornelia Huck wrote:
> On Fri, 24 Jul 2020 11:17:57 -0400
> "Michael S. Tsirkin"<mst@redhat.com>  wrote:
>
>> On Fri, Jul 24, 2020 at 04:56:27PM +0200, Cornelia Huck wrote:
>>> On Fri, 24 Jul 2020 09:30:58 -0400
>>> "Michael S. Tsirkin"<mst@redhat.com>  wrote:
>>>    
>>>> On Fri, Jul 24, 2020 at 03:27:18PM +0200, Cornelia Huck wrote:
>>>>> When I start qemu with a second virtio-net-ccw device (i.e. adding
>>>>> -device virtio-net-ccw in addition to the autogenerated device), I get
>>>>> a segfault. gdb points to
>>>>>
>>>>> #0  0x000055d6ab52681d in virtio_net_get_config (vdev=<optimized out>,
>>>>>      config=0x55d6ad9e3f80 "RT") at /home/cohuck/git/qemu/hw/net/virtio-net.c:146
>>>>> 146	    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>>>>>
>>>>> (backtrace doesn't go further)
>>> The core was incomplete, but running under gdb directly shows that it
>>> is just a bog-standard config space access (first for that device).
>>>
>>> The cause of the crash is that nc->peer is not set... no idea how that
>>> can happen, not that familiar with that part of QEMU. (Should the code
>>> check, or is that really something that should not happen?)
>>>
>>> What I don't understand is why it is set correctly for the first,
>>> autogenerated virtio-net-ccw device, but not for the second one, and
>>> why virtio-net-pci doesn't show these problems. The only difference
>>> between -ccw and -pci that comes to my mind here is that config space
>>> accesses for ccw are done via an asynchronous operation, so timing
>>> might be different.
>> Hopefully Jason has an idea. Could you post a full command line
>> please? Do you need a working guest to trigger this? Does this trigger
>> on an x86 host?
> Yes, it does trigger with tcg-on-x86 as well. I've been using
>
> s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu qemu,zpci=on
> -m 1024 -nographic -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001
> -drive file=/path/to/image,format=qcow2,if=none,id=drive-scsi0-0-0-0
> -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1
> -device virtio-net-ccw
>
> It seems it needs the guest actually doing something with the nics; I
> cannot reproduce the crash if I use the old advent calendar moon buggy
> image and just add a virtio-net-ccw device.
>
> (I don't think it's a problem with my local build, as I see the problem
> both on my laptop and on an LPAR.)


It looks to me we forget the check the existence of peer.

Please try the attached patch to see if it works.

Thanks


--------------8ED6C34AE94E99B62194916F
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-virtio-net-check-the-existence-of-peer-before-accesi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-virtio-net-check-the-existence-of-peer-before-accesi.pa";
 filename*1="tch"

From f6959056dcc65cbdc256c4af2b1a0eaee784c15f Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 25 Jul 2020 08:13:17 +0800
Subject: [PATCH] virtio-net: check the existence of peer before accesing its
 config

We try to get config from peer unconditionally which may lead NULL
pointer dereference. Add a check before trying to access the config.

Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4895af1cbe..935b9ef5c7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -125,6 +125,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     struct virtio_net_config netcfg;
+    NetClientState *nc = qemu_get_queue(n->nic);
 
     int ret = 0;
     memset(&netcfg, 0 , sizeof(struct virtio_net_config));
@@ -142,13 +143,12 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
                  VIRTIO_NET_RSS_SUPPORTED_HASHES);
     memcpy(config, &netcfg, n->config_size);
 
-    NetClientState *nc = qemu_get_queue(n->nic);
-    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
         ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
-                             n->config_size);
-    if (ret != -1) {
-        memcpy(config, &netcfg, n->config_size);
-    }
+                                   n->config_size);
+        if (ret != -1) {
+            memcpy(config, &netcfg, n->config_size);
+        }
     }
 }
 
@@ -156,6 +156,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     struct virtio_net_config netcfg = {};
+    NetClientState *nc = qemu_get_queue(n->nic);
 
     memcpy(&netcfg, config, n->config_size);
 
@@ -166,11 +167,10 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
     }
 
-    NetClientState *nc = qemu_get_queue(n->nic);
-    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
-                               0, n->config_size,
-                        VHOST_SET_CONFIG_TYPE_MASTER);
+    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+        vhost_net_set_config(get_vhost_net(nc->peer),
+                             (uint8_t *)&netcfg, 0, n->config_size,
+                             VHOST_SET_CONFIG_TYPE_MASTER);
       }
 }
 
-- 
2.20.1


--------------8ED6C34AE94E99B62194916F--


