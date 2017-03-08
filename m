Received: from eggs.gnu.org ([2001:4830:134:3::10]:42687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cleM5-00011e-P5
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cleM0-0001i2-R4
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:22:25 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <k.kozlowski.k@gmail.com>)
	id 1cleM0-0001hL-Jv
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:22:20 -0500
Received: by mail-wm0-f65.google.com with SMTP id v190so6868214wme.3
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 08:22:18 -0800 (PST)
Date: Wed, 8 Mar 2017 18:22:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170308162213.kcs3udn6ckvl7jd7@kozik-lap>
References: <20170305214633.19844-1-krzk@kernel.org>
	<20170306120948.GV2778@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170306120948.GV2778@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH] qdev: Constify data pointed by few
 arguments and local variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 06, 2017 at 09:09:48AM -0300, Eduardo Habkost wrote:
> Hi,
> 
> 
> On Sun, Mar 05, 2017 at 11:46:33PM +0200, Krzysztof Kozlowski wrote:
> > In few places the function arguments and local variables are not
> > modifying data passed through pointers so this can be made const for
> > code safeness.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> I believe most changes below are misleading to users of the API,
> and make the code less safe. Most of the pointers passed as
> argument to those functions will be stored at non-const pointer
> fields inside the objects.
> 
> > ---
> >  hw/core/qdev-properties-system.c |  6 +++---
> >  hw/core/qdev-properties.c        |  7 ++++---
> >  include/hw/qdev-properties.h     | 11 +++++++----
> >  3 files changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> > index c34be1c1bace..abbf3ef754d8 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -405,7 +405,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
> >      if (value) {
> >          ref = blk_name(value);
> >          if (!*ref) {
> > -            BlockDriverState *bs = blk_bs(value);
> > +            const BlockDriverState *bs = blk_bs(value);
> >              if (bs) {
> >                  ref = bdrv_get_node_name(bs);
> >              }
> 
> This part looks safe, but still misleading: the
> object_property_set_str() call will end up changing a non-const
> pointer field in the object. I'm not sure what's the benefit of
> this change.

I might be missing something... but I am touching only the 'bs' and it
is passed to bdrv_get_node_name() also as const. The
bdrv_get_node_name() just accepts pointer to const.

I am not sure why are you referring to object_property_set_str(). The
value returned by bdrv_get_node_name() is pointer to const.
object_property_set_str() also takes pointer to const.

So entire path, starting from 'bs' uses pointer to const... thus I
find misleading that 'bs' is not pointing to const data. It should.

> 
> > @@ -416,7 +416,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
> >  }
> >  
> >  void qdev_prop_set_chr(DeviceState *dev, const char *name,
> > -                       Chardev *value)
> > +                       const Chardev *value)
> 
> This wrapper will end up storing 'value' in a non-const pointer
> in the object (e.g. PL011State::chr). Declaring 'value' as const
> is misleading.

The object_property_set_str() takes data as pointer to const. If data
ends up as being non-const, then this is the mistake -
object_property_set_str().

> 
> 
> >  {
> >      assert(!value || value->label);
> >      object_property_set_str(OBJECT(dev),
> > @@ -424,7 +424,7 @@ void qdev_prop_set_chr(DeviceState *dev, const char *name,
> >  }
> >  
> >  void qdev_prop_set_netdev(DeviceState *dev, const char *name,
> > -                          NetClientState *value)
> > +                          const NetClientState *value)
> 
> Same case here: the wrapper will store 'value' in a non-const
> NetClientState pointer in the object.
> 
> >  {
> >      assert(!value || value->name);
> >      object_property_set_str(OBJECT(dev),
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index 6ab4265eb478..34ec10f0caac 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -1010,7 +1010,8 @@ void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value)
> >      object_property_set_str(OBJECT(dev), value, name, &error_abort);
> >  }
> >  
> > -void qdev_prop_set_macaddr(DeviceState *dev, const char *name, uint8_t *value)
> > +void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
> > +                           const uint8_t *value)
> 
> This one makes sense to me.
> 
> >  {
> >      char str[2 * 6 + 5 + 1];
> >      snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
> > @@ -1028,10 +1029,10 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
> >                              name, &error_abort);
> >  }
> >  
> > -void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value)
> > +void qdev_prop_set_ptr(DeviceState *dev, const char *name, const void *value)
> >  {
> >      Property *prop;
> > -    void **ptr;
> > +    const void **ptr;
> 
> This one is also misleading: the field pointed by
> qdev_prop_find() is normally a non-const pointer.

Understood, I'll drop it.

Best regards,
Krzysztof
