Received: from eggs.gnu.org ([2001:4830:134:3::10]:49212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVMOK-0000iC-Iq
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVMOG-0001uW-62
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVMOF-0001tq-Tb
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:29:36 -0400
Date: Wed, 12 Jul 2017 15:29:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170712182929.GI6020@localhost.localdomain>
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-2-ehabkost@redhat.com>
	<91940c7e-3685-26e0-e8f9-e050afcd28b5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91940c7e-3685-26e0-e8f9-e050afcd28b5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>

On Wed, Jul 12, 2017 at 07:33:15PM +0200, Halil Pasic wrote:
> 
> 
> On 07/11/2017 02:43 AM, Eduardo Habkost wrote:
> > From: Greg Kurz <groug@kaod.org>
> > 
> > The current code recursively applies global properties from child up to
> > parent types. This can cause properties passed with the -global option to
> > be silently overridden by internal compat properties.
> > 
> > This is exactly what happens with virtio-*-pci drivers since commit:
> > 
> > "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour"
> > 
> > Passing -device virtio-blk-pci.disable-modern=off has no effect on 2.6
> > machine types because the internal virtio-pci.disable-modern=on compat
> > property always prevail.
> > 
> > This patch fixes the issue by reversing the logic: we now go through the
> > global property list and, for each property, we check if it is applicable
> > to the device.
> > 
> > This result in compat properties being applied first, in the order they
> > appear in the HW_COMPAT_* macros, followed by global properties, in they
> > order appear on the command line.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Message-Id: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/core/qdev-properties.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index f11d578..41cca9d 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -1148,8 +1148,7 @@ int qdev_prop_check_globals(void)
> >      return ret;
> >  }
> > 
> > -static void qdev_prop_set_globals_for_type(DeviceState *dev,
> > -                                           const char *typename)
> > +void qdev_prop_set_globals(DeviceState *dev)
> >  {
> >      GList *l;
> > 
> > @@ -1157,7 +1156,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
> >          GlobalProperty *prop = l->data;
> >          Error *err = NULL;
> > 
> > -        if (strcmp(typename, prop->driver) != 0) {
> > +        if (object_dynamic_cast(OBJECT(dev), prop->driver) == NULL) {
> >              continue;
> >          }
> >          prop->used = true;
> > @@ -1175,16 +1174,6 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
> >      }
> >  }
> > 
> > -void qdev_prop_set_globals(DeviceState *dev)
> > -{
> > -    ObjectClass *class = object_get_class(OBJECT(dev));
> > -
> > -    do {
> > -        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
> > -        class = object_class_get_parent(class);
> > -    } while (class);
> > -}
> > -
> >  /* --- 64bit unsigned int 'size' type --- */
> > 
> >  static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
> > 
> 
> Code looks good to me. Given that high profile people are happy with the
> patch I won't object on the behavior aspect which I don't understand fully.
> Thus:
> 
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> 
> Now a couple of questions for keeping  my clear conscience:
> * What did we test? Since this patch is fixing a problem it
> changes behavior. Did we test if there is something that breaks?
> 
> * The previous version seems to establish a (somewhat strange)
> precedence for the case the same device property (storage object)
> is set via multiple super-classes (e.g. set both by parent and
> parents parent). This seems to have at least been possible,
> and technically it still is I guess. Now instead of most general
> (super class) wins we have last added property wins. I assume it
> isn't a problem, because we don't have something obscure like that.
> Or am I wrong? This obviously connects to the first question.
> (By the way, most specialized wins would not have been that
> surprising given how inheritance and OO usually works. My assumption
> that nobody used this obscure mechanism is largely based on it's
> strangeness).

Note that we are not changing the behavior when the classes
themselves set different defaults.  Subclasses are still free to
override defaults set by superclasses inside QEMU code, and they
will be unaffected by this series.  What we are changing here are
the semantics of the -global command-line option when applied to
superclasses.

The main sources of global properties we have are:
* MachineClass::compat_props
* -global command-line option
* -cpu command-line option

The behavior on the compat_props case was addressed by the hack
in commit 0bcba41f "machine: Convert abstract typename on
compat_props to subclass names".  This means compat_props was
already following the order in which properties were registered.
In this case there should be no behavior change, and we have
something to test: check if the original bug[1] (where -global
was unable to override compat_props) is still fixed.

However, the behavior of -global will change if the user
specifies command-line options that contradict each other.  I
don't believe users rely on that behavior, and the old behavior
was a bug and not a feature.  In this case we can test it, but
the behavior change is intentional.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg416670.html
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg416985.html

-- 
Eduardo
