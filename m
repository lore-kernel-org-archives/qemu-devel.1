Received: from eggs.gnu.org ([2001:4830:134:3::10]:33875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1e7oiH-000452-Jy
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1e7oiE-0000Ve-9S
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:25:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1e7oiE-0000TP-3W
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:25:10 -0400
References: <1509043965-5852-1-git-send-email-walling@linux.vnet.ibm.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <5edd8fdc-e2b2-2112-afaf-30b63e738e33@suse.de>
Date: Thu, 26 Oct 2017 22:25:03 +0200
MIME-Version: 1.0
In-Reply-To: <1509043965-5852-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390-ccw: print carriage return with
 new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, rth@twiddle.net



On 26.10.17 20:52, Collin L. Walling wrote:
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
>  pc-bios/s390-ccw/sclp.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 486fce1..f8ad5ae 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -68,17 +68,27 @@ void sclp_setup(void)
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
> +    for (i = len; i > 0; i--) {

Where did the bounds check go? If you write(max) before, you were
writing max bytes. If you do it now, you end up writing max + n bytes
and potentially overflow the array, no?


Alex

> +        if (*p == '\n') {
> +            sccb->data[data_len++] = '\r';
> +        }
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
> 
