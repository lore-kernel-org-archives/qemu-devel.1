Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D877C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1C92133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXwCCJFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1C92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgFY-00026L-Kj
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iFgE8-0000gW-1l
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iFgE5-00031f-M0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:07:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iFgE5-000316-E8
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:07:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id n14so20055865wrw.9
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ia0M6u7DdX+N08E03rqv/IxpSOQjyo7R70z8Iw6B/+4=;
 b=tXwCCJFC/9GP3x9BhxFqNZbGH+1tsr6/gwrHfr0zyrA/mUi4LesmAqEUSRBDK9LbG8
 vF0kLM9yk5R+2CQ5BEeoIy7gWqKrEAAyqWArxWHJ0U18BDYpWBp/rMK6SMccS4eSXZEJ
 cRMfbQ1IQAT2UQFG6CEUKCMkPPYc4C5/qx9TjGWW2NNJ2j/iNHo6uDxaUytoxwFW4Wur
 Jk1hfEq4PR70jBEjUA1alFYKAw6ch9+4qgjXqMQR/sGD8sDvEflkpIypWoN1l4h+hvs+
 Or7rUkBcbS/o2T2fyyt3zblkBbYrtMMml2myDgzwnVluGIH6XdWUztzcGBu3kwMNsV95
 +yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ia0M6u7DdX+N08E03rqv/IxpSOQjyo7R70z8Iw6B/+4=;
 b=lI2mxfBxiscabD+aPo6L4Bjbo/Nd8oJcGdTRUFzvMcpL7lBvSDPC5g/Uzl25rZxtEB
 gCGpAFuw1zpbt+0YGMN0VtSe5/Lv4KSBZJFsQkMBMZKgj9J/MiEUcqWglDlI04lfusRP
 llRq9QkTTGjEhUAWefp0j7PLpbdPPFr5wDTSHIoW6ZlTQdAfOyLgFNSyoxJf1oOO5T9g
 wZhS4yAdn8Z7tJrK2bBakpIPX0sqU+mAzY7n4PFJ9TtbLtuJ4lY/S/vOzW63m014nG6a
 Cl0eMoitOdtg1tcko9RS1qs8y/hEbOnkY8zrhs6LKtvIgvSc6T+t21/SywsS50Zor4FA
 Nysg==
X-Gm-Message-State: APjAAAXGf/4GwlHH6I5v3chitQG2W9Lu4HyJHnMySjhcW/4oC6amiR3n
 CTCpP7IgtnQcwHwK8QesiPN9lgb3MQDIZYYvRX2GWaMhUjI=
X-Google-Smtp-Source: APXvYqzPAmN0WeH+LAvIiG+MSbwb6iGcyqXUWKqS3YHtrM1ACBmoqPzEHCQ9uqv3LlWrbMRLIjg9z+VCiITxg7Zu+EY=
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr3056180wrm.396.1570028855728; 
 Wed, 02 Oct 2019 08:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190930105135.27244-1-dgilbert@redhat.com>
 <20190930105135.27244-3-dgilbert@redhat.com>
 <CAJ+F1CJ0KoFay_yddvQRZ73VNECyjzdWL8rBj9pCdWncFZhMbA@mail.gmail.com>
 <20191001172914.GE2781@work-vm>
In-Reply-To: <20191001172914.GE2781@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 2 Oct 2019 19:07:22 +0400
Message-ID: <CAJ+F1C+Xy+-42nGYfN=1A3+XhEye=Ag=ZVBbt6NfLQ2UBerQ+A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] virtio: add vhost-user-fs base device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: mszeredi@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Oct 1, 2019 at 9:29 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > Hi
> >
> > On Mon, Sep 30, 2019 at 2:52 PM Dr. David Alan Gilbert (git)
> > <dgilbert@redhat.com> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >
> > > The virtio-fs virtio device provides shared file system access using
> > > the FUSE protocol carried over virtio.
> > > The actual file server is implemented in an external vhost-user-fs de=
vice
> > > backend process.
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  configure                         |  13 ++
> > >  hw/virtio/Makefile.objs           |   1 +
> > >  hw/virtio/vhost-user-fs.c         | 299 ++++++++++++++++++++++++++++=
++
> > >  include/hw/virtio/vhost-user-fs.h |  45 +++++
> > >  4 files changed, 358 insertions(+)
> > >  create mode 100644 hw/virtio/vhost-user-fs.c
> > >  create mode 100644 include/hw/virtio/vhost-user-fs.h
> > >
> > > diff --git a/configure b/configure
> > > index 542f6aea3f..204cbe351e 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -381,6 +381,7 @@ vhost_crypto=3D""
> > >  vhost_scsi=3D""
> > >  vhost_vsock=3D""
> > >  vhost_user=3D""
> > > +vhost_user_fs=3D""
> > >  kvm=3D"no"
> > >  hax=3D"no"
> > >  hvf=3D"no"
> > > @@ -1293,6 +1294,10 @@ for opt do
> > >    ;;
> > >    --enable-vhost-vsock) vhost_vsock=3D"yes"
> > >    ;;
> > > +  --disable-vhost-user-fs) vhost_user_fs=3D"no"
> > > +  ;;
> > > +  --enable-vhost-user-fs) vhost_user_fs=3D"yes"
> > > +  ;;
> > >    --disable-opengl) opengl=3D"no"
> > >    ;;
> > >    --enable-opengl) opengl=3D"yes"
> > > @@ -2236,6 +2241,10 @@ test "$vhost_crypto" =3D "" && vhost_crypto=3D=
$vhost_user
> > >  if test "$vhost_crypto" =3D "yes" && test "$vhost_user" =3D "no"; th=
en
> > >    error_exit "--enable-vhost-crypto requires --enable-vhost-user"
> > >  fi
> > > +test "$vhost_user_fs" =3D "" && vhost_user_fs=3D$vhost_user
> > > +if test "$vhost_user_fs" =3D "yes" && test "$vhost_user" =3D "no"; t=
hen
> > > +  error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
> > > +fi
> > >
> > >  # OR the vhost-kernel and vhost-user values for simplicity
> > >  if test "$vhost_net" =3D ""; then
> > > @@ -6377,6 +6386,7 @@ echo "vhost-crypto support $vhost_crypto"
> > >  echo "vhost-scsi support $vhost_scsi"
> > >  echo "vhost-vsock support $vhost_vsock"
> > >  echo "vhost-user support $vhost_user"
> > > +echo "vhost-user-fs support $vhost_user_fs"
> > >  echo "Trace backends    $trace_backends"
> > >  if have_backend "simple"; then
> > >  echo "Trace output file $trace_file-<pid>"
> > > @@ -6873,6 +6883,9 @@ fi
> > >  if test "$vhost_user" =3D "yes" ; then
> > >    echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
> > >  fi
> > > +if test "$vhost_user_fs" =3D "yes" ; then
> > > +  echo "CONFIG_VHOST_USER_FS=3Dy" >> $config_host_mak
> > > +fi
> > >  if test "$blobs" =3D "yes" ; then
> > >    echo "INSTALL_BLOBS=3Dyes" >> $config_host_mak
> > >  fi
> > > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > > index 964ce78607..47ffbf22c4 100644
> > > --- a/hw/virtio/Makefile.objs
> > > +++ b/hw/virtio/Makefile.objs
> > > @@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
> > >  common-obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio-mmio.o
> > >  obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon.o
> > >  obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-crypto.o
> > > +obj-$(CONFIG_VHOST_USER_FS) +=3D vhost-user-fs.o
> > >  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=3D v=
irtio-crypto-pci.o
> > >  obj-$(CONFIG_VIRTIO_PMEM) +=3D virtio-pmem.o
> > >  common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) +=
=3D virtio-pmem-pci.o
> > > diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> > > new file mode 100644
> > > index 0000000000..f0df7f4746
> > > --- /dev/null
> > > +++ b/hw/virtio/vhost-user-fs.c
> > > @@ -0,0 +1,299 @@
> > > +/*
> > > + * Vhost-user filesystem virtio device
> > > + *
> > > + * Copyright 2018-2019 Red Hat, Inc.
> > > + *
> > > + * Authors:
> > > + *  Stefan Hajnoczi <stefanha@redhat.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r
> > > + * (at your option) any later version.  See the COPYING file in the
> > > + * top-level directory.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include <sys/ioctl.h>
> > > +#include "standard-headers/linux/virtio_fs.h"
> > > +#include "qapi/error.h"
> > > +#include "hw/qdev-properties.h"
> > > +#include "hw/virtio/virtio-bus.h"
> > > +#include "hw/virtio/virtio-access.h"
> > > +#include "qemu/error-report.h"
> > > +#include "hw/virtio/vhost-user-fs.h"
> > > +#include "monitor/monitor.h"
> > > +
> > > +static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
> > > +{
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > > +    struct virtio_fs_config fscfg =3D {};
> > > +
> > > +    memcpy((char *)fscfg.tag, fs->conf.tag,
> > > +           MIN(strlen(fs->conf.tag) + 1, sizeof(fscfg.tag)));
> > > +
> > > +    virtio_stl_p(vdev, &fscfg.num_request_queues, fs->conf.num_reque=
st_queues);
> > > +
> > > +    memcpy(config, &fscfg, sizeof(fscfg));
> > > +}
> > > +
> > > +static void vuf_start(VirtIODevice *vdev)
> > > +{
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > > +    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> > > +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > > +    int ret;
> > > +    int i;
> > > +
> > > +    if (!k->set_guest_notifiers) {
> > > +        error_report("binding does not support guest notifiers");
> > > +        return;
> > > +    }
> > > +
> > > +    ret =3D vhost_dev_enable_notifiers(&fs->vhost_dev, vdev);
> > > +    if (ret < 0) {
> > > +        error_report("Error enabling host notifiers: %d", -ret);
> > > +        return;
> > > +    }
> > > +
> > > +    ret =3D k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs,=
 true);
> > > +    if (ret < 0) {
> > > +        error_report("Error binding guest notifier: %d", -ret);
> > > +        goto err_host_notifiers;
> > > +    }
> > > +
> > > +    fs->vhost_dev.acked_features =3D vdev->guest_features;
> > > +    ret =3D vhost_dev_start(&fs->vhost_dev, vdev);
> > > +    if (ret < 0) {
> > > +        error_report("Error starting vhost: %d", -ret);
> > > +        goto err_guest_notifiers;
> > > +    }
> > > +
> > > +    /*
> > > +     * guest_notifier_mask/pending not used yet, so just unmask
> > > +     * everything here.  virtio-pci will do the right thing by
> > > +     * enabling/disabling irqfd.
> > > +     */
> > > +    for (i =3D 0; i < fs->vhost_dev.nvqs; i++) {
> > > +        vhost_virtqueue_mask(&fs->vhost_dev, vdev, i, false);
> > > +    }
> > > +
> > > +    return;
> > > +
> > > +err_guest_notifiers:
> > > +    k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
> > > +err_host_notifiers:
> > > +    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
> > > +}
> > > +
> > > +static void vuf_stop(VirtIODevice *vdev)
> > > +{
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > > +    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> > > +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > > +    int ret;
> > > +
> > > +    if (!k->set_guest_notifiers) {
> > > +        return;
> > > +    }
> > > +
> > > +    vhost_dev_stop(&fs->vhost_dev, vdev);
> > > +
> > > +    ret =3D k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs,=
 false);
> > > +    if (ret < 0) {
> > > +        error_report("vhost guest notifier cleanup failed: %d", ret)=
;
> > > +        return;
> > > +    }
> > > +
> > > +    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
> > > +}
> > > +
> > > +static void vuf_set_status(VirtIODevice *vdev, uint8_t status)
> > > +{
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > > +    bool should_start =3D status & VIRTIO_CONFIG_S_DRIVER_OK;
> > > +
> > > +    if (!vdev->vm_running) {
> > > +        should_start =3D false;
> > > +    }
> > > +
> > > +    if (fs->vhost_dev.started =3D=3D should_start) {
> > > +        return;
> > > +    }
> > > +
> > > +    if (should_start) {
> > > +        vuf_start(vdev);
> > > +    } else {
> > > +        vuf_stop(vdev);
> > > +    }
> > > +}
> >
> > It looks like you could have benefited from backends/vhost-user.c
> >
> > This would allow to factor out some common code and properties used by
> > vhost-user devices (currently gpu & input, but more could be
> > converted).
> >
> > Advantage is that if we add a new mechanism, say to start helpers
> > (like I propose earlier), all devices using that could benefit it more
> > easily (in theory).
>
> It looks like that came along after we originally wrote this;
> is that something I can retrofit sometime later then without
> breaking anything?

I think so, this can be done later.

>
> Dave
>
> > > +
> > > +static uint64_t vuf_get_features(VirtIODevice *vdev,
> > > +                                      uint64_t requested_features,
> > > +                                      Error **errp)
> > > +{
> > > +    /* No feature bits used yet */
> > > +    return requested_features;
> > > +}
> > > +
> > > +static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> > > +{
> > > +    /*
> > > +     * Not normally called; it's the daemon that handles the queue;
> > > +     * however virtio's cleanup path can call this.
> > > +     */
> > > +}
> > > +
> > > +static void vuf_guest_notifier_mask(VirtIODevice *vdev, int idx,
> > > +                                            bool mask)
> > > +{
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > > +
> > > +    vhost_virtqueue_mask(&fs->vhost_dev, vdev, idx, mask);
> > > +}
> > > +
> > > +static bool vuf_guest_notifier_pending(VirtIODevice *vdev, int idx)
> > > +{
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > > +
> > > +    return vhost_virtqueue_pending(&fs->vhost_dev, idx);
> > > +}
> > > +
> > > +static void vuf_device_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(dev);
> > > +    unsigned int i;
> > > +    size_t len;
> > > +    int ret;
> > > +
> > > +    if (!fs->conf.chardev.chr) {
> > > +        error_setg(errp, "missing chardev");
> > > +        return;
> > > +    }
> > > +
> > > +    if (!fs->conf.tag) {
> > > +        error_setg(errp, "missing tag property");
> > > +        return;
> > > +    }
> > > +    len =3D strlen(fs->conf.tag);
> > > +    if (len =3D=3D 0) {
> > > +        error_setg(errp, "tag property cannot be empty");
> > > +        return;
> > > +    }
> > > +    if (len > sizeof_field(struct virtio_fs_config, tag)) {
> > > +        error_setg(errp, "tag property must be %zu bytes or less",
> > > +                   sizeof_field(struct virtio_fs_config, tag));
> > > +        return;
> > > +    }
> > > +
> > > +    if (fs->conf.num_request_queues =3D=3D 0) {
> > > +        error_setg(errp, "num-request-queues property must be larger=
 than 0");
> > > +        return;
> > > +    }
> > > +
> > > +    if (!is_power_of_2(fs->conf.queue_size)) {
> > > +        error_setg(errp, "queue-size property must be a power of 2")=
;
> > > +        return;
> > > +    }
> > > +
> > > +    if (fs->conf.queue_size > VIRTQUEUE_MAX_SIZE) {
> > > +        error_setg(errp, "queue-size property must be %u or smaller"=
,
> > > +                   VIRTQUEUE_MAX_SIZE);
> > > +        return;
> > > +    }
> > > +
> > > +    if (!vhost_user_init(&fs->vhost_user, &fs->conf.chardev, errp)) =
{
> > > +        return;
> > > +    }
> > > +
> > > +    virtio_init(vdev, "vhost-user-fs", VIRTIO_ID_FS,
> > > +                sizeof(struct virtio_fs_config));
> > > +
> > > +    /* Hiprio queue */
> > > +    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> > > +
> > > +    /* Request queues */
> > > +    for (i =3D 0; i < fs->conf.num_request_queues; i++) {
> > > +        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_outpu=
t);
> > > +    }
> > > +
> > > +    /* 1 high prio queue, plus the number configured */
> > > +    fs->vhost_dev.nvqs =3D 1 + fs->conf.num_request_queues;
> > > +    fs->vhost_dev.vqs =3D g_new0(struct vhost_virtqueue, fs->vhost_d=
ev.nvqs);
> > > +    ret =3D vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
> > > +                         VHOST_BACKEND_TYPE_USER, 0);
> > > +    if (ret < 0) {
> > > +        error_setg_errno(errp, -ret, "vhost_dev_init failed");
> > > +        goto err_virtio;
> > > +    }
> > > +
> > > +    return;
> > > +
> > > +err_virtio:
> > > +    vhost_user_cleanup(&fs->vhost_user);
> > > +    virtio_cleanup(vdev);
> > > +    g_free(fs->vhost_dev.vqs);
> > > +    return;
> > > +}
> > > +
> > > +static void vuf_device_unrealize(DeviceState *dev, Error **errp)
> > > +{
> > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(dev);
> > > +
> > > +    /* This will stop vhost backend if appropriate. */
> > > +    vuf_set_status(vdev, 0);
> > > +
> > > +    vhost_dev_cleanup(&fs->vhost_dev);
> > > +
> > > +    vhost_user_cleanup(&fs->vhost_user);
> > > +
> > > +    virtio_cleanup(vdev);
> > > +    g_free(fs->vhost_dev.vqs);
> > > +    fs->vhost_dev.vqs =3D NULL;
> > > +}
> > > +
> > > +static const VMStateDescription vuf_vmstate =3D {
> > > +    .name =3D "vhost-user-fs",
> > > +    .unmigratable =3D 1,
> > > +};
> > > +
> > > +static Property vuf_properties[] =3D {
> > > +    DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
> > > +    DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
> > > +    DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
> > > +                       conf.num_request_queues, 1),
> > > +    DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 1=
28),
> > > +    DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void vuf_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> > > +
> > > +    dc->props =3D vuf_properties;
> > > +    dc->vmsd =3D &vuf_vmstate;
> > > +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > > +    vdc->realize =3D vuf_device_realize;
> > > +    vdc->unrealize =3D vuf_device_unrealize;
> > > +    vdc->get_features =3D vuf_get_features;
> > > +    vdc->get_config =3D vuf_get_config;
> > > +    vdc->set_status =3D vuf_set_status;
> > > +    vdc->guest_notifier_mask =3D vuf_guest_notifier_mask;
> > > +    vdc->guest_notifier_pending =3D vuf_guest_notifier_pending;
> > > +}
> > > +
> > > +static const TypeInfo vuf_info =3D {
> > > +    .name =3D TYPE_VHOST_USER_FS,
> > > +    .parent =3D TYPE_VIRTIO_DEVICE,
> > > +    .instance_size =3D sizeof(VHostUserFS),
> > > +    .class_init =3D vuf_class_init,
> > > +};
> > > +
> > > +static void vuf_register_types(void)
> > > +{
> > > +    type_register_static(&vuf_info);
> > > +}
> > > +
> > > +type_init(vuf_register_types)
> > > diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vh=
ost-user-fs.h
> > > new file mode 100644
> > > index 0000000000..539885b458
> > > --- /dev/null
> > > +++ b/include/hw/virtio/vhost-user-fs.h
> > > @@ -0,0 +1,45 @@
> > > +/*
> > > + * Vhost-user filesystem virtio device
> > > + *
> > > + * Copyright 2018-2019 Red Hat, Inc.
> > > + *
> > > + * Authors:
> > > + *  Stefan Hajnoczi <stefanha@redhat.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r
> > > + * (at your option) any later version.  See the COPYING file in the
> > > + * top-level directory.
> > > + */
> > > +
> > > +#ifndef _QEMU_VHOST_USER_FS_H
> > > +#define _QEMU_VHOST_USER_FS_H
> > > +
> > > +#include "hw/virtio/virtio.h"
> > > +#include "hw/virtio/vhost.h"
> > > +#include "hw/virtio/vhost-user.h"
> > > +#include "chardev/char-fe.h"
> > > +
> > > +#define TYPE_VHOST_USER_FS "vhost-user-fs-device"
> > > +#define VHOST_USER_FS(obj) \
> > > +        OBJECT_CHECK(VHostUserFS, (obj), TYPE_VHOST_USER_FS)
> > > +
> > > +typedef struct {
> > > +    CharBackend chardev;
> > > +    char *tag;
> > > +    uint16_t num_request_queues;
> > > +    uint16_t queue_size;
> > > +    char *vhostfd;
> > > +} VHostUserFSConf;
> > > +
> > > +typedef struct {
> > > +    /*< private >*/
> > > +    VirtIODevice parent;
> > > +    VHostUserFSConf conf;
> > > +    struct vhost_virtqueue *vhost_vqs;
> > > +    struct vhost_dev vhost_dev;
> > > +    VhostUserState vhost_user;
> > > +
> > > +    /*< public >*/
> > > +} VHostUserFS;
> > > +
> > > +#endif /* _QEMU_VHOST_USER_FS_H */
> > > --
> > > 2.21.0
> > >
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



--=20
Marc-Andr=C3=A9 Lureau

