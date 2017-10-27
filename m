Received: from eggs.gnu.org ([2001:4830:134:3::10]:57338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e86je-0000Mj-4x
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e86jb-0006dH-1r
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:39:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50394
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e86ja-0006cr-Rv
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:39:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RFaelP120314
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:39:43 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv3t5dbx3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:39:43 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 16:39:41 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v9RFddAL28311666
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 15:39:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 887C84C04A
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:35:14 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F5CB4C040
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:35:14 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.35])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:35:14 +0100 (BST)
References: <1509114613-10601-1-git-send-email-walling@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 17:39:38 +0200
MIME-Version: 1.0
In-Reply-To: <1509114613-10601-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <5d039f30-4896-fef3-3b1c-a2be4edcf13b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] s390-ccw: print carriage return with
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



On 10/27/2017 04:30 PM, Collin L. Walling wrote:
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
> conversion  in the console part of the driver. 
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
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  pc-bios/s390-ccw/sclp.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 486fce1..a57006e 100644
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
> +    for (i = len; i > 0; i--) > +        if (data_len + 1 >= SCCB_DATA_LEN) {
> +            /* We would overflow the sccb buffer, abort early */
> +            len = i;

This is not correct. Write is supposed to return the number
of bytes written. In this case the number of the bytes of the
original string which have been processed (so the client
code can resume at that place, using the nuber of bytes
transferred via sclp_service_call would be wrong if at least
one \n was processed).

Here you return the number of the bytes remaining, as i goes
from len to 0 and not the other way around. By the way Alex's
version was correct.

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
I would have wrote the loop part like this:
-    sccb->h.length = sizeof(WriteEventData) + len;
+    for (i = 0; i < len; ++i) {
+        if (data_len + 1 >= SCCB_DATA_LEN) {
+            /* We would overflow the sccb buffer, abort early */
+            len = i;
+            break;
+        }
+
+        if (str[i] == '\n') {
+            /* Terminal emulators might need \r\n, so generate it */
+            sccb->data[data_len++] = '\r';
+        }
+
+        sccb->data[data_len++] = str[i];
+    }
+
+    sccb->h.length = sizeof(WriteEventData) + data_len;

This way you don't need p, and the loop steps trough the str indexed by
i while sccb->data is indexed by data_len. data_len is incremented each
time after we have written to the buffer (that's why postfix ++)
and i is incremented on each iteration (that's why normal prefix ++).

Btw I would also rename i to str_i and data_len to data_i to better
reflect this.

The cosmetics aren't important though, so it's probably better to go
with what we have already discussed as Alex's version.

Regards,
Halil
