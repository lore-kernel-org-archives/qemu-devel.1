Received: from eggs.gnu.org ([2001:4830:134:3::10]:51709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel@lists.ewheeler.net>) id 1fF3p9-00074A-Dl
	for qemu-devel@nongnu.org; Sat, 05 May 2018 16:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu-devel@lists.ewheeler.net>) id 1fF3p6-0003Y9-2e
	for qemu-devel@nongnu.org; Sat, 05 May 2018 16:30:31 -0400
Received: from mx.ewheeler.net ([66.155.3.69]:43314 helo=mail.ewheeler.net)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel@lists.ewheeler.net>) id 1fF3p5-0003U2-LM
	for qemu-devel@nongnu.org; Sat, 05 May 2018 16:30:27 -0400
Date: Sat, 5 May 2018 20:30:24 +0000 (UTC)
From: Eric Wheeler <qemu-devel@lists.ewheeler.net>
In-Reply-To: <20180427024511.GX9036@xz-mi>
Message-ID: <alpine.LRH.2.11.1805052020240.28587@mail.ewheeler.net>
References: <alpine.LRH.2.11.1804262308190.12327@mail.ewheeler.net>
	<20180427024511.GX9036@xz-mi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] Migration without memory page transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 27 Apr 2018, Peter Xu wrote:

> On Thu, Apr 26, 2018 at 11:33:53PM +0000, Eric Wheeler wrote:
> > Hello all,
> 
> Hi, Eric,
> 
> > 
> > This is my first time inside of the qemu code, so your help is greatly 
> > appreciated!
> > 
> > I have been experimenting with stop/start of VMs to/from a migration 
> > stream that excludes RAM pages and let the RAM pages come from memory file 
> > provided by the memory-backend-file called '/dev/shm/mem'.
> > 
> > To disable writing of memory pages to the migration stream, I've disabled 
> > calls to ram_find_and_save_block in ram_save_iterate() and 
> > ram_save_complete() (see patch below).  Thus, the migration stream has the 
> > "ram" SaveStateEntry section start/ends, but no pages:
> > 
> > qemu-system-x86_64 \
> > 	-object memory-backend-file,prealloc=no,mem-path=/dev/shm/mem,id=ram-node0,host-nodes=0,policy=bind,size=64m,share=on \
> > 	-numa node,nodeid=0,cpus=0,memdev=ram-node0\
> > 	-m 64 -vnc 0:0
> > 
> > Once the VM is running, I press ctrl-B to get the IPXE prompt and then 
> > run 'kernel http://192.168.0.1/foo' to start a network request and watch 
> > it in tcpdump.
> > 
> > Once the download starts, I save the migration file:
> > 	migrate "exec:cat > /dev/shm/t"
> > 
> > 	# ls -lh /dev/shm/t
> > 	-rw-r--r-- 1 root root 321K Apr 26 16:06 /dev/shm/t
> > 
> > Now I can kill qemu and boot it again with -incoming:
> > 
> > qemu-system-x86_64 \
> > 	-object memory-backend-file,prealloc=no,mem-path=/dev/shm/mem,id=ram-node0,host-nodes=0,policy=bind,size=64m,share=on \
> > 	-numa node,nodeid=0,cpus=0,memdev=ram-node0\
> > 	-m 64 -vnc 0:0 \
> > 	-incoming 'exec:cat /dev/shm/t'
> > 
> > It seems to work.  That is, network traffic continues (http from IPXE) 
> > which I can see from tcpdump.  I can type into the console and it moves 
> > the cursor around---but there is nothing on the screen except the blinking 
> > text-mode cursor!  I can even blindly start a new transfer in ipxe: kernel 
> > http://192.168.0.222/foo2 and see it in tcpdump.
> > 
> > So what am I missing here?  Is the video memory not saved to /dev/shm/mem?
> > 
> > Or perhaps it is saved, but VGA isn't initialized to use what is 
> > already in /dev/shm/mem?  I've tried the cirrus, std, and vmware drivers 
> > to see if they behave differently, but the do not seem to.
> 
> My wild guess is that we might still need to migrate some RAM besides
> the /dev/shm/mem file.  We have at least these ramblocks to migrate:
> 
> $ ./x86_64-softmmu/qemu-system-x86_64 -monitor stdio -m 2G                                                                           
> QEMU 2.12.0 monitor - type 'help' for more information
> (qemu) info ramblock
>               Block Name    PSize              Offset               Used              Total
>                   pc.ram    4 KiB  0x0000000000000000 0x0000000080000000 0x0000000080000000
>                 vga.vram    4 KiB  0x0000000080080000 0x0000000001000000 0x0000000001000000
>     /rom@etc/acpi/tables    4 KiB  0x0000000081100000 0x0000000000020000 0x0000000000200000
>                  pc.bios    4 KiB  0x0000000080000000 0x0000000000040000 0x0000000000040000
>   0000:00:03.0/e1000.rom    4 KiB  0x00000000810c0000 0x0000000000040000 0x0000000000040000
>                   pc.rom    4 KiB  0x0000000080040000 0x0000000000020000 0x0000000000020000
>     0000:00:02.0/vga.rom    4 KiB  0x0000000081080000 0x0000000000010000 0x0000000000010000
>    /rom@etc/table-loader    4 KiB  0x0000000081300000 0x0000000000001000 0x0000000000001000
>       /rom@etc/acpi/rsdp    4 KiB  0x0000000081340000 0x0000000000001000 0x0000000000001000

Yes, that makes sense!

> 
> And my understanding is that /dev/shm/mem only corresponds to the
> "pc.ram" entry.  I suspect the rest of RAMBlocks will still need to be
> migrated.  For example, the VGA ram.

The patch Dr. David Alan Gilbert mentioned is exactly what I was looking 
for:
  https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg02250.html

> Meanwhile, could I ask about where will this be used?  Is there
> anything to do with something like a "distributed memory cache" that
> provide memory service across multiple hosts?

I'm mostly interested in quickly restoring without a memory dump, possibly 
implementing a "fork()" to quickly clone VMs.  Also remote memory would be 
neat.

Do you remember OpenMOSIX?  I wonder if it would be possible to launch 
qemu instances on different nodes such that each instance is a remote NUMA 
node.  Cache coherency would need to be worked out, and it might require 
an OS port to handle new synchronization primitives---but if there was a 
way to do it without modifying the OS then you could create really big 
single-system-image NUMA servers.


--
Eric Wheeler



> 
> Best Regards,
> 
> > 
> > Thanks for your help!
> > 
> > --
> > Eric Wheeler
> > 
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 021d583..9f4bfff 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2267,9 +2267,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> >      t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> >      i = 0;
> >      while ((ret = qemu_file_rate_limit(f)) == 0) {
> > -        int pages;
> > +        int pages = 0;
> >  
> > -        pages = ram_find_and_save_block(rs, false);
> > +        if (0) pages = ram_find_and_save_block(rs, false);
> >          /* no more pages to sent */
> >          if (pages == 0) {
> >              done = 1;
> > @@ -2338,9 +2338,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >  
> >      /* flush all remaining blocks regardless of rate limiting */
> >      while (true) {
> > -        int pages;
> > +        int pages = 0;
> >  
> > -        pages = ram_find_and_save_block(rs, !migration_in_colo_state());
> > +        if (0) pages = ram_find_and_save_block(rs, !migration_in_colo_state());
> >          /* no more blocks to sent */
> >          if (pages == 0) {
> >              break;
> > 
> > 
> 
> -- 
> Peter Xu
> 
