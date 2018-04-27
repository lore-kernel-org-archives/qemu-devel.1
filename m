Received: from eggs.gnu.org ([2001:4830:134:3::10]:60616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBzcC-0003ky-M9
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBzc9-0002uc-HQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:24:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBzc9-0002uU-BL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:24:25 -0400
Date: Fri, 27 Apr 2018 10:24:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180427092413.GA2609@work-vm>
References: <alpine.LRH.2.11.1804262308190.12327@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1804262308190.12327@mail.ewheeler.net>
Subject: Re: [Qemu-devel] Migration without memory page transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Wheeler <qemu-devel@lists.ewheeler.net>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

* Eric Wheeler (qemu-devel@lists.ewheeler.net) wrote:
> Hello all,

Hi Eric,

> This is my first time inside of the qemu code, so your help is greatly 
> appreciated!
> 
> I have been experimenting with stop/start of VMs to/from a migration 
> stream that excludes RAM pages and let the RAM pages come from memory file 
> provided by the memory-backend-file called '/dev/shm/mem'.
> 
> To disable writing of memory pages to the migration stream, I've disabled 
> calls to ram_find_and_save_block in ram_save_iterate() and 
> ram_save_complete() (see patch below).  Thus, the migration stream has the 
> "ram" SaveStateEntry section start/ends, but no pages:

You're in luck, because someone else has just done something very
similar.

> qemu-system-x86_64 \
> 	-object memory-backend-file,prealloc=no,mem-path=/dev/shm/mem,id=ram-node0,host-nodes=0,policy=bind,size=64m,share=on \
> 	-numa node,nodeid=0,cpus=0,memdev=ram-node0\
> 	-m 64 -vnc 0:0
> 
> Once the VM is running, I press ctrl-B to get the IPXE prompt and then 
> run 'kernel http://192.168.0.1/foo' to start a network request and watch 
> it in tcpdump.
> 
> Once the download starts, I save the migration file:
> 	migrate "exec:cat > /dev/shm/t"
> 
> 	# ls -lh /dev/shm/t
> 	-rw-r--r-- 1 root root 321K Apr 26 16:06 /dev/shm/t
> 
> Now I can kill qemu and boot it again with -incoming:
> 
> qemu-system-x86_64 \
> 	-object memory-backend-file,prealloc=no,mem-path=/dev/shm/mem,id=ram-node0,host-nodes=0,policy=bind,size=64m,share=on \
> 	-numa node,nodeid=0,cpus=0,memdev=ram-node0\
> 	-m 64 -vnc 0:0 \
> 	-incoming 'exec:cat /dev/shm/t'
> 
> It seems to work.  That is, network traffic continues (http from IPXE) 
> which I can see from tcpdump.  I can type into the console and it moves 
> the cursor around---but there is nothing on the screen except the blinking 
> text-mode cursor!  I can even blindly start a new transfer in ipxe: kernel 
> http://192.168.0.222/foo2 and see it in tcpdump.
> 
> So what am I missing here?  Is the video memory not saved to /dev/shm/mem?
> 
> Or perhaps it is saved, but VGA isn't initialized to use what is 
> already in /dev/shm/mem?  I've tried the cirrus, std, and vmware drivers 
> to see if they behave differently, but the do not seem to.

They have their own RAMBlocks, not the main RAM, so that does need
migrating.

The patch here:
   http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00003.html

should do what you want.
You need to turn on the bypass-shared-memory capability.
   migrate_set_capability bypass-shared-memory on

Dave


> Thanks for your help!


> --
> Eric Wheeler
> 
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 021d583..9f4bfff 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2267,9 +2267,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>      t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      i = 0;
>      while ((ret = qemu_file_rate_limit(f)) == 0) {
> -        int pages;
> +        int pages = 0;
>  
> -        pages = ram_find_and_save_block(rs, false);
> +        if (0) pages = ram_find_and_save_block(rs, false);
>          /* no more pages to sent */
>          if (pages == 0) {
>              done = 1;
> @@ -2338,9 +2338,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>  
>      /* flush all remaining blocks regardless of rate limiting */
>      while (true) {
> -        int pages;
> +        int pages = 0;
>  
> -        pages = ram_find_and_save_block(rs, !migration_in_colo_state());
> +        if (0) pages = ram_find_and_save_block(rs, !migration_in_colo_state());
>          /* no more blocks to sent */
>          if (pages == 0) {
>              break;
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
