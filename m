Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E022FC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A998420708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oy1g188E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A998420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY482-0008TX-Lt
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 04:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jY47C-00081k-Un
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:48:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jY47A-0002JD-VM
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589186923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGA8/gv/uBm4mCZHjhRaJppFMpXRPShx9RI73BaqgQA=;
 b=Oy1g188EhXYGBtfJc+SF2kaKPsTn2zLFkeJxYcpDBfFoWY0xNevBNw90ed8KHsUEC64/vG
 2tSqSkUUWE8vfnac9SMIYDfkAsWERTVT62bZ3siwqyoyJC1kHS61o2+J2r/S+Kin6Cxii5
 ik4s6CEctSx6mQA3AK19K9ihQ/MNMm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-RTzdh-KFPTeU6WABM8QLbQ-1; Mon, 11 May 2020 04:48:41 -0400
X-MC-Unique: RTzdh-KFPTeU6WABM8QLbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED437108BD12;
 Mon, 11 May 2020 08:48:40 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EA3A196AE;
 Mon, 11 May 2020 08:48:36 +0000 (UTC)
Message-ID: <0f7698095cde89c6cb2f73e389340132f529ee5a.camel@redhat.com>
Subject: Re: [PATCH 2/4] device-core: use RCU for list of childs of a bus
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 May 2020 11:48:35 +0300
In-Reply-To: <20200504104111.GB354891@stefanha-x1.localdomain>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200416203624.32366-3-mlevitsk@redhat.com>
 <20200504104111.GB354891@stefanha-x1.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-05-04 at 11:41 +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 16, 2020 at 11:36:22PM +0300, Maxim Levitsky wrote:
> > @@ -90,9 +92,13 @@ static void bus_reset_child_foreach(Object *obj, ResettableChildCallback cb,
> >      BusState *bus = BUS(obj);
> >      BusChild *kid;
> >  
> > -    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> > +    rcu_read_lock();
> > +
> > +    QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
> >          cb(OBJECT(kid->child), opaque, type);
> >      }
> > +
> > +    rcu_read_unlock();
> >  }
> >  
> >  static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
> > @@ -138,10 +144,15 @@ static void bus_unparent(Object *obj)
> >      /* Only the main system bus has no parent, and that bus is never freed */
> >      assert(bus->parent);
> >  
> > -    while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
> > +    rcu_read_lock();
> > +
> > +    while ((kid = QTAILQ_FIRST_RCU(&bus->children)) != NULL) {
> >          DeviceState *dev = kid->child;
> >          object_unparent(OBJECT(dev));
> >      }
> > +
> > +    rcu_read_unlock();
> 
> rcu_read_lock() is called but this looks like a list write operation.
> If I understand correctly bus->children list writes can only be called
> with the QEMU global mutex and therefore rcu_read_lock() is not required
> here?

This is indeed write operation. Paulo helped me to finally understand
what RCU guarantees are, so now I understand.

About write locking here (which I also understand now that I need for RCU),
this is very good question if that can race as well:

It looks like qdev_unplug is what does the device removal, and it first
calls the hotplug handler which is supposed to unrealize the device,
in addition to whatever hot unplug actions are needed (like informing the guest),
and then it does object_unparent which removes the device from the bus.
Therefore as long as the .realized store is atomic and with proper barriers,
the scsi IO thread might be able to see the device but it will be unplugged by then.


There are plenty of object_unparent calls through the code base and I can only hope
that these are done with big qemu lock held.


> 
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 85f062def7..f0c87e582e 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -50,26 +50,37 @@ const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
> >      return dc->vmsd;
> >  }
> >  
> > +static void bus_free_bus_child(BusChild *kid)
> > +{
> > +    object_unref(OBJECT(kid->child));
> 
> Users like scsi_device_find() do not take a refcount on the child.  If
> the device is removed then bus_free_bus_child may call object_unref()
> while another thread is still accessing the child.

I agree, however this is existing bug - bus_remove_child was dropping this
reference immediatly and I delayed it to RCU callback it now sets.
So I didn't made the situation worse.


> 
> Maybe I'm missing something that prevents this scenario?
> 
> If not, then another patch is necessary first that introduces stricter
> refcount discipline across the codebase. This applies both to users who
> directly access bus->children as well as to those who call walk() and
> stash child pointers in their callback function.

In scsi_device_find, as long as RCU read lock is held, no RCU reclaim should happen,
thus this code shouldn't have the child disapper under it.
However once scsi_device_find returns, indeed this can happen,

so scsi_device_find should indeed take a reference to the scsi device and the caller should
drop it when not needed. That should be done in a separate patch, and it
might open yet another can of worms.
While at it, it should be renamed scsi_device_get()
Maybe keep both scsi_device_find and scsi_device_get(), and let the legacy drivers
continue using the former one, while make virtio-scsi use the later? 


> 
> > +    g_free(kid);
> > +}
> > +
> >  static void bus_remove_child(BusState *bus, DeviceState *child)
> >  {
> >      BusChild *kid;
> >  
> > -    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> > +    rcu_read_lock();
> 
> List write under rcu_read_lock().
I removed the RCU read lock here, under assumption that
bus_remove_child will be called with BQL held.
I kept the _RCU version of the list removal, under assumption that
writer still needs it to avoid race vs readers.


> 
> > @@ -82,7 +93,9 @@ static void bus_add_child(BusState *bus, DeviceState *child)
> >      kid->child = child;
> >      object_ref(OBJECT(kid->child));
> >  
> > -    QTAILQ_INSERT_HEAD(&bus->children, kid, sibling);
> > +    rcu_read_lock();
> > +    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
> > +    rcu_read_unlock();
> 
> List write under rcu_read_lock().
Same as above.

> 
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index 472bbd233b..b0f4a35f81 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -367,12 +367,16 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
> >      case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET:
> >          target = req->req.tmf.lun[1];
> >          s->resetting++;
> > -        QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
> > +
> > +        rcu_read_lock();
> > +        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
> 
> We need a QTAILQ_FOREACH_WITH_RCU_READ_LOCK() macro that combines
> WITH_RCU_READ_LOCK() and QTAILQ_FOREACH_RCU(). :-)
Assuming that you are not joking here, I'll add this in the new version of the patches.

> 
> > diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
> > index 38c9399cd4..58733f28e2 100644
> > --- a/include/hw/virtio/virtio-bus.h
> > +++ b/include/hw/virtio/virtio-bus.h
> > @@ -128,8 +128,11 @@ void virtio_bus_set_vdev_config(VirtioBusState *bus, uint8_t *config);
> >  static inline VirtIODevice *virtio_bus_get_device(VirtioBusState *bus)
> >  {
> >      BusState *qbus = &bus->parent_obj;
> > -    BusChild *kid = QTAILQ_FIRST(&qbus->children);
> > -    DeviceState *qdev = kid ? kid->child : NULL;
> > +    BusChild *kid;
> > +    DeviceState *qdev;
> > +
> > +    kid = QTAILQ_FIRST(&qbus->children);
> 
> QTAILQ_FIRST_RCU()

This is on purpose - I didn't convert to RCU most of the drivers
which don't have this race versus iothread after a discussion with Paulo,
and this is one of them. Virtio bus has only one device
and it is added right away on initialization and vise-versa of the parent
(aka virtio-pci/virtio-mmio) bus device.

I will revert the other cosmetic changes in this function which I did when
I wasn't sure if to use _RCU version here.

Best regards,
	Maxim Levitsky







