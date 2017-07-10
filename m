Received: from eggs.gnu.org ([2001:4830:134:3::10]:50578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dUbio-0007zh-J3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dUbil-00075l-Fx
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dUbil-000749-9e
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:39:39 -0400
Date: Mon, 10 Jul 2017 19:39:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170710193708-mutt-send-email-mst@kernel.org>
References: <20170707142138.411-1-pbutsykin@virtuozzo.com>
	<0464adf0-801b-7083-6c3c-d8dae7ddb037@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0464adf0-801b-7083-6c3c-d8dae7ddb037@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-serial: add enable_backend callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, amit@kernel.org, pbonzini@redhat.com, den@openvz.org

On Mon, Jul 10, 2017 at 04:13:54PM +0200, Laurent Vivier wrote:
> >  static void virtconsole_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
> > @@ -233,6 +253,7 @@ static void virtserialport_class_init(ObjectClass *klass, void *data)
> >      k->unrealize = virtconsole_unrealize;
> >      k->have_data = flush_buf;
> >      k->set_guest_connected = set_guest_connected;
> > +    k->enable_backend = virtconsole_enable_backend;
> 
> Why don't you register a  vm_state change handler to change the state of
> the virtconsole according to the state of the machine instead of adding
> a new function in the VirtIOSerialPortClass?
> 
> See a23a6d1 ("virtio-rng: stop virtqueue while the CPU is stopped")
> 
> Thanks,
> Laurent


In fact that commit does it the wrong way IMHO.

The order of this call wrt other virtio calls is not
guaranteed.

IMHO the right way is to set a vm state change handler in VirtioBusClass
or status change handler in VirtioDeviceClass.

-- 
MST
