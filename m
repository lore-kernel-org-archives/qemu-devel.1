Received: from eggs.gnu.org ([2001:4830:134:3::10]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel@lists.ewheeler.net>) id 1fBqOl-0007Q0-RZ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 19:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu-devel@lists.ewheeler.net>) id 1fBqOh-0000xZ-Sl
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 19:33:59 -0400
Received: from mx.ewheeler.net ([66.155.3.69]:34886 helo=mail.ewheeler.net)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel@lists.ewheeler.net>) id 1fBqOh-0000wt-JZ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 19:33:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id E3B99A0414
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 23:33:53 +0000 (UTC)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Lw8Bu6pXOhcZ for <qemu-devel@nongnu.org>;
	Thu, 26 Apr 2018 23:33:53 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id 7370EA03B0
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 23:33:53 +0000 (UTC)
Date: Thu, 26 Apr 2018 23:33:53 +0000 (UTC)
From: Eric Wheeler <qemu-devel@lists.ewheeler.net>
Message-ID: <alpine.LRH.2.11.1804262308190.12327@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] Migration without memory page transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello all,

This is my first time inside of the qemu code, so your help is greatly 
appreciated!

I have been experimenting with stop/start of VMs to/from a migration 
stream that excludes RAM pages and let the RAM pages come from memory file 
provided by the memory-backend-file called '/dev/shm/mem'.

To disable writing of memory pages to the migration stream, I've disabled 
calls to ram_find_and_save_block in ram_save_iterate() and 
ram_save_complete() (see patch below).  Thus, the migration stream has the 
"ram" SaveStateEntry section start/ends, but no pages:

qemu-system-x86_64 \
	-object memory-backend-file,prealloc=no,mem-path=/dev/shm/mem,id=ram-node0,host-nodes=0,policy=bind,size=64m,share=on \
	-numa node,nodeid=0,cpus=0,memdev=ram-node0\
	-m 64 -vnc 0:0

Once the VM is running, I press ctrl-B to get the IPXE prompt and then 
run 'kernel http://192.168.0.1/foo' to start a network request and watch 
it in tcpdump.

Once the download starts, I save the migration file:
	migrate "exec:cat > /dev/shm/t"

	# ls -lh /dev/shm/t
	-rw-r--r-- 1 root root 321K Apr 26 16:06 /dev/shm/t

Now I can kill qemu and boot it again with -incoming:

qemu-system-x86_64 \
	-object memory-backend-file,prealloc=no,mem-path=/dev/shm/mem,id=ram-node0,host-nodes=0,policy=bind,size=64m,share=on \
	-numa node,nodeid=0,cpus=0,memdev=ram-node0\
	-m 64 -vnc 0:0 \
	-incoming 'exec:cat /dev/shm/t'

It seems to work.  That is, network traffic continues (http from IPXE) 
which I can see from tcpdump.  I can type into the console and it moves 
the cursor around---but there is nothing on the screen except the blinking 
text-mode cursor!  I can even blindly start a new transfer in ipxe: kernel 
http://192.168.0.222/foo2 and see it in tcpdump.

So what am I missing here?  Is the video memory not saved to /dev/shm/mem?

Or perhaps it is saved, but VGA isn't initialized to use what is 
already in /dev/shm/mem?  I've tried the cirrus, std, and vmware drivers 
to see if they behave differently, but the do not seem to.

Thanks for your help!

--
Eric Wheeler


diff --git a/migration/ram.c b/migration/ram.c
index 021d583..9f4bfff 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2267,9 +2267,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     i = 0;
     while ((ret = qemu_file_rate_limit(f)) == 0) {
-        int pages;
+        int pages = 0;
 
-        pages = ram_find_and_save_block(rs, false);
+        if (0) pages = ram_find_and_save_block(rs, false);
         /* no more pages to sent */
         if (pages == 0) {
             done = 1;
@@ -2338,9 +2338,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     /* flush all remaining blocks regardless of rate limiting */
     while (true) {
-        int pages;
+        int pages = 0;
 
-        pages = ram_find_and_save_block(rs, !migration_in_colo_state());
+        if (0) pages = ram_find_and_save_block(rs, !migration_in_colo_state());
         /* no more blocks to sent */
         if (pages == 0) {
             break;
