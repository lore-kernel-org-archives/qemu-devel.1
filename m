Received: from eggs.gnu.org ([2001:4830:134:3::10]:43794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzQGC-0007uY-Mh
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzQG7-0003be-Um
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:41:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzQG7-0003ah-OH
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:41:27 -0400
Date: Tue, 3 Oct 2017 18:41:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171003184122.1e023f6e@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA8av+9qUDJ6U0YzOPxCx_xW4c-F+Ci1n+W=TxK909z1hw@mail.gmail.com>
References: <20171002192404.GC17385@localhost.localdomain>
	<1507032886-199950-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA8av+9qUDJ6U0YzOPxCx_xW4c-F+Ci1n+W=TxK909z1hw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, 3 Oct 2017 16:44:28 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 3 October 2017 at 13:14, Igor Mammedov <imammedo@redhat.com> wrote:
> > it will help to remove code duplication in places
> > that currently open code registration of static
> > type[s] and remove necessity to declare function
> > for type_init() to call, when only static types
> > need to be registered.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > I'm going to use it for CPU types in followup patches
> >
> > CC: ehabkost@redhat.com
> > ---
> >  include/qemu/module.h | 10 ++++++++++
> >  include/qom/object.h  | 10 ++++++++++
> >  qom/object.c          |  9 +++++++++
> >  3 files changed, 29 insertions(+)
> >
> > diff --git a/include/qemu/module.h b/include/qemu/module.h
> > index 56dd218..60dd632 100644
> > --- a/include/qemu/module.h
> > +++ b/include/qemu/module.h
> > @@ -52,6 +52,16 @@ typedef enum {
> >  #define type_init(function) module_init(function, MODULE_INIT_QOM)
> >  #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
> >
> > +#define REGISTER_STATIC_TYPES(t, nr)                                        \
> > +static void do_qemu_init_ ## t(void)                                        \
> > +{                                                                           \
> > +    type_register_static_array(t, nr);                                      \
> > +}                                                                           \
> > +type_init(do_qemu_init_ ## t)  
> 
> Could we use
>     type_register_static_array(t, ARRAY_SIZE(t));
> here to save the caller having to pass the array size,
> or is that too magic?
+1
this way user will not have to type ARRAY_SIZE(t) and make mistake by chance 
