Received: from eggs.gnu.org ([2001:4830:134:3::10]:41638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzM4u-0001IM-D1
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzM4q-0002s9-AE
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:13:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzM4q-0002qG-0u
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:13:32 -0400
Date: Tue, 3 Oct 2017 14:13:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171003141328.4c07ae4c@nial.brq.redhat.com>
In-Reply-To: <20171002192404.GC17385@localhost.localdomain>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<20171002192404.GC17385@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/38] qom: add helper
 type_init_from_array()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Mon, 2 Oct 2017 16:24:04 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Oct 02, 2017 at 11:07:43AM +0200, Igor Mammedov wrote:
> > it will help to remove code duplication in places
> > that currently open code registration of several
> > types.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > I'm going to use it for CPU types in followup patches
> > 
> > CC: ehabkost@redhat.com
> > ---
> >  include/qemu/module.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/qemu/module.h b/include/qemu/module.h
> > index 56dd218..29f9089 100644
> > --- a/include/qemu/module.h
> > +++ b/include/qemu/module.h
> > @@ -52,6 +52,16 @@ typedef enum {
> >  #define type_init(function) module_init(function, MODULE_INIT_QOM)
> >  #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
> >  
> > +#define type_init_from_array(array)                                        \  
> 
> So we're moving from a imperative way to register types to a
> declarative way.  Sounds nice.
> 
> You are also adding a way to register a TypeInfo array easily.
> That's nice, too.
> 
> But, why do we need to address both at the same time?  I think
> this adds some confusing gaps to the module/QOM APIs:
> 
> * If you want to register a type at runtime, there are only
>   functions to register a single type (type_register(),
>   type_register_static().  What if I want to register a TypeInfo
>   array from an existing type_init() function?
> * If you want to declare types to be registered automatically at
>   module_call_init(MODULE_INIT_QOM), you are adding a helper that
>   avoids manual type_register*() calls, but only for arrays.
>   What if I want to register a single type?  (There are 440+
>   functions containing a single type_register*() call in the
>   tree)
just array is sufficient for code touched in this series.
I'll add helper for single type as well, but I'd leave for someone
else to use it (i.e. do cleanup).

> I have two suggestions:
> 
> * Adding a type_register_static_array() helper first, call it
>   from a type_init() function, and think about a module.h-based
>   helper for arrays later.
> 
> * (For later) adding a module_init() helper that works for
>   registering a single type too. So, this very common pattern:
> 
>       static const TypeInfo FOO_type = {
>           /* ... */
>       };
>       
>       static void register_FOO_type(void)
>       {
>           type_register_static(&FOO_type);
>       }
>       
>       QOM_TYPE(register_FOO_type);
> 
>   could be written as:
> 
>       static const TypeInfo FOO_type = {
>           /* ... */
>       };
>       
>       QOM_TYPE(FOO_type);
> 
> (I'm suggesting QOM_TYPE as the macro name, but I'm not sure
> about it.  But I think type_init_*() is confusing because it
> doesn't work like the other *_init() helpers in module.h)
> 
> QOM_TYPE(T) could be just a shortcut to:
> QOM_TYPES_PTR(&T, 1).
QOM here seems redundant, how about
REGISTER_STATIC_TYPE/REGISTER_STATIC_TYPES

> 
> Your type_init_from_array(A) helper could be just a shortcut to:
> QOM_TYPES_PTR(A, ARRAY_SIZE(A)).
> 
> > +static void do_qemu_init_ ## array(void)                                   \
> > +{                                                                          \
> > +    int i;                                                                 \
> > +    for (i = 0; i < ARRAY_SIZE(array); i++) {                              \
> > +        type_register_static(&array[i]);                                   \  
> 
> type_register_static() is in qom/object.[ch], and module.[ch] has
> no dependency on QOM at all.  I believe this belongs in
> qom/object.h, not module.h.
ok

> 
> > +    }                                                                      \
> > +}                                                                          \
> > +module_init(do_qemu_init_ ## array, MODULE_INIT_QOM)  
> 
> Why not use type_init(do_qemu_init_ ## array)?
I'll will use it in v2

> 
> > +  
> 
> Also for later: this is not the first time we generate function
> bodies on the fly for module_init().  Maybe module_init could
> support a void* data argument?
> 
> >  #define block_module_load_one(lib) module_load_one("block-", lib)
> >  
> >  void register_module_init(void (*fn)(void), module_init_type type);
> > -- 
> > 2.7.4
> >   
> 
