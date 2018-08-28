Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1fuY30-0001KE-Qc
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 03:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1fuY2w-0002no-NO
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 03:04:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:30414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1fuY2w-0002li-DW
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 03:04:14 -0400
Date: Tue, 28 Aug 2018 23:42:57 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20180828154256.GH13028@tiger-server>
References: <20180820104045.133968-1-mst@redhat.com>
	<20180820104045.133968-5-mst@redhat.com>
	<CAFEAcA9eOFMuvkN2gBetU4SSpV0Jp2hSVsjMG53_Cp8TrkObFg@mail.gmail.com>
	<20180824195231-mutt-send-email-mst@kernel.org>
	<CAFEAcA8d0TMqkmkVY9mANj+Dv9fZj18ov=nvaDNtKqss5Nmc+w@mail.gmail.com>
	<20180824201116-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824201116-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL 4/7] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Junyan He <junyan.he@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2018-08-24 at 20:14:37 +0300, Michael S. Tsirkin wrote:
> On Fri, Aug 24, 2018 at 05:57:06PM +0100, Peter Maydell wrote:
> > On 24 August 2018 at 17:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Fri, Aug 24, 2018 at 04:13:18PM +0100, Peter Maydell wrote:
> > >> object_get_canonical_path_component() returns a string which
> > >> must be freed using g_free().
> > 
> > > Like the following? Junyan, could you pls try this one and confirm?
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > > index 2476dcb435..d88125b86e 100644
> > > --- a/backends/hostmem-file.c
> > > +++ b/backends/hostmem-file.c
> > > @@ -154,11 +154,14 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
> > >  #ifndef CONFIG_LIBPMEM
> > >      if (value) {
> > >          Error *local_err = NULL;
> > > +        char *path = object_get_canonical_path_component(o);
> > > +
> > >          error_setg(&local_err,
> > >                     "Lack of libpmem support while setting the 'pmem=on'"
> > >                     " of %s '%s'. We can't ensure data persistence.",
> > >                     object_get_typename(o),
> > > -                   object_get_canonical_path_component(o));
> > > +                   );
> > > +        g_free(path);
> > >          error_propagate(errp, local_err);
> > >          return;
> > 
> > Yep, like that (though I would put the closing ");" on
> > the line with object_get_typename() and delete the trailing comma).
> > 
> > thanks
> > -- PMM
>a

Ah.. Thanks Michael/Peter to identify/prepare this fix.

> oh i forgot to add in "path".
> I didn't build with libpmem installed

Maybe you already have libpmem installed yet, 
it is *ifndef* CONFIG_LIBPMEM ^_^

> Should have been (still untested):
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 2476dcb435..72e7055ee7 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -154,11 +154,14 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
>  #ifndef CONFIG_LIBPMEM
>      if (value) {
>          Error *local_err = NULL;
> +        char *path = object_get_canonical_path_component(o);
> +
>          error_setg(&local_err,
>                     "Lack of libpmem support while setting the 'pmem=on'"
>                     " of %s '%s'. We can't ensure data persistence.",
>                     object_get_typename(o),
> -                   object_get_canonical_path_component(o));
> +                   path);
> +        g_free(path);
>          error_propagate(errp, local_err);
>          return;
>      }
> 
Ah.. I saw another place still have the seem leak, on the previous few lines in
file_memory_backend_set_pmem, I will prepare another patch to fix the
leaks in these two place.

Regards
Yi.
