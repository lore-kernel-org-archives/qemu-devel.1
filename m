Received: from eggs.gnu.org ([2001:4830:134:3::10]:56640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1e8csR-0007My-0z
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 21:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1e8csN-0003g8-5K
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 21:59:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1e8csM-0003cs-UH
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 21:58:59 -0400
References: <1509120893-28054-1-git-send-email-walling@linux.vnet.ibm.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <1ec2c07c-64e5-b779-1f24-c1252730bc22@suse.de>
Date: Sun, 29 Oct 2017 02:58:52 +0100
MIME-Version: 1.0
In-Reply-To: <1509120893-28054-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, rth@twiddle.net



On 27.10.17 18:14, Collin L. Walling wrote:
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

I would probably replace this with str[i] to make it slightly more
readable, but that's just personal preference I think. The resulting
assembly should be identical with any recent compiler.


Reviewed-by: Alexander Graf <agraf@suse.de>

Alex
