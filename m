Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85681C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 05:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5954220B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 05:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5954220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIR67-0000ek-DF
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 01:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iIR5J-0008Iz-Ub
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 01:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iIR5G-0000Lt-TJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 01:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iIR5G-0000Lh-Kp
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 01:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD540A44AD7;
 Thu, 10 Oct 2019 05:33:52 +0000 (UTC)
Received: from [10.72.12.46] (ovpn-12-46.pek2.redhat.com [10.72.12.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C87019C69;
 Thu, 10 Oct 2019 05:33:45 +0000 (UTC)
Subject: Re: [PATCH] virtio-net: prevent offloads reset on migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>,
 stefanha@redhat.com, mst@redhat.com
References: <1569932308-30478-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <1569932308-30478-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <20191002095538.GA2709@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <778087fb-6d91-3f63-18cb-78cab6a68f77@redhat.com>
Date: Thu, 10 Oct 2019 13:33:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002095538.GA2709@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 10 Oct 2019 05:33:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/10/2 =E4=B8=8B=E5=8D=885:55, Dr. David Alan Gilbert wrote:
> Copying in Stefan, Jason and Michael who know the virtio details
>
> Dave
>
> * Mikhail Sennikovsky (mikhail.sennikovskii@cloud.ionos.com) wrote:
>> Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFF=
LOADS_SET
>> command are not preserved on VM migration.
>> Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_=
FEATURES)
>> get enabled.
>> What happens is: first the VirtIONet::curr_guest_offloads gets restore=
d and offloads
>> are getting set correctly:
>>
>>   #0  qemu_set_offload (nc=3D0x555556a11400, csum=3D1, tso4=3D0, tso6=3D=
0, ecn=3D0, ufo=3D0) at net/net.c:474
>>   #1  virtio_net_apply_guest_offloads (n=3D0x555557701ca0) at hw/net/v=
irtio-net.c:720
>>   #2  virtio_net_post_load_device (opaque=3D0x555557701ca0, version_id=
=3D11) at hw/net/virtio-net.c:2334
>>   #3  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577c80 <v=
mstate_virtio_net_device>, opaque=3D0x555557701ca0, version_id=3D11)
>>       at migration/vmstate.c:168
>>   #4  virtio_load (vdev=3D0x555557701ca0, f=3D0x5555569dc010, version_=
id=3D11) at hw/virtio/virtio.c:2197
>>   #5  virtio_device_get (f=3D0x5555569dc010, opaque=3D0x555557701ca0, =
size=3D0, field=3D0x55555668cd00 <__compound_literal.5>) at hw/virtio/vir=
tio.c:2036
>>   #6  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577ce0 <v=
mstate_virtio_net>, opaque=3D0x555557701ca0, version_id=3D11) at migratio=
n/vmstate.c:143
>>   #7  vmstate_load (f=3D0x5555569dc010, se=3D0x5555578189e0) at migrat=
ion/savevm.c:829
>>   #8  qemu_loadvm_section_start_full (f=3D0x5555569dc010, mis=3D0x5555=
569eee20) at migration/savevm.c:2211
>>   #9  qemu_loadvm_state_main (f=3D0x5555569dc010, mis=3D0x5555569eee20=
) at migration/savevm.c:2395
>>   #10 qemu_loadvm_state (f=3D0x5555569dc010) at migration/savevm.c:246=
7
>>   #11 process_incoming_migration_co (opaque=3D0x0) at migration/migrat=
ion.c:449
>>
>> However later on the features are getting restored, and offloads get r=
eset to
>> everything supported by features:
>>
>>   #0  qemu_set_offload (nc=3D0x555556a11400, csum=3D1, tso4=3D1, tso6=3D=
1, ecn=3D0, ufo=3D0) at net/net.c:474
>>   #1  virtio_net_apply_guest_offloads (n=3D0x555557701ca0) at hw/net/v=
irtio-net.c:720
>>   #2  virtio_net_set_features (vdev=3D0x555557701ca0, features=3D51044=
41767) at hw/net/virtio-net.c:773
>>   #3  virtio_set_features_nocheck (vdev=3D0x555557701ca0, val=3D510444=
1767) at hw/virtio/virtio.c:2052
>>   #4  virtio_load (vdev=3D0x555557701ca0, f=3D0x5555569dc010, version_=
id=3D11) at hw/virtio/virtio.c:2220
>>   #5  virtio_device_get (f=3D0x5555569dc010, opaque=3D0x555557701ca0, =
size=3D0, field=3D0x55555668cd00 <__compound_literal.5>) at hw/virtio/vir=
tio.c:2036
>>   #6  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577ce0 <v=
mstate_virtio_net>, opaque=3D0x555557701ca0, version_id=3D11) at migratio=
n/vmstate.c:143
>>   #7  vmstate_load (f=3D0x5555569dc010, se=3D0x5555578189e0) at migrat=
ion/savevm.c:829
>>   #8  qemu_loadvm_section_start_full (f=3D0x5555569dc010, mis=3D0x5555=
569eee20) at migration/savevm.c:2211
>>   #9  qemu_loadvm_state_main (f=3D0x5555569dc010, mis=3D0x5555569eee20=
) at migration/savevm.c:2395
>>   #10 qemu_loadvm_state (f=3D0x5555569dc010) at migration/savevm.c:246=
7
>>   #11 process_incoming_migration_co (opaque=3D0x0) at migration/migrat=
ion.c:449
>>
>> This patch fixes this by adding an extra argument to the set_features =
callback,
>> specifying whether the offloads are to be reset, and setting it to fal=
se
>> for the migration case.
>>
>> Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.c=
om>
>> ---
>>   hw/display/virtio-gpu-base.c |  3 ++-
>>   hw/net/virtio-net.c          |  5 +++--
>>   hw/virtio/virtio.c           | 10 +++++-----
>>   include/hw/virtio/virtio.h   |  2 +-
>>   4 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base=
.c
>> index 55e0799..04d8a23 100644
>> --- a/hw/display/virtio-gpu-base.c
>> +++ b/hw/display/virtio-gpu-base.c
>> @@ -193,7 +193,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, u=
int64_t features,
>>   }
>>  =20
>>   static void
>> -virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features)
>> +virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features,
>> +                               bool reset_offloads)


It's not good for e.g gpu to know anything about net.

How about checking runstate and do not call apply_guest_offload() in=20
virtio_net_set_features() when in the state of migration?

Thanks


>>   {
>>       static const uint32_t virgl =3D (1 << VIRTIO_GPU_F_VIRGL);
>>       VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(vdev);
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index b9e1cd7..5d108e5 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -743,7 +743,8 @@ static inline uint64_t virtio_net_supported_guest_=
offloads(VirtIONet *n)
>>       return virtio_net_guest_offloads_by_features(vdev->guest_feature=
s);
>>   }
>>  =20
>> -static void virtio_net_set_features(VirtIODevice *vdev, uint64_t feat=
ures)
>> +static void virtio_net_set_features(VirtIODevice *vdev, uint64_t feat=
ures,
>> +                                        bool reset_offloads)
>>   {
>>       VirtIONet *n =3D VIRTIO_NET(vdev);
>>       int i;
>> @@ -767,7 +768,7 @@ static void virtio_net_set_features(VirtIODevice *=
vdev, uint64_t features)
>>       n->rsc6_enabled =3D virtio_has_feature(features, VIRTIO_NET_F_RS=
C_EXT) &&
>>           virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
>>  =20
>> -    if (n->has_vnet_hdr) {
>> +    if (reset_offloads && n->has_vnet_hdr) {
>>           n->curr_guest_offloads =3D
>>               virtio_net_guest_offloads_by_features(features);
>>           virtio_net_apply_guest_offloads(n);
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index a94ea18..b89f7b0 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2042,14 +2042,14 @@ const VMStateInfo  virtio_vmstate_info =3D {
>>       .put =3D virtio_device_put,
>>   };
>>  =20
>> -static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t v=
al)
>> +static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t v=
al, bool reset_offloads)
>>   {
>>       VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>>       bool bad =3D (val & ~(vdev->host_features)) !=3D 0;
>>  =20
>>       val &=3D vdev->host_features;
>>       if (k->set_features) {
>> -        k->set_features(vdev, val);
>> +        k->set_features(vdev, val, reset_offloads);
>>       }
>>       vdev->guest_features =3D val;
>>       return bad ? -1 : 0;
>> @@ -2065,7 +2065,7 @@ int virtio_set_features(VirtIODevice *vdev, uint=
64_t val)
>>       if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
>>           return -EINVAL;
>>       }
>> -    ret =3D virtio_set_features_nocheck(vdev, val);
>> +    ret =3D virtio_set_features_nocheck(vdev, val, true);
>>       if (!ret) {
>>           if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) =
{
>>               /* VIRTIO_RING_F_EVENT_IDX changes the size of the cache=
s.  */
>> @@ -2217,14 +2217,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *=
f, int version_id)
>>            * host_features.
>>            */
>>           uint64_t features64 =3D vdev->guest_features;
>> -        if (virtio_set_features_nocheck(vdev, features64) < 0) {
>> +        if (virtio_set_features_nocheck(vdev, features64, false) < 0)=
 {
>>               error_report("Features 0x%" PRIx64 " unsupported. "
>>                            "Allowed features: 0x%" PRIx64,
>>                            features64, vdev->host_features);
>>               return -1;
>>           }
>>       } else {
>> -        if (virtio_set_features_nocheck(vdev, features) < 0) {
>> +        if (virtio_set_features_nocheck(vdev, features, false) < 0) {
>>               error_report("Features 0x%x unsupported. "
>>                            "Allowed features: 0x%" PRIx64,
>>                            features, vdev->host_features);
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index b189788..fd8cac5 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -128,7 +128,7 @@ typedef struct VirtioDeviceClass {
>>                                uint64_t requested_features,
>>                                Error **errp);
>>       uint64_t (*bad_features)(VirtIODevice *vdev);
>> -    void (*set_features)(VirtIODevice *vdev, uint64_t val);
>> +    void (*set_features)(VirtIODevice *vdev, uint64_t val, bool reset=
_offloads);
>>       int (*validate_features)(VirtIODevice *vdev);
>>       void (*get_config)(VirtIODevice *vdev, uint8_t *config);
>>       void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>> --=20
>> 2.7.4
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

