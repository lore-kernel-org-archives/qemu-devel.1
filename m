Received: from eggs.gnu.org ([2001:4830:134:3::10]:52118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEFI5-0007Sk-Ss
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEFI1-0007eR-UF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:33:01 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:59169)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEFI1-0007dL-NQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:32:57 -0400
Received: from player714.ha.ovh.net (unknown [10.109.108.14])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7CB29A5733
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 16:32:55 +0200 (CEST)
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-9-david@gibson.dropbear.id.au>
	<0d815d7c-42de-c89e-4481-21b32e04ed7c@kaod.org>
	<20180503115909.GA13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bde43733-5049-525d-0cd3-d5285322972e@kaod.org>
Date: Thu, 3 May 2018 16:32:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180503115909.GA13229@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/8] spapr: Clean up handling of LPCR
 power-saving exit bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

On 05/03/2018 01:59 PM, David Gibson wrote:
> On Thu, May 03, 2018 at 09:47:18AM +0200, C=E9dric Le Goater wrote:
>> On 05/03/2018 08:21 AM, David Gibson wrote:
>>> To prevent spurious wakeups on cpus that are supposed to be disabled,=
 we
>>> need to clear the LPCR bits which control certain wakeup events.
>>> spapr_cpu_reset() has separate cases here for boot and non-boot (init=
ially
>>> inactive) cpus.  rtas_start_cpu() then turns the LPCR bits on when th=
e
>>> non-boot cpus are activated.
>>>
>>> But explicit checks against first_cpu are not how we usually do thing=
s:
>>> instead spapr_cpu_reset() generally sets things up for non-boot (inac=
tive)
>>> cpus, then spapr_machine_reset() and/or rtas_start_cpu() override as
>>> necessary.
>>>
>>> So, do that instead.  Because the LPCR activation is identical for bo=
ot
>>> cpus and non-boot cpus just activated with rtas_start_cpu() we can pu=
t the
>>> code common in spapr_cpu_set_entry_state().
>>
>> This is much nicer.
>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>>
>> and for the patchset :
>>
>> Tested-by: C=E9dric Le Goater <clg@kaod.org>
>>
>> under KVM & TCG with cpu hotplug and unplug.
>=20
> Thanks.  I've folded the series into ppc-for-2.13.

We still need that patch for unplug to work :

	http://patchwork.ozlabs.org/patch/904229/

C.

>> There is still a spapr_cpu_reset() call under spapr_cpu_init().
>> Is that on purpose ?
>=20
> Sort of.  I'd still like to remove it, but figuring out how to do so
> safely is going to take a bit longer.  Well, probably quite a lot
> longer, since I doubt I'll get it done before I go away.
>=20
