Received: from eggs.gnu.org ([2001:4830:134:3::10]:34051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhv1m-0007PV-AI
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhv1k-0000kW-QE
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:50 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhv1k-0000kK-GV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:48 -0400
Received: by mail-wm0-x244.google.com with SMTP id y9-v6so1252638wma.5
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:58:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:09 +0100
Message-Id: <20180724105109.8392-18-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/17] tests/tcg: remove runcom test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The combination of being rather esoteric and needing to support mmap @
0 means this only ever worked under translation. It has now regressed
even further and is no longer useful. Kill it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index c1997a1624..b4033ba3d1 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -29,11 +29,6 @@ test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
 
-# Specialist test runners
-run-runcom: TIMEOUT=30
-run-runcom: runcom pi_10.com
-	$(call run-test,$<,$(QEMU) ./runcom $(I386_SRC)/pi_10.com,"$< on $(TARGET_NAME)")
-
 ifeq ($(SPEED), slow)
 
 test-i386-fprem.ref: test-i386-fprem
diff --git a/tests/tcg/i386/README b/tests/tcg/i386/README
index 7a0a47bf27..09e88f30dc 100644
--- a/tests/tcg/i386/README
+++ b/tests/tcg/i386/README
@@ -25,9 +25,6 @@ and host CPUs.
 test-i386-fprem
 ---------------
 
-runcom
-------
-
 test-mmap
 ---------
 
diff --git a/tests/tcg/i386/pi_10.com b/tests/tcg/i386/pi_10.com
deleted file mode 100644
index 8993ba1a51bbc2aaddc3aa99ceea37ab3bf9ea9e..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 54
zcmV-60LlM|6SaSi!9cr&CiAO|!E5OPMfdfRtCIKOQkA$004Db(1I1kv)#B#&Gz2h`
MtF!{mAxm}F!x~T=Hvj+t

diff --git a/tests/tcg/i386/runcom.c b/tests/tcg/i386/runcom.c
deleted file mode 100644
index d60342bfc6..0000000000
--- a/tests/tcg/i386/runcom.c
+++ /dev/null
@@ -1,192 +0,0 @@
-/*
- * Simple example of use of vm86: launch a basic .com DOS executable
- */
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <inttypes.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <signal.h>
-
-#include <linux/unistd.h>
-#include <asm/vm86.h>
-
-extern int vm86 (unsigned long int subfunction,
-		 struct vm86plus_struct *info);
-
-#define VIF_MASK                0x00080000
-
-//#define SIGTEST
-
-#define COM_BASE_ADDR    0x10100
-
-static void usage(void)
-{
-    printf("runcom version 0.1 (c) 2003 Fabrice Bellard\n"
-           "usage: runcom file.com\n"
-           "VM86 Run simple .com DOS executables (linux vm86 test mode)\n");
-    exit(1);
-}
-
-static inline void set_bit(uint8_t *a, unsigned int bit)
-{
-    a[bit / 8] |= (1 << (bit % 8));
-}
-
-static inline uint8_t *seg_to_linear(unsigned int seg, unsigned int reg)
-{
-    return (uint8_t *)((seg << 4) + (reg & 0xffff));
-}
-
-static inline void pushw(struct vm86_regs *r, int val)
-{
-    r->esp = (r->esp & ~0xffff) | ((r->esp - 2) & 0xffff);
-    *(uint16_t *)seg_to_linear(r->ss, r->esp) = val;
-}
-
-void dump_regs(struct vm86_regs *r)
-{
-    fprintf(stderr,
-            "EAX=%08lx EBX=%08lx ECX=%08lx EDX=%08lx\n"
-            "ESI=%08lx EDI=%08lx EBP=%08lx ESP=%08lx\n"
-            "EIP=%08lx EFL=%08lx\n"
-            "CS=%04x DS=%04x ES=%04x SS=%04x FS=%04x GS=%04x\n",
-            r->eax, r->ebx, r->ecx, r->edx, r->esi, r->edi, r->ebp, r->esp,
-            r->eip, r->eflags,
-            r->cs, r->ds, r->es, r->ss, r->fs, r->gs);
-}
-
-#ifdef SIGTEST
-void alarm_handler(int sig)
-{
-    fprintf(stderr, "alarm signal=%d\n", sig);
-    alarm(1);
-}
-#endif
-
-int main(int argc, char **argv)
-{
-    uint8_t *vm86_mem;
-    const char *filename;
-    int fd, ret, seg;
-    struct vm86plus_struct ctx;
-    struct vm86_regs *r;
-
-    if (argc != 2)
-        usage();
-    filename = argv[1];
-
-    vm86_mem = mmap((void *)0x00000000, 0x110000,
-                    PROT_WRITE | PROT_READ | PROT_EXEC,
-                    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
-    if (vm86_mem == MAP_FAILED) {
-        perror("mmap");
-        exit(1);
-    }
-#ifdef SIGTEST
-    {
-        struct sigaction act;
-
-        act.sa_handler = alarm_handler;
-        sigemptyset(&act.sa_mask);
-        act.sa_flags = 0;
-        sigaction(SIGALRM, &act, NULL);
-        alarm(1);
-    }
-#endif
-
-    /* load the MSDOS .com executable */
-    fd = open(filename, O_RDONLY);
-    if (fd < 0) {
-        perror(filename);
-        exit(1);
-    }
-    ret = read(fd, vm86_mem + COM_BASE_ADDR, 65536 - 256);
-    if (ret < 0) {
-        perror("read");
-        exit(1);
-    }
-    close(fd);
-
-    memset(&ctx, 0, sizeof(ctx));
-    /* init basic registers */
-    r = &ctx.regs;
-    r->eip = 0x100;
-    r->esp = 0xfffe;
-    seg = (COM_BASE_ADDR - 0x100) >> 4;
-    r->cs = seg;
-    r->ss = seg;
-    r->ds = seg;
-    r->es = seg;
-    r->fs = seg;
-    r->gs = seg;
-    r->eflags = VIF_MASK;
-
-    /* put return code */
-    set_bit((uint8_t *)&ctx.int_revectored, 0x21);
-    *seg_to_linear(r->cs, 0) = 0xb4; /* mov ah, $0 */
-    *seg_to_linear(r->cs, 1) = 0x00;
-    *seg_to_linear(r->cs, 2) = 0xcd; /* int $0x21 */
-    *seg_to_linear(r->cs, 3) = 0x21;
-    pushw(&ctx.regs, 0x0000);
-
-    /* the value of these registers seem to be assumed by pi_10.com */
-    r->esi = 0x100;
-    r->ecx = 0xff;
-    r->ebp = 0x0900;
-    r->edi = 0xfffe;
-
-    for(;;) {
-        ret = vm86(VM86_ENTER, &ctx);
-        switch(VM86_TYPE(ret)) {
-        case VM86_INTx:
-            {
-                int int_num, ah;
-
-                int_num = VM86_ARG(ret);
-                if (int_num != 0x21)
-                    goto unknown_int;
-                ah = (r->eax >> 8) & 0xff;
-                switch(ah) {
-                case 0x00: /* exit */
-                    exit(0);
-                case 0x02: /* write char */
-                    {
-                        uint8_t c = r->edx;
-                        write(1, &c, 1);
-                    }
-                    break;
-                case 0x09: /* write string */
-                    {
-                        uint8_t c;
-                        for(;;) {
-                            c = *seg_to_linear(r->ds, r->edx);
-                            if (c == '$')
-                                break;
-                            write(1, &c, 1);
-                        }
-                        r->eax = (r->eax & ~0xff) | '$';
-                    }
-                    break;
-                default:
-                unknown_int:
-                    fprintf(stderr, "unsupported int 0x%02x\n", int_num);
-                    dump_regs(&ctx.regs);
-                    //                    exit(1);
-                }
-            }
-            break;
-        case VM86_SIGNAL:
-            /* a signal came, we just ignore that */
-            break;
-        case VM86_STI:
-            break;
-        default:
-            fprintf(stderr, "unhandled vm86 return code (0x%x)\n", ret);
-            dump_regs(&ctx.regs);
-            exit(1);
-        }
-    }
-}
-- 
2.17.1
