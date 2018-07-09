Received: from eggs.gnu.org ([2001:4830:134:3::10]:56522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fcTm3-0003D0-Ji
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fcTlz-0001sy-Kj
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:52:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fcTlz-0001ro-C5
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:52:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w69AiOCb112622
	for <qemu-devel@nongnu.org>; Mon, 9 Jul 2018 06:52:02 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k446dqg0w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 06:52:01 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 9 Jul 2018 11:51:58 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 9 Jul 2018 12:51:52 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
Content-Language: en-US
Message-Id: <55ec62d3-6d68-4bbe-4de3-283283b36c01@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 10/15] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com



On 07/05/2018 07:25 PM, Jason J. Herne wrote:
Instead of doing this
> +void await_io_int(uint16_t sch_no)
> +{
> +    /*
> +     * wait_psw and ctl6 must be static to avoid stack allocation as gcc cannot
> +     * align stack variables. The stctg, lctlg and lpswe instructions require
> +     * that their operands be aligned on an 8-byte boundary.
> +    */
> +    static uint64_t ctl6 __attribute__((__aligned__(8)));
> +    static PSW wait_psw;
> +
> +    /* PSW to load when I/O interrupt happens */
> +    lowcore->io_new_psw.mask = PSW_MASK_ZMODE;
> +    lowcore->io_new_psw.addr = (uint64_t)&&IOIntWakeup; /* Wake-up address */
> +
> +    /* Enable io interrupts subclass mask */
> +    asm volatile("stctg 6,6,%0" : "=S" (ctl6) : : "memory");
> +    ctl6 |= 0x00000000FF000000;
> +    asm volatile("lctlg 6,6,%0" : : "S" (ctl6));
> +
> +    /* Set wait psw enabled for io interrupt */
> +    wait_psw.mask = (PSW_MASK_ZMODE | PSW_MASK_IOINT | PSW_MASK_WAIT);
> +    asm volatile("lpswe %0" : : "Q" (wait_psw) : "cc");
> +
> +    panic("await_io_int: lpswe failed!!\n");
> +
> +IOIntWakeup:
> +    /* Should never happen - all other subchannels are disabled by default */
> +    IPL_assert(lowcore->subchannel_nr == sch_no,
> +               "Interrupt from unexpected device");
> +
> +    /* Disable all subclasses of I/O interrupts for this cpu */
> +    asm volatile("stctg 6,6,%0" : "=S" (ctl6) : : "memory");
> +    ctl6 &= ~(0x00000000FF000000);
> +    asm volatile("lctlg 6,6,%0" : : "S" (ctl6));
> +}

Can you please add something like consume_sclp_interrupt in start.S?
Jumping inside a function from an interrupt can mess up the stack
and possibly other things as gcc does not expect this. (you do a
longjmp without doing any precaution)
This might explain why you needed the static hack for the variables.
