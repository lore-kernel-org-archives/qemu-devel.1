Received: from eggs.gnu.org ([2001:4830:134:3::10]:52739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fOadK-0006cS-Ey
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fOadH-0007Sp-6W
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:21:42 -0400
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
	<1527671818-23809-3-git-send-email-thuth@redhat.com>
	<9b84d9e4-f7b8-dd5b-3180-551047879eab@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0eaa6943-57a8-3dec-18e5-5e498dd06e6a@redhat.com>
Date: Fri, 1 Jun 2018 05:21:32 +0200
MIME-Version: 1.0
In-Reply-To: <9b84d9e4-f7b8-dd5b-3180-551047879eab@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

On 31.05.2018 23:25, Farhan Ali wrote:
>=20
>=20
> On 05/30/2018 05:16 AM, Thomas Huth wrote:
>> Since it is quite cumbersome to manually create a combined kernel with
>> initrd image for network booting, we now support loading via pxelinux
>> configuration files, too. In these files, the kernel, initrd and comma=
nd
>> line parameters can be specified seperately, and the firmware then tak=
es
>> care of glueing everything together in memory after the files have bee=
n
>> downloaded. See this URL for details about the config file layout:
>> https://www.syslinux.org/wiki/index.php?title=3DPXELINUX
>>
>> The user can either specify a config file directly as bootfile via DHC=
P
>> (but in this case, the file has to start either with "default" or a "#=
"
>> comment so we can distinguish it from binary kernels), or a folder (i.=
e.
>> the bootfile name must end with "/") where the firmware should look fo=
r
>> the typical pxelinux.cfg file names, e.g. based on MAC or IP address.
>> We also support the pxelinux.cfg DHCP options 209 and 210 from RFC 507=
1.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 pc-bios/s390-ccw/netboot.mak |=C2=A0 7 ++--
>> =C2=A0 pc-bios/s390-ccw/netmain.c=C2=A0=C2=A0 | 79
>> +++++++++++++++++++++++++++++++++++++++++++-
>> =C2=A0 2 files changed, 82 insertions(+), 4 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.m=
ak
>> index a73be36..8af0cfd 100644
>> --- a/pc-bios/s390-ccw/netboot.mak
>> +++ b/pc-bios/s390-ccw/netboot.mak
>> @@ -25,8 +25,9 @@ CTYPE_OBJS =3D isdigit.o isxdigit.o toupper.o
>> =C2=A0 %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call quiet-command,$(CC) $(LIBC_CFLAG=
S) -c -o $@
>> $<,"CC","$(TARGET_DIR)$@")
>> =C2=A0 -STRING_OBJS =3D strcat.o strchr.o strcmp.o strcpy.o strlen.o
>> strncmp.o strncpy.o \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strstr.o memse=
t.o memcpy.o memmove.o memcmp.o
>> +STRING_OBJS =3D strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy=
.o \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcmp.o strnc=
mp.o strcasecmp.o strncasecmp.o strstr.o \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset.o memcp=
y.o memmove.o memcmp.o
>> =C2=A0 %.o : $(SLOF_DIR)/lib/libc/string/%.c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call quiet-command,$(CC) $(LIBC_CFLAG=
S) -c -o $@
>> $<,"CC","$(TARGET_DIR)$@")
>> =C2=A0 @@ -50,7 +51,7 @@ libc.a: $(LIBCOBJS)
>> =C2=A0 # libnet files:
>> =C2=A0 =C2=A0 LIBNETOBJS :=3D args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.=
o udp.o
>> bootp.o \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dhcpv6.o ether=
net.o ipv4.o ndp.o tftp.o
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dhcpv6.o ether=
net.o ipv4.o ndp.o tftp.o pxelinux.o
>> =C2=A0 LIBNETCFLAGS :=3D $(QEMU_CFLAGS) -DDHCPARCH=3D0x1F $(LIBC_INC)
>> $(LIBNET_INC)
>> =C2=A0 =C2=A0 %.o : $(SLOF_DIR)/lib/libnet/%.c
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index 7533cf7..e84bb2b 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -30,6 +30,7 @@
>> =C2=A0 #include <ipv6.h>
>> =C2=A0 #include <dns.h>
>> =C2=A0 #include <time.h>
>> +#include <pxelinux.h>
>> =C2=A0 =C2=A0 #include "s390-ccw.h"
>> =C2=A0 #include "virtio.h"
>> @@ -41,12 +42,14 @@ extern char _start[];
>> =C2=A0 =C2=A0 #define KERNEL_ADDR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((void *)0L)
>> =C2=A0 #define KERNEL_MAX_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ((long)_start)
>> +#define ARCH_COMMAND_LINE_SIZE=C2=A0 896=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Taken from Linux
>> kernel */
>> =C2=A0 =C2=A0 char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SI=
ZE)));
>> =C2=A0 IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
>> =C2=A0 static char cfgbuf[2048];
>> =C2=A0 =C2=A0 static SubChannelId net_schid =3D { .one =3D 1 };
>> +static uint8_t mac[6];
>> =C2=A0 static uint64_t dest_timer;
>> =C2=A0 =C2=A0 static uint64_t get_timer_ms(void)
>> @@ -158,7 +161,6 @@ static int tftp_load(filename_ip_t *fnip, void
>> *buffer, int len)
>> =C2=A0 =C2=A0 static int net_init(filename_ip_t *fn_ip)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 uint8_t mac[6];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(fn_ip, 0, sizeof(filename=
_ip_t));
>> @@ -233,6 +235,66 @@ static void net_release(filename_ip_t *fn_ip)
>> =C2=A0 }
>> =C2=A0 =C2=A0 /**
>> + * Load a kernel with initrd (i.e. with the information that we've
>> got from
>> + * a pxelinux.cfg config file)
>> + */
>> +static int load_kernel_with_initrd(filename_ip_t *fn_ip,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pl_cf=
g_entry *entry)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int rc;
>> +
>> +=C2=A0=C2=A0=C2=A0 printf("Loading pxelinux.cfg entry '%s'\n", entry-=
>label);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!entry->kernel) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Kernel entry is mi=
ssing!\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 strncpy(fn_ip->filename, entry->kernel, sizeof(fn_=
ip->filename));
>> +=C2=A0=C2=A0=C2=A0 rc =3D tftp_load(fn_ip, KERNEL_ADDR, KERNEL_MAX_SI=
ZE);
>> +=C2=A0=C2=A0=C2=A0 if (rc < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (entry->initrd) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t iaddr =3D (rc + 0=
xfff) & ~0xfffUL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(fn_ip->filename, e=
ntry->initrd,
>> sizeof(fn_ip->filename));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D tftp_load(fn_ip, (v=
oid *)iaddr, KERNEL_MAX_SIZE - iaddr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn rc;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Patch location and size=
: */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(uint64_t *)0x10408 =3D i=
addr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(uint64_t *)0x10410 =3D r=
c;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc +=3D iaddr;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (entry->append) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy((char *)0x10480, e=
ntry->append, ARCH_COMMAND_LINE_SIZE);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return rc;
>> +}
>> +
>> +#define MAX_PXELINUX_ENTRIES 16
>> +
>> +static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
>> +=C2=A0=C2=A0=C2=A0 int num_ent, def_ent =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 num_ent =3D pxelinux_load_parse_cfg(fn_ip, mac, NU=
LL,
>> DEFAULT_TFTP_RETRIES,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cfgbuf, sizeof(cfgbuf),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 entries, MAX_PXELINUX_ENTRIES,
>> &def_ent);
>=20
> Just a question do we want to clear cfgbuf here, before calling
> pxelinux_load_parse_cfg?

That's theoretically not necessary. The buffer either gets populated
with data, or the function errors out. The code also makes sure that
there is a final NUL-character in the buffer:

https://github.com/aik/SLOF/blob/64c526a/lib/libnet/pxelinux.c#L169

... but I think I've got to double check that there is also a
NUL-character immediately at the end of the downloaded data ... so
there's indeed a change required, but likely rather in the SLOF code
than here.

 Thomas
