Received: from eggs.gnu.org ([2001:4830:134:3::10]:40537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ftFsq-0000Os-8n
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ftFfX-00020C-W5
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:14:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ftFfW-0001vP-SK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:14:43 -0400
Date: Fri, 24 Aug 2018 20:14:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180824201116-mutt-send-email-mst@kernel.org>
References: <20180820104045.133968-1-mst@redhat.com>
	<20180820104045.133968-5-mst@redhat.com>
	<CAFEAcA9eOFMuvkN2gBetU4SSpV0Jp2hSVsjMG53_Cp8TrkObFg@mail.gmail.com>
	<20180824195231-mutt-send-email-mst@kernel.org>
	<CAFEAcA8d0TMqkmkVY9mANj+Dv9fZj18ov=nvaDNtKqss5Nmc+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8d0TMqkmkVY9mANj+Dv9fZj18ov=nvaDNtKqss5Nmc+w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 4/7] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On Fri, Aug 24, 2018 at 05:57:06PM +0100, Peter Maydell wrote:
> On 24 August 2018 at 17:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Aug 24, 2018 at 04:13:18PM +0100, Peter Maydell wrote:
> >> object_get_canonical_path_component() returns a string which
> >> must be freed using g_free().
> 
> > Like the following? Junyan, could you pls try this one and confirm?
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index 2476dcb435..d88125b86e 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -154,11 +154,14 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
> >  #ifndef CONFIG_LIBPMEM
> >      if (value) {
> >          Error *local_err = NULL;
> > +        char *path = object_get_canonical_path_component(o);
> > +
> >          error_setg(&local_err,
> >                     "Lack of libpmem support while setting the 'pmem=on'"
> >                     " of %s '%s'. We can't ensure data persistence.",
> >                     object_get_typename(o),
> > -                   object_get_canonical_path_component(o));
> > +                   );
> > +        g_free(path);
> >          error_propagate(errp, local_err);
> >          return;
> 
> Yep, like that (though I would put the closing ");" on
> the line with object_get_typename() and delete the trailing comma).
> 
> thanks
> -- PMM

oh i forgot to add in "path".
I didn't build with libpmem installed
Should have been (still untested):

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 2476dcb435..72e7055ee7 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -154,11 +154,14 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
 #ifndef CONFIG_LIBPMEM
     if (value) {
         Error *local_err = NULL;
+        char *path = object_get_canonical_path_component(o);
+
         error_setg(&local_err,
                    "Lack of libpmem support while setting the 'pmem=on'"
                    " of %s '%s'. We can't ensure data persistence.",
                    object_get_typename(o),
-                   object_get_canonical_path_component(o));
+                   path);
+        g_free(path);
         error_propagate(errp, local_err);
         return;
     }
