Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C137C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C89206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Lt50kDuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C89206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXdM-0005ZN-3v
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIXLh-0000Ny-2A
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIXLf-0003zh-AF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:15:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIXLf-0003zO-4u
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:15:15 -0400
Received: by mail-ot1-x341.google.com with SMTP id c10so4633339otd.9
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 05:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7oq3SsFxxyQqN8ykacVa0m46Z5w/+lN7c1KagfhHmOA=;
 b=Lt50kDuT14asHJkKS0oXuYAcviwFiofBCxugAJalTSvxH9KjAktWPeyoBBLlYQvl83
 tmXpk8UwdE6k8lKeOhowLK3fO60cPPMwIoyZPkEvyR53VHZjlv3hU3CRNHv7g/eWkB0+
 ewwiYDf13QVecSJoUoUA4y8YdY6Aiii0QYZt3adR1xnivXtkh2U2BFvpsJ55R4bZ/vO1
 HWWkjdxOiPmr2IH6ABFZTY2CxutQ4xBp1HJkwQsfXG2rVHrGn1tKBQlmc/lCNwAJ8qzR
 44wv1MkLam7ET859WmRayr+mthkGlAV/vuQPzR3lpvskUMuza1m2PpdJu2IR55jHW+U3
 Qw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7oq3SsFxxyQqN8ykacVa0m46Z5w/+lN7c1KagfhHmOA=;
 b=FtJrqY9coEw/k35xbx2uvfBAAXux+r2LW1opvl42ZZznurKY+dx8a3grH52R0xWCDv
 DrQLVzo2XCp0gJhk3DONzcpb7T3Crv14C9/k1jVhmmuxkaJDLxjnDhEwGrwr7pMO6VfU
 iA3qEhzzSg5K+8+l9N1DYib0PQV9DobQgbcTNuQqKY6vwYkMRKA1nkWmo8pdkWNgYiFR
 kyWXcpF+ZyWRc1TdSe0DDNsC5/ZFdzUK+szCYNjA6LyBplCaMGgEBI2E+qyVqggVhWbr
 HwC4GPOrA/kJfoPQRdiHDZS2M8gcALn8IeKnpJc1JuEuWvruDVXJKBvaxMfpTsqlQoDj
 Zceg==
X-Gm-Message-State: APjAAAUhyhslOPOiI2oDWwyekhCyT9mLsohfJjaAiQvAaT9zwlzsRjJD
 T6dRWMqQ+rQH9xvfplsINIpfz2Z/ByzFjZdlUP5xYw==
X-Google-Smtp-Source: APXvYqy6v1/vDy3ArYIs7Re6BOHByQ64EPXbA9ZLEcYwQE6xT2nNTU8pG03cnGYmgqnreKCuEorP5x9zL/JbqtYKUQI=
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr7618976otn.316.1570709713518; 
 Thu, 10 Oct 2019 05:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <1569932308-30478-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <1569932308-30478-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <20191002095538.GA2709@work-vm>
 <778087fb-6d91-3f63-18cb-78cab6a68f77@redhat.com>
In-Reply-To: <778087fb-6d91-3f63-18cb-78cab6a68f77@redhat.com>
From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Date: Thu, 10 Oct 2019 14:15:02 +0200
Message-ID: <CALHVEJZfNLLMSx9EVXx28L3aDh4RgfoUqjYqVqr5jcJS4fNYxQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: prevent offloads reset on migration
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

Thank you for your reply.
I've submitted the third version of the patch which does the runstate
check as you propose.

Thanks,
Mikhail

Am Do., 10. Okt. 2019 um 07:33 Uhr schrieb Jason Wang <jasowang@redhat.com>=
:
>
>
> On 2019/10/2 =E4=B8=8B=E5=8D=885:55, Dr. David Alan Gilbert wrote:
> > Copying in Stefan, Jason and Michael who know the virtio details
> >
> > Dave
> >
> > * Mikhail Sennikovsky (mikhail.sennikovskii@cloud.ionos.com) wrote:
> >> Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFF=
LOADS_SET
> >> command are not preserved on VM migration.
> >> Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_=
FEATURES)
> >> get enabled.
> >> What happens is: first the VirtIONet::curr_guest_offloads gets restore=
d and offloads
> >> are getting set correctly:
> >>
> >>   #0  qemu_set_offload (nc=3D0x555556a11400, csum=3D1, tso4=3D0, tso6=
=3D0, ecn=3D0, ufo=3D0) at net/net.c:474
> >>   #1  virtio_net_apply_guest_offloads (n=3D0x555557701ca0) at hw/net/v=
irtio-net.c:720
> >>   #2  virtio_net_post_load_device (opaque=3D0x555557701ca0, version_id=
=3D11) at hw/net/virtio-net.c:2334
> >>   #3  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577c80 <v=
mstate_virtio_net_device>, opaque=3D0x555557701ca0, version_id=3D11)
> >>       at migration/vmstate.c:168
> >>   #4  virtio_load (vdev=3D0x555557701ca0, f=3D0x5555569dc010, version_=
id=3D11) at hw/virtio/virtio.c:2197
> >>   #5  virtio_device_get (f=3D0x5555569dc010, opaque=3D0x555557701ca0, =
size=3D0, field=3D0x55555668cd00 <__compound_literal.5>) at hw/virtio/virti=
o.c:2036
> >>   #6  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577ce0 <v=
mstate_virtio_net>, opaque=3D0x555557701ca0, version_id=3D11) at migration/=
vmstate.c:143
> >>   #7  vmstate_load (f=3D0x5555569dc010, se=3D0x5555578189e0) at migrat=
ion/savevm.c:829
> >>   #8  qemu_loadvm_section_start_full (f=3D0x5555569dc010, mis=3D0x5555=
569eee20) at migration/savevm.c:2211
> >>   #9  qemu_loadvm_state_main (f=3D0x5555569dc010, mis=3D0x5555569eee20=
) at migration/savevm.c:2395
> >>   #10 qemu_loadvm_state (f=3D0x5555569dc010) at migration/savevm.c:246=
7
> >>   #11 process_incoming_migration_co (opaque=3D0x0) at migration/migrat=
ion.c:449
> >>
> >> However later on the features are getting restored, and offloads get r=
eset to
> >> everything supported by features:
> >>
> >>   #0  qemu_set_offload (nc=3D0x555556a11400, csum=3D1, tso4=3D1, tso6=
=3D1, ecn=3D0, ufo=3D0) at net/net.c:474
> >>   #1  virtio_net_apply_guest_offloads (n=3D0x555557701ca0) at hw/net/v=
irtio-net.c:720
> >>   #2  virtio_net_set_features (vdev=3D0x555557701ca0, features=3D51044=
41767) at hw/net/virtio-net.c:773
> >>   #3  virtio_set_features_nocheck (vdev=3D0x555557701ca0, val=3D510444=
1767) at hw/virtio/virtio.c:2052
> >>   #4  virtio_load (vdev=3D0x555557701ca0, f=3D0x5555569dc010, version_=
id=3D11) at hw/virtio/virtio.c:2220
> >>   #5  virtio_device_get (f=3D0x5555569dc010, opaque=3D0x555557701ca0, =
size=3D0, field=3D0x55555668cd00 <__compound_literal.5>) at hw/virtio/virti=
o.c:2036
> >>   #6  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577ce0 <v=
mstate_virtio_net>, opaque=3D0x555557701ca0, version_id=3D11) at migration/=
vmstate.c:143
> >>   #7  vmstate_load (f=3D0x5555569dc010, se=3D0x5555578189e0) at migrat=
ion/savevm.c:829
> >>   #8  qemu_loadvm_section_start_full (f=3D0x5555569dc010, mis=3D0x5555=
569eee20) at migration/savevm.c:2211
> >>   #9  qemu_loadvm_state_main (f=3D0x5555569dc010, mis=3D0x5555569eee20=
) at migration/savevm.c:2395
> >>   #10 qemu_loadvm_state (f=3D0x5555569dc010) at migration/savevm.c:246=
7
> >>   #11 process_incoming_migration_co (opaque=3D0x0) at migration/migrat=
ion.c:449
> >>
> >> This patch fixes this by adding an extra argument to the set_features =
callback,
> >> specifying whether the offloads are to be reset, and setting it to fal=
se
> >> for the migration case.
> >>
> >> Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.c=
om>
> >> ---
> >>   hw/display/virtio-gpu-base.c |  3 ++-
> >>   hw/net/virtio-net.c          |  5 +++--
> >>   hw/virtio/virtio.c           | 10 +++++-----
> >>   include/hw/virtio/virtio.h   |  2 +-
> >>   4 files changed, 11 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base=
.c
> >> index 55e0799..04d8a23 100644
> >> --- a/hw/display/virtio-gpu-base.c
> >> +++ b/hw/display/virtio-gpu-base.c
> >> @@ -193,7 +193,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, u=
int64_t features,
> >>   }
> >>
> >>   static void
> >> -virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features)
> >> +virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features,
> >> +                               bool reset_offloads)
>
>
> It's not good for e.g gpu to know anything about net.
>
> How about checking runstate and do not call apply_guest_offload() in
> virtio_net_set_features() when in the state of migration?
>
> Thanks
>
>
> >>   {
> >>       static const uint32_t virgl =3D (1 << VIRTIO_GPU_F_VIRGL);
> >>       VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(vdev);
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index b9e1cd7..5d108e5 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -743,7 +743,8 @@ static inline uint64_t virtio_net_supported_guest_=
offloads(VirtIONet *n)
> >>       return virtio_net_guest_offloads_by_features(vdev->guest_feature=
s);
> >>   }
> >>
> >> -static void virtio_net_set_features(VirtIODevice *vdev, uint64_t feat=
ures)
> >> +static void virtio_net_set_features(VirtIODevice *vdev, uint64_t feat=
ures,
> >> +                                        bool reset_offloads)
> >>   {
> >>       VirtIONet *n =3D VIRTIO_NET(vdev);
> >>       int i;
> >> @@ -767,7 +768,7 @@ static void virtio_net_set_features(VirtIODevice *=
vdev, uint64_t features)
> >>       n->rsc6_enabled =3D virtio_has_feature(features, VIRTIO_NET_F_RS=
C_EXT) &&
> >>           virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
> >>
> >> -    if (n->has_vnet_hdr) {
> >> +    if (reset_offloads && n->has_vnet_hdr) {
> >>           n->curr_guest_offloads =3D
> >>               virtio_net_guest_offloads_by_features(features);
> >>           virtio_net_apply_guest_offloads(n);
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index a94ea18..b89f7b0 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -2042,14 +2042,14 @@ const VMStateInfo  virtio_vmstate_info =3D {
> >>       .put =3D virtio_device_put,
> >>   };
> >>
> >> -static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t v=
al)
> >> +static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t v=
al, bool reset_offloads)
> >>   {
> >>       VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> >>       bool bad =3D (val & ~(vdev->host_features)) !=3D 0;
> >>
> >>       val &=3D vdev->host_features;
> >>       if (k->set_features) {
> >> -        k->set_features(vdev, val);
> >> +        k->set_features(vdev, val, reset_offloads);
> >>       }
> >>       vdev->guest_features =3D val;
> >>       return bad ? -1 : 0;
> >> @@ -2065,7 +2065,7 @@ int virtio_set_features(VirtIODevice *vdev, uint=
64_t val)
> >>       if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
> >>           return -EINVAL;
> >>       }
> >> -    ret =3D virtio_set_features_nocheck(vdev, val);
> >> +    ret =3D virtio_set_features_nocheck(vdev, val, true);
> >>       if (!ret) {
> >>           if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) =
{
> >>               /* VIRTIO_RING_F_EVENT_IDX changes the size of the cache=
s.  */
> >> @@ -2217,14 +2217,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *=
f, int version_id)
> >>            * host_features.
> >>            */
> >>           uint64_t features64 =3D vdev->guest_features;
> >> -        if (virtio_set_features_nocheck(vdev, features64) < 0) {
> >> +        if (virtio_set_features_nocheck(vdev, features64, false) < 0)=
 {
> >>               error_report("Features 0x%" PRIx64 " unsupported. "
> >>                            "Allowed features: 0x%" PRIx64,
> >>                            features64, vdev->host_features);
> >>               return -1;
> >>           }
> >>       } else {
> >> -        if (virtio_set_features_nocheck(vdev, features) < 0) {
> >> +        if (virtio_set_features_nocheck(vdev, features, false) < 0) {
> >>               error_report("Features 0x%x unsupported. "
> >>                            "Allowed features: 0x%" PRIx64,
> >>                            features, vdev->host_features);
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index b189788..fd8cac5 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -128,7 +128,7 @@ typedef struct VirtioDeviceClass {
> >>                                uint64_t requested_features,
> >>                                Error **errp);
> >>       uint64_t (*bad_features)(VirtIODevice *vdev);
> >> -    void (*set_features)(VirtIODevice *vdev, uint64_t val);
> >> +    void (*set_features)(VirtIODevice *vdev, uint64_t val, bool reset=
_offloads);
> >>       int (*validate_features)(VirtIODevice *vdev);
> >>       void (*get_config)(VirtIODevice *vdev, uint8_t *config);
> >>       void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
> >> --
> >> 2.7.4
> >>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

