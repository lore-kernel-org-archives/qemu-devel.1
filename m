Received: from eggs.gnu.org ([2001:4830:134:3::10]:57829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcbBq-0003lZ-A2
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcbBn-0006PY-5S
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:47:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fcbBm-0006PS-TT
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:47:11 -0400
Date: Mon, 9 Jul 2018 15:47:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180709184703.GY7451@localhost.localdomain>
References: <1529378899-24086-1-git-send-email-junyan.he@gmx.com>
	<20180621152011.5f3778e9@redhat.com>
	<EC8A4E314CF1574AB62C80421BD98339340A8EF5@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC8A4E314CF1574AB62C80421BD98339340A8EF5@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH 3/7 V7 RESEND] hostmem-file: add the 'pmem'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "He, Junyan" <junyan.he@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "junyan.he@gmx.com" <junyan.he@gmx.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lai, Paul C" <paul.c.lai@intel.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "Zhang, Yu C" <yu.c.zhang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>

On Mon, Jul 09, 2018 at 04:43:08AM +0000, He, Junyan wrote:
> Hi:
> 
> Do I still need to do something before it can be merged?

Unfortunately this missed 3.0 soft freeze (July 3).

I can still queue it for 3.1, but Igor had a question below that
is still unanswered, and I have a new question below.

If you have to send a new version of a patch, please send it as a
new version (e.g. "v8" instead of "v7 RESEND").  I thought this
patch was the same as "[PATCH 3/7 V7]".

Questions below:

[...]
> > +static void file_memory_backend_set_pmem(Object *o, bool value, Error 
> > +**errp) {
> > +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> > +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
> > +
> > +    if (host_memory_backend_mr_inited(backend)) {
> > +        error_setg(errp, "cannot change property 'pmem' of %s '%s'",
> > +                   object_get_typename(o),
> > +                   object_get_canonical_path_component(o));
> > +        return;
> > +    }
> > +
> > +#ifndef CONFIG_LIBPMEM
> > +    if (value) {
> > +        error_report("Lack of libpmem support while setting the 'pmem=on'"
> > +                     " of %s '%s'. We can not ensure the persistence of it"
> > +                     " without libpmem support, this may cause serious"
> > +                     " problems." , object_get_typename(o),
> > +                     object_get_canonical_path_component(o));
> > +        exit(1);

Why error_report()+exit() instead of error_setg(errp)?

> > +    }
> > +#endif
> > +
> > +    fb->is_pmem = value;
> > +}
> > +
[...]
> >  static void file_backend_instance_finalize(Object *o) diff --git 
> > a/docs/nvdimm.txt b/docs/nvdimm.txt index 8b48fb4..2f7d348 100644
> > --- a/docs/nvdimm.txt
> > +++ b/docs/nvdimm.txt
> > @@ -180,3 +180,21 @@ supports CPU Cache Flush and Memory Controller Flush on Power Loss, etc.
> >  
> >  For a complete list of the flags available and for more detailed 
> > descriptions,  please consult the ACPI spec.
> > +
> > +guest software that this vNVDIMM device contains a region that cannot 
> > +accept persistent writes. In result, for example, the guest Linux 
> > +NVDIMM driver, marks such vNVDIMM device as read-only.
> > +
> > +If the vNVDIMM backend is on the host persistent memory that can be 
> > +accessed in SNIA NVM Programming Model [1] (e.g., Intel NVDIMM), it's 
> > +suggested to set the 'pmem' option of memory-backend-file to 'on'. 
> > +When 'pmem=on' and QEMU is built with libpmem [2] support (configured 
> > +with --enable-libpmem), QEMU will take necessary operations to 
> > +guarantee the persistence of its own writes to the vNVDIMM backend 
> > +(e.g., in vNVDIMM label emulation and live migration).
> will libpmem guarantee data persistence even if backend's file is not on persistent memory?
> 
> 

-- 
Eduardo
