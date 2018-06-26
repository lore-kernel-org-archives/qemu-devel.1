Received: from eggs.gnu.org ([2001:4830:134:3::10]:48006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXiQt-0005hU-Jp
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXiQp-0001sp-Kv
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:30:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fXiQp-0001pk-Bd
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:30:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5Q7TeMY131843
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 03:30:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jugf21uxh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 03:30:27 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Jun 2018 08:30:24 +0100
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
	<cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
	<patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Jun 2018 09:30:19 +0200
MIME-Version: 1.0
In-Reply-To: <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
Content-Language: en-US
Message-Id: <7cb526fc-9da4-248b-d5c4-cb463a2c2bac@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] s390/boot: block uncompressed vmlinux
 booting attempts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vasily Gorbik <gor@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>



On 06/25/2018 05:09 PM, Vasily Gorbik wrote:
> Since uncompressed kernel image "vmlinux" elf file is not bootable under
> qemu anymore, add a check which would report that.
> 
> Qemu users are encouraged to use bzImage or
> arch/s390/boot/compressed/vmlinux instead.
> 
> The check relies on s390 linux entry point ABI definition, which is only
> present in bzImage and arch/s390/boot/compressed/vmlinux.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

some proposals regarding the wording below..

[...]
> +
> +	sclp_early_printk("The linux kernel boot failure: the image is corrupted or not bootable.\n");
> +	sclp_early_printk("Please check that you are using bootable kernel image \"bzImage\".\n");
> +	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinux\" image for qemu)\n");

What about making this explain things a bit more, e.g. something like

Linux kernel boot failure: The boot image does not contain all necessary
components (like the entry point and decompressor). The plain vmlinux ELF
file no longer carries all necessary parts for starting up. Please use
bzImage or arch/s390/boot/compressed/vmlinux.
