Received: from eggs.gnu.org ([2001:4830:134:3::10]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gCpDp-0000wZ-Tv
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gCpDg-0004ur-TM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:03:00 -0400
From: Luc Michel <luc.michel@greensocs.com>
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-16-luc.michel@greensocs.com>
	<35ffbd68-f783-b6f4-18a2-dd995819c046@redhat.com>
	<CAFEAcA9vHi=qrV-Aj5ptgBQntafLGwL6VezxnmOuuR=6=Pr8cA@mail.gmail.com>
	<33c3ea72-652a-53b2-4865-830f3d7f2c3a@greensocs.com>
	<3d459f14-b701-02b6-d231-fc48c509640f@redhat.com>
	<20181004195225.GV5738@habkost.net>
	<CAFEAcA9tT5iFAo5DG=3dyBYNjBVN9u2qEK6Bo9Rf2MAPMBC6bg@mail.gmail.com>
	<20181004215352.GW5738@habkost.net>
	<e4724ba3-4dbc-7b79-b520-96b69be1a73c@redhat.com>
	<20181005184929.GY5738@habkost.net>
Message-ID: <5f7f1c42-18a4-5241-d1be-2e06ab86bdba@greensocs.com>
Date: Wed, 17 Oct 2018 19:02:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181005184929.GY5738@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/15] arm/xlnx-zynqmp: put APUs and RPUs in
 separate GDB groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>



On 10/5/18 8:49 PM, Eduardo Habkost wrote:
> On Fri, Oct 05, 2018 at 03:50:01PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> On 04/10/2018 23:53, Eduardo Habkost wrote:
>>> On Thu, Oct 04, 2018 at 09:01:09PM +0100, Peter Maydell wrote:
>>>> On 4 October 2018 at 20:52, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
>>>>> Changing the object hierarchy based on GDB groups doesn't seem
>>>>> right, but I don't think it would be a big deal if we have the
>>>>> board code explicitly telling the GDB code how to group the CPUs.
>>>>>
>>>>> If you really want to do it implicitly, would it work if you
>>>>> simply group the CPUs based on object_get_canonical_path()?
>>>>>
>>>>> If a more explicit GDB grouping API is acceptable, what about
>>>>> just adding a INTERFACE_GDB_GROUP interface name to (existing)
>>>>> container objects that we expect to become GDB groups?
>>>>>
>>>>> I'm not sure which way is better. I'm a bit worried that making
>>>>> things too implicit could easily break (e.g. if somebody changes
>>>>> the CPU QOM hierarchy in the future for unrelated reasons).
>>>>
>>>> I don't want things implicit. I just don't want the explicitness
>>>> to be "this is all about GDB", because it isn't. I want us
>>>> to explicitly say "these 4 CPUs are in one cluster" (or
>>>> whatever term we use), because that affects more than merely GDB.
>>>
>>> We already have a way to say "these 4 CPUs are in one cluster",
>>> don't we?  That's the QOM hierarchy.
>>>
>>> My question is if "the CPUs are in one cluster" should implicitly
>>> mean "the CPUs are in one GDB group".
>>>
>>
>> What about having the container implement INTERFACE_CPU_CLUSTER?
>>
>> Or even cleaner, add a TYPE_CPU_CLUSTER which is just a container for
>> TYPE_CPU[*]?
>=20
> Sounds good to me.  An interface sounds more flexible, to avoid
> clashing with existing type hierarchies for
> nodes/sockets/cores/etc.
But we still need a container sub-class specialized for that matter
right? Or are we going to have the generic container class implements
this not-so-generic interface?

>=20
> But first of all, I think we need a good definition of what
> exactly is a cluster, and what is the purpose of this
> abstraction.
I think it has implications that go way beyond this patch set.
Here we want to put the APUs (cortex-a53) and the RPUs (cortex-r5) in
different groups mainly because they have different architectures (I
think the address space is more or less the same for all the CPUs in
this SoC).

The current configuration is wrong since the A53 and the R5 probably
don't have the same features, hence for the same piece of code,
translations can differ from one another (e.g. one could have VFPv4 and
not the other). So the translation cache should not be shared.

We could imagine modelling more complex heterogeneous architectures. One
that come to my mind is a many-core chip from Kalray, which is organised
in 16 clusters of 16 cores each. In a cluster, the cores are SMP,
accessing the same SRAM. But inter-cluster communication is done through
an explicit NoC, using DMAs.

In that case, a "cluster" QEMU abstraction would make sense since cores
between clusters must not share the same address space, nor translation
cache.

Regarding GDB, two CPUs should be put in different groups if:
  - Their architectures are different
  - or if the extra XML descriptions we send to GDB for those CPUs are
different (extra registers).

So for now I think we can introduce this new "cpu cluster" abstraction
as it makes sense for the kind of system we (could) want to model in
QEMU. For now it will only be used by the GDB stub but it definitely has
a deeper implication.

>=20
> If we end up with a new abstraction that is only going to used by
> GDB code and nothing else, I don't see the point of pretending it
> is not a GDB-specific abstraction.
>=20
