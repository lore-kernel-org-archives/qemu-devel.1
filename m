Received: from eggs.gnu.org ([2001:4830:134:3::10]:37338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dTTaw-0007S0-Id
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dTTat-0002w9-Ee
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:46:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45883
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dTTat-0002vv-7P
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:46:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v67DiKo4175978
	for <qemu-devel@nongnu.org>; Fri, 7 Jul 2017 09:46:50 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bj3v7166c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 09:46:50 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 7 Jul 2017 07:46:48 -0600
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-2-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 7 Jul 2017 15:46:41 +0200
MIME-Version: 1.0
In-Reply-To: <1499423224-23060-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <67f92ccb-0bb4-7092-46f7-17adfc097800@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/8] pc-bios/s390-ccw: Move libc
 functions to separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On 07/07/2017 12:26 PM, Thomas Huth wrote:
> The upcoming netboot code will use the libc from SLOF. To be able
> to still use s390-ccw.h there, the libc related functions in this
> header have to be moved to a different location.
> And while we're at it, remove the duplicate memcpy() function from
> sclp.c.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

one suggestion below, but 

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

for change and no change

[...]
> +static inline void *memcpy(void *s1, const void *s2, size_t n)
> +{
> +    uint8_t *p1 = s1;
> +    const uint8_t *p2 = s2;
> +
> +    while (n--) {
> +        p1[n] = p2[n];
> +    }
> +    return s1;
> +}

Not that it matters, and no idea if moving forward like in the for loop below
might allow gcc to generate better code, but a for loop like below will be the 
same direction as the MVC instruction. Can you double check if this generates
better code?

> -static void _memcpy(char *dest, const char *src, int len)
> -{
> -   int i;
> -     for (i = 0; i < len; i++)
> -        dest[i] = src[i];
> -}
> - 
