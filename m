Received: from eggs.gnu.org ([2001:4830:134:3::10]:49593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEGSt-0008Mz-NG
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEGSq-0002vk-JI
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:48:15 -0400
References: <20180502125221.4877-1-cohuck@redhat.com>
	<cbe7b21c-639c-aa64-4777-03d0aa793ac8@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea05d15c-5aa3-7a73-937f-f6e41893ad85@redhat.com>
Date: Thu, 3 May 2018 10:48:10 -0500
MIME-Version: 1.0
In-Reply-To: <cbe7b21c-639c-aa64-4777-03d0aa793ac8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 05/03/2018 10:25 AM, Farhan Ali wrote:
> On 05/02/2018 08:52 AM, Cornelia Huck wrote:
>> We currently pass an integer as the subcode parameter. However,
>> the upper bits of the register containing the subcode need to
>> be 0, which is not guaranteed unless we explicitly specify the
>> subcode to be an unsigned long value.
>>
>> Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 
>> 308/6")
>> Cc:qemu-stable@nongnu.org
>> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> 
> Sorry for my ignorance, but is there a C standard that says upper bits 
> of an int is not guaranteed to be 0?

We're outside the bounds of the C standard because of the use of asm(). 
The problem here is that the compiler assigning a 32-bit int into a 
64-bit register uses the shortest sequence possible (leaving the upper 
64 bits garbage), because the compiler assumes you correctly wrote the 
assembly to only use 32-bit operations on that register (which don't 
care about the upper bits).  By using an unsigned long (a 64-bit value), 
the compiler instead emits assembly to write the full 64-bit register 
value, rather than leaving the upper bits as garbage; and this matters 
because we are subsequently using all 64 bits of the register in a later 
operation.  We could also use a signed long, even long long, or written 
it as: (store ? 6ULL : 5ULL) instead of using a temporary variable.  The 
crux of the fix is that you have to tell asm() that you want a 64-bit 
value written (the unpatched (store ? 6 : 5) is only a 32-bit value), 
and not whether that value is signed or unsigned (since the 
representation of both 6 and 5 are the same regardless of whether the 
type being written into the register is signed or not).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
