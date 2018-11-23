Received: from eggs.gnu.org ([2001:4830:134:3::10]:34561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gQGDZ-0003kR-RU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gQG0T-0001bV-E6
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gQG0S-0001TU-DS
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:16:44 -0500
Date: Fri, 23 Nov 2018 16:16:38 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181123181638.GO18284@habkost.net>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-23-maozhongyi@cmss.chinamobile.com>
	<20181119233139.GO3807@habkost.net>
	<bb601691-a96d-8968-bb5b-0b15757285f6@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb601691-a96d-8968-bb5b-0b15757285f6@cmss.chinamobile.com>
Subject: Re: [Qemu-devel] [PATCH 22/22] core/sysbus: remove the
 SysBusDeviceClass::initpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: maozy <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com, armbru@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, alistair.francis@wdc.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Fri, Nov 23, 2018 at 11:10:40AM +0800, maozy wrote:
> Hi, Eduardo
> 
> On 11/20/18 7:31 AM, Eduardo Habkost wrote:
> > On Mon, Nov 19, 2018 at 08:08:20PM +0800, Mao Zhongyi wrote:
> > > Currently, all sysbus devices have been converted to realize(),
> > > so remove this path.
> > > 
> > > Cc: ehabkost@redhat.com
> > > Cc: thuth@redhat.com
> > > Cc: pbonzini@redhat.com
> > > Cc: armbru@redhat.com
> > > Cc: peter.maydell@linaro.org
> > > Cc: richard.henderson@linaro.org
> > > Cc: alistair.francis@wdc.com
> > > 
> > > Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> > > Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> > > ---
> > >   hw/core/sysbus.c    | 15 ---------------
> > >   include/hw/sysbus.h |  3 ---
> > >   2 files changed, 18 deletions(-)
> > > 
> > > diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> > > index 7ac36ad3e7..030ad426c1 100644
> > > --- a/hw/core/sysbus.c
> > > +++ b/hw/core/sysbus.c
> > > @@ -201,20 +201,6 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
> > >       }
> > >   }
> > > -/* TODO remove once all sysbus devices have been converted to realize */
> > > -static void sysbus_realize(DeviceState *dev, Error **errp)
> > > -{
> > > -    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
> > > -    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
> > > -
> > > -    if (!sbc->init) {
> > > -        return;
> > > -    }
> > > -    if (sbc->init(sd) < 0) {
> > > -        error_setg(errp, "Device initialization failed");
> > > -    }
> > > -}
> > 
> > Nice.  :)
> > 
> > 
> > > -
> > >   DeviceState *sysbus_create_varargs(const char *name,
> > >                                      hwaddr addr, ...)
> > >   {
> > > @@ -327,7 +313,6 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
> > >   static void sysbus_device_class_init(ObjectClass *klass, void *data)
> > >   {
> > >       DeviceClass *k = DEVICE_CLASS(klass);
> > > -    k->realize = sysbus_realize;
> > 
> > Have you ensured this won't break any subclasses that
> > saved the original realize function on a parent_realize field?
> 
> Thanks for the catch.
> 
> > Now they will have parent_realize set to NULL.
> 
> In order to void the subclasses whose parent_realize field is
> set to NULL, the k->realize function must be retained even
> though it doesn't do anything practical. Just like this:
> 
> 
> -/* TODO remove once all sysbus devices have been converted to realize*/
>  static void sysbus_realize(DeviceState *dev, Error **errp)
>  {
> -    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
> -    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
> -
> -    if (!sbc->init) {
> -        return;
> -    }
> -    if (sbc->init(sd) < 0) {
> -        error_setg(errp, "Device initialization failed");
> -    }
>  }
> 
> it doesn't look elegant, but I didn't think of a better way, if you
> can give me some hints, I really appreciate it. :)

I think this is good enough for now (as long as there's a comment
like Peter suggested).  Allowing parent_realize to be NULL would
be inconvenient to all code that uses parent_realize today.

Personally, I would love to get rid of parent_realize entirely.
We could simply provide a helper to let device subclasses call
the parent's realize function without the need to copy function
pointers around.

-- 
Eduardo
