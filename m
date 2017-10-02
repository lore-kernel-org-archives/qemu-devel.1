Received: from eggs.gnu.org ([2001:4830:134:3::10]:48585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dywnP-0006lR-QE
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dywnL-0000ct-NP
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:13:51 -0400
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:39453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dywnL-0000c2-Fz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:13:47 -0400
Received: from player756.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 748A49C055
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 11:13:45 +0200 (CEST)
Date: Mon, 2 Oct 2017 11:13:36 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171002111336.42beb727@bahia.lan>
In-Reply-To: <150600964184.30533.472565821627831467.stgit@bahia.lan>
References: <150600964184.30533.472565821627831467.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
List-ID: <qemu-devel.nongnu.org>

Ping ?

On Thu, 21 Sep 2017 18:00:41 +0200
Greg Kurz <groug@kaod.org> wrote:

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
> 
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
> 
