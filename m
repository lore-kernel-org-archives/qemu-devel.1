Received: from eggs.gnu.org ([2001:4830:134:3::10]:54962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozI-0008Fm-5s
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozE-0003tX-Gq
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPozE-0003t5-8O
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:52 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:15 +0200
Message-Id: <1498564100-10045-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 09/14] pc-bios/s390-ccw: Make the basic
 libnet code compilable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

Adjust the Makefiles, remove non-required code and fix some spots that
generated compiler warnings / errors with the s390-ccw firmware CFLAGS.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                         |   3 +-
 pc-bios/s390-ccw/Makefile         |   6 +-
 pc-bios/s390-ccw/libnet/Makefile  |  38 ++---
 pc-bios/s390-ccw/libnet/netapps.h |   4 +-
 pc-bios/s390-ccw/libnet/netload.c | 319 ++------------------------------------
 pc-bios/s390-ccw/libnet/tftp.c    |   2 +-
 6 files changed, 33 insertions(+), 339 deletions(-)

diff --git a/configure b/configure
index 954c286..0ac761e 100755
--- a/configure
+++ b/configure
@@ -6378,7 +6378,7 @@ fi
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
 DIRS="$DIRS docs docs/interop fsdev"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas"
-DIRS="$DIRS pc-bios/s390-ccw pc-bios/s390-ccw/libc"
+DIRS="$DIRS pc-bios/s390-ccw pc-bios/s390-ccw/libc pc-bios/s390-ccw/libnet"
 DIRS="$DIRS roms/seabios roms/vgabios"
 DIRS="$DIRS qapi-generated"
 FILES="Makefile tests/tcg/Makefile qdict-test-data.txt"
@@ -6387,6 +6387,7 @@ FILES="$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
 FILES="$FILES pc-bios/optionrom/Makefile pc-bios/keymaps"
 FILES="$FILES pc-bios/spapr-rtas/Makefile"
 FILES="$FILES pc-bios/s390-ccw/Makefile pc-bios/s390-ccw/libc/Makefile"
+FILES="$FILES pc-bios/s390-ccw/libnet/Makefile"
 FILES="$FILES roms/seabios/Makefile roms/vgabios/Makefile"
 FILES="$FILES pc-bios/qemu-icon.bmp"
 FILES="$FILES .gdbinit scripts" # scripts needed by relative path in .gdbinit
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 8fbefe8..02b9b08 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -7,7 +7,7 @@ include $(SRC_PATH)/rules.mak
 
 $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
-.PHONY : all clean build-all libc.a
+.PHONY : all clean build-all libc.a libnet.a
 
 OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o
 OBJECTS += libc.a sbrk.o
@@ -26,6 +26,9 @@ s390-ccw.elf: $(OBJECTS)
 libc.a:
 	@$(MAKE) -C libc V="$(V)"
 
+libnet.a:
+	@$(MAKE) -C libnet V="$(V)"
+
 STRIP ?= strip
 
 s390-ccw.img: s390-ccw.elf
@@ -36,3 +39,4 @@ $(OBJECTS): Makefile
 clean:
 	rm -f *.o *.d *.img *.elf *~
 	@$(MAKE) -C libc clean
+	@$(MAKE) -C libnet clean
diff --git a/pc-bios/s390-ccw/libnet/Makefile b/pc-bios/s390-ccw/libnet/Makefile
index 83ac1e5..72e12d7 100644
--- a/pc-bios/s390-ccw/libnet/Makefile
+++ b/pc-bios/s390-ccw/libnet/Makefile
@@ -10,16 +10,21 @@
 # *     IBM Corporation - initial implementation
 # ****************************************************************************/
 
-ifndef TOP
-  TOP = $(shell while ! test -e make.rules; do cd ..  ; done; pwd)
-  export TOP
-endif
-include $(TOP)/make.rules
+include ../../../config-host.mak
+include $(SRC_PATH)/rules.mak
 
-CFLAGS += -I. -I.. -I../libc/include -I$(TOP)/include
+$(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw/libnet)
 
-SRCS =	ethernet.c ipv4.c udp.c tcp.c dns.c bootp.c dhcp.c tftp.c \
-	ipv6.c dhcpv6.c icmpv6.c ndp.c netload.c ping.c args.c
+QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
+QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
+QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing -Wno-redundant-decls
+QEMU_CFLAGS += -I$(SRC_PATH)/pc-bios/s390-ccw/libnet
+QEMU_CFLAGS += -I$(SRC_PATH)/pc-bios/s390-ccw/libc/include
+QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
+LDFLAGS += -Wl,-pie -nostdlib
+
+SRCS =	ethernet.c ipv4.c udp.c tcp.c dns.c dhcp.c tftp.c \
+	ipv6.c dhcpv6.c icmpv6.c ndp.c netload.c args.c
 
 OBJS = $(SRCS:%.c=%.o)
 
@@ -28,23 +33,10 @@ TARGET = ../libnet.a
 all: $(TARGET)
 
 $(TARGET): $(OBJS)
-	$(AR) -rc $@ $(OBJS)
-	$(RANLIB) $@
+	$(call quiet-command,$(AR) -rc $@ $(OBJS),"AR","$(TARGET_DIR)$@")
 
 clean:
-	$(RM) $(TARGET) $(OBJS)
+	rm -f $(TARGET) $(OBJS)
 
 distclean: clean
-	$(RM) Makefile.dep
-
-
-# Rules for creating the dependency file:
-depend:
-	$(RM) Makefile.dep
-	$(MAKE) Makefile.dep
-
-Makefile.dep: Makefile
-	$(CC) -M $(CPPFLAGS) $(CFLAGS) $(SRCS) > Makefile.dep
 
-# Include dependency file if available:
--include Makefile.dep
diff --git a/pc-bios/s390-ccw/libnet/netapps.h b/pc-bios/s390-ccw/libnet/netapps.h
index 2fea4a7..d2283af 100644
--- a/pc-bios/s390-ccw/libnet/netapps.h
+++ b/pc-bios/s390-ccw/libnet/netapps.h
@@ -18,9 +18,7 @@
 
 struct filename_ip;
 
-extern int netload(char *buffer, int len, char *ret_buffer, int huge_load,
-		   int block_size, char *args_fs, int alen);
-extern int ping(char *args_fs, int alen);
+extern int netload(char *buffer, int len, char *ret_buffer);
 extern int dhcp(char *ret_buffer, struct filename_ip *fn_ip,
 		unsigned int retries, int flags);
 
diff --git a/pc-bios/s390-ccw/libnet/netload.c b/pc-bios/s390-ccw/libnet/netload.c
index f872884..eae8333 100644
--- a/pc-bios/s390-ccw/libnet/netload.c
+++ b/pc-bios/s390-ccw/libnet/netload.c
@@ -23,8 +23,6 @@
 #include <time.h>
 #include <stdlib.h>
 #include <sys/socket.h>
-#include <libbootmsg/libbootmsg.h>
-#include <helpers.h>
 #include "args.h"
 #include "netapps.h"
 
@@ -66,266 +64,7 @@ static void netload_error(int errcode, const char *format, ...)
 	vsnprintf(&buf[13], sizeof(buf) - 13, format, vargs);
 	va_end(vargs);
 
-	bootmsg_error(errcode, &buf[7]);
-	write_mm_log(buf, strlen(buf), 0x91);
-}
-
-/**
- * Parses a argument string for IPv6 booting, extracts all
- * parameters and fills a structure accordingly
- *
- * @param  arg_str        string with arguments, separated with ','
- * @param  argc           number of arguments
- * @param  obp_tftp_args  structure which contains the result
- * @return                updated arg_str
- */
-static const char * 
-parse_ipv6args (const char *arg_str, unsigned int argc,
-		obp_tftp_args_t *obp_tftp_args)
-{
-	char *ptr = NULL;
-	char arg_buf[100];
-
-	// find out siaddr
-	if (argc == 0)
-		memset(&obp_tftp_args->si6addr.addr, 0, 16);
-	else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if(str_to_ipv6(arg_buf, (uint8_t *) &(obp_tftp_args->si6addr.addr[0]))) {
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else if(arg_buf[0] == 0) {
-			memset(&obp_tftp_args->si6addr.addr, 0, 16);
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else
-			memset(&obp_tftp_args->si6addr.addr, 0, 16);
-	}
-
-	// find out filename
-	if (argc == 0)
-		obp_tftp_args->filename[0] = 0;
-	else {
-		argncpy(arg_str, 0, obp_tftp_args->filename, 100);
-		for(ptr = obp_tftp_args->filename; *ptr != 0; ++ptr)
-			if(*ptr == '\\') {
-				*ptr = '/';
-			}
-		arg_str = get_arg_ptr(arg_str, 1);
-		--argc;
-	}
-
-	// find out ciaddr
-	if (argc == 0)
-		memset(&obp_tftp_args->ci6addr, 0, 16);
-	else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if (str_to_ipv6(arg_buf, (uint8_t *) &(obp_tftp_args->ci6addr.addr[0]))) {
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else if(arg_buf[0] == 0) {
-			memset(&obp_tftp_args->ci6addr.addr, 0, 16);
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else
-			memset(&obp_tftp_args->ci6addr.addr, 0, 16);
-	}
-
-	// find out giaddr
-	if (argc == 0)
-		memset(&obp_tftp_args->gi6addr, 0, 16);
-	else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if (str_to_ipv6(arg_buf, (uint8_t *) &(obp_tftp_args->gi6addr.addr)) ) {
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else if(arg_buf[0] == 0) {
-			memset(&obp_tftp_args->gi6addr, 0, 16);
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else
-			memset(&obp_tftp_args->gi6addr.addr, 0, 16);
-	}
-
-	return arg_str;
-}
-
-
-/**
- * Parses a argument string for IPv4 booting, extracts all
- * parameters and fills a structure accordingly
- *
- * @param  arg_str        string with arguments, separated with ','
- * @param  argc           number of arguments
- * @param  obp_tftp_args  structure which contains the result
- * @return                updated arg_str
- */
-static const char * 
-parse_ipv4args (const char *arg_str, unsigned int argc,
-		obp_tftp_args_t *obp_tftp_args)
-{
-	char *ptr = NULL;
-	char arg_buf[100];
-
-	// find out siaddr
-	if(argc==0) {
-		memset(obp_tftp_args->siaddr, 0, 4);
-	} else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if(strtoip(arg_buf, obp_tftp_args->siaddr)) {
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else if(arg_buf[0] == 0) {
-			memset(obp_tftp_args->siaddr, 0, 4);
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else
-			memset(obp_tftp_args->siaddr, 0, 4);
-	}
-
-	// find out filename
-	if(argc==0)
-		obp_tftp_args->filename[0] = 0;
-	else {
-		argncpy(arg_str, 0, obp_tftp_args->filename, 100);
-		for(ptr = obp_tftp_args->filename; *ptr != 0; ++ptr)
-			if(*ptr == '\\')
-				*ptr = '/';
-		arg_str = get_arg_ptr(arg_str, 1);
-		--argc;
-	}
-
-	// find out ciaddr
-	if(argc==0)
-		memset(obp_tftp_args->ciaddr, 0, 4);
-	else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if(strtoip(arg_buf, obp_tftp_args->ciaddr)) {
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else if(arg_buf[0] == 0) {
-			memset(obp_tftp_args->ciaddr, 0, 4);
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else
-			memset(obp_tftp_args->ciaddr, 0, 4);
-	}
-
-	// find out giaddr
-	if(argc==0)
-		memset(obp_tftp_args->giaddr, 0, 4);
-	else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if(strtoip(arg_buf, obp_tftp_args->giaddr)) {
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else if(arg_buf[0] == 0) {
-			memset(obp_tftp_args->giaddr, 0, 4);
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else
-			memset(obp_tftp_args->giaddr, 0, 4);
-	}
-
-	return arg_str;
-}
-
-/**
- * Parses a argument string which is given by netload, extracts all
- * parameters and fills a structure according to this
- *
- * Netload-Parameters:
- *    [bootp,]siaddr,filename,ciaddr,giaddr,bootp-retries,tftp-retries
- *
- * @param  arg_str        string with arguments, separated with ','
- * @param  obp_tftp_args  structure which contains the result
- * @return                none
- */
-static void
-parse_args(const char *arg_str, obp_tftp_args_t *obp_tftp_args)
-{
-	unsigned int argc;
-	char arg_buf[100];
-
-	memset(obp_tftp_args, 0, sizeof(*obp_tftp_args));
-
-	argc = get_args_count(arg_str);
-
-	// find out if we should use BOOTP or DHCP
-	if(argc==0)
-		obp_tftp_args->ip_init = IP_INIT_DEFAULT;
-	else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if (strcasecmp(arg_buf, "bootp") == 0) {
-			obp_tftp_args->ip_init = IP_INIT_BOOTP;
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else if(strcasecmp(arg_buf, "dhcp") == 0) {
-			obp_tftp_args->ip_init = IP_INIT_DHCP;
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-		}
-		else if(strcasecmp(arg_buf, "ipv6") == 0) {
-			obp_tftp_args->ip_init = IP_INIT_DHCPV6_STATELESS;
-			arg_str = get_arg_ptr(arg_str, 1);
-			--argc;
-			ip_version = 6;
-		}
-		else
-			obp_tftp_args->ip_init = IP_INIT_DEFAULT;
-	}
-
-	if (ip_version == 4) {
-		arg_str = parse_ipv4args (arg_str, argc, obp_tftp_args);
-	}
-	else if (ip_version == 6) {
-		arg_str = parse_ipv6args (arg_str, argc, obp_tftp_args);
-	}
-
-	// find out bootp-retries
-	if (argc == 0)
-		obp_tftp_args->bootp_retries = DEFAULT_BOOT_RETRIES;
-	else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if(arg_buf[0] == 0)
-			obp_tftp_args->bootp_retries = DEFAULT_BOOT_RETRIES;
-		else {
-			obp_tftp_args->bootp_retries = strtol(arg_buf, 0, 10);
-			if(obp_tftp_args->bootp_retries < 0)
-				obp_tftp_args->bootp_retries = DEFAULT_BOOT_RETRIES;
-		}
-		arg_str = get_arg_ptr(arg_str, 1);
-		--argc;
-	}
-
-	// find out tftp-retries
-	if (argc == 0)
-		obp_tftp_args->tftp_retries = DEFAULT_TFTP_RETRIES;
-	else {
-		argncpy(arg_str, 0, arg_buf, 100);
-		if(arg_buf[0] == 0)
-			obp_tftp_args->tftp_retries = DEFAULT_TFTP_RETRIES;
-		else {
-			obp_tftp_args->tftp_retries = strtol(arg_buf, 0, 10);
-			if(obp_tftp_args->tftp_retries < 0)
-				obp_tftp_args->tftp_retries = DEFAULT_TFTP_RETRIES;
-		}
-		arg_str = get_arg_ptr(arg_str, 1);
-		--argc;
-	}
+	puts(buf);
 }
 
 /**
@@ -361,10 +100,6 @@ int dhcp(char *ret_buffer, struct filename_ip *fn_ip, unsigned int retries,
 
 	do {
 		printf("\b\b\b%03d", i-1);
-		if (getchar() == 27) {
-			printf("\nAborted\n");
-			return -1;
-		}
 		if (!--i) {
 			printf("\nGiving up after %d DHCP requests\n", retries);
 			return -1;
@@ -396,9 +131,9 @@ int dhcp(char *ret_buffer, struct filename_ip *fn_ip, unsigned int retries,
  */
 static void seed_rng(uint8_t mac[])
 {
-	unsigned int seed;
+	uint64_t seed;
 
-	asm volatile("mftbl %0" : "=r"(seed));
+	asm volatile(" stck %0 " : : "Q"(seed) : "memory");
 	seed ^= (mac[2] << 24) | (mac[3] << 16) | (mac[4] << 8) | mac[5];
 	srand(seed);
 }
@@ -445,7 +180,7 @@ static int tftp_load(filename_ip_t *fnip, unsigned char *buffer, int len,
 		netload_error(0x3018, "file exceeds maximum TFTP transfer size");
 		return -117;
 	} else if (rc <= -10 && rc >= -15) {
-		char *icmp_err_str;
+		const char *icmp_err_str;
 		switch (rc) {
 		case -ICMP_NET_UNREACHABLE - 10:
 			icmp_err_str = "net unreachable";
@@ -492,8 +227,7 @@ static int tftp_load(filename_ip_t *fnip, unsigned char *buffer, int len,
 	return rc;
 }
 
-int netload(char *buffer, int len, char *ret_buffer, int huge_load,
-	    int block_size, char *args_fs, int alen)
+int netload(char *buffer, int len, char *ret_buffer)
 {
 	int rc;
 	filename_ip_t fn_ip;
@@ -524,10 +258,6 @@ int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 		fd_device = socket(0, 0, 0, (char*) own_mac);
 		if(fd_device != -2)
 			break;
-		if(getchar() == 27) {
-			fd_device = -2;
-			break;
-		}
 	}
 
 	if (fd_device == -1) {
@@ -551,27 +281,10 @@ int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 
 	seed_rng(own_mac);
 
-	if (alen > 0) {
-		char args[256];
-		if (alen > sizeof(args) - 1) {
-			puts("ERROR: Parameter string is too long.");
-			return -7;
-		}
-		/* Convert forth string into NUL-terminated C-string */
-		strncpy(args, args_fs, alen);
-		args[alen] = 0;
-		parse_args(args, &obp_tftp_args);
-		if(obp_tftp_args.bootp_retries - rc < DEFAULT_BOOT_RETRIES)
-			obp_tftp_args.bootp_retries = DEFAULT_BOOT_RETRIES;
-		else
-			obp_tftp_args.bootp_retries -= rc;
-	}
-	else {
-		memset(&obp_tftp_args, 0, sizeof(obp_tftp_args_t));
-		obp_tftp_args.ip_init = IP_INIT_DEFAULT;
-		obp_tftp_args.bootp_retries = DEFAULT_BOOT_RETRIES;
-		obp_tftp_args.tftp_retries = DEFAULT_TFTP_RETRIES;
-	}
+	memset(&obp_tftp_args, 0, sizeof(obp_tftp_args_t));
+	obp_tftp_args.ip_init = IP_INIT_DEFAULT;
+	obp_tftp_args.bootp_retries = DEFAULT_BOOT_RETRIES;
+	obp_tftp_args.tftp_retries = DEFAULT_TFTP_RETRIES;
 	memcpy(&fn_ip.own_ip, obp_tftp_args.ciaddr, 4);
 
 	//  reset of error code
@@ -602,20 +315,6 @@ int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 
 	// construction of fn_ip from parameter
 	switch(obp_tftp_args.ip_init) {
-	case IP_INIT_BOOTP:
-		// if giaddr in not specified, then we have to identify
-		// the BOOTP server via broadcasts
-		if(memcmp(obp_tftp_args.giaddr, null_ip, 4) == 0) {
-			// don't do this, when using DHCP !!!
-			fn_ip.server_ip = 0xFFFFFFFF;
-		}
-		// if giaddr is specified, then we have to use this
-		// IP address as proxy to identify the BOOTP server
-		else {
-			memcpy(&fn_ip.server_ip, obp_tftp_args.giaddr, 4);
-		}
-		rc = bootp(ret_buffer, &fn_ip, obp_tftp_args.bootp_retries);
-		break;
 	case IP_INIT_DHCP:
 		rc = dhcp(ret_buffer, &fn_ip, obp_tftp_args.bootp_retries, F_IPV4);
 		break;
diff --git a/pc-bios/s390-ccw/libnet/tftp.c b/pc-bios/s390-ccw/libnet/tftp.c
index d0c2f13..34f448c 100644
--- a/pc-bios/s390-ccw/libnet/tftp.c
+++ b/pc-bios/s390-ccw/libnet/tftp.c
@@ -265,7 +265,7 @@ static void print_progress(int urgent, int received_bytes)
 			sprintf(buffer, "%d KBytes", (progress_last_bytes >> 10));
 			for(ptr = buffer; *ptr != 0; ++ptr)
 				*ptr = '\b';
-			printf(buffer);
+			printf("%s", buffer);
 		}
 		printf("%d KBytes", (received_bytes >> 10));
 		i = 1;
-- 
1.8.3.1
