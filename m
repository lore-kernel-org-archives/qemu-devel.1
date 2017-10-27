Received: from eggs.gnu.org ([2001:4830:134:3::10]:43312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1e8BBr-0007cN-J7
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1e8BBo-0003uc-Ex
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:25:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54596
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1e8BBo-0003tJ-8e
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:25:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RKOp5t142817
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:25:08 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv8bdhb8q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:25:08 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 16:25:06 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
	[9.57.199.111])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v9RKP3AG64028922
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 20:25:03 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C316AC03A
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:25:49 -0400 (EDT)
Received: from [9.12.80.228] (unknown [9.12.80.228])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 10E27AC041
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:25:49 -0400 (EDT)
References: <1509120893-28054-1-git-send-email-walling@linux.vnet.ibm.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 16:25:03 -0400
MIME-Version: 1.0
In-Reply-To: <1509120893-28054-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <999f9963-7f3a-4848-b0c6-ccc9a9c23538@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4] s390-ccw: print carriage return with
 new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 10/27/2017 12:14 PM, Collin L. Walling wrote:
> The sclp console in the s390 bios writes raw data,
> leading console emulators (such as virsh console) to
> treat a new line ('\n') as just a new line instead
> of as a Unix line feed. Because of this, output
> appears in a "stair case" pattern.
>
> Let's print \r\n on every occurrence of a new line
> in the string passed to write to amend this issue.
>
> This is in sync with the guest Linux code in
> drivers/s390/char/sclp_vt220.c which also does a line feed
> conversion in the console part of the driver.
>
> This fixes the s390-ccw and s390-netboot output like
> $ virsh start test --console
> Domain test started
> Connected to domain test
> Escape character is ^]
> Network boot starting...
>                           Using MAC address: 02:01:02:03:04:05
>                                                                 Requesting information via DHCP:  010
>
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/sclp.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 486fce1..e6a0898 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -68,17 +68,35 @@ void sclp_setup(void)
>  long write(int fd, const void *str, size_t len)
>  {
>      WriteEventData *sccb = (void *)_sccb;
> +    const char *p = str;
> +    size_t data_len = 0;
> +    size_t i;
>
>      if (fd != 1 && fd != 2) {
>          return -EIO;
>      }
>
> -    sccb->h.length = sizeof(WriteEventData) + len;
> +    for (i = 0; i < len; i++) {
> +        if ((data_len + 1) >= SCCB_DATA_LEN) {
> +            /* We would overflow the sccb buffer, abort early */
> +            len = i;
> +            break;
> +        }
> +
> +        if (*p == '\n') {
> +            /* Terminal emulators might need \r\n, so generate it */
> +            sccb->data[data_len++] = '\r';
> +        }
> +
> +        sccb->data[data_len++] = *p;
> +        p++;
> +    }
> +
> +    sccb->h.length = sizeof(WriteEventData) + data_len;
>      sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
> -    sccb->ebh.length = sizeof(EventBufferHeader) + len;
> +    sccb->ebh.length = sizeof(EventBufferHeader) + data_len;
>      sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
>      sccb->ebh.flags = 0;
> -    memcpy(sccb->data, str, len);
>
>      sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>
Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
