Received: from eggs.gnu.org ([209.51.188.92]:35739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ghZf2-0000cf-FN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ghZf1-0003sM-NO
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:42:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34682
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ghZf1-0003qM-Iu
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:42:11 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0ACcs1Q130343
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 07:42:09 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2px4m3cftd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 07:42:08 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 10 Jan 2019 12:42:07 -0000
References: <1547123559-30476-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 10 Jan 2019 13:42:02 +0100
MIME-Version: 1.0
In-Reply-To: <1547123559-30476-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <bf13f1ca-f568-8d62-5b01-e5122d160a28@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: Use proper register
 names for Clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org



On 10.01.2019 13:32, Thomas Huth wrote:
> When compiling the s390-ccw firmware with Clang 7.0.1, I get the
> following errors:
> 
> pc-bios/s390-ccw/start.S:62:19: error: invalid use of length addressing
>         stctg 0,0,0(15)
>                   ^
> pc-bios/s390-ccw/start.S:63:12: error: invalid use of length addressing
>         oi 6(15), 0x2
>            ^
> pc-bios/s390-ccw/start.S:64:19: error: invalid use of length addressing
>         lctlg 0,0,0(15)
>                   ^
> pc-bios/s390-ccw/start.S:76:19: error: invalid use of length addressing
>         stctg 0,0,0(15)
>                   ^
> pc-bios/s390-ccw/start.S:77:12: error: invalid use of length addressing
>         ni 6(15), 0xfd
>            ^
> pc-bios/s390-ccw/start.S:78:19: error: invalid use of length addressing
>         lctlg 0,0,0(15)
>                   ^
> pc-bios/s390-ccw/start.S:79:12: error: invalid operand for instruction
>         br 14
>            ^
> 
> Let's use proper register names like in the rest of this file to fix it.

Sad that this does no longer work, but

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/start.S | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index eb8d024..3b7fa3f 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -59,9 +59,9 @@ disabled_wait:
>          .globl consume_sclp_int
>  consume_sclp_int:
>          /* enable service interrupts in cr0 */
> -        stctg 0,0,0(15)
> -        oi 6(15), 0x2
> -        lctlg 0,0,0(15)
> +        stctg   %c0,%c0,0(%r15)
> +        oi      6(%r15),0x2
> +        lctlg   %c0,%c0,0(%r15)
>          /* prepare external call handler */
>          larl %r1, external_new_code
>          stg %r1, 0x1b8
> @@ -73,10 +73,10 @@ consume_sclp_int:
>  
>  external_new_code:
>          /* disable service interrupts in cr0 */
> -        stctg 0,0,0(15)
> -        ni 6(15), 0xfd
> -        lctlg 0,0,0(15)
> -        br 14
> +        stctg   %c0,%c0,0(%r15)
> +        ni      6(%r15),0xfd
> +        lctlg   %c0,%c0,0(%r15)
> +        br      %r14
>  
>          .align  8
>  disabled_wait_psw:
> 
