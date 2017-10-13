Received: from eggs.gnu.org ([2001:4830:134:3::10]:52893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longman@redhat.com>) id 1e372P-0001JY-6o
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longman@redhat.com>) id 1e372L-0000yU-8c
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longman@redhat.com>) id 1e372K-0000xy-Vj
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:58:29 -0400
References: <20171006215244.27104-1-ehabkost@redhat.com>
	<765f7133-0ccc-2239-d49b-55d8b2a24cc7@redhat.com>
	<fddffbab-7aab-72b4-f42f-d18e94517350@redhat.com>
	<17ed046b-2c29-340b-9802-f43a709715e2@redhat.com>
	<20171010155003.GD3246@localhost.localdomain>
	<4b9e65ed-3636-bff4-3cca-52f6b80bca3b@redhat.com>
	<20171010194117.GK3246@localhost.localdomain>
	<cdd2b3da-b243-0d17-c3b7-305532b3bc43@redhat.com>
	<20171013190138.GB3246@localhost.localdomain>
From: Waiman Long <longman@redhat.com>
Message-ID: <c0614596-8157-0d91-77a7-e28946b8b13f@redhat.com>
Date: Fri, 13 Oct 2017 16:58:23 -0400
MIME-Version: 1.0
In-Reply-To: <20171013190138.GB3246@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, libvir-list@redhat.com

On 10/13/2017 03:01 PM, Eduardo Habkost wrote:
> On Wed, Oct 11, 2017 at 04:19:38PM -0400, Waiman Long wrote:
>> On 10/10/2017 03:41 PM, Eduardo Habkost wrote:
>>> On Tue, Oct 10, 2017 at 02:07:25PM -0400, Waiman Long wrote:
>>>> On 10/10/2017 11:50 AM, Eduardo Habkost wrote:
>>>>>> Yes.  Another possibility is to enable it when there is >1 NUMA no=
de in
>>>>>> the guest.  We generally don't do this kind of magic but higher la=
yers
>>>>>> (oVirt/OpenStack) do.
>>>>> Can't the guest make this decision, instead of the host?
>>>> By guest, do you mean the guest OS itself or the admin of the guest =
VM?
>>> It could be either.  But even if action is required from the
>>> guest admin to get better performance in some cases, I'd argue
>>> that the default behavior of a Linux guest shouldn't cause a
>>> performance regression if the host stops hiding a feature in
>>> CPUID.
>>>
>>>> I am thinking about maybe adding kernel boot command line option lik=
e
>>>> "unfair_pvspinlock_cpu_threshold=3D4" which will instruct the OS to =
use
>>>> unfair spinlock if the number of CPUs is 4 or less, for example. The=

>>>> default value of 0 will have the same behavior as it is today. Pleas=
e
>>>> let me know what you guys think about that.
>>> If that's implemented, can't Linux choose a reasonable default
>>> for unfair_pvspinlock_cpu_threshold that won't require the admin
>>> to manually configure it on most cases?
>> It is hard to have a fixed value as it depends on the CPUs being used =
as
>> well as the kind of workloads that are being run. Besides, using unfai=
r
>> locks have the undesirable side effect of being subject to lock
>> starvation under certain circumstances. So we may not work it to be
>> turned on by default. Customers have to take their own risk if they wa=
nt
>> that.
> Probably I am not seeing all variables involved, so pardon my
> confusion.  Would unfair_pvspinlock_cpu_threshold > num_cpus just
> disable usage of kvm_pv_unhalt, or make the guest choose a
> completely different spinlock implementation?

What I am proposing is that if num_cpus <=3D
unfair_pvspinlock_cpu_threshold, the unfair spinlock will be used even
if kvm_pv_unhalt is set.

> Is the current default behavior of Linux guests when
> kvm_pv_unhalt is unavailable a good default?  If using
> kvm_pv_unhalt is not always a good idea, why do Linux guests
> default to eagerly trying to use it only because the host says
> it's available?

For kernel with CONFIG_PARVIRT_SPINLOCKS, the current default is to use
pvqspinlock if kvm_pv_unhalt is enabled, but use unfair spinlock if it
is disabled. For kernel with just CONFIG_PARVIRT but no
CONFIG_PARAVIRT_SPINLOCKS, the unfair lock will be use no matter the
setting of kvm_pv_unhalt. Without those config options, the standard
qspinlock will be used.

Cheers,
Longman
