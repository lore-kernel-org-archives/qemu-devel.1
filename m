Received: from eggs.gnu.org ([2001:4830:134:3::10]:44044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cvBxi-0000rV-P9
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 20:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cvBxe-0005yH-QV
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 20:04:42 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1cvBxe-0005y6-LF
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 20:04:38 -0400
Received: by mail-qt0-x243.google.com with SMTP id r45so21321760qte.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 17:04:38 -0700 (PDT)
Date: Mon, 3 Apr 2017 20:04:35 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Message-ID: <20170404000435.GB32510@foober.ini.cmu.edu>
References: <1490978921-3782-1-git-send-email-gsomlo@gmail.com>
	<1490978921-3782-3-git-send-email-gsomlo@gmail.com>
	<31b4d051-cc87-41c8-f568-8299f758bfe3@suse.de>
	<c1daa1a8-05e9-a42a-7f22-50600942a093@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1daa1a8-05e9-a42a-7f22-50600942a093@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/3] applesmc: consolidate port i/o into
 single contiguous region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, eshelton@pobox.com

On Mon, Apr 03, 2017 at 12:27:15PM +0200, Paolo Bonzini wrote:
> 
> 
> On 03/04/2017 11:32, Alexander Graf wrote:
> > 
> >> Newer AppleSMC revisions support an error status (read) port
> >> in addition to the data and command ports currently supported.
> >>
> >> Register the full 32-bit region at once, and handle individual
> >> ports at various offsets within the region from the top-level
> >> applesmc_io_[write|read]() methods (ctual support for reading
> >> the error status port to be added by a subsequent patch).
> >>
> >> Originally proposed by Eric Shelton <eshelton@pobox.com>
> >>
> >> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > 
> > I would prefer if we could leave the multiplexing to the layer that
> > knows how to do that the best: Memory Regions.
> > 
> > Why don't you just define a big region that ecompasses all of the IO
> > space (with fallback I/O handlers for warnings) and then just sprinkle
> > the ones we handle on top with higher prio?
> 
> You don't need priority at all, "contained" regions always win over the
> container (docs/memory.txt just before "Region names").
> 
> Both what you propose and what Gabriel did makes sense.  In general QEMU
> does things more like in this patch, but there are exceptions (e.g. ACPI).

So, option 1 would be:

Leave the region covering the entire AppleSMC port range (APPLESMC_NUM_PORTS)
as-is:

static const MemoryRegionOps applesmc_io_ops = {
    .write = applesmc_io_write,
    .read = applesmc_io_read,
    .endianness = DEVICE_NATIVE_ENDIAN,
    .impl = {
        .min_access_size = 1,
        .max_access_size = 1,
    },
};

but modify applesmc_io_write() and applesmc_io_read() to do nothing or
return 0xff, respectively. Then, add three separate regions covering 1
byte, for each of the three ports, with their own methods pointing at
the existing port-specific read/write methods.


Option 2 would be to leave everything as-is, per Paolo's suggestion
that it's the more common way of doing things. I personally find this
one easier to follow, but really don't mind doing either.


If I end up going with #1, I'd probably be bringing back
applesmc_data_io_ops and applesmc_cmd_io_ops, in which case I'd like
to know why the access size was set to 4 bytes to begin with:

-    memory_region_init_io(&s->io_data, OBJECT(s), &applesmc_data_io_ops, s,
-                          "applesmc-data", 4);
-    isa_register_ioport(&s->parent_obj, &s->io_data,
-                        s->iobase + APPLESMC_DATA_PORT);
-
-    memory_region_init_io(&s->io_cmd, OBJECT(s), &applesmc_cmd_io_ops, s,
-                          "applesmc-cmd", 4);
-    isa_register_ioport(&s->parent_obj, &s->io_cmd,
-                        s->iobase + APPLESMC_CMD_PORT);

Each port is 8-bits wide only, so why 4 and not 1, above ?

I guess that doesn't matter if we stick with option #2... :)

Any further advice on which way to go much appreciated!

Thanks,
--Gabriel
