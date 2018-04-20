Received: from eggs.gnu.org ([2001:4830:134:3::10]:32848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9RzI-0006ZN-2Q
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9RzE-0002M0-3W
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:05:48 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:53958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f9RzD-0002KF-Ss
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:05:44 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.46])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E8B691A24BB
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 11:05:41 +0200 (CEST)
References: <20180413075200.15217-1-clg@kaod.org>
	<20180419165800.GA2731@work-vm>
	<e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
	<CAFEAcA9hZ83_jwFi-=HhEf7KS6=F3KGuA++adfvqAiTy+rVZ8g@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2b5cf6b9-b9b5-7897-4c18-5d6734279633@kaod.org>
Date: Fri, 20 Apr 2018 11:05:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9hZ83_jwFi-=HhEf7KS6=F3KGuA++adfvqAiTy+rVZ8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On 04/20/2018 10:47 AM, Peter Maydell wrote:
> On 20 April 2018 at 07:59, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> Hello David,
>>
>> On 04/19/2018 06:58 PM, Dr. David Alan Gilbert wrote:
>>> * C=C3=A9dric Le Goater (clg@kaod.org) wrote:
>>>> @@ -1823,6 +1831,7 @@ void qemu_ram_set_idstr(RAMBlock *new_block, c=
onst char *name, DeviceState *dev)
>>>>          }
>>>>      }
>>>>      pstrcat(new_block->idstr, sizeof(new_block->idstr), name);
>>>> +    new_block->flags |=3D RAM_MIGRATABLE;
>>>>
>>>>      rcu_read_lock();
>>>>      RAMBLOCK_FOREACH(block) {
>>>> @@ -1845,6 +1854,7 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>>>>       */
>>>>      if (block) {
>>>>          memset(block->idstr, 0, sizeof(block->idstr));
>>>> +        block->flags &=3D ~RAM_MIGRATABLE;
>>>>      }
>>>>  }
>>>
>>> Why in qemu_ram_set_idstr and qemu_ram_(un)set_idstr ?  It seems an
>>> odd place to put them.
>>
>> The only place where this routines are called is from vmstate_un/regis=
ter_ram()
>> It seemed unnecessary to add an extra interface qemu_ram_un/set_migrat=
able().
>=20
> Why not set the flags in vmstate_{register,unregister}_ram() ?

because the RAM flags are not exposed outside exec.c so it would=20
require some qemu_ram_un/set_migratable() helpers like this is done
for RAM_UF_ZEROPAGE. That is possible of course.=20

C.
