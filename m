Received: from eggs.gnu.org ([2001:4830:134:3::10]:45284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLp2v-0000Aq-Bk
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLp2r-0002bQ-4b
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:04:09 -0400
References: <1496931482-29914-1-git-send-email-thuth@redhat.com>
	<4b0ebafd-46da-3ec9-7a43-c008ba90b32b@redhat.com>
	<0c96c64b-20ef-c0ef-3206-2a4ff713f6d9@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f22dfd0c-5781-0e82-f5df-2d3c14868669@redhat.com>
Date: Fri, 16 Jun 2017 13:03:59 +0200
MIME-Version: 1.0
In-Reply-To: <0c96c64b-20ef-c0ef-3206-2a4ff713f6d9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Makefile: Move balloon.o,
 numa.o and bootdevice.o to common-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Andrew Jones <drjones@redhat.com>, Juan Quintela <quintela@redhat.com>

On 14.06.2017 13:25, Paolo Bonzini wrote:
> 
> 
> On 14/06/2017 13:18, Thomas Huth wrote:
>> On 08.06.2017 16:18, Thomas Huth wrote:
>>> There does not seem to be any target specific code in these files, so
>>> we can put them into "common-obj" instead of "obj" to compile them only
>>> once for all targets.
>>
>> Self-NACK: balloon.c uses kvm_enabled() which in turn depends on
>> CONFIG_KVM ... and that flag is target-specific, so balloon.o can not be
>> moved to common-obj right now.
>>
>> We should poison CONFIG_KVM for common code ... I'll have a look into
>> that...
> 
> No, your patch is okay.
> 
> #if defined CONFIG_KVM || !defined NEED_CPU_H
> #define kvm_enabled()           (kvm_allowed)
> ...
> #else
> #define kvm_enabled()           (0)
> 
> In other words, kvm_enabled() forces itself to be 0 only in per-target
> files.  This is done mostly to limit the number of required stubs:
> target-independent APIs can be called from compile-once files and must
> be stubbed; target-specific APIs can only be called from per-target
> files, and their calls are culled by the compiler if !CONFIG_KVM.

OK, thanks for the explanation!
... but I now think my patch is still wrong, due to another reason:
numa.o indirectly uses ram_addr_t variables, and these are target
specific, as far as I can see. So at least that file should not be moved
to common-obj-y.

 Thomas
