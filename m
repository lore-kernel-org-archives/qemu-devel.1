Received: from eggs.gnu.org ([209.51.188.92]:34103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLt-0007yS-8X
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLr-0003Zy-UT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  3 May 2019 13:26:53 +0200
Message-Id: <20190503112654.4393-12-laurent@vivier.eu>
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 11/12] hw/sparc/leon3: Allow load of uImage
 firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, KONRAD Frederic <frederic.konrad@adacore.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Currently the Leon3 machine doesn't allow to load legacy u-boot images:

  $ qemu-system-sparc -M leon3_generic -d in_asm \
      -kernel HelenOS-0.6.0-sparc32-leon3.bin
  qemu-system-sparc: could not load kernel 'HelenOS-0.6.0-sparc32-leon3.bin'

  $ file HelenOS-0.6.0-sparc32-leon3.bin
  HelenOS-0.6.0-sparc32-leon3.bin: u-boot legacy uImage, HelenOS-0.6.0,\
    Linux/ARM, OS Kernel Image (Not compressed), 2424229 bytes,\
    Sun Dec 21 19:18:09 2014,\
    Load Address: 0x40000000, Entry Point: 0x40000000,\
    Header CRC: 0x8BCFA236, Data CRC: 0x37AD87DF

Since QEMU can load uImages, add the necessary code,
so the Leon3 machine can load these images:

  $ qemu-system-sparc -M leon3_generic -d in_asm \
      -kernel HelenOS-0.6.0-sparc32-leon3.bin
  ----------------
  IN:
  0x40000000:  b  0x400007a8
  0x40000004:  nop
  ----------------
  IN:
  0x400007a8:  save  %sp, -136, %sp
  0x400007ac:  call  0x40000020
  0x400007b0:  sethi  %hi(0x4000b800), %i1
  ...

Tested with the following firmware:
http://www.helenos.org/releases/HelenOS-0.6.0-sparc32-leon3.bin

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20190427162922.4207-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/sparc/leon3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 774639af3393..0383b17c298f 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -193,6 +193,10 @@ static void leon3_generic_hw_init(MachineState *machine)
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, NULL, NULL,
                                1 /* big endian */, EM_SPARC, 0, 0);
+        if (kernel_size < 0) {
+            kernel_size = load_uimage(kernel_filename, NULL, &entry,
+                                      NULL, NULL, NULL);
+        }
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
-- 
2.20.1
