Received: from eggs.gnu.org ([2001:4830:134:3::10]:53304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVMgI-0007xw-45
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVMgF-0002Yg-3D
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:48:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVMgE-0002YN-QC
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:48:11 -0400
Date: Wed, 12 Jul 2017 15:48:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170712184805.GJ6020@localhost.localdomain>
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-3-ehabkost@redhat.com>
	<6c43bf15-772e-2f8c-737c-6789d8ae28f2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c43bf15-772e-2f8c-737c-6789d8ae28f2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] test-qdev-global-props: Test global
 property ordering
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

On Wed, Jul 12, 2017 at 08:06:14PM +0200, Halil Pasic wrote:
> 
> 
> On 07/11/2017 02:43 AM, Eduardo Habkost wrote:
> > Test case to detect the bug fixed by commit
> > "qdev: fix the order compat and global properties are applied".
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> Please see below nevertheless.
> 
> > ---
> >  tests/test-qdev-global-props.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
> > index 48e5b73..ef2951f 100644
> > --- a/tests/test-qdev-global-props.c
> > +++ b/tests/test-qdev-global-props.c
> > @@ -33,6 +33,8 @@
> >  #define STATIC_TYPE(obj) \
> >      OBJECT_CHECK(MyType, (obj), TYPE_STATIC_PROPS)
> > 
> > +#define TYPE_SUBCLASS "static_prop_subtype"
> > +
> >  #define PROP_DEFAULT 100
> > 
> >  typedef struct MyType {
> > @@ -63,6 +65,11 @@ static const TypeInfo static_prop_type = {
> >      .class_init = static_prop_class_init,
> >  };
> > 
> > +static const TypeInfo subclass_type = {
> > +    .name = TYPE_SUBCLASS,
> > +    .parent = TYPE_STATIC_PROPS,
> > +};
> > +
> >  /* Test simple static property setting to default value */
> >  static void test_static_prop_subprocess(void)
> >  {
> > @@ -279,12 +286,35 @@ static void test_dynamic_globalprop_nouser(void)
> >      g_test_trap_assert_stdout("");
> >  }
> > 
> > +/* Test if global props affecting subclasses are applied in the right order */
> 
> Now that I think about it this is affecting an  external and
> (end-)user facing interface. You say this is the right order.
> Based on what is this the right order? Do we need to update some
> documentation too?

-global documentation is already very poor, as you have noticed:

> 
> I've checked out the user manual. There we talk about 'driver' but
> I could not find a spot where 'driver' is explained.

Yes.  For that reason, it looks like there's nothing to be
updated on the existing (poor) documentation.  I will re-read it
to be sure.

> 
> If I would have to translate between user manual terminology and
> code terminology, I would say a driver is a not abstract class
> inheriting from device. If that's right I wonder if it should
> be allowed for a non-abstract class inheriting from device to
> inherit form another non-abstract class.

We could, but this wouldn't save us from having to decide what to
do if people are already using those non-abstract superclasses
with -global.  e.g.: "-global spapr-pci-host-bridge.FOO=BAR"
(spapr-pci-host-bridge is the parent of spapr-pci-vfio-host-bridge).

This means a new rule like this would necessarily break
command-line compatibility.  Probably not a blocker in the
spapr-pci-host-bridge case, but to me it looks like the rule
would cause more problems than it would solve.

> 
> Another question is -global with an abstract class seems to be
> accepted on the command line. Is that an undocumented feature?

Considering that we never documented that "driver" could be a
superclass, that's true: it is an undocumented feature.

However, it is a feature people are likely to be relying upon, to
configure a feature on all devices of a given type.


> 
> Sorry for expanding the front. I also trying to figure out the design
> for my own benefit.

Your comments and suggestions are very welcome, thanks!

-- 
Eduardo
