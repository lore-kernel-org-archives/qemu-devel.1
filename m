Received: from eggs.gnu.org ([2001:4830:134:3::10]:40924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dyzzU-0008SJ-Sq
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dyzzQ-0005s7-HW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:38:32 -0400
References: <150600964184.30533.472565821627831467.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e37fe041-e70a-e9b3-34cf-d0b92b6b863f@redhat.com>
Date: Mon, 2 Oct 2017 14:38:24 +0200
MIME-Version: 1.0
In-Reply-To: <150600964184.30533.472565821627831467.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: use kvm_vm_check_extension()
 with VM capabilities
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
List-ID: <qemu-devel.nongnu.org>

On 21/09/2017 18:00, Greg Kurz wrote:
> Some VM capabilities are currently checked with kvm_check_extension(). This
> doesn't have any impact for most host architectures because they don't depend
> on the KVM type. However, this is a problem for server-class ppc hosts that
> can support the PR and HV KVM types. Both implementations can co-exist in the
> kernel at the same time and we decide which one will be used with the "type"
> argument of the KVM_CREATE_VM ioctl.
> 
> Each KVM type has a different set of capabilities, and checking them with
> kvm_check_extension() will always cause KVM to assume we're in HV mode,
> even if they are VM specific and we have explicitely requested to run in
> PR mode. This may produce unexpected results.
> 
> Similar issues were recently fixed in the ppc code:
> 
> https://github.com/qemu/qemu/commit/70a0c19e83aa4c71c879d51e426e89e4b3d4e014
> https://github.com/dgibson/qemu/commit/b152d74ebaed61f89fa1ab2c9b1526d9e9dabae5
> 
> This series focuses on capabilities that are checked by the common code.

Queued, thanks.

Paolo

> --
> Greg
> 
> ---
> 
> Greg Kurz (2):
>       kvm: check KVM_CAP_SYNC_MMU with kvm_vm_check_extension()
>       kvm: check KVM_CAP_NR_VCPUS with kvm_vm_check_extension()
> 
> 
>  accel/kvm/kvm-all.c    |   51 +++++++++++++++++++++++++-----------------------
>  accel/stubs/kvm-stub.c |    4 ++--
>  include/sysemu/kvm.h   |    2 +-
>  3 files changed, 30 insertions(+), 27 deletions(-)
> 
