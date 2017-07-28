Received: from eggs.gnu.org ([2001:4830:134:3::10]:45210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1mc-0004Hw-Nj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1mZ-00055N-DW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db1mZ-00054i-3u
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:42:07 -0400
Date: Fri, 28 Jul 2017 11:41:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728114159.519eacf4@gondolin>
In-Reply-To: <20170728085547.13947-1-vsementsov@virtuozzo.com>
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On Fri, 28 Jul 2017 11:55:47 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> To make logs more readable prefix all hex values with '0x' mark.
> This is needed for consistency too, as a lot of hex values are already
> prefixed with '0x'. Also, bring all hex outputs to the common form -
> use '%#', not '0x%'.

This is problematic if you try to match up things in the trace with
things that don't have the leading 0x elsewhere. See my comments on the
s390x changes below.

> 
> This patch is done by two commands:
> find . -name trace-events | \
>  xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\)\)/%#\1/g'
> find . -name trace-events | xargs sed -i 's/0x%#/%#/g'
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
> index f07e974678..a18679c5cf 100644
> --- a/hw/s390x/trace-events
> +++ b/hw/s390x/trace-events
> @@ -2,15 +2,15 @@
>  
>  # hw/s390x/css.c
>  css_enable_facility(const char *facility) "CSS: enable %s"
> -css_crw(uint8_t rsc, uint8_t erc, uint16_t rsid, const char *chained) "CSS: queueing crw: rsc=%x, erc=%x, rsid=%x %s"
> -css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02x (type %02x)"
> -css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %02x %s"
> -css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
> -css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm %08x, isc %x) %s"
> -css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x)"
> -css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode %x on isc %x"
> +css_crw(uint8_t rsc, uint8_t erc, uint16_t rsid, const char *chained) "CSS: queueing crw: rsc=%#x, erc=%#x, rsid=%#x %s"

ok

> +css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %#x.%#02x (type %#02x)"

Not ok. This is supposed to mimic the identifier used in the Linux
kernel (sysfs and elsewhere), which is of the form 0.42. (Changing type
is fine.)

> +css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %#02x %s"

ok

> +css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %#x.%#x.%#04x (devno %#04x)"

Again, not ok. This is a bus id, which uses the form fe.1.4711 and is
used both on the command line and in the Linux kernel. Changing devno
is debatable.

> +css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %#x.%#x.%#04x (intparm %#08x, isc %#x) %s"

Again x.y.zzzz bus id. intparm is ok, isc is a value in the 0..7 range,
so not really useful, but does not hurt.

> +css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %#x)"

Dito on the isc, but does not really hurt.

> +css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode %#x on isc %#x"

Dito on the isc, mode is fine.

>  
>  # hw/s390x/virtio-ccw.c
> -virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
> -virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno %04x (%s)"
> -virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": %x->%x"
> +virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %#x.%#x.%#04x: interpret command %#x"

x.y.zzzz bus id, cmd_code is ok

> +virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %#x.%#x.%#04x, devno %#04x (%s)"

x.y.zzzz bus id, devno debatable

> +virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": %#x->%#x"

ok

>
> diff --git a/target/s390x/trace-events b/target/s390x/trace-events
> index 1574033e31..95a19ecf75 100644
> --- a/target/s390x/trace-events
> +++ b/target/s390x/trace-events
> @@ -6,9 +6,9 @@ set_skeys_nonzero(int rc) "SKEY: Call to set_skeys unexpectedly returned %d"
>  
>  # target/s390x/ioinst.c
>  ioinst(const char *insn) "IOINST: %s"
> -ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
> -ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
> -ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %04x, len %04x"
> +ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%#x.%#x.%#04x)"

x.y.zzzz bus id

> +ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%#x.%#02x)"

m.nn bus id

> +ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %#04x, len %#04x"

ok

>  
>  # target/s390x/kvm.c
>  kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
