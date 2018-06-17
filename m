Received: from eggs.gnu.org ([2001:4830:134:3::10]:58948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUUpI-00048J-G8
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 06:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUUpF-0002xK-8I
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 06:22:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40718
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fUUpF-0002v0-1J
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 06:22:25 -0400
References: <40d9df00-f80d-02a4-58ec-b407e7dd8cdb@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <da05f804-31f4-e820-12ed-22a240bf2d07@ilande.co.uk>
Date: Sun, 17 Jun 2018 11:22:08 +0100
MIME-Version: 1.0
In-Reply-To: <40d9df00-f80d-02a4-58ec-b407e7dd8cdb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] valgrind problem in sun4u_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15/06/18 11:37, Thomas Huth wrote:

>   Hi Mark, hi Artyom,
> 
> while using valgrind to fix some issues with the rom_ptr() function
> today, I noticed that there is one more problem in sun4u_load_kernel():
> The kernel_top variable can be used uninitialized in some cases:
> If load_elf() fails and the kernel is loaded via load_aout() or
> load_image_targphys(), the kernel_top variable is never set to a valid
> value. This could cause some trouble when loading the initrd later. When
> you've got some spare time, could you please have a look?

Hmmm that's an interesting one - I'm not immediately aware of any 64-bit 
kernels that are a.out rather than ELF, so I wonder if this has been 
used to run a.out executables on startup? Any thoughts, Artyom?

If this is the case then we can only have a valid kernel_top with an ELF 
kernel then maybe the following is a good enough solution:


diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 3975a7b65a..35acf8c96e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -139,7 +139,7 @@ static uint64_t sun4u_load_kernel(const char 
*kernel_filename,
      unsigned int i;
      long kernel_size;
      uint8_t *ptr;
-    uint64_t kernel_top;
+    uint64_t kernel_top = 0;

      linux_boot = (kernel_filename != NULL);

@@ -172,7 +172,7 @@ static uint64_t sun4u_load_kernel(const char 
*kernel_filename,
          }
          /* load initrd above kernel */
          *initrd_size = 0;
-        if (initrd_filename) {
+        if (initrd_filename && kernel_top) {
              *initrd_addr = TARGET_PAGE_ALIGN(kernel_top);

              *initrd_size = load_image_targphys(initrd_filename,


ATB,

Mark.
