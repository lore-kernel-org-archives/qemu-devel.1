Received: from eggs.gnu.org ([2001:4830:134:3::10]:48563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1aHf-0003C3-Km
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1aHb-0002F1-NL
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1aHb-0002EP-EO
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:47:55 -0400
References: <20171006215244.27104-1-ehabkost@redhat.com>
	<765f7133-0ccc-2239-d49b-55d8b2a24cc7@redhat.com>
	<fddffbab-7aab-72b4-f42f-d18e94517350@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17ed046b-2c29-340b-9802-f43a709715e2@redhat.com>
Date: Mon, 9 Oct 2017 17:47:44 +0200
MIME-Version: 1.0
In-Reply-To: <fddffbab-7aab-72b4-f42f-d18e94517350@redhat.com>
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
To: Waiman Long <longman@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>

On 09/10/2017 17:15, Waiman Long wrote:
> On 10/09/2017 09:39 AM, Paolo Bonzini wrote:
>> On 06/10/2017 23:52, Eduardo Habkost wrote:
>>> This series enables kvm_pv_unhalt by default on pc-*-2.11 and
>>> newer.
>>
>> I've discussed PV spinlocks with some folks at Microsoft for a few wee=
ks
>> now, and I'm not 100% sure about enabling kvm_pv_unhalt by default.
>> It's probably a good idea overall, but it does come with some caveats.
>>
>> The problem is that there were two different implementations of fair
>> spinlocks in Linux, ticket spinlocks and queued spinlocks.  When
>> kvm_pv_unhalt is disabled, ticket spinlocks sucked badly indeed; queue=
d
>> spinlocks however simply revert to unfair spinlocks, which loses the
>> fairness but has the best performance.  See virt_spin_lock in
>> arch/x86/include/asm/qspinlock.h.
>>
>> Now, fair spinlocks are only really needed for large NUMA machines.
>> With a single NUMA node, for example, test-and-set spinlocks work well
>> enough; there's not _much_ need for fairness in practice, and the
>> paravirtualization does introduce some overhead.
>>
>> Therefore, the best performance would be achieved with kvm_pv_unhalt
>> disabled on small VMs, and enabled on large VMs spanning multiple host
>> NUMA nodes.
>>
>> Waiman, Davidlohr, do you have an opinion on this as well?
>=20
> I agree. Using unfair lock in a small VM is good for performance. The
> only problem I see is how do we define what is small. Now, even a
> machine with a single socket can have up to 28 cores, 56 threads. If a
> VM has up to 56 vCPUs, we may still want pvqspinlock to be used.

Yes.  Another possibility is to enable it when there is >1 NUMA node in
the guest.  We generally don't do this kind of magic but higher layers
(oVirt/OpenStack) do.

It also depends on how worse performance is with PV qspinlocks,
especially since now there's also vcpu_is_preempted that has to be
thrown in the mix.  A lot more testing is needed.

> Is the kvm_pv_unhalt flag a global one for all VMs within a machine? Or
> can it be different for each VM? We may want to have this flag
> dynamically determined depending on the configuration of the VM.

It's per-VM, so that's easy.

Paolo
