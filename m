Received: from eggs.gnu.org ([2001:4830:134:3::10]:32836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePm21-000450-JV
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePm1x-0006GZ-J4
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:11:49 -0500
Date: Fri, 15 Dec 2017 10:11:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171215101135.447d9316.cohuck@redhat.com>
In-Reply-To: <cf44ca76-d581-8d96-3e2b-78c698dda446@de.ibm.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
	<CAFEAcA8tY9=jtsw-MtjWTceLizvpH8oui_+6xf7V6K5o5BLf-A@mail.gmail.com>
	<cf44ca76-d581-8d96-3e2b-78c698dda446@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 00/46] First batch of s390x
 patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Fri, 15 Dec 2017 09:35:10 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 12/14/2017 08:05 PM, Peter Maydell wrote:
> > On 14 December 2017 at 17:09, Cornelia Huck <cohuck@redhat.com> wrote:  
> >> The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549ac5b6d:
> >>
> >>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171214' into staging (2017-12-14 15:32:32 +0000)
> >>
> >> are available in the git repository at:
> >>
> >>   git://github.com/cohuck/qemu tags/s390x-20171214
> >>
> >> for you to fetch changes up to a9e3065c6579df8652ce38502276ac0a13180d6f:
> >>
> >>   s390-ccw-virtio: allow for systems larger that 7.999TB (2017-12-14 17:56:54 +0100)
> >>
> >> ----------------------------------------------------------------
> >> s390x changes for 2.12:
> >> - Lots of tcg improvements: ccw hotplug is now working and we can run
> >>   a Linux kernel built for z12 under tcg
> >> - zPCI improvements to get virtio-pci working
> >> - get rid of the cssid restrictions for virtual and non-virtual channel
> >>   devices
> >> - we now support 8TB+ systems
> >> - 2.12 compat machine
> >> - fixes and cleanups
> >>
> >> ----------------------------------------------------------------  
> > 
> > Hi; I'm afraid this fails to build on 32-bit:
> > 
> > In file included from
> > /usr/lib/arm-linux-gnueabihf/glib-2.0/include/glibconfig.h:9:0,
> >                  from /usr/include/glib-2.0/glib/gtypes.h:32,
> >                  from /usr/include/glib-2.0/glib/galloca.h:32,
> >                  from /usr/include/glib-2.0/glib.h:30,
> >                  from /home/peter.maydell/qemu/include/glib-compat.h:19,
> >                  from /home/peter.maydell/qemu/include/qemu/osdep.h:107,
> >                  from /home/peter.maydell/qemu/hw/s390x/s390-virtio-ccw.c:13:
> > /home/peter.maydell/qemu/hw/s390x/s390-virtio-ccw.c: In function
> > 's390_memory_init':
> > /usr/include/glib-2.0/glib/gmacros.h:291:26: error: comparison is
> > always true due to limited range of data type [-Werror=type-limits]
> >  #define MIN(a, b)  (((a) < (b)) ? (a) : (b))
> >                           ^
> > /home/peter.maydell/qemu/hw/s390x/s390-virtio-ccw.c:177:17: note: in
> > expansion of macro 'MIN'
> >          chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
> >                  ^
> > 
> > (ram_addr_t can be a 32-bit type).  

This a 32 bit host, isn't it? I don't have regular access to one...

> 
> gcc seems to be extra clever, even a cast does not work.
> Something like this seems to work.
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 80e753a5ef..9abb8de9f9 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -172,9 +172,10 @@ static void s390_memory_init(ram_addr_t mem_size)
>      name = g_strdup_printf("s390.ram");
>      while (mem_size) {
>          MemoryRegion *ram = g_new(MemoryRegion, 1);
> +       unsigned long long size = mem_size;
>  
>          /* KVM does not allow memslots >= 8 TB */
> -        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
> +        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
>          memory_region_allocate_system_memory(ram, NULL, name, chunk);
>          memory_region_add_subregion(sysmem, offset, ram);
>          mem_size -= chunk;
> 

Will see how I can test this and then merge it.
