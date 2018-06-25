Received: from eggs.gnu.org ([2001:4830:134:3::10]:50118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXQaA-0005na-Gf
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXQa6-0000J9-HV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:26:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fXQa6-0000IG-8R
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:26:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PCOO0Z142800
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:26:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jtw0n9c0c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:26:52 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Jun 2018 13:26:49 +0100
References: <20180622194736.GA5794@roeck-us.net>
	<126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
	<88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
	<20180625100548.64222dad.cohuck@redhat.com>
	<your-ad-here.call-01529915788-ext-6027@work.hours>
	<20180625104928.6c4cb239.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Jun 2018 14:26:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180625104928.6c4cb239.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <76740f8f-ef4c-9d11-dae1-192beebff4d8@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] s390 qemu boot failure in -next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>



On 06/25/2018 10:49 AM, Cornelia Huck wrote:
> On Mon, 25 Jun 2018 10:36:33 +0200
> Vasily Gorbik <gor@linux.ibm.com> wrote:
> 
>> This change has been done on purpose. Uncompressed image is not going
>> to be bootable any more. In future the decompressor phase would get
>> more function (early memory detection as an example) and there is no
>> chance to duplicate that code in uncompressed image as well (to keep it
>> bootable on its own). The patch series commit messages contain more
>> technical details.
>>
>> For qemu either bzImage or arch/s390/boot/compressed/vmlinux should be
>> used, which are bootable images.
>>
>> But that's really confusing that uncompressed vmlinux is still kind
>> of booting. May be we should discuss how to avoid this confusion
>> (may be change uncompressed image enty point to a function doing
>> disabled wait with badb007 or smth) and how to encourage people to use
>> arch/s390/boot/compressed/vmlinux instead.
> 
> So, the intention is that you can't boot the uncompressed image
> anywhere? (Was it possible before, e.g. when punching the image under
> z/VM?)

The uncompressed image (the vmlinux file) was never bootable in LPAR or z/VM.
It was just a "nice hack" that QEMU was able to do so. (even qemu on x86 can not
boot the pure vmlinux file as far as I know).

I talked to Vasily and the vmlinux file in the linux source path is just an 
intermediate file. Future changes will happen that will make that ELF file
unsuitable for direct boot anyway (e.g. think about potential ASLR or Kasan
changes).

 If yes, it would make sense to explicitly fence it. But I'm
> worried that it would break previously working setups (did we document
> the purpose of the images anywhere?)
> 


I think by referring to arch/s390/boot/compressed/vmlinux things are probably
good enough. That will still load from 0x10000.

We might still "change" the way that we add the parameters (e.g.
make that not depend on the load address), but looking forward this might
become less important for the "intermediate vmlnux file".
