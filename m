Received: from eggs.gnu.org ([209.51.188.92]:49434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1h0ofe-0007SY-Jd
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1h0ofY-00088K-Ab
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:34:22 -0500
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com> <87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304132507.39273826@redhat.com> <20190304123908.GK4239@redhat.com>
	<20190304151641.3deefc3b@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <762d9059-48fe-fe8a-42cf-bae6e802a1a9@redhat.com>
Date: Mon, 4 Mar 2019 15:34:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190304151641.3deefc3b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] numa: deprecate 'mem'
 parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 3/4/19 3:16 PM, Igor Mammedov wrote:
> On Mon, 4 Mar 2019 12:39:08 +0000
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
>> On Mon, Mar 04, 2019 at 01:25:07PM +0100, Igor Mammedov wrote:
>>> On Mon, 04 Mar 2019 08:13:53 +0100
>>> Markus Armbruster <armbru@redhat.com> wrote:
>>>   =20
>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>>   =20
>>>>> On Fri, Mar 01, 2019 at 06:33:28PM +0100, Igor Mammedov wrote:
>>>>>> On Fri, 1 Mar 2019 15:49:47 +0000
>>>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>>>>>     =20
>>>>>>> On Fri, Mar 01, 2019 at 04:42:15PM +0100, Igor Mammedov wrote:
>>>>>>>> The parameter allows to configure fake NUMA topology where guest
>>>>>>>> VM simulates NUMA topology but not actually getting a performanc=
e
>>>>>>>> benefits from it. The same or better results could be achieved
>>>>>>>> using 'memdev' parameter. In light of that any VM that uses NUMA
>>>>>>>> to get its benefits should use 'memdev' and to allow transition
>>>>>>>> initial RAM to device based model, deprecate 'mem' parameter as
>>>>>>>> its ad-hoc partitioning of initial RAM MemoryRegion can't be
>>>>>>>> translated to memdev based backend transparently to users and in
>>>>>>>> compatible manner (migration wise).
>>>>>>>>
>>>>>>>> That will also allow to clean up a bit our numa code, leaving on=
ly
>>>>>>>> 'memdev' impl. in place and several boards that use node_mem
>>>>>>>> to generate FDT/ACPI description from it.
>>>>>>>
>>>>>>> Can you confirm that the  'mem' and 'memdev' parameters to -numa
>>>>>>> are 100% live migration compatible in both directions ?  Libvirt
>>>>>>> would need this to be the case in order to use the 'memdev' synta=
x
>>>>>>> instead.
>>>>>> Unfortunately they are not migration compatible in any direction,
>>>>>> if it where possible to translate them to each other I'd alias 'me=
m'
>>>>>> to 'memdev' without deprecation. The former sends over only one
>>>>>> MemoryRegion to target, while the later sends over several (one pe=
r
>>>>>> memdev).
>>>>>
>>>>> If we can't migration from one to the other, then we can not deprec=
ate
>>>>> the existing 'mem' syntax. Even if libvirt were to provide a config
>>>>> option to let apps opt-in to the new syntax, we need to be able to
>>>>> support live migration of existing running VMs indefinitely. Effect=
ively
>>>>> this means we need the to keep 'mem' support forever, or at least s=
uch
>>>>> a long time that it effectively means forever.
>>>>>
>>>>> So I think this patch has to be dropped & replaced with one that
>>>>> simply documents that memdev syntax is preferred.
>>>>
>>>> We have this habit of postulating absolutes like "can not deprecate"
>>>> instead of engaging with the tradeoffs.  We need to kick it.
>>>>
>>>> So let's have an actual look at the tradeoffs.
>>>>
>>>> We don't actually "support live migration of existing running VMs
>>>> indefinitely".
>>>>
>>>> We support live migration to any newer version of QEMU that still
>>>> supports the machine type.
>>>>
>>>> We support live migration to any older version of QEMU that already
>>>> supports the machine type and all the devices the machine uses.
>>>>
>>>> Aside: "support" is really an honest best effort here.  If you rely =
on
>>>> it, use a downstream that puts in the (substantial!) QA work real
>>>> support takes.
>>>>
>>>> Feature deprecation is not a contract to drop the feature after two
>>>> releases, or even five.  It's a formal notice that users of the feat=
ure
>>>> should transition to its replacement in an orderly manner.
>>>>
>>>> If I understand Igor correctly, all users should transition away fro=
m
>>>> outdated NUMA configurations at least for new VMs in an orderly mann=
er.
>>> Yes, we can postpone removing options until there are machines type
>>> versions that were capable to use it (unfortunate but probably
>>> unavoidable unless there is a migration trick to make transition
>>> transparent) but that should not stop us from disabling broken
>>> options on new machine types at least.
>>>
>>> This series can serve as formal notice with follow up disabling of
>>> deprecated options for new machine types. (As Thomas noted, just warn=
ings
>>> do not work and users continue to use broken features regardless whet=
her
>>> they are don't know about issues or aware of it [*])
>>>
>>> Hence suggested deprecation approach and enforced rejection of legacy
>>> numa options for new machine types in 2 releases so users would stop
>>> using them eventually.
>>
>> When we deprecate something, we need to have a way for apps to use the
>> new alternative approach *at the same time*.  So even if we only want =
to
>> deprecate for new machine types, we still have to first solve the prob=
lem
>> of how mgmt apps will introspect QEMU to learn which machine types exp=
ect
>> the new options.
> I'm not aware any mechanism to introspect machine type options (existin=
g
> or something being developed). Are/were there any ideas about it that w=
ere
> discussed in the past?
>=20
> Aside from developing a new mechanism what are alternative approaches?
> I mean when we delete deprecated CLI option, how it's solved on libvirt
> side currently?

Libvirt queries qemu capabilites via QMP. And in all places it can it=20
preferes the latest recommended cmd line options (well, those known to a=20
libvirt developer at the time he/she is writing the code). So as long as=20
you remove only old stuff and libvirt refreshes itself when following=20
best practicies we're okay.

>=20
> For example I don't see anything introspection related when we have bee=
n
> removing deprecated options recently.
>=20
> More exact question specific to this series usecase,
> how libvirt decides when to use -numa node,memdev or not currently?

It has a mechanism to tell if '-numa node,memdev=3D' is needed (i.e. ther=
e=20
is no other way to satisfy user requested configuration) and only then=20
it uses ,memdev. For all other cases it defaults to -numa node,mem=3D=20
simply to keep backwards compatibility (as I'm explaining in another=20
e-mail I've just sent to this list).

Anyway, in the libvirt code you want to be looking at:

src/qemu/qemu_command.c: qemuBuildNumaArgStr
src/qemu/qemu_command.c: qemuBuildMemoryCellBackendStr

Michal
