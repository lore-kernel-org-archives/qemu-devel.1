Received: from eggs.gnu.org ([2001:4830:134:3::10]:41553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clgmO-000729-RZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clgmK-0000py-Vz
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:57:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1clgmK-0000pm-Mc
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:57:40 -0500
Date: Wed, 8 Mar 2017 15:57:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308185726.GH4694@thinpad.lan.raisama.net>
References: <20170305214633.19844-1-krzk@kernel.org>
	<20170306120948.GV2778@thinpad.lan.raisama.net>
	<20170308162213.kcs3udn6ckvl7jd7@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308162213.kcs3udn6ckvl7jd7@kozik-lap>
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
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 08, 2017 at 06:22:13PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Mar 06, 2017 at 09:09:48AM -0300, Eduardo Habkost wrote:
> > Hi,
> > 
> > 
> > On Sun, Mar 05, 2017 at 11:46:33PM +0200, Krzysztof Kozlowski wrote:
> > > In few places the function arguments and local variables are not
> > > modifying data passed through pointers so this can be made const for
> > > code safeness.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > I believe most changes below are misleading to users of the API,
> > and make the code less safe. Most of the pointers passed as
> > argument to those functions will be stored at non-const pointer
> > fields inside the objects.
> > 
> > > ---
> > >  hw/core/qdev-properties-system.c |  6 +++---
> > >  hw/core/qdev-properties.c        |  7 ++++---
> > >  include/hw/qdev-properties.h     | 11 +++++++----
> > >  3 files changed, 14 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> > > index c34be1c1bace..abbf3ef754d8 100644
> > > --- a/hw/core/qdev-properties-system.c
> > > +++ b/hw/core/qdev-properties-system.c
> > > @@ -405,7 +405,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
> > >      if (value) {
> > >          ref = blk_name(value);
> > >          if (!*ref) {
> > > -            BlockDriverState *bs = blk_bs(value);
> > > +            const BlockDriverState *bs = blk_bs(value);
> > >              if (bs) {
> > >                  ref = bdrv_get_node_name(bs);
> > >              }
> > 
> > This part looks safe, but still misleading: the
> > object_property_set_str() call will end up changing a non-const
> > pointer field in the object. I'm not sure what's the benefit of
> > this change.
> 
> I might be missing something... but I am touching only the 'bs' and it
> is passed to bdrv_get_node_name() also as const. The
> bdrv_get_node_name() just accepts pointer to const.
> 
> I am not sure why are you referring to object_property_set_str(). The
> value returned by bdrv_get_node_name() is pointer to const.
> object_property_set_str() also takes pointer to const.
> 
> So entire path, starting from 'bs' uses pointer to const... thus I
> find misleading that 'bs' is not pointing to const data. It should.

This code path is correct, yes. That's why I don't mind either
way. What I find misleading is that the object_property_set_str()
call will end up setting a pointer inside the object to 'bs', and
that pointer is not const.

> 
> > 
> > > @@ -416,7 +416,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
> > >  }
> > >  
> > >  void qdev_prop_set_chr(DeviceState *dev, const char *name,
> > > -                       Chardev *value)
> > > +                       const Chardev *value)
> > 
> > This wrapper will end up storing 'value' in a non-const pointer
> > in the object (e.g. PL011State::chr). Declaring 'value' as const
> > is misleading.
> 
> The object_property_set_str() takes data as pointer to const. If data
> ends up as being non-const, then this is the mistake -
> object_property_set_str().

I don't see the mistake. The whole purpose of:
  qdev_prop_set_chr(dev, "some-field", v)
is to end up doing this assignment internally:
  dev->some_field = v;
and on most (or all?) cases dev->some_field is not a const
pointer. The details are hidden behind the
object_property_set_str() call.

That means code must never call qdev_prop_set_chr(dev, field, v)
if 'v' is a const pointer.

-- 
Eduardo
