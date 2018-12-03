Received: from eggs.gnu.org ([2001:4830:134:3::10]:55783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gTmI2-000415-VP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gTmHv-0005xP-UO
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:21:22 -0500
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
	<20181123181059.GN18284@habkost.net>
	<65d3a572-9a80-f332-1f88-69e43e8a3663@redhat.com>
	<20181126132731.GJ18284@habkost.net>
	<CAFEAcA8D7ZjO059Sgrx-4i0iT+V3gxT4f=DvdmUAJS7KomtyOg@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <b8e20686-e5d1-a844-48f7-a4ae471e3fd5@greensocs.com>
Date: Mon, 3 Dec 2018 12:20:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8D7ZjO059Sgrx-4i0iT+V3gxT4f=DvdmUAJS7KomtyOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On 11/30/18 5:52 PM, Peter Maydell wrote:
> On Mon, 26 Nov 2018 at 13:27, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
>>
>> On Sun, Nov 25, 2018 at 10:27:04PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> Hi Eduardo,
>>>
>>> On 23/11/18 19:10, Eduardo Habkost wrote:
>>>> If you really want to do this and assign cluster_id
>>>> automatically, please do it on realize, where it won't have
>>>> unexpected side-effects after a simple `qom-list-properties` QMP
>>>> command.
>>>
>>> This looks clean enough to me.
>>> Do you prefer we don't use static auto_increment at all?
>>
>> I would prefer to avoid the static variable if possible, but I
>> won't reject it if the alternatives make the API too complex to
>> use.
>=20
> I guess the alternative would be to require the cluster ID
> to be a QOM property on the cluster object. Usage would then
> be something like
>     object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
>                             sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
>                             &error_abort, NULL);
>     object_property_set_int(OBJECT(s), 1, "cluster-id", &error_abort);
>     qdev_init_nofail(DEVICE(&s->rpu_cluster));
>=20
> (ie one extra line setting the cluster ID explicitly).
I had such a line in v3 which was removed with the Philippe's
auto-assign suggestion. Discussions seems to converge to the removal of
the auto-assign mechanism though. I can rollback to manual assign for my
next re-roll.
Philippe: is it OK for you?

>=20
> SoC objects can probably reasonably assume that they are
> the only SoC in the system, ie that they can just assign
> cluster IDs themselves). If that turns out not to be true
> we can make the SoC take a property to specify a cluster ID
> base or something.
>=20
> I guess if we've been bitten by cpu-ID auto-assignment
> in the past, starting out with "user picks the cluster ID"
> would be safer, and it's not too much pain at the callsite.
> Plus it avoids the gdbstub changing its mind about which
> order the cluster "processes" appear in if we refactor the
> board code.
>=20
>> In either case, I'd like to ensure the caveats of the cluster_id
>> field are clearly documented: no guarantees about ordering or
>> predictability, making it not appropriate for external
>> interfaces.
>=20
> The gdb stub is sort of an external interface, of course...
>=20
> Luc: what are the requirements on boards using CPU cluster
> objects? I assume these are both OK:
>  * does not use cluster objects at all
>    (the gdbstub puts all the CPUs in one process?)
Yes, when no clusters are found, a process with PID 1 is created and
used for all CPUs.
>  * all CPUs created are in some CPU cluster
>    (the gdbstub uses one process per CPU cluster)
> but what about
>  * some CPUs are created in a CPU cluster, but some
>    are "loose", not in any cluster at all> ?
> Is that just invalid, or do the "loose" CPUs end up in
> a default cluster (gdbstub process), or do they get
> one cluster each?
Currently this is valid and the "loose" CPUs end up in the first
available process (which will be PID 1 if we are in your first case,
i.e. no clusters in the machine).

>=20
> If it's invalid (which doesn't seem like a bad idea),
> is there an assert somewhere so that getting it wrong
> results in the board failing to start (ie a "make check"
> failure) ?
I could add such a check if you think it's a good idea, i.e. assert that
"no cluster exist" or "all CPUs are in a cluster"

But maybe in the end this check should not be done in the gdb stub? For
the same reasons maybe you want to ensure that all CPUs have a well
known address space or whatever information the cluster will provide?

Thanks.

--=20
Luc
