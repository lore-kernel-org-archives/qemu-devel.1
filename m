Received: from eggs.gnu.org ([2001:4830:134:3::10]:36220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eZqip-0000qX-70
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eZqil-0003Eh-Py
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:13:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:42370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eZqil-0003D1-GI
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:13:35 -0500
Date: Fri, 12 Jan 2018 12:13:29 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180112041329.ylw5bm7cieghbpjy@hz-desktop>
References: <20180111142208.17617-1-haozhong.zhang@intel.com>
	<20180111142208.17617-3-haozhong.zhang@intel.com>
	<20180111200610.GE13422@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111200610.GE13422@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hostmem-file: add 'sync' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>

On 01/11/18 20:06 +0000, Dr. David Alan Gilbert wrote:
> * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> > This option controls whether QEMU mmap(2) the memory backend file with
> > MAP_SYNC flag, which can fully guarantee the guest write persistence
> > to the backend, if MAP_SYNC flag is supported by the host kernel
> > (Linux kernel 4.15 and later) and the backend is a file supporting
> > DAX (e.g., file on ext4/xfs file system mounted with '-o dax').
> > 
> > It can take one of following values:
> >  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> >         'share=off', QEMU will abort
> >  - off: never pass MAP_SYNC to mmap(2)
> >  - auto (default): if MAP_SYNC is supported and 'share=on', work as if
> >         'sync=on'; otherwise, work as if 'sync=off'
> 
> I don't know anything about MAP_SYNC but see two minor comments below:
> 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Sugguested-by: Eduardo Habkost <ehabkost@redhat.com>
>       ^ typo!
>
[..]
> > +static void file_memory_backend_set_sync(
> > +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> > +{
> > +    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> > +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
> > +    Error *local_err = NULL;
> > +    OnOffAuto value;
> > +
> > +    if (host_memory_backend_mr_inited(backend)) {
> > +        error_setg(&local_err, "cannot change property value");
> 
> Please make this error clearer; if I was helping someone and saw
> this error message in a log, I wouldn't know what type of property it
> was on what device.   Please at least include something saying it's
> memory backend related and sync related; even just including a %s and
> __func__ would help;  even better if you include the name of the object
> so if you had multiple backend files and one failed you could see which
> one.

I'll fix the typo, and include the backend id and the property name in
the error messages in the next version.

Thanks,
Haozhong
