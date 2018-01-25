Received: from eggs.gnu.org ([2001:4830:134:3::10]:36237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eeVBj-0008Mh-PG
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eeVBf-0000NZ-N8
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:14:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:35534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eeVBf-0000N4-EZ
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:14:39 -0500
Date: Thu, 25 Jan 2018 08:14:22 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180125001422.i3yjdjta727ob2uj@hz-desktop>
References: <20180117081325.11924-1-haozhong.zhang@intel.com>
	<20180117081325.11924-2-haozhong.zhang@intel.com>
	<20180124221602-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124221602-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 01/24/18 22:20 +0200, Michael S. Tsirkin wrote:
> > index 50385e3f81..dd5876471f 100644
> > --- a/include/qemu/mmap-alloc.h
> > +++ b/include/qemu/mmap-alloc.h
> > @@ -7,7 +7,8 @@ size_t qemu_fd_getpagesize(int fd);
> >  
> >  size_t qemu_mempath_getpagesize(const char *mem_path);
> >  
> > -void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
> > +void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared,
> > +                    OnOffAuto sync);
> >  
> >  void qemu_ram_munmap(void *ptr, size_t size);
> >  
> 
> And Marcel plans to add a remappable flag ...  Is it time we
> switched to a flags field?

Yes. Some patches on my hands are going to add another field to this
function, so let's switch to flags.

> 
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index adb3758275..0ff10cb529 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -372,6 +372,24 @@ void qemu_anon_ram_free(void *ptr, size_t size);
> >  #  define QEMU_VMALLOC_ALIGN getpagesize()
> >  #endif
> >  
> > +/*
> > + * MAP_SHARED_VALIDATE and MAP_SYNC were introduced in Linux kernel
> > + * 4.15, so they may not be defined when compiling on older kernels.
> > + */
> > +#ifdef CONFIG_LINUX
> > +#ifndef MAP_SHARED_VALIDATE
> > +#define MAP_SHARED_VALIDATE   0x3
> > +#endif
> > +#ifndef MAP_SYNC
> > +#define MAP_SYNC              0x80000
> > +#endif
> > +#define QEMU_HAS_MAP_SYNC     true
> > +#else  /* !CONFIG_LINUX */
> > +#define MAP_SHARED_VALIDATE   0x0
> > +#define MAP_SYNC              0x0
> > +#define QEMU_HAS_MAP_SYNC     false
> > +#endif /* CONFIG_LINUX */
> > +
> >  #ifdef CONFIG_POSIX
> >  struct qemu_signalfd_siginfo {
> >      uint32_t ssi_signo;   /* Signal number */
> 
> Please just import this into standard-headers from Linux.
>

Sure, I'll move it to a new file include/standard-headers/linux/mman.h.

Thanks,
Haozhong
