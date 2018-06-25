Received: from eggs.gnu.org ([2001:4830:134:3::10]:38503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gor@linux.ibm.com>) id 1fXT7V-0001kR-PV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gor@linux.ibm.com>) id 1fXT7R-0001Vf-J3
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gor@linux.ibm.com>) id 1fXT7R-0001Uu-AA
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PExUNL049139
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:09:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ju2au1kt5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:09:27 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <gor@linux.ibm.com>;
	Mon, 25 Jun 2018 16:09:24 +0100
Date: Mon, 25 Jun 2018 17:09:19 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
	<cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
Message-Id: <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] s390/boot: block uncompressed vmlinux booting
 attempts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

Since uncompressed kernel image "vmlinux" elf file is not bootable under
qemu anymore, add a check which would report that.

Qemu users are encouraged to use bzImage or
arch/s390/boot/compressed/vmlinux instead.

The check relies on s390 linux entry point ABI definition, which is only
present in bzImage and arch/s390/boot/compressed/vmlinux.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/head.S         |  4 ++--
 arch/s390/include/asm/setup.h |  3 ++-
 arch/s390/kernel/early.c      | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
index f09e792df495..f721913b73f1 100644
--- a/arch/s390/boot/head.S
+++ b/arch/s390/boot/head.S
@@ -272,14 +272,14 @@ iplstart:
 	.org	0x10000
 ENTRY(startup)
 	j	.Lep_startup_normal
-	.org	0x10008
+	.org	EP_OFFSET
 #
 # This is a list of s390 kernel entry points. At address 0x1000f the num=
ber of
 # valid entry points is stored.
 #
 # IMPORTANT: Do not change this table, it is s390 kernel ABI!
 #
-	.ascii	"S390EP"
+	.ascii	EP_STRING
 	.byte	0x00,0x01
 #
 # kdump startup-code at 0x10010, running in 64 bit absolute addressing m=
ode
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.=
h
index be02f0558048..1d66016f4170 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -9,7 +9,8 @@
 #include <linux/const.h>
 #include <uapi/asm/setup.h>
=20
-
+#define EP_OFFSET		0x10008
+#define EP_STRING		"S390EP"
 #define PARMAREA		0x10400
 #define PARMAREA_END		0x11000
=20
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 827699eb48fa..45c5be3d8777 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -331,8 +331,20 @@ static void __init setup_boot_command_line(void)
 	append_to_cmdline(append_ipl_scpdata);
 }
=20
+static void __init check_image_bootable(void)
+{
+	if (!memcmp(EP_STRING, (void *)EP_OFFSET, strlen(EP_STRING)))
+		return;
+
+	sclp_early_printk("The linux kernel boot failure: the image is corrupte=
d or not bootable.\n");
+	sclp_early_printk("Please check that you are using bootable kernel imag=
e \"bzImage\".\n");
+	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinu=
x\" image for qemu)\n");
+	disabled_wait(0xbadb007);
+}
+
 void __init startup_init(void)
 {
+	check_image_bootable();
 	time_early_init();
 	init_kernel_storage_key();
 	lockdep_off();
--=20
=E2=A3=94=E2=A2=BB=E2=A3=9F=E2=A2=A2 2.18.0.rc2.13.g4da9a5d
=E2=A3=BF=E2=A2=BF=E2=A1=BF=E2=A3=BF pacman edition
