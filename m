Received: from eggs.gnu.org ([2001:4830:134:3::10]:37016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dQbFT-00073c-40
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dQbFF-0006wO-Te
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:20:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dQbFF-0006uN-Hj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:20:37 -0400
Date: Thu, 29 Jun 2017 17:20:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170629172030.224712ad@nial.brq.redhat.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/23] hyperv fixes and enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>

On Wed, 21 Jun 2017 19:24:01 +0300
Roman Kagan <rkagan@virtuozzo.com> wrote:

> This series applies miscellaneous fixes and enhancements to Hyper-V
> emulation code in QEMU, and lays out the ground for VMBus devices.

Series is a big random mix of cleanup/refactoring/new features
which is hard to review due to mixed content of above
within patches as well inter them.

I suggest to split series in at least in 2
 1: make cleanups/refactoring first
and on top of this
 2: add new features

* hyperv_find_vcpu() with expensive lookup and related renaming
  might be not needed at all if local_apics[12/23] is used.

*pls add in cover letter a link to public git repo where
 it would be possible to pull from for testing/review.

PS:
if renaming, do it consistently.
ex:
 vcpu_id -> vp_index touches only hyperv.c
 but leaves old naming in user of kvm_hv_sint_route_create(): hyperv_testdev.c

> v1 -> v2:
>  - drop the already merged patch
>  - split and rework SINTx and SVERSION msrs init
>  - factor out hyperv vcpu init to a function
>  - rework vp_index management
>  - distinguish kvm-only (== legacy) mode for SynIC
>  - use new capabilities recently submitted to KVM
>  - add compat logic for SynIC
>  - drop workaround for KVM zeroing SynIC pages
>  - minor fixes according to comments
> 
> Evgeny Yakovlev (1):
>   hyperv: set partition-wide MSRs only on first vcpu
> 
> Roman Kagan (22):
>   hyperv: add header with protocol definitions
>   update-linux-headers: prepare for hyperv.h removal
>   hyperv: ensure SINTx msrs are reset properly
>   hyperv: make SynIC version msr constant
>   [not to commit] add new hyperv-related caps
>   hyperv: ensure VP index equal to QEMU cpu_index
>   hyperv_testdev: refactor for readability
>   hyperv: cosmetic: g_malloc -> g_new
>   hyperv: synic: only setup ack notifier if there's a callback
>   hyperv: allow passing arbitrary data to sint ack callback
>   hyperv: address HvSintRoute by X86CPU pointer
>   hyperv: make HvSintRoute reference-counted
>   hyperv: qom-ify SynIC
>   hyperv: block SynIC use in QEMU in incompatible configurations
>   hyperv: make overlay pages for SynIC
>   hyperv: add synic message delivery
>   hyperv: add synic event flag signaling
>   hyperv: process SIGNAL_EVENT hypercall
>   hyperv: process POST_MESSAGE hypercall
>   hyperv_testdev: add SynIC message and event testmodes
>   MAINTAINERS: add myself and eyakovlev@ for hyperv*
>   hyperv: update copyright notices
> 
>  include/hw/i386/pc.h            |   5 +
>  linux-headers/linux/kvm.h       |   2 +
>  target/i386/cpu.h               |  16 +-
>  target/i386/hyperv.h            |  40 ++-
>  target/i386/hyperv_proto.h      | 257 ++++++++++++++++
>  hw/misc/hyperv_testdev.c        | 267 +++++++++++++----
>  target/i386/cpu.c               |   4 +-
>  target/i386/hyperv.c            | 634 ++++++++++++++++++++++++++++++++++++++--
>  target/i386/kvm.c               | 167 +++++++----
>  target/i386/machine.c           |  24 +-
>  MAINTAINERS                     |   7 +
>  scripts/update-linux-headers.sh |   4 +-
>  12 files changed, 1256 insertions(+), 171 deletions(-)
>  create mode 100644 target/i386/hyperv_proto.h
> 
