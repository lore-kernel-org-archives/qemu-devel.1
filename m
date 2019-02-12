Received: from eggs.gnu.org ([209.51.188.92]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gtS1u-00089r-Vn
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gtS1s-0008MM-Bk
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:58:54 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:47506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gtS1n-0008Aw-0l
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:58:49 -0500
Received: from player770.ha.ovh.net (unknown [10.109.160.253])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 91D70E1C23
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 07:58:33 +0100 (CET)
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-7-clg@kaod.org>
	<20190208053554.GC12810@umbus.fritz.box>
	<36cd0056-a8b6-7128-5bf4-d5a479d99d76@kaod.org>
	<20190212002223.GD1884@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ff010890-0b21-8821-395f-c71f0e41c8e2@kaod.org>
Date: Tue, 12 Feb 2019 07:58:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190212002223.GD1884@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/13] spapr/xive: fix migration of the
 XiveTCTX under TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/12/19 1:22 AM, David Gibson wrote:
> On Fri, Feb 08, 2019 at 08:12:12AM +0100, C=E9dric Le Goater wrote:
>> On 2/8/19 6:36 AM, David Gibson wrote:
>>> On Mon, Jan 07, 2019 at 07:39:39PM +0100, C=E9dric Le Goater wrote:
>>>> When the thread interrupt management state is retrieved from the KVM
>>>> VCPU, word2 is saved under the QEMU XIVE thread context to print out
>>>> the OS CAM line under the QEMU monitor.
>>>>
>>>> This breaks the migration of a TCG guest (and with KVM when
>>>> kernel_irqchip=3Doff) because the matching algorithm of the presente=
r
>>>> relies on the OS CAM value. Fix with an extra reset of the thread
>>>> contexts to restore the expected value.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Why is the CAM value you get from KVM different from the one you
>>> expect in qemu?
>>
>> An NVT base identifier is allocated for each VM at the OPAL level
>> and each vCPU getd an increment of this value. It is pushed in the=20
>> OS CAM line when the vCPU is scheduled to run.
>> =20
>> KVM XIVE names this identifier a VP id.=20
>>
>> The QEMU emulation of XIVE uses a fixed value for the NVT base=20
>> identifier.
>=20
> Ah, I see.
>=20
> Hmm.  Really this highlights why I'm uneasy migrating the whole TCTX
> as just a blob of registers, even though only some of them are really
> runtime state, and others are machine configuration that can be worked
> out separately at the two ends.

This is really a special case :

1. migration kernel_irqchip=3Don -> kernel_irqchip=3Doff
2. debug info from KVM is squashing TCG state

We could ignore the VP id configured by KVM but it seems interesting
to retrieve.=20

C.=20
