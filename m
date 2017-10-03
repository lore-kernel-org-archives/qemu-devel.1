Received: from eggs.gnu.org ([2001:4830:134:3::10]:42354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzQCW-0006QQ-7P
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzQCT-0006NT-2z
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzQCS-0006MR-QV
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:37:41 -0400
Date: Tue, 3 Oct 2017 18:37:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171003183737.63cf74cf@nial.brq.redhat.com>
In-Reply-To: <20171003153722.GM17385@localhost.localdomain>
References: <20171002192404.GC17385@localhost.localdomain>
	<1507032886-199950-1-git-send-email-imammedo@redhat.com>
	<20171003142501.GI17385@localhost.localdomain>
	<20171003170139.36e23ab7@nial.brq.redhat.com>
	<20171003153722.GM17385@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qom: add helpers REGISTER_STATIC_TYPE[S]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, 3 Oct 2017 12:37:22 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Oct 03, 2017 at 05:01:39PM +0200, Igor Mammedov wrote:
> > On Tue, 3 Oct 2017 11:25:01 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Tue, Oct 03, 2017 at 02:14:46PM +0200, Igor Mammedov wrote:  
> > > > it will help to remove code duplication in places
> > > > that currently open code registration of static
> > > > type[s] and remove necessity to declare function
> > > > for type_init() to call, when only static types
> > > > need to be registered.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > > I'm going to use it for CPU types in followup patches
> > > > 
> > > > CC: ehabkost@redhat.com
> > > > ---
> > > >  include/qemu/module.h | 10 ++++++++++
> > > >  include/qom/object.h  | 10 ++++++++++
> > > >  qom/object.c          |  9 +++++++++
> > > >  3 files changed, 29 insertions(+)
> > > > 
> > > > diff --git a/include/qemu/module.h b/include/qemu/module.h
> > > > index 56dd218..60dd632 100644
> > > > --- a/include/qemu/module.h
> > > > +++ b/include/qemu/module.h
> > > > @@ -52,6 +52,16 @@ typedef enum {
> > > >  #define type_init(function) module_init(function, MODULE_INIT_QOM)
> > > >  #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
> > > >  
> > > > +#define REGISTER_STATIC_TYPES(t, nr)                                        \    
> > > 
> > > I'm unsure about the name.  We already have a declarative way to
> > > register machine types (DEFINE_MACHINE), maybe use "DEFINE_*" for
> > > consistency?
> > > 
> > > Also, this function won't work if t isn't a static variable, will
> > > it?  The "STATIC" part looks redundant.
> > > 
> > > In other words, how about "DEFINE_TYPE" and "DEFINE_TYPES"?  
> > 'define' word remind me more of declaration but here we actually
> > register types that's why 'register' looks better to me as it says
> > exactly what's going here.  
> 
> Making it look like a declaration and not an action like
> "register" is on purpose, as it's not a function call anymore:
> it's a declaration that will make the type get registered
> automatically.

so if there is no objections I'd respin patch with
 "DEFINE_TYPE" and "DEFINE_TYPES"
that Eduardo suggested and put these into object.h instead of module.h

I also would prefer to drop/postpone "DEFINE_TYPE" till someone takes
on a quest to actually use it.

> 
> >   
> > > 
> > >   
> > > > +static void do_qemu_init_ ## t(void)                                        \
> > > > +{                                                                           \
> > > > +    type_register_static_array(t, nr);                                      \    
> > > 
> > > qemu/module.h doesn't include qom/object.h.  I think this should
> > > go to either qom/object.h or a new header file.  
> > I could move it to qom/object.h
> >   
> > >   
> > > > +}                                                                           \
> > > > +type_init(do_qemu_init_ ## t)
> > > > +
> > > > +#define REGISTER_STATIC_TYPE(t)                                             \
> > > > +    REGISTER_STATIC_TYPES(t, 1)
> > > > +
> > > >  #define block_module_load_one(lib) module_load_one("block-", lib)
> > > >  
> > > >  void register_module_init(void (*fn)(void), module_init_type type);
> > > > diff --git a/include/qom/object.h b/include/qom/object.h
> > > > index f3e5cff..17fcadd 100644
> > > > --- a/include/qom/object.h
> > > > +++ b/include/qom/object.h
> > > > @@ -789,6 +789,16 @@ Type type_register_static(const TypeInfo *info);
> > > >  Type type_register(const TypeInfo *info);
> > > >  
> > > >  /**
> > > > + * type_register_static_array:
> > > > + * @infos: The array of the new type #TypeInfo structures.
> > > > + * @nr_infos: number of entries in @infos
> > > > + *
> > > > + * @infos and all of the strings it points to should exist for the life time
> > > > + * that the type is registered.
> > > > + */
> > > > +void type_register_static_array(const TypeInfo *infos, int nr_infos);    
> > > 
> > > This new function is probably less controversial than the new
> > > module.h-based code.  Maybe worth moving to a separate patch so
> > > it can be merged earlier?
> > > 
> > > (If I were you, I would just use type_register_static_array()
> > > inside the existing *_cpu_register_types() functions by now, so
> > > this won't block the whole series, and worry about
> > > REGISTER_STATIC_TYPE*/DEFINE_TYPE* later.)  
> > it would be nice to have both in one series so that
> > we won't have to touch/rewrite more than once code where
> > static cpu types are registered.
> > 
> > If you prefer I can do what you suggest and keep
> > *_cpu_register_types() functions
> > but I can't promise to return back to cleaning them up
> > or to REGISTER_STATIC_TYPE*/DEFINE_TYPE, so probably
> > someone else will have to pickup that work.  
> 
> No problem to me, if this is left for later.  The macro saves
> only 3 lines of code.
> 
> I think REGISTER_STATIC_TYPE*/DEFINE_TYPE* is a good idea, but
> considering that QOM types are not the only kind of entity we
> register at module_init(), we need to pick a style that can be
> consistently used by other subsystems (e.g. for QemuOpts,
> BlockDrivers, and TraceEvents).  This means this could take a
> little longer to be discussed, and I guess you wouldn't like the
> discussion to block the cleanups in this series.
> 
> >   
> > > > +
> > > > +/**
> > > >   * object_class_dynamic_cast_assert:
> > > >   * @klass: The #ObjectClass to attempt to cast.
> > > >   * @typename: The QOM typename of the class to cast to.
> > > > diff --git a/qom/object.c b/qom/object.c
> > > > index 3e18537..40b1729 100644
> > > > --- a/qom/object.c
> > > > +++ b/qom/object.c
> > > > @@ -151,6 +151,15 @@ TypeImpl *type_register_static(const TypeInfo *info)
> > > >      return type_register(info);
> > > >  }
> > > >  
> > > > +void type_register_static_array(const TypeInfo *infos, int nr_infos)
> > > > +{
> > > > +    int i;
> > > > +
> > > > +    for (i = 0; i < nr_infos; i++) {
> > > > +        assert(type_register_static(&infos[i]));    
> > > 
> > > Why the assert()?  type_register_static() is already guaranteed
> > > to never return NULL.  
> > according to doc comment type_register_static might return 0 on failure
> > so qemu should die in that case.  
> 
> We have absolutely no callers of type_register*() that check its
> return value, and the existing implementation guarantees it will
> never return NULL.  Instead of making
> type_register_static_array() more commplex, we could just update
> the documentation.
> 
> >   
> > > 
> > > This will break if compiled with -DNDEBUG: assert() won't even
> > > evaluate the expression if NDEBUG is defined.
> > >   
> > > > +    }
> > > > +}
> > > > +
> > > >  static TypeImpl *type_get_by_name(const char *name)
> > > >  {
> > > >      if (name == NULL) {
> > > > -- 
> > > > 2.7.4
> > > >     
> > >   
> >   
> 
