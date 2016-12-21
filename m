Received: from eggs.gnu.org ([2001:4830:134:3::10]:47337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJlAC-0002lU-F3
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJlA9-0006tG-AZ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:58:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cJlA9-0006sL-4O
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:58:49 -0500
References: <20161216152319.12494-1-leif.lindholm@linaro.org>
	<20161221115102.251224b8@nial.brq.redhat.com>
	<20161221123509.GC16872@bivouac.eciton.net>
	<20161221145934.219d73fd@nial.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0a8813e-1407-f6a7-a70e-387071aed93a@redhat.com>
Date: Wed, 21 Dec 2016 18:58:44 +0100
MIME-Version: 1.0
In-Reply-To: <20161221145934.219d73fd@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] smbios: stop ignoring command line options
 for TARGET_ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Leif Lindholm <leif.lindholm@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org



On 21/12/2016 14:59, Igor Mammedov wrote:
>> Apparently a misunderstanding of the underlying command line handling
>> mechanics.
>>
>>> Also this patch would break build for targets that don't link smbios.c
>>> (i.e. which don't have CONFIG_SMBIOS=y)  
>> 
>> Ah, I hadn't spotted that - apologies.
> 
> Just do 1 build for all targets before posting patches to avoid
> such kind of errors.
> 
>> So a simpler, and more correct fix would rather be to change the
>> #ifdef TARGET_I386
>> in arch_init.c to
>> #ifdef CONFIG_SMBIOS
> 
> it looks better to me than enumerating targets explicitly,
> CCing Paolo for another opinion

I don't think CONFIG_SMBIOS is visible from C, is it?

However, the solution is to:

1) add a smbios-stub.c file to hw/smbios, containing a dummy
implementation of smbios_entry_add.  For the Makefile magic see
hw/pci/Makefile.objs.

2) add an Error * argument to smbios_entry_add, and make the stub
version fail

3) remove do_smbios_option altogether, and make vl.c call
smbios_entry_add directly.

Paolo
