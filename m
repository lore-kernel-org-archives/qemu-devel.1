Received: from eggs.gnu.org ([2001:4830:134:3::10]:39827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUwBE-0008KE-Ta
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUwB9-0003GP-WE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUwB9-0003G5-NP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:30:19 -0400
Date: Tue, 11 Jul 2017 16:30:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711163011.1e1ddc30@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499781397-19749-10-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
	<1499781397-19749-10-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 09/11] pc-bios/s390-ccw: Add core files
 for the network bootloading program
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Tue, 11 Jul 2017 15:56:35 +0200
Thomas Huth <thuth@redhat.com> wrote:

> This is just a preparation for the next steps: Add a makefile and a
> stripped down copy of pc-bios/s390-ccw/main.c as a basis for the network
> bootloader program, linked against the libc from SLOF already (which we
> will need for SLOF's libnet). The networking code is not included yet.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/Makefile    |  11 +++-
>  pc-bios/s390-ccw/netboot.mak |  41 +++++++++++++
>  pc-bios/s390-ccw/netmain.c   | 137 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+), 2 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/netboot.mak
>  create mode 100644 pc-bios/s390-ccw/netmain.c
> 

> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> new file mode 100644
> index 0000000..d604623
> --- /dev/null
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -0,0 +1,137 @@

(...)

> +static uint64_t get_timer_ms(void)
> +{
> +    uint64_t clk;
> +
> +    asm volatile(" stck %0 " : : "Q"(clk) : "memory");
> +
> +    /* Bit 51 is incrememented each microsecond */

s/incrememented/incremented/

> +    return (clk >> (63 - 51)) / 1000;
> +}

(...)

> +static bool find_net_dev(Schib *schib, int dev_no)
> +{
> +    int i, r;
> +
> +    for (i = 0; i < 0x10000; i++) {
> +        net_schid.sch_no = i;
> +        r = stsch_err(net_schid, schib);
> +        if (r == 3 || r == -EIO) {
> +            break;
> +        }
> +        if (!schib->pmcw.dnv) {
> +            continue;
> +        }
> +        if (!virtio_is_supported(net_schid)) {
> +            continue;
> +        }
> +        if (virtio_get_device_type() != VIRTIO_ID_NET) {
> +            continue;
> +        }
> +        if (dev_no < 0 || schib->pmcw.dev == dev_no) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static void virtio_setup(void)
> +{
> +    Schib schib;
> +    int ssid;
> +    bool found = false;
> +    uint16_t dev_no;
> +
> +    /*
> +     * We unconditionally enable mss support. In every sane configuration,
> +     * this will succeed; and even if it doesn't, stsch_err() can deal
> +     * with the consequences.
> +     */
> +    enable_mss_facility();
> +
> +    if (store_iplb(&iplb)) {
> +        IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
> +        dev_no = iplb.ccw.devno;
> +        debug_print_int("device no. ", dev_no);
> +        net_schid.ssid = iplb.ccw.ssid & 0x3;
> +        debug_print_int("ssid ", net_schid.ssid);
> +        found = find_net_dev(&schib, dev_no);
> +    } else {
> +        for (ssid = 0; ssid < 0x3; ssid++) {
> +            net_schid.ssid = ssid;
> +            found = find_net_dev(&schib, -1);
> +            if (found) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    IPL_assert(found && virtio_get_device_type() == VIRTIO_ID_NET,

Is found && virtio_get_device_type() != VIRTIO_ID_NET even possible?

> +               "No virtio net device found");
> +}

Anyway, otherwise

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
