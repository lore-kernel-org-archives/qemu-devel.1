Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9630AC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E97C20704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Skif2fMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E97C20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReVl-0005tx-FG
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jReJU-00005k-9Y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jReJT-0003lv-1N
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:02:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jReJS-0003kd-Jy
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587657773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AKyRWlrirtLMF58AjjXU7oxyV10KBpwvro8qTcVZPeQ=;
 b=Skif2fMGLzzoGqE4xEfqqlMbP0zG2AiSahAyjUIOEmx4f5XfkU9FcQGJk2I6TporHm8jrm
 bT8dNNfVUEdldIEuoLgIsyzUPlzZVa7wP8/pV9xhEB3q/OEZqnTHc6DHWgZXozFJX7RUZd
 oiOc1VQw8MlRveN6ngW989Fr+E4KAUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-Fn8m_6lANueJoXggWhPYqg-1; Thu, 23 Apr 2020 12:02:49 -0400
X-MC-Unique: Fn8m_6lANueJoXggWhPYqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D7018A0762;
 Thu, 23 Apr 2020 16:02:48 +0000 (UTC)
Received: from [10.36.114.136] (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FA7919D9E;
 Thu, 23 Apr 2020 16:02:42 +0000 (UTC)
Subject: Re: [PATCH v21 QEMU 4/5] virtio-balloon: Implement support for page
 poison tracking feature
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182120.12258.67417.stgit@localhost.localdomain>
 <2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
 <CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <46fb7362-0ec7-d27d-a8bc-458e9ae0beea@redhat.com>
Date: Thu, 23 Apr 2020 18:02:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23.04.20 16:46, Alexander Duyck wrote:
> On Thu, Apr 23, 2020 at 1:11 AM David Hildenbrand <david@redhat.com> wrot=
e:
>>
>> On 22.04.20 20:21, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> We need to make certain to advertise support for page poison tracking i=
f
>>> we want to actually get data on if the guest will be poisoning pages.
>>>
>>> Add a value for tracking the poison value being used if page poisoning =
is
>>> enabled. With this we can determine if we will need to skip page report=
ing
>>> when it is enabled in the future.
>>
>> Maybe add something about the semantics
>>
>> "VIRTIO_BALLOON_F_PAGE_POISON will not change the behavior of free page
>> hinting or ordinary balloon inflation/deflation."
>>
>> I do wonder if we should just unconditionally enable
>> VIRTIO_BALLOON_F_PAGE_POISON here, gluing it to the QEMU compat machine
>> (via a property that is default-enabled, and disabled from compat machin=
es).
>>
>> Because, as Michael said, knowing that the guest is using page poisoning
>> might be interesting even if free page reporting is not around.
>=20
> I could do that. So if that is the case though would I disable page
> reporting if it isn't enabled, or would I be enabling page poison if
> page reporting is enabled?


So, I would suggest this the following as a diff to this patch (the TODO pa=
rt as a
separate patch - we will have these compat properties briefly after the 5.0
release)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c1a444cb75..2e96cba4ff 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,6 +28,12 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
=20
+// TODO: After 5.0 release
+GlobalProperty hw_compat_5_0[] =3D {
+    { "virtio-balloon-device", "page-hint", "false"},
+};
+const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
+
 GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-blk-device", "queue-size", "128"},
     { "virtio-scsi-device", "virtqueue_size", "128"},
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..5ff8a669cf 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -924,6 +924,8 @@ static Property virtio_balloon_properties[] =3D {
                      qemu_4_0_config_size, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
+    DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_PAGE_POISON, true),
     DEFINE_PROP_END_OF_LIST(),
 };


What to do with page reporting depends: I would not implicitly enable featu=
res.
I think we are talking about

-device virtio-balloon-pci,...,page-poison=3Dfalse,free-page-reporting=3Dtr=
ue

a) Valid scenario. Fix Linux guests as we discussed to not use reporting if=
 they rely on page poisoning.
b) Invalid scenario. E.g., bail out when trying to realize that device ("'f=
ree-page-reporting' requires 'page-poison'").

With new QEMU machines, this should not happen with

-device virtio-balloon-pci,...,free-page-reporting=3Dtrue

as page-poison=3Dtrue is the new default.

What's your opinion?

>=20
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>>  hw/virtio/virtio-balloon.c         |    7 +++++++
>>>  include/hw/virtio/virtio-balloon.h |    1 +
>>>  2 files changed, 8 insertions(+)
>>>
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index a1d6fb52c876..5effc8b4653b 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice =
*vdev, uint8_t *config_data)
>>>
>>>      config.num_pages =3D cpu_to_le32(dev->num_pages);
>>>      config.actual =3D cpu_to_le32(dev->actual);
>>> +    config.poison_val =3D cpu_to_le32(dev->poison_val);
>>>
>>>      if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_REQUESTED) =
{
>>>          config.free_page_hint_cmd_id =3D
>>> @@ -697,6 +698,10 @@ static void virtio_balloon_set_config(VirtIODevice=
 *vdev,
>>>          qapi_event_send_balloon_change(vm_ram_size -
>>>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PF=
N_SHIFT));
>>>      }
>>> +    dev->poison_val =3D 0;
>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>>> +        dev->poison_val =3D le32_to_cpu(config.poison_val);
>>> +    }
>>>      trace_virtio_balloon_set_config(dev->actual, oldactual);
>>>  }
>>>
>>> @@ -854,6 +859,8 @@ static void virtio_balloon_device_reset(VirtIODevic=
e *vdev)
>>>          g_free(s->stats_vq_elem);
>>>          s->stats_vq_elem =3D NULL;
>>>      }
>>> +
>>> +    s->poison_val =3D 0;
>>>  }
>>>
>>>  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t stat=
us)
>>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/vir=
tio-balloon.h
>>> index 108cff97e71a..3ca2a78e1aca 100644
>>> --- a/include/hw/virtio/virtio-balloon.h
>>> +++ b/include/hw/virtio/virtio-balloon.h
>>> @@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
>>>      uint32_t host_features;
>>>
>>>      bool qemu_4_0_config_size;
>>> +    uint32_t poison_val;
>>>  } VirtIOBalloon;
>>>
>>>  #endif
>>>
>>
>> You still have to migrate poison_val if I am not wrong, otherwise you
>> would lose it during migration if I am not mistaking.
>=20
> So what are the requirements to migrate a value? Would I need to add a
> property so it can be retrieved/set?
>=20

Something like this would do the trick:

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..ea0afec5f6 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -522,6 +522,13 @@ static bool virtio_balloon_free_page_support(void *opa=
que)
     return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
 }
=20
+static bool virtio_balloon_page_poison_support(void *opaque)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+}
+
 static void virtio_balloon_free_page_start(VirtIOBalloon *s)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
@@ -755,6 +762,17 @@ static const VMStateDescription vmstate_virtio_balloon=
_free_page_report =3D {
     }
 };
=20
+static const VMStateDescription vmstate_virtio_balloon_page_poison =3D {
+    .name =3D "vitio-balloon-device/page-poison",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D virtio_balloon_page_poison_support,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(poison_val, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_balloon_device =3D {
     .name =3D "virtio-balloon-device",
     .version_id =3D 1,
@@ -767,6 +785,7 @@ static const VMStateDescription vmstate_virtio_balloon_=
device =3D {
     },
     .subsections =3D (const VMStateDescription * []) {
         &vmstate_virtio_balloon_free_page_report,
+        &vmstate_virtio_balloon_page_poison,
         NULL
     }
 };




But I *think* the following should work as well IIRC (could be that migrati=
ng new QEMU
-> old QEMU would be an issue, I don't recall if both directions are safe):


diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..01bccf26fb 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -757,12 +757,13 @@ static const VMStateDescription vmstate_virtio_balloo=
n_free_page_report =3D {
=20
 static const VMStateDescription vmstate_virtio_balloon_device =3D {
     .name =3D "virtio-balloon-device",
-    .version_id =3D 1,
+    .version_id =3D 2,
     .minimum_version_id =3D 1,
     .post_load =3D virtio_balloon_post_load_device,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(num_pages, VirtIOBalloon),
         VMSTATE_UINT32(actual, VirtIOBalloon),
+        VMSTATE_UINT32_V(poison_val, VirtIOBalloon, 2),
         VMSTATE_END_OF_LIST()
     },
     .subsections =3D (const VMStateDescription * []) {


--=20
Thanks,

David / dhildenb


