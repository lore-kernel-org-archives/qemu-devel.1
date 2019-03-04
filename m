Received: from eggs.gnu.org ([209.51.188.92]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1h0qKL-0002MS-99
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1h0qKJ-0004nb-No
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:20:29 -0500
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com> <87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304132507.39273826@redhat.com> <20190304123908.GK4239@redhat.com>
	<20190304151641.3deefc3b@redhat.com> <20190304142432.GM4239@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <a6081774-c9d5-0496-3e65-ffb885408261@redhat.com>
Date: Mon, 4 Mar 2019 17:20:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190304142432.GM4239@redhat.com>
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 3/4/19 3:24 PM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 04, 2019 at 03:16:41PM +0100, Igor Mammedov wrote:
>> On Mon, 4 Mar 2019 12:39:08 +0000
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>
>>> On Mon, Mar 04, 2019 at 01:25:07PM +0100, Igor Mammedov wrote:
>>>> On Mon, 04 Mar 2019 08:13:53 +0100
>>>> Markus Armbruster <armbru@redhat.com> wrote:
>>>>   =20
>>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>>>   =20
>>>>>> On Fri, Mar 01, 2019 at 06:33:28PM +0100, Igor Mammedov wrote:
>>>>>>> On Fri, 1 Mar 2019 15:49:47 +0000
>>>>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>>>>>>     =20
>>>>>>>> On Fri, Mar 01, 2019 at 04:42:15PM +0100, Igor Mammedov wrote:
>>>>>>>>> The parameter allows to configure fake NUMA topology where gues=
t
>>>>>>>>> VM simulates NUMA topology but not actually getting a performan=
ce
>>>>>>>>> benefits from it. The same or better results could be achieved
>>>>>>>>> using 'memdev' parameter. In light of that any VM that uses NUM=
A
>>>>>>>>> to get its benefits should use 'memdev' and to allow transition
>>>>>>>>> initial RAM to device based model, deprecate 'mem' parameter as
>>>>>>>>> its ad-hoc partitioning of initial RAM MemoryRegion can't be
>>>>>>>>> translated to memdev based backend transparently to users and i=
n
>>>>>>>>> compatible manner (migration wise).
>>>>>>>>>
>>>>>>>>> That will also allow to clean up a bit our numa code, leaving o=
nly
>>>>>>>>> 'memdev' impl. in place and several boards that use node_mem
>>>>>>>>> to generate FDT/ACPI description from it.
>>>>>>>>
>>>>>>>> Can you confirm that the  'mem' and 'memdev' parameters to -numa
>>>>>>>> are 100% live migration compatible in both directions ?  Libvirt
>>>>>>>> would need this to be the case in order to use the 'memdev' synt=
ax
>>>>>>>> instead.
>>>>>>> Unfortunately they are not migration compatible in any direction,
>>>>>>> if it where possible to translate them to each other I'd alias 'm=
em'
>>>>>>> to 'memdev' without deprecation. The former sends over only one
>>>>>>> MemoryRegion to target, while the later sends over several (one p=
er
>>>>>>> memdev).
>>>>>>
>>>>>> If we can't migration from one to the other, then we can not depre=
cate
>>>>>> the existing 'mem' syntax. Even if libvirt were to provide a confi=
g
>>>>>> option to let apps opt-in to the new syntax, we need to be able to
>>>>>> support live migration of existing running VMs indefinitely. Effec=
tively
>>>>>> this means we need the to keep 'mem' support forever, or at least =
such
>>>>>> a long time that it effectively means forever.
>>>>>>
>>>>>> So I think this patch has to be dropped & replaced with one that
>>>>>> simply documents that memdev syntax is preferred.
>>>>>
>>>>> We have this habit of postulating absolutes like "can not deprecate=
"
>>>>> instead of engaging with the tradeoffs.  We need to kick it.
>>>>>
>>>>> So let's have an actual look at the tradeoffs.
>>>>>
>>>>> We don't actually "support live migration of existing running VMs
>>>>> indefinitely".
>>>>>
>>>>> We support live migration to any newer version of QEMU that still
>>>>> supports the machine type.
>>>>>
>>>>> We support live migration to any older version of QEMU that already
>>>>> supports the machine type and all the devices the machine uses.
>>>>>
>>>>> Aside: "support" is really an honest best effort here.  If you rely=
 on
>>>>> it, use a downstream that puts in the (substantial!) QA work real
>>>>> support takes.
>>>>>
>>>>> Feature deprecation is not a contract to drop the feature after two
>>>>> releases, or even five.  It's a formal notice that users of the fea=
ture
>>>>> should transition to its replacement in an orderly manner.
>>>>>
>>>>> If I understand Igor correctly, all users should transition away fr=
om
>>>>> outdated NUMA configurations at least for new VMs in an orderly man=
ner.
>>>> Yes, we can postpone removing options until there are machines type
>>>> versions that were capable to use it (unfortunate but probably
>>>> unavoidable unless there is a migration trick to make transition
>>>> transparent) but that should not stop us from disabling broken
>>>> options on new machine types at least.
>>>>
>>>> This series can serve as formal notice with follow up disabling of
>>>> deprecated options for new machine types. (As Thomas noted, just war=
nings
>>>> do not work and users continue to use broken features regardless whe=
ther
>>>> they are don't know about issues or aware of it [*])
>>>>
>>>> Hence suggested deprecation approach and enforced rejection of legac=
y
>>>> numa options for new machine types in 2 releases so users would stop
>>>> using them eventually.
>>>
>>> When we deprecate something, we need to have a way for apps to use th=
e
>>> new alternative approach *at the same time*.  So even if we only want=
 to
>>> deprecate for new machine types, we still have to first solve the pro=
blem
>>> of how mgmt apps will introspect QEMU to learn which machine types ex=
pect
>>> the new options.
>> I'm not aware any mechanism to introspect machine type options (existi=
ng
>> or something being developed). Are/were there any ideas about it that =
were
>> discussed in the past?
>>
>> Aside from developing a new mechanism what are alternative approaches?
>> I mean when we delete deprecated CLI option, how it's solved on libvir=
t
>> side currently?
>>
>> For example I don't see anything introspection related when we have be=
en
>> removing deprecated options recently.
>=20
> Right, with other stuff we deprecate we've had a simpler time, as it
> either didn't affect migration at all, or the new replacement stuff
> was fully compatible with the migration data stream. IOW, libvirt
> could unconditionally use the new feature as soon as it saw that it
> exists in QEMU. We didn't have any machine type dependancy to deal
> with before now.

We couldn't have done that. How we would migrate from older qemu?

Anyway, now that I look into this (esp. git log) I came accross:

commit f309db1f4d51009bad0d32e12efc75530b66836b
Author:     Michal Privoznik <mprivozn@redhat.com>
AuthorDate: Thu Dec 18 12:36:48 2014 +0100
Commit:     Michal Privoznik <mprivozn@redhat.com>
CommitDate: Fri Dec 19 07:44:44 2014 +0100

     qemu: Create memory-backend-{ram,file} iff needed

Or this 7832fac84741d65e851dbdbfaf474785cbfdcf3c. We did try to=20
generated newer cmd line but then for various reasong (e.g. avoiding=20
triggering a qemu bug) we turned it off and make libvirt default to=20
older (now deprecated) cmd line.

Frankly, I don't know how to proceed. Unless qemu is fixed to allow=20
migration from deprecated to new cmd line (unlikely, if not impossible,=20
right?) then I guess the only approach we can have is that:

1) whenever so called cold booting a new machine (fresh, brand new start=20
of a new domain) libvirt would default to modern cmd line,

2) on migration, libvirt would record in the migration stream (or status=20
XML or wherever) that modern cmd line was generated and thus it'll make=20
the destination generate modern cmd line too.

This solution still suffers a couple of problems:
a) migration to older libvirt will fail as older libvirt won't recognize=20
the flag set in 2) and therefore would default to deprecated cmd line
b) migrating from one host to another won't modernize the cmd line

But I guess we have to draw a line somewhere (if we are not willing to=20
write those migration patches).

Michal
