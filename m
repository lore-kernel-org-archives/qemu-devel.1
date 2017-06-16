Received: from eggs.gnu.org ([2001:4830:134:3::10]:55219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLsoU-0007vp-8s
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLsoR-0001DV-2Y
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:05:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLsoQ-0001C1-Td
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:05:27 -0400
References: <1497625153-19812-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2343916-49d4-5c18-8b2f-f3538839b46e@redhat.com>
Date: Fri, 16 Jun 2017 17:05:21 +0200
MIME-Version: 1.0
In-Reply-To: <1497625153-19812-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Poison some more target-specific
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 16/06/2017 16:59, Thomas Huth wrote:
> This series marks some more #defines as poisoned, which are
> target-specific (declared in config-target.h) and thus must
> not be used in common code.
> 
> v2:
>  - First two patches are the same as in v1
>  - Reworked the CONFIG_KVM patches according to Paolo's review feedback
>  - Added two new patches to finally poison CONFIG_SOFTMMU, too
>  - Added a final patch to move bootdevice.o to common-obj now
>    (based on an earlier patch where I also tried to move numa.o and
>    balloon.o, too - but these files are indirectly target-dependent as
>    I now know, so they can't be moved)

Why do you say they can't be moved?  They can, and your series should
change nothing about it, thanks to what you're doing now with
CONFIG_KVM_IS_POSSIBLE (which was also done before with NEED_CPU_H).

If it compiles, it's perfect. :)  (Almost---your patches 5-6 show it's
not entirely true, but poisoning helps).

Paolo

> Thomas Huth (7):
>   include/exec/poison: Add missing TARGET defines
>   include/exec/poison: Mark some CONFIG defines as poisoned, too
>   Move CONFIG_KVM related definitions to kvm_i386.h
>   include/exec/poison: Mark CONFIG_KVM as poisoned, too
>   cpu: Introduce a wrapper for tlb_flush() that can be used in common
>     code
>   include/exec/poison: Mark CONFIG_SOFTMMU as poisoned
>   Makefile: Move bootdevice.o to common-obj-y
> 
>  Makefile.objs             |  2 +-
>  Makefile.target           |  2 +-
>  bootdevice.c              |  2 +-
>  hw/acpi/ich9.c            |  1 -
>  hw/i386/pc_q35.c          |  1 +
>  include/exec/cpu-common.h |  2 ++
>  include/exec/poison.h     | 33 +++++++++++++++++++++++++++++++++
>  include/hw/i386/pc.h      | 13 -------------
>  include/qom/cpu.h         |  8 ++++++++
>  include/sysemu/kvm.h      | 31 ++++++++++++-------------------
>  qom/cpu.c                 |  5 ++---
>  target/i386/kvm_i386.h    | 23 +++++++++++++++++++++++
>  translate-all.c           |  8 ++++++++
>  13 files changed, 92 insertions(+), 39 deletions(-)
> 
