Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C1FC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AE52081E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxRzt4QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AE52081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruZY-0003EZ-Q7
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iruXd-0000hH-RM
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iruXb-0002Ps-FG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:05:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28511
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iruXb-0002Pc-Bj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579140347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ju8sALBC7a/8+LxQjUeUVX8WJegzsZ7RS9n2mNvylRE=;
 b=TxRzt4QRDAbr2qvWImIll0oPM3mlyTNe/F2gv8CF5+8ugEDF0QdoiH/2Xfqn0wyZnbr1vi
 vtRkGsjI4Bt7QOSFCQ5LnhbizOpuucZuAUpuV/G7OrftVHL2VOE1Z5TEgfiocQB6mKEIdV
 CTDR6iQwPYaq2rHTWz6Cl21FMHg3h+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-mpJsfZ9pM_Gmy387yddMSA-1; Wed, 15 Jan 2020 21:05:44 -0500
Received: by mail-wr1-f70.google.com with SMTP id u12so8671488wrt.15
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 18:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Twoj1AAB72O/56W4q6C4e/wUA7Ex0j39DYbw33DZHl0=;
 b=GajOPdIFsNZekcYO+TFeq+kUWOxJfJs/i62Ce1DmTJo6gW4qfqH8NA9P4rWe0Qmf1s
 oabbQc+arfN1r9jbykkQ/jvu7YLq7XZ1PdCzdF8wwkPL5NPl3UyBry0vABztfAWM5bv9
 Vs0nVAEYnjD+BgNwFMldZGgf08Xar0GtwN7UBaZhLGm2IbvrGdSVmjlsArX8TGx2JdKz
 nL2baQTCFkR0pPJAY6Fpp0bHI+49RREe/RitRTsa81kQRJGCCa/7ln0Q+2zFRyo/Q/Po
 tfP/oI9c3BZ6yzDrYyGf79lmqFdf9MOpjCna4DRcBtfTBlLzsY+6VL10nDASZXpEprXD
 3oGA==
X-Gm-Message-State: APjAAAV13MTfwRtuT3n4309NXkHEdgwG950lHk3+yMIUgqbBHapXka9Y
 s6cQ7z/XMWkEyp154WVP+EzcgRkn3nbG+pbhLeL6OP0qx6c0efYj9jwRFVpnpBEV4F9XWpy4NAf
 mBeKybX/flO0hDe8=
X-Received: by 2002:adf:ce87:: with SMTP id r7mr313815wrn.245.1579140343311;
 Wed, 15 Jan 2020 18:05:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlPHSEw16IFHssTBf/MRNH5mS5cEbdRhAsSwzB5O4dZc/1CCnltxYF1BJxLaPLS8zGojerOQ==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr313798wrn.245.1579140343054;
 Wed, 15 Jan 2020 18:05:43 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id c5sm2470232wmb.9.2020.01.15.18.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 18:05:42 -0800 (PST)
Subject: Re: [PATCH v7 06/11] hw/core/qdev: handle parent bus change regarding
 resettable
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-7-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8409ff44-d658-097e-0225-76231b4162b1@redhat.com>
Date: Thu, 16 Jan 2020 03:05:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115123620.250132-7-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: mpJsfZ9pM_Gmy387yddMSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 1:36 PM, Damien Hedde wrote:
> In qdev_set_parent_bus(), when changing the parent bus of a
> realized device, if the source and destination buses are not in the
> same reset state, some adaptations are required. This patch adds
> needed call to resettable_change_parent() to make sure a device reset
> state stays coherent with its parent bus.
>=20
> The addition is a no-op if:
> 1. the device being parented is not realized.
> 2. the device is realized, but both buses are not under reset.
>=20
> Case 2 means that as long as qdev_set_parent_bus() is called
> during the machine realization procedure (which is before the
> machine reset so nothing is in reset), it is a no op.
>=20
> There are 52 call sites of qdev_set_parent_bus(). All but one fall
> into the no-op case:
> + 29 trivial calls related to virtio (in hw/{s390x,display,virtio}/
>    {vhost,virtio}-xxx.c) to set a vdev(or vgpu) composing device
>    parent bus just before realizing the same vdev(vgpu).
> + hw/core/qdev.c: when creating a device in qdev_try_create()
> + hw/core/sysbus.c: when initializing a device in the sysbus
> + hw/i386/amd_iommu.c: before realizing AMDVIState/pci
> + hw/isa/piix4.c: before realizing PIIX4State/rtc
> + hw/misc/auxbus.c: when creating an AUXBus
> + hw/misc/auxbus.c: when creating an AUXBus child
> + hw/misc/macio/macio.c: when initializing a MACIOState child
> + hw/misc/macio/macio.c: before realizing NewWorldMacIOState/pmu
> + hw/misc/macio/macio.c: before realizing NewWorldMacIOState/cuda
> + hw/net/virtio-net.c: Used for migration when using the failover
>                         mechanism to migration a vfio-pci/net. It is
>                         a no-op because at this point the device is
>                         already on the bus.
> + hw/pci-host/designware.c: before realizing DesignwarePCIEHost/root
> + hw/pci-host/gpex.c: before realizing GPEXHost/root
> + hw/pci-host/prep.c: when initializaing PREPPCIState/pci_dev

typo "initializing"

> + hw/pci-host/q35.c: before realizing Q35PCIHost/mch
> + hw/pci-host/versatile.c: when initializing PCIVPBState/pci_dev
> + hw/pci-host/xilinx-pcie.c: before realizing XilinxPCIEHost/root
> + hw/s390x/event-facility.c: when creating SCLPEventFacility/
>                               TYPE_SCLP_QUIESCE
> + hw/s390x/event-facility.c: ditto with SCLPEventFacility/
>                               TYPE_SCLP_CPU_HOTPLUG
> + hw/s390x/sclp.c: Not trivial because it is called on a SLCPDevice
>    just after realizing it. Ok because at this point the destination
>    bus (sysbus) is not in reset; the realize step is before the
>    machine reset.
> + hw/sd/core.c: Not OK. Used in sdbus_reparent_card(). See below.
> + hw/ssi/ssi.c: Used to put spi slave on spi bus and connect the cs
>    line in ssi_auto_connect_slave(). Ok because this function is only
>    used in realize step in hw/ssi/aspeed_smc.ci, hw/ssi/imx_spi.c,
>    hw/ssi/mss-spi.c, hw/ssi/xilinx_spi.c and hw/ssi/xilinx_spips.c.
> + hw/xen/xen-legacy-backend.c: when creating a XenLegacyDevice device
> + qdev-monitor.c: in device hotplug creation procedure before realize
>=20
> Note that this commit alone will have no effect, right now there is no
> use of resettable API to reset anything. So a bus will never be tagged
> as in-reset by this same API.
>=20
> The one place where side-effect will occurs is in hw/sd/core.c in
> sdbus_reparent_card(). This function is only used in the raspi machines,
> including during the sysbus reset procedure. This case will be
> carrefully handled when doing the multiple phase reset transition.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>=20
> v6 update: there are now 3 more call sites (52 instead of 49).
> + hw/isa/piix4.c
> + hw/net/virtio-net.c
> + hw/virtio/vhost-user-fs-pci.c (in list below)
>=20
> Exhaustive list of the 29 "virtio" caller to qdev_set_parent_bus():
> + hw/display/virtio-gpu-pci.c:     VirtIOGPUPCIBase/vgpu realize
> + hw/display/virtio-vga.c:         VirtIOVGABase/vgpu realize
> + hw/s390x/vhost-vsock-ccw.c:      VHostVSockCCWState/vdev realize
> + hw/s390x/virtio-ccw-9p.c:        V9fsCCWState/vdev realize
> + hw/s390x/virtio-ccw-balloon.c:   VirtIOBalloonCcw/vdev realize
> + hw/s390x/virtio-ccw-blk.c:       VirtIOBlkCcw/vdev realize
> + hw/s390x/virtio-ccw-crypto.c:    VirtIOCryptoCcw/vdev realize
> + hw/s390x/virtio-ccw-gpu.c:       VirtIOGPUCcw/vdev realize
> + hw/s390x/virtio-ccw-input.c:     VirtIOInputCcw/vdev realize
> + hw/s390x/virtio-ccw-net.c:       VirtIONetCcw/vdev realize
> + hw/s390x/virtio-ccw-rng.c:       VirtIORNGCcw/vdev realize
> + hw/s390x/virtio-ccw-scsi.c:      VirtIOSCSICcw/vdev realize
> + hw/s390x/virtio-ccw-scsi.c:      VHostSCSICcw/vdev realize
> + hw/s390x/virtio-ccw-serial.c:    VirtioSerialCcw/vdev realize
> + hw/virtio/vhost-scsi-pci.c:      VHostSCSIPCI/vdev realize
> + hw/virtio/vhost-user-blk-pci.c:  VHostUserBlkPCI/vdev realize
> + hw/virtio/vhost-user-fs-pci.c:   VHostUserFSPCI/vdev realize
> + hw/virtio/vhost-user-scsi-pci.c: VHostUserSCSIPCI/vdev realize
> + hw/virtio/vhost-vsock-pci.c:     VHostVSockPCI/vdev realize
> + hw/virtio/virtio-9p-pci.c:       V9fsPCIState/vdev realize
> + hw/virtio/virtio-balloon-pci.c:  VirtIOBalloonPCI/vdev realize
> + hw/virtio/virtio-blk-pci.c:      VirtIOBlkPCI/vdev realize
> + hw/virtio/virtio-crypto-pci.c:   VirtIOCryptoPCI/vdev realize
> + hw/virtio/virtio-input-pci.c:    VirtIOInputPCI/vdev realize
> + hw/virtio/virtio-net-pci.c:      VirtIONetPCI/vdev realize
> + hw/virtio/virtio-pmem-pci.c:     VirtIOPMEMPCI/vdev realize
> + hw/virtio/virtio-rng-pci.c:      VirtIORngPCI/vdev realize
> + hw/virtio/virtio-scsi-pci.c:     VirtIOSCSIPCI/vdev realize
> + hw/virtio/virtio-serial-pci.c:   VirtIOSerialPCI/vdev realize
> ---
>   hw/core/qdev.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index d431a020fc..310b87e25a 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -96,25 +96,31 @@ static void bus_add_child(BusState *bus, DeviceState =
*child)
>  =20
>   void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
>   {
> -    bool replugging =3D dev->parent_bus !=3D NULL;
> +    BusState *old_parent_bus =3D dev->parent_bus;
>  =20
> -    if (replugging) {
> +    if (old_parent_bus) {
>           trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(de=
v)),
> -            dev->parent_bus, object_get_typename(OBJECT(dev->parent_bus)=
),
> +            old_parent_bus, object_get_typename(OBJECT(old_parent_bus)),
>               OBJECT(bus), object_get_typename(OBJECT(bus)));
>           /*
>            * Keep a reference to the device while it's not plugged into
>            * any bus, to avoid it potentially evaporating when it is
>            * dereffed in bus_remove_child().
> +         * Also keep the ref of the parent bus until the end, so that
> +         * we can safely call resettable_change_parent() below.
>            */
>           object_ref(OBJECT(dev));
>           bus_remove_child(dev->parent_bus, dev);
> -        object_unref(OBJECT(dev->parent_bus));
>       }
>       dev->parent_bus =3D bus;
>       object_ref(OBJECT(bus));
>       bus_add_child(bus, dev);
> -    if (replugging) {
> +    if (dev->realized) {
> +        resettable_change_parent(OBJECT(dev), OBJECT(bus),
> +                                 OBJECT(old_parent_bus));
> +    }
> +    if (old_parent_bus) {
> +        object_unref(OBJECT(old_parent_bus));
>           object_unref(OBJECT(dev));
>       }
>   }
>=20


