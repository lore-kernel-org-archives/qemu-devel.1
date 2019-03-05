Received: from eggs.gnu.org ([209.51.188.92]:48319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h14ZU-0000UU-SQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h14ZU-0008OX-4f
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:33:04 -0500
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-11-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6127a424-50cc-7a8a-3142-4797127f9282@redhat.com>
Date: Tue, 5 Mar 2019 08:32:59 +0100
MIME-Version: 1.0
In-Reply-To: <1551466776-29123-11-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 10/16] s390-bios: Support
 for running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 01/03/2019 19.59, Jason J. Herne wrote:
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
[...]
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 5c22cb0..2b4ea4c 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -71,6 +71,26 @@ consume_sclp_int:
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

Could you please use %-register names? If we ever want to compile the
code with Clang again, this will likely be required (see commit
0d3a76139827f7d08f1b for example). I.e.:

        stctg   %c6,%c6,0(%r15)
        oi      4(%r15),0xff
        lctlg   %c6,%c6,0(%r15)

(indenting the parameters of the instruction would also be nice)

> +        /* prepare i/o call handler */
> +        larl %r1, io_new_code
> +        stg %r1, 0x1f8
> +        larl %r1, io_new_mask
> +        mvc 0x1f0(8),0(%r1)
> +        /* load enabled wait PSW */
> +        larl %r1, enabled_wait_psw
> +        lpswe 0(%r1)
> +
>  external_new_code:
>          /* disable service interrupts in cr0 */
>          stctg   %c0,%c0,0(%r15)
> @@ -78,6 +98,15 @@ external_new_code:
>          lctlg   %c0,%c0,0(%r15)
>          br      %r14
>  
> +io_new_code:
> +        /* disable I/O interrupts in cr6 */
> +        stctg 6,6,0(15)
> +        ni 4(15), 0x00
> +        lctlg 6,6,0(15)

dito

 Thanks,
  Thomas
