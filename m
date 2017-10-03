Received: from eggs.gnu.org ([2001:4830:134:3::10]:48515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzRrz-0007pG-66
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzRru-0000V6-75
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:24:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzRrt-0000SH-TY
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:24:34 -0400
Date: Tue, 3 Oct 2017 15:24:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003182427.GP17385@localhost.localdomain>
References: <20171002192404.GC17385@localhost.localdomain>
	<1507032886-199950-1-git-send-email-imammedo@redhat.com>
	<20171003142501.GI17385@localhost.localdomain>
	<20171003170139.36e23ab7@nial.brq.redhat.com>
	<20171003153722.GM17385@localhost.localdomain>
	<20171003183737.63cf74cf@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003183737.63cf74cf@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qom: add helpers REGISTER_STATIC_TYPE[S]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, Oct 03, 2017 at 06:37:37PM +0200, Igor Mammedov wrote:
> On Tue, 3 Oct 2017 12:37:22 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Tue, Oct 03, 2017 at 05:01:39PM +0200, Igor Mammedov wrote:
> > > On Tue, 3 Oct 2017 11:25:01 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > On Tue, Oct 03, 2017 at 02:14:46PM +0200, Igor Mammedov wrote:  
> > > > > it will help to remove code duplication in places
> > > > > that currently open code registration of static
> > > > > type[s] and remove necessity to declare function
> > > > > for type_init() to call, when only static types
> > > > > need to be registered.
> > > > > 
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > ---
> > > > > I'm going to use it for CPU types in followup patches
> > > > > 
> > > > > CC: ehabkost@redhat.com
> > > > > ---
> > > > >  include/qemu/module.h | 10 ++++++++++
> > > > >  include/qom/object.h  | 10 ++++++++++
> > > > >  qom/object.c          |  9 +++++++++
> > > > >  3 files changed, 29 insertions(+)
> > > > > 
> > > > > diff --git a/include/qemu/module.h b/include/qemu/module.h
> > > > > index 56dd218..60dd632 100644
> > > > > --- a/include/qemu/module.h
> > > > > +++ b/include/qemu/module.h
> > > > > @@ -52,6 +52,16 @@ typedef enum {
> > > > >  #define type_init(function) module_init(function, MODULE_INIT_QOM)
> > > > >  #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
> > > > >  
> > > > > +#define REGISTER_STATIC_TYPES(t, nr)                                        \    
> > > > 
> > > > I'm unsure about the name.  We already have a declarative way to
> > > > register machine types (DEFINE_MACHINE), maybe use "DEFINE_*" for
> > > > consistency?
> > > > 
> > > > Also, this function won't work if t isn't a static variable, will
> > > > it?  The "STATIC" part looks redundant.
> > > > 
> > > > In other words, how about "DEFINE_TYPE" and "DEFINE_TYPES"?  
> > > 'define' word remind me more of declaration but here we actually
> > > register types that's why 'register' looks better to me as it says
> > > exactly what's going here.  
> > 
> > Making it look like a declaration and not an action like
> > "register" is on purpose, as it's not a function call anymore:
> > it's a declaration that will make the type get registered
> > automatically.
> 
> so if there is no objections I'd respin patch with
>  "DEFINE_TYPE" and "DEFINE_TYPES"
> that Eduardo suggested and put these into object.h instead of module.h
> 
> I also would prefer to drop/postpone "DEFINE_TYPE" till someone takes
> on a quest to actually use it.

No problem to me.  Missing type_register_static_array() was a
problem, but missing DEFINE_TYPE is not a big deal.

-- 
Eduardo
