Received: from eggs.gnu.org ([2001:4830:134:3::10]:54048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fOV4t-0001Om-FI
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fOV4q-00070h-8v
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:25:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43234
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fOV4q-0006zI-2n
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:25:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4VLNpGI103099
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:25:42 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jap7c6pu1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:25:41 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 31 May 2018 15:25:40 -0600
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
	<1527671818-23809-3-git-send-email-thuth@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 31 May 2018 17:25:34 -0400
MIME-Version: 1.0
In-Reply-To: <1527671818-23809-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9b84d9e4-f7b8-dd5b-3180-551047879eab@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] pc-bios/s390-ccw/net: Add support for
 pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>



On 05/30/2018 05:16 AM, Thomas Huth wrote:
> Since it is quite cumbersome to manually create a combined kernel with
> initrd image for network booting, we now support loading via pxelinux
> configuration files, too. In these files, the kernel, initrd and command
> line parameters can be specified seperately, and the firmware then takes
> care of glueing everything together in memory after the files have been
> downloaded. See this URL for details about the config file layout:
> https://www.syslinux.org/wiki/index.php?title=PXELINUX
> 
> The user can either specify a config file directly as bootfile via DHCP
> (but in this case, the file has to start either with "default" or a "#"
> comment so we can distinguish it from binary kernels), or a folder (i.e.
> the bootfile name must end with "/") where the firmware should look for
> the typical pxelinux.cfg file names, e.g. based on MAC or IP address.
> We also support the pxelinux.cfg DHCP options 209 and 210 from RFC 5071.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/netboot.mak |  7 ++--
>   pc-bios/s390-ccw/netmain.c   | 79 +++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
> index a73be36..8af0cfd 100644
> --- a/pc-bios/s390-ccw/netboot.mak
> +++ b/pc-bios/s390-ccw/netboot.mak
> @@ -25,8 +25,9 @@ CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
>   %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
>   	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
>   
> -STRING_OBJS = strcat.o strchr.o strcmp.o strcpy.o strlen.o strncmp.o strncpy.o \
> -	      strstr.o memset.o memcpy.o memmove.o memcmp.o
> +STRING_OBJS = strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
> +	      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
> +	      memset.o memcpy.o memmove.o memcmp.o
>   %.o : $(SLOF_DIR)/lib/libc/string/%.c
>   	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
>   
> @@ -50,7 +51,7 @@ libc.a: $(LIBCOBJS)
>   # libnet files:
>   
>   LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
> -	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o
> +	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
>   LIBNETCFLAGS := $(QEMU_CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
>   
>   %.o : $(SLOF_DIR)/lib/libnet/%.c
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 7533cf7..e84bb2b 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -30,6 +30,7 @@
>   #include <ipv6.h>
>   #include <dns.h>
>   #include <time.h>
> +#include <pxelinux.h>
>   
>   #include "s390-ccw.h"
>   #include "virtio.h"
> @@ -41,12 +42,14 @@ extern char _start[];
>   
>   #define KERNEL_ADDR             ((void *)0L)
>   #define KERNEL_MAX_SIZE         ((long)_start)
> +#define ARCH_COMMAND_LINE_SIZE  896              /* Taken from Linux kernel */
>   
>   char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
>   IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
>   static char cfgbuf[2048];
>   
>   static SubChannelId net_schid = { .one = 1 };
> +static uint8_t mac[6];
>   static uint64_t dest_timer;
>   
>   static uint64_t get_timer_ms(void)
> @@ -158,7 +161,6 @@ static int tftp_load(filename_ip_t *fnip, void *buffer, int len)
>   
>   static int net_init(filename_ip_t *fn_ip)
>   {
> -    uint8_t mac[6];
>       int rc;
>   
>       memset(fn_ip, 0, sizeof(filename_ip_t));
> @@ -233,6 +235,66 @@ static void net_release(filename_ip_t *fn_ip)
>   }
>   
>   /**
> + * Load a kernel with initrd (i.e. with the information that we've got from
> + * a pxelinux.cfg config file)
> + */
> +static int load_kernel_with_initrd(filename_ip_t *fn_ip,
> +                                   struct pl_cfg_entry *entry)
> +{
> +    int rc;
> +
> +    printf("Loading pxelinux.cfg entry '%s'\n", entry->label);
> +
> +    if (!entry->kernel) {
> +        printf("Kernel entry is missing!\n");
> +        return -1;
> +    }
> +
> +    strncpy(fn_ip->filename, entry->kernel, sizeof(fn_ip->filename));
> +    rc = tftp_load(fn_ip, KERNEL_ADDR, KERNEL_MAX_SIZE);
> +    if (rc < 0) {
> +        return rc;
> +    }
> +
> +    if (entry->initrd) {
> +        uint64_t iaddr = (rc + 0xfff) & ~0xfffUL;
> +
> +        strncpy(fn_ip->filename, entry->initrd, sizeof(fn_ip->filename));
> +        rc = tftp_load(fn_ip, (void *)iaddr, KERNEL_MAX_SIZE - iaddr);
> +        if (rc < 0) {
> +            return rc;
> +        }
> +        /* Patch location and size: */
> +        *(uint64_t *)0x10408 = iaddr;
> +        *(uint64_t *)0x10410 = rc;
> +        rc += iaddr;
> +    }
> +
> +    if (entry->append) {
> +        strncpy((char *)0x10480, entry->append, ARCH_COMMAND_LINE_SIZE);
> +    }
> +
> +    return rc;
> +}
> +
> +#define MAX_PXELINUX_ENTRIES 16
> +
> +static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
> +{
> +    struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
> +    int num_ent, def_ent = 0;
> +
> +    num_ent = pxelinux_load_parse_cfg(fn_ip, mac, NULL, DEFAULT_TFTP_RETRIES,
> +                                      cfgbuf, sizeof(cfgbuf),
> +                                      entries, MAX_PXELINUX_ENTRIES, &def_ent);

Just a question do we want to clear cfgbuf here, before calling 
pxelinux_load_parse_cfg?


Thanks
Farhan

> +    if (num_ent > 0) {
> +        return load_kernel_with_initrd(fn_ip, &entries[def_ent]);
> +    }
> +
> +    return -1;
> +}
> +
> +/**
>    * Load via information from a .INS file (which can be found on CD-ROMs
>    * for example)
>    */
> @@ -301,6 +363,18 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>           if (!strncmp("* ", cfgbuf, 2)) {
>               return handle_ins_cfg(fn_ip, cfgbuf, rc);
>           }
> +        if (!strncasecmp("default", cfgbuf, 7) || !strncmp("# ", cfgbuf, 2)) {
> +            /* Looks like it is a pxelinux.cfg */
> +            struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
> +            int num_ent, def_ent = 0;
> +
> +            num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
> +                                         MAX_PXELINUX_ENTRIES, &def_ent);
> +            if (num_ent <= 0) {
> +                return -1;
> +            }
> +            return load_kernel_with_initrd(fn_ip, &entries[def_ent]);
> +        }
>       }
>   
>       /* Move kernel to right location */
> @@ -406,6 +480,9 @@ void main(void)
>       if (fnlen > 0 && fn_ip.filename[fnlen - 1] != '/') {
>           rc = net_try_direct_tftp_load(&fn_ip);
>       }
> +    if (rc <= 0) {
> +        rc = net_try_pxelinux_cfg(&fn_ip);
> +    }
>   
>       net_release(&fn_ip);
>   
> 
