Received: from eggs.gnu.org ([2001:4830:134:3::10]:39587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1YHT-0007Gd-5f
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1YHQ-00069v-0f
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1YHP-000695-Qx
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:39:35 -0400
References: <20171006215244.27104-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <765f7133-0ccc-2239-d49b-55d8b2a24cc7@redhat.com>
Date: Mon, 9 Oct 2017 15:39:26 +0200
MIME-Version: 1.0
In-Reply-To: <20171006215244.27104-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] x86: Rework KVM-defaults compat code,
 enable kvm_pv_unhalt by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Waiman Long <longman@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>

On 06/10/2017 23:52, Eduardo Habkost wrote:
> This series enables kvm_pv_unhalt by default on pc-*-2.11 and
> newer.
>=20
> To do that, I first reworked the existing
> x86_cpu_change_kvm_default() logic to use compat_props instead,
> so we don't need to make the chain of pc_compat_*() functions
> grow.

I've discussed PV spinlocks with some folks at Microsoft for a few weeks
now, and I'm not 100% sure about enabling kvm_pv_unhalt by default.
It's probably a good idea overall, but it does come with some caveats.

The problem is that there were two different implementations of fair
spinlocks in Linux, ticket spinlocks and queued spinlocks.  When
kvm_pv_unhalt is disabled, ticket spinlocks sucked badly indeed; queued
spinlocks however simply revert to unfair spinlocks, which loses the
fairness but has the best performance.  See virt_spin_lock in
arch/x86/include/asm/qspinlock.h.

Now, fair spinlocks are only really needed for large NUMA machines.
With a single NUMA node, for example, test-and-set spinlocks work well
enough; there's not _much_ need for fairness in practice, and the
paravirtualization does introduce some overhead.

Therefore, the best performance would be achieved with kvm_pv_unhalt
disabled on small VMs, and enabled on large VMs spanning multiple host
NUMA nodes.

Waiman, Davidlohr, do you have an opinion on this as well?

Paolo
