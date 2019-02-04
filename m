Received: from eggs.gnu.org ([209.51.188.92]:51372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqcPR-00059r-LQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqcMo-0004hm-Vd
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:24:48 -0500
Date: Mon, 4 Feb 2019 12:24:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204122437.58ebdba9.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/15] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:17 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add struct for format-0 ccws. Support executing format-0 channel
> programs and waiting for their completion before continuing execution.
> This will be used for real dasd ipl.
> 
> Add cu_type() to channel io library. This will be used to query control
> unit type which is used to determine if we are booting a virtio device or a
> real dasd device.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c      | 114 +++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h      | 127 ++++++++++++++++++++++++++++++++++++++++++--
>  pc-bios/s390-ccw/s390-ccw.h |   1 +
>  pc-bios/s390-ccw/start.S    |  33 +++++++++++-
>  4 files changed, 270 insertions(+), 5 deletions(-)

> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index 7b07d75..1086f31 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
> @@ -70,9 +70,46 @@ struct scsw {
>      __u16 count;
>  } __attribute__ ((packed));
>  
> -#define SCSW_FCTL_CLEAR_FUNC 0x1000
> -#define SCSW_FCTL_HALT_FUNC 0x2000
> +/* Function Control */
>  #define SCSW_FCTL_START_FUNC 0x4000
> +#define SCSW_FCTL_HALT_FUNC 0x2000
> +#define SCSW_FCTL_CLEAR_FUNC 0x1000
> +
> +/* Activity Control */
> +#define SCSW_ACTL_RESUME_PEND   0x0800
> +#define SCSW_ACTL_START_PEND    0x0400
> +#define SCSW_ACTL_HALT_PEND     0x0200
> +#define SCSW_ACTL_CLEAR_PEND    0x0100
> +#define SCSW_ACTL_CH_ACTIVE     0x0080
> +#define SCSW_ACTL_DEV_ACTIVE    0x0040
> +#define SCSW_ACTL_SUSPENDED     0x0020
> +
> +/* Status Control */
> +#define SCSW_SCTL_ALERT         0x0010
> +#define SCSW_SCTL_INTERMED      0x0008
> +#define SCSW_SCTL_PRIMARY       0x0004
> +#define SCSW_SCTL_SECONDARY     0x0002
> +#define SCSW_SCTL_STATUS_PEND   0x0001
> +
> +/* SCSW Device Status Flags */
> +#define SCSW_DSTAT_ATTN     0x80
> +#define SCSW_DSTAT_STATMOD  0x40
> +#define SCSW_DSTAT_CUEND    0x20
> +#define SCSW_DSTAT_BUSY     0x10
> +#define SCSW_DSTAT_CHEND    0x08
> +#define SCSW_DSTAT_DEVEND   0x04
> +#define SCSW_DSTAT_UCHK     0x02
> +#define SCSW_DSTAT_UEXCP    0x01
> +
> +/* SCSW Subchannel Status Flags */
> +#define SCSW_CSTAT_PCINT    0x80
> +#define SCSW_CSTAT_BADLEN   0x40
> +#define SCSW_CSTAT_PROGCHK  0x20
> +#define SCSW_CSTAT_PROTCHK  0x10
> +#define SCSW_CSTAT_CHDCHK   0x08
> +#define SCSW_CSTAT_CHCCHK   0x04
> +#define SCSW_CSTAT_ICCHK    0x02
> +#define SCSW_CSTAT_CHAINCHK 0x01

Any reason you're not following the Linux kernel definitions here?
Might make it easier for folks familiar with the kernel implementation.

>  
>  /*
>   * subchannel information block

(...)

> +/* basic sense response buffer layout */
> +typedef struct sense_data_eckd_dasd {
> +    uint8_t common_status;
> +    uint8_t status[2];
> +    uint8_t res_count;
> +    uint8_t phys_drive_id;
> +    uint8_t low_cyl_addr;
> +    uint8_t head_high_cyl_addr;
> +    uint8_t fmt_msg;
> +    uint64_t fmt_dependent_info[2];
> +    uint8_t reserved;
> +    uint8_t program_action_code;
> +    uint16_t config_info;
> +    uint8_t mcode_hicyl;
> +    uint8_t cyl_head_addr[3];
> +}  __attribute__ ((packed, aligned(4))) sense_data_eckd_dasd;

SenseDataEckdDasd would be more QEMU-y.

> +
> +#define ECKD_SENSE24_GET_FMT(sd)     (sd->fmt_msg & 0xF0 >> 4)
> +#define ECKD_SENSE24_GET_MSG(sd)     (sd->fmt_msg & 0x0F)
> +
> +#define unit_check(irb)         ((irb)->scsw.dstat & SCSW_DSTAT_UCHK)
> +#define iface_ctrl_check(irb)   ((irb)->scsw.cstat & SCSW_CSTAT_ICCHK)
> +
>  /* interruption response block */
>  typedef struct irb {
>      struct scsw scsw;

(...)

> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index eb8d024..22b38ec 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -65,12 +65,32 @@ consume_sclp_int:
>          /* prepare external call handler */
>          larl %r1, external_new_code
>          stg %r1, 0x1b8
> -        larl %r1, external_new_mask
> +        larl %r1, int_new_mask

Isn't that for external interrupts?

>          mvc 0x1b0(8),0(%r1)
>          /* load enabled wait PSW */
>          larl %r1, enabled_wait_psw
>          lpswe 0(%r1)
>  
> +/*
> + * void consume_io_int(void)
> + *
> + * eats one I/O interrupt
> + */
> +        .globl consume_io_int
> +consume_io_int:
> +        /* enable I/O interrupts in cr6 */
> +        stctg 6,6,0(15)
> +        oi 4(15), 0xff
> +        lctlg 6,6,0(15)
> +        /* prepare i/o call handler */
> +        larl %r1, io_new_code
> +        stg %r1, 0x1f8
> +        larl %r1, int_new_mask
> +        mvc 0x1f0(8),0(%r1)
> +        /* load enabled wait PSW */
> +        larl %r1, enabled_wait_psw
> +        lpswe 0(%r1)
> +
>  external_new_code:
>          /* disable service interrupts in cr0 */
>          stctg 0,0,0(15)
> @@ -78,10 +98,19 @@ external_new_code:
>          lctlg 0,0,0(15)
>          br 14
>  
> +io_new_code:
> +        /* disable I/O interrupts in cr6 */
> +        stctg 6,6,0(15)
> +        ni 4(15), 0x00
> +        lctlg 6,6,0(15)

What about leaving the isc enabled in cr6 all the time and just
controlling interrupts via enabling/disabling I/O interrupts?

> +        br 14
> +
> +
> +
>          .align  8
>  disabled_wait_psw:
>          .quad   0x0002000180000000,0x0000000000000000
>  enabled_wait_psw:
>          .quad   0x0302000180000000,0x0000000000000000
> -external_new_mask:
> +int_new_mask:

Ah, I see. But I'd probably have two masks instead.

>          .quad   0x0000000180000000
