Received: from eggs.gnu.org ([2001:4830:134:3::10]:60607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOPZL-0007MA-IZ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 11:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOPZK-0006Da-Fg
	for qemu-devel@nongnu.org; Thu, 31 May 2018 11:32:51 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOPZK-0006D0-AB
	for qemu-devel@nongnu.org; Thu, 31 May 2018 11:32:50 -0400
Received: by mail-oi0-x241.google.com with SMTP id c128-v6so10615852oig.11
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 08:32:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 16:32:28 +0100
Message-ID: <CAFEAcA9W_Qn84WT9_T2trh4eO6=kxzXfLbf9U=7USu28s-d4hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 31 May 2018 at 15:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue. This has the "plumb txattrs through various
> bits of exec.c" patches, and a collection of bug fixes from
> various people.
>
> thanks
> -- PMM
>
>
>
> The following changes since commit a3ac12fba028df90f7b3dbec924995c126c41022:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/numa-next-pull-request' into staging (2018-05-31 11:12:36 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180531
>
> for you to fetch changes up to 49d1dca0520ea71bc21867fab6647f474fcf857b:
>
>   KVM: GIC: Fix memory leak due to calling kvm_init_irq_routing twice (2018-05-31 14:52:53 +0100)
>

Patch "Make address_space_translate{, _cached}() take a MemTxAttrs argument"
needs this squashed into it:

--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -664,7 +664,8 @@ int kvm_arch_fixup_msi_route(struct
kvm_irq_routing_entry *route,
     /* MSI doorbell address is translated by an IOMMU */

     rcu_read_lock();
-    mr = address_space_translate(as, address, &xlat, &len, true);
+    mr = address_space_translate(as, address, &xlat, &len, true,
+                                 MEMTXATTRS_UNSPECIFIED);
     if (!mr) {
         goto unlock;
     }


to avoid a compile failure on arm hosts.

-- PMM
