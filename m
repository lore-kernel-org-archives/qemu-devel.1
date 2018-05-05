Received: from eggs.gnu.org ([2001:4830:134:3::10]:37437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF5De-0001pA-7g
	for qemu-devel@nongnu.org; Sat, 05 May 2018 17:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF5Dc-00013s-0W
	for qemu-devel@nongnu.org; Sat, 05 May 2018 17:59:54 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:44794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF5Db-00013K-Og
	for qemu-devel@nongnu.org; Sat, 05 May 2018 17:59:51 -0400
Received: by mail-oi0-x22f.google.com with SMTP id e80-v6so22110587oig.11
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 14:59:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180505114812.GO13229@umbus.fritz.box>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
	<20180505114812.GO13229@umbus.fritz.box>
From: Michael Clark <mjc@sifive.com>
Date: Sun, 6 May 2018 09:59:50 +1200
Message-ID: <CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>

On Sat, May 5, 2018 at 11:48 PM, David Gibson <david@gibson.dropbear.id.au>
wrote:

> On Sat, May 05, 2018 at 11:44:25AM +0100, Peter Maydell wrote:
> > cc'ing David -- is this the best way to do this?
> >
> > (It would be nicer if libfdt would just dynamically
> > reallocate the buffer as needed,
>
> That's a deliberate design tradeoff.  Because it's designed to be
> embeddable in really limited environments, libfdt tries to keep to
> really minimal dependencies - in particular it doesn't depend on an
> allocator.
>
> It'd be nice to have another (optional) layer on top that does
> reallocate automatically.allocator.  In principle it's pretty simple -
> you just call down to the existing functions and if they return
> FDT_ERR_NOSPACE, rellocate and retry.  I've never had the time to
> write it though - especially since in most simple cases just
> allocating a far-to-big buffer initially actually works pretty well,
> crude though it may be.
>
> For complex fdt manipulations.. well.. there comes a point where fdt
> is the wrong tool for the job and you'd be better off using a "live"
> representation of the tree and just flattening it when you're
> finished.  IMO qemu is already past that point.  I send some early
> draft patches adding live tree infrastructure a while back but got too
> sidetracked by higher priorities to follow it through.
>
> > and then tell you
> > the final size, rather than having to specify a
> > maximum buffer size up front, but given the API we
> > have a "tell me how big this thing actually is"
> > function seems reasonable. I'm just surprised we
> > need to know so much about the DT internals to do it.)
>
> I'm not familiar with the rest of this thread, so I'm not sure at what
> point you're wanting to know this.  If it's only right at the end
> before loading the final blob you can fdt_pack() and then check
> fdt_totalsize().


Okay, so an alternative is to call fdt_pack() and then fdt_totalsize().
Thanks!

QEMU has its own wrapper around libfdt and neither the fdt_pack() nor
fdt_totalsize() functions are exposed.

Some architecture use only the wrapper functions provided by
qemu/include/include/sysemu/device_tree.h

It seems that target/ppc has #include <libfdt.h> and calls fdt_pack() and
fdt_totalsize() directly.

Some architectures appear to copy the unpacked fdt into their ROMS where
the allocated size in QEMU defaults to 1MiB.

QEMU has a wrapper function called create_device_tree that
calls fdt_create(), fdt_finish_reservemap(), fdt_begin_node(),
fdt_end_node(), fdt_finish(), fdt_open_into()
with a 1MiB initial buffer size. The resulting device tree is modified in
memory using various QEMU wrapper APIs that call fdt_setprop_string(),
fdt_setprop_cell(), etc

For RISC-V we were able to get an accurate size using this function:

size_t qemu_fdt_totalsize(void *fdt)
{
    return fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt) +
           fdt_size_dt_strings(fdt) + sizeof(uint32_t) /* terminator */;
}

Now that we're aware of fdt_pack() and then fdt_totalsize() then we can
avoid changing target neutral code in
qemu/include/include/sysemu/device_tree.h by following ppc's lead and add
#include <libfdt.h> and call fdt_pack() and fdt_totalsize() directly.

The thing I spotted in fdt_resize() was the calculation to check that the
new buffer was large enough however it excludes dt_off_dt_struct(fdt) and
space for the uin32_t terminator. See here:

int fdt_resize(void *fdt, void *buf, int bufsize)
{
...

headsize = fdt_off_dt_struct(fdt);
tailsize = fdt_size_dt_strings(fdt);

if ((headsize + tailsize) > bufsize)
return -FDT_ERR_NOSPACE;

...

return 0;
}

>
> > thanks
> > -- PMM
> >
> > On 4 May 2018 at 02:19, Michael Clark <mjc@sifive.com> wrote:
> > > Currently the device-tree create_device_tree function
> > > returns the size of the allocated device tree buffer
> > > however there is no way to get the actual amount of
> > > buffer space used by the device-tree.
> > >
> > > 14ec3cbd7c1e31dca4d23f028100c8f43e156573 increases
> > > the FDT_MAX_SIZE to 1 MiB. This creates an issue
> > > for boards that have less than 1 MiB in their ROM
> > > for device tree. While cpu_physical_memory_write
> > > will not write past the end of a buffer there is
> > > and a board is aware of its ROM buffer size, so
> > > can use min(fdt_size,rom_size); this provides no
> > > indication as to whether the device-tree may be
> > > truncated. qemu_fdt_totalsize allows a board to
> > > check that a dynamically created device tree will
> > > fit within its alloted ROM space.
> > >
> > > Add qemu_fdt_totalsize which uses the logic and
> > > public APIs from libfdt to calculate the device
> > > size: struct_offset + struct_size + strings_size
> > > + terminator.
> > >
> > > Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> > > Cc: Alexander Graf <agraf@suse.de>
> > > Cc: Alistair Francis <Alistair.Francis@wdc.com>
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >  device_tree.c                | 6 ++++++
> > >  include/sysemu/device_tree.h | 6 ++++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/device_tree.c b/device_tree.c
> > > index 52c3358a5583..3a2166d61f37 100644
> > > --- a/device_tree.c
> > > +++ b/device_tree.c
> > > @@ -215,6 +215,12 @@ void *load_device_tree_from_sysfs(void)
> > >
> > >  #endif /* CONFIG_LINUX */
> > >
> > > +size_t qemu_fdt_totalsize(void *fdt)
> > > +{
> > > +    return fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt) +
> > > +           fdt_size_dt_strings(fdt) + sizeof(uint32_t) /* terminator
> */;
> > > +}
> > > +
> > >  static int findnode_nofail(void *fdt, const char *node_path)
> > >  {
> > >      int offset;
> > > diff --git a/include/sysemu/device_tree.h
> b/include/sysemu/device_tree.h
> > > index e22e5bec9c3f..4af232dfdc65 100644
> > > --- a/include/sysemu/device_tree.h
> > > +++ b/include/sysemu/device_tree.h
> > > @@ -26,6 +26,12 @@ void *load_device_tree_from_sysfs(void);
> > >  #endif
> > >
> > >  /**
> > > + * qemu_fdt_total_size: returns the size required to store the current
> > > + * device tree versus the buffer size returned by create_device_tree
> > > + */
> > > +size_t qemu_fdt_totalsize(void *fdt);
> > > +
> > > +/**
> > >   * qemu_fdt_node_path: return the paths of nodes matching a given
> > >   * name and compat string
> > >   * @fdt: pointer to the dt blob
> >
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>
