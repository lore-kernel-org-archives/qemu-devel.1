Received: from eggs.gnu.org ([2001:4830:134:3::10]:42816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ewNyE-0006mo-1K
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 04:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ewNy9-0001EN-AY
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 04:10:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ewNy9-0001DH-1t
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 04:10:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2F8A4le021033
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 04:10:35 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gqjjv5f7n-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 04:10:34 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 15 Mar 2018 08:10:32 -0000
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-2-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 15 Mar 2018 09:10:28 +0100
MIME-Version: 1.0
In-Reply-To: <1521100145-15304-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dd517533-9b9a-3e28-9234-4ca04ace0cb5@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/3] tests/boot-sector: Add
 magic bytes to s390x boot code header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>



On 03/15/2018 08:49 AM, Thomas Huth wrote:
> We're going to use the s390x boot code for testing CD-ROM booting.
> But the ISO loader of the s390-ccw bios is a little bit more picky
> than the network loader and expects some magic bytes in the header
> of the file (see linux_s390_magic in pc-bios/s390-ccw/bootmap.c), so
> we've got to add them in our boot code here, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  tests/boot-sector.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/boot-sector.c b/tests/boot-sector.c
> index c373f0e..04721c9 100644
> --- a/tests/boot-sector.c
> +++ b/tests/boot-sector.c
> @@ -68,8 +68,11 @@ static uint8_t x86_boot_sector[512] = {
>  };
> 
>  /* For s390x, use a mini "kernel" with the appropriate signature */
> -static const uint8_t s390x_psw[] = {
> -    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00
> +static const uint8_t s390x_psw_and_magic[] = {
> +    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00,
> +    0x02, 0x00, 0x00, 0x18, 0x60, 0x00, 0x00, 0x50,
> +    0x02, 0x00, 0x00, 0x68, 0x60, 0x00, 0x00, 0x50,
> +    0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
>  };
>  static const uint8_t s390x_code[] = {
>      0xa7, 0xf4, 0x00, 0x0a,                                /* j 0x10010 */
> @@ -110,7 +113,7 @@ int boot_sector_init(char *fname)
>      } else if (g_str_equal(arch, "s390x")) {
>          len = 0x10000 + sizeof(s390x_code);
>          boot_code = g_malloc0(len);
> -        memcpy(boot_code, s390x_psw, sizeof(s390x_psw));
> +        memcpy(boot_code, s390x_psw_and_magic, sizeof(s390x_psw_and_magic));
>          memcpy(&boot_code[0x10000], s390x_code, sizeof(s390x_code));
>      } else {
>          g_assert_not_reached();
> 
