Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E88C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A91E206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCmQ3RHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A91E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXAV-0005ZN-Hb
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNX9m-0004jf-JZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNX9k-0005hS-Dc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:08:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601453287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xlx9gaNKZKqdBu02gsJZ7Lo+Egdrif5g5DRBfymPng=;
 b=fCmQ3RHnB4SvjbBkOjoi+ZrzPKQaZJeXpkerCn0rtSSaid6l/6+tlssBxKL/2qiLaN3T5b
 JYUlI6iSy26GHM98BdjQEpHlOcFKIlk1XQg8C5G7NambNfBjpHToIKClCE5Hz9AIV9zKoh
 s66FX+dPKKttFALNsxCF1CiwT5TbPuQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-y23PYbT2P3ivw9Gn2ZmMnA-1; Wed, 30 Sep 2020 04:08:05 -0400
X-MC-Unique: y23PYbT2P3ivw9Gn2ZmMnA-1
Received: by mail-wr1-f71.google.com with SMTP id a12so306323wrg.13
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 01:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sBgwaswi8aE+MBgp+AjsZd5weyRsYZTc5zWV1b0YzgQ=;
 b=Tmtc5MxTNJNUB/xtGgX5+g7qtNNwHLjL/Eq/z1rEt4zG+J7gU3qy7a/ZbxoSnu7+CI
 +TYuWwCx35Nt7DNSsO3bB89wzuyOgX8Fc44jzNlp8hSzqO5aQ2dkIzDYpXrQUGCEeI00
 OrfOMcVDRBlg06RVKh588JoUv6KTXMXWR6omzxb8H0MHKUeis2Y0pT5vlo8+3U9lqK4A
 DeMBCUsNXKm9YuObxKfo1RbncU4S0iWnMR3Hll5pc9p+gSqs4UW1L7kc4DceynkgFeYZ
 Mcl5Evh27Vk/wX70kp2OEWyRWTHJaT9zS1YyCArPdfcTvVf3dXhD1UVQ9yXsnSmpHj3X
 7ekw==
X-Gm-Message-State: AOAM53064PNAqyekRF5chcNnss8H3Gj3PNLIPyJ/dJx6v2c4DI9j7h2Z
 OC12NKqf83htUCJZ8VfCbePnVKApk/3PHJz8jJb+CjnrAWaU/yFTO/KZT+5U7642vwKzI7RobQ5
 fhY6p2HSHNNOKgpc=
X-Received: by 2002:adf:dd88:: with SMTP id x8mr1772906wrl.54.1601453283851;
 Wed, 30 Sep 2020 01:08:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypCcKAqACmCRvBI8j/nOHTsWwRDd7JWvJAYLjoyNn2oUIjm3yyeGeWyX45efGHbIz91IcuJQ==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr1772870wrl.54.1601453283557;
 Wed, 30 Sep 2020 01:08:03 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id 63sm1703977wrc.63.2020.09.30.01.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 01:08:02 -0700 (PDT)
Date: Wed, 30 Sep 2020 04:07:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200930034807-mutt-send-email-mst@kernel.org>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <20200929020114-mutt-send-email-mst@kernel.org>
 <20200929085751.GA181609@stefanha-x1.localdomain>
 <20200929055110-mutt-send-email-mst@kernel.org>
 <20200929183824.GC191675@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200929183824.GC191675@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lulu@redhat.com, tiwei.bie@intel.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, raphael.norwitz@nutanix.com, maxime.coquelin@redhat.com,
 kraxel@redhat.com, Felipe Franciosi <felipe@nutanix.com>,
 marcandre.lureau@redhat.com, Nikos Dragazis <ndragazis@arrikto.com>,
 changpeng.liu@intel.com, Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 07:38:24PM +0100, Stefan Hajnoczi wrote:
> On Tue, Sep 29, 2020 at 06:04:34AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 29, 2020 at 09:57:51AM +0100, Stefan Hajnoczi wrote:
> > > On Tue, Sep 29, 2020 at 02:09:55AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Sep 28, 2020 at 10:25:37AM +0100, Stefan Hajnoczi wrote:
> > > > > Why extend vhost-user with vDPA?
> > > > > ================================
> > > > > Reusing VIRTIO emulation code for vhost-user backends
> > > > > -----------------------------------------------------
> > > > > It is a common misconception that a vhost device is a VIRTIO device.
> > > > > VIRTIO devices are defined in the VIRTIO specification and consist of a
> > > > > configuration space, virtqueues, and a device lifecycle that includes
> > > > > feature negotiation. A vhost device is a subset of the corresponding
> > > > > VIRTIO device. The exact subset depends on the device type, and some
> > > > > vhost devices are closer to the full functionality of their
> > > > > corresponding VIRTIO device than others. The most well-known example is
> > > > > that vhost-net devices have rx/tx virtqueues and but lack the virtio-net
> > > > > control virtqueue. Also, the configuration space and device lifecycle
> > > > > are only partially available to vhost devices.
> > > > > 
> > > > > This difference makes it impossible to use a VIRTIO device as a
> > > > > vhost-user device and vice versa. There is an impedance mismatch and
> > > > > missing functionality. That's a shame because existing VIRTIO device
> > > > > emulation code is mature and duplicating it to provide vhost-user
> > > > > backends creates additional work.
> > > > 
> > > > 
> > > > The biggest issue facing vhost-user and absent in vdpa is
> > > > backend disconnect handling. This is the reason control path
> > > > is kept under QEMU control: we do not need any logic to
> > > > restore control path data, and we can verify a new backend
> > > > is consistent with old one.
> > > 
> > > I don't think using vhost-user with vDPA changes that. The VMM still
> > > needs to emulate a virtio-pci/ccw/mmio device that the guest interfaces
> > > with. If the device backend goes offline it's possible to restore that
> > > state upon reconnection. What have I missed?
> > 
> > The need to maintain the state in a way that is robust
> > against backend disconnects and can be restored.
> 
> QEMU is only bypassed for virtqueue accesses. Everything else still
> goes through the virtio-pci emulation in QEMU (VIRTIO configuration
> space, status register). vDPA doesn't change this.
> 
> Existing vhost-user messages can be kept if they are useful (e.g.
> virtqueue state tracking). So I think the situation is no different than
> with the existing vhost-user protocol.
> 
> > > Regarding reconnection in general, it currently seems like a partially
> > > solved problem in vhost-user. There is the "Inflight I/O tracking"
> > > mechanism in the spec and some wording about reconnecting the socket,
> > > but in practice I wouldn't expect all device types, VMMs, or device
> > > backends to actually support reconnection. This is an area where a
> > > uniform solution would be very welcome too.
> > 
> > I'm not aware of big issues. What are they?
> 
> I think "Inflight I/O tracking" can only be used when request processing
> is idempotent? In other words, it can only be used when submitting the
> same request multiple times is safe.


Not inherently it just does not attempt to address this problem.


Inflight tracking only tries to address issues on the guest side,
that is, making sure the same buffer is used exactly once.

> A silly example where this recovery mechanism cannot be used is if a
> device has a persistent counter that is incremented by the request. The
> guest can't be sure that the counter will be incremented exactly once.
> 
> Another example: devices that support requests with compare-and-swap
> semantics cannot use this mechanism. During recover the compare will
> fail if the request was just completing when the backend crashed.
> 
> Do I understand the limitations of this mechanism correctly? It doesn't
> seem general and I doubt it can be applied to all existing device types.

Device with any kind of atomicity guarantees will
have to use some internal mechanism (e.g. log?) to ensure
internal consistency, that is out of scope for tracking.



> > > There was discussion about recovering state in muser. The original idea
> > > was for the muser kernel module to host state that persists across
> > > device backend restart. That way the device backend can go away
> > > temporarily and resume without guest intervention.
> > > 
> > > Then when the vfio-user discussion started the idea morphed into simply
> > > keeping a tmpfs file for each device instance (no special muser.ko
> > > support needed anymore). This allows the device backend to resume
> > > without losing state. In practice a programming framework is needed to
> > > make this easy and safe to use but it boils down to a tmpfs mmap.
> > > 
> > > > > If there was a way to reuse existing VIRTIO device emulation code it
> > > > > would be easier to move to a multi-process architecture in QEMU. Want to
> > > > > run --netdev user,id=netdev0 --device virtio-net-pci,netdev=netdev0 in a
> > > > > separate, sandboxed process? Easy, run it as a vhost-user-net device
> > > > > instead of as virtio-net.
> > > > 
> > > > Given vhost-user is using a socket, and given there's an elaborate
> > > > protocol due to need for backwards compatibility, it seems safer to
> > > > have vhost-user interface in a separate process too.
> > > 
> > > Right, with vhost-user only the virtqueue processing is done in the
> > > device backend. The VMM still has to do the virtio transport emulation
> > > (pci, ccw, mmio) and vhost-user connection lifecycle, which is complex.
> > 
> > IIUC all vfio user does is add another protocol in the VMM,
> > and move code out of VMM to backend.
> > 
> > Architecturally I don't see why it's safer.
> 
> It eliminates one layer of device emulation (virtio-pci). Fewer
> registers to emulate means a smaller attack surface.

Well it does not eliminate it as such, it moves it to the backend.
Which in a variety of setups is actually a more sensitive
place as the backend can do things like access host
storage/network which VMM can be prevented from doing.

> It's possible to take things further, maybe with the proposed ioregionfd
> mechanism, where the VMM's KVM_RUN loop no longer handles MMIO/PIO
> exits. A separate process can handle them. Maybe some platform devices
> need CPU state access though.
> 
> BTW I think the goal of removing as much emulation from the VMM as
> possible is interesting.
> 
> Did you have some other approach in mind to remove the PCI and
> virtio-pci device from the VMM?

Architecturally, I think we can have 3 processes:


VMM -- guest device emulation -- host backend


to me this looks like increasing our defence in depth strength,
as opposed to just shifting things around ...




> > Something like multi-process patches seems like a way to
> > add defence in depth by having a process in the middle,
> > outside both VMM and backend.
> 
> There is no third process in mpqemu. The VMM uses a UNIX domain socket
> to communicate directly with the device backend. There is a PCI "proxy"
> device in the VMM that does this communication when the guest accesses
> registers. The device backend has a PCI "remote" host controller that a
> PCIDevice instance is plugged into and the UNIX domain socket protocol
> commands are translated into PCIDevice operations.

Yes, but does anything prevent us from further splitting the backend
up to emulation part and host side part?


> This is exactly the same as vfio-user. The only difference is that
> vfio-user uses an existing set of commands, whereas mpqemu defines a new
> protocol that will eventually need to provide equivalent functionality.
>
> > > Going back to Marc-AndrÃ©'s point, why don't we focus on vfio-user so the
> > > entire device can be moved out of the VMM?
> > > 
> > > Stefan
> > 
> > The fact that vfio-user adds a kernel component is one issue.
> 
> vfio-user only needs a UNIX domain socket. The muser.ko kernel module
> that was discussed after last KVM Forum is not used by vfio-user.
> 
> Stefan

Sorry I will need to go and read the doc which I didn't yet, sorry
about that.

-- 
MST


