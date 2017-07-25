Received: from eggs.gnu.org ([2001:4830:134:3::10]:34898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZvpp-0007lK-7a
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZvpm-00037r-1C
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:08:57 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:55319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZvpl-00037D-Qf
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:08:53 -0400
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 415C588E97
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 11:08:52 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-15-git-send-email-clg@kaod.org>
	<20170724063534.GM17228@umbus.fritz.box>
	<fa7a0b3f-89d5-b1ef-238d-0bda41beee9f@kaod.org>
	<20170725042027.GC8978@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1d7d50ee-7559-2e6b-4ed0-741d810052d0@kaod.org>
Date: Tue, 25 Jul 2017 11:08:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170725042027.GC8978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 14/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/25/2017 06:20 AM, David Gibson wrote:
> On Mon, Jul 24, 2017 at 04:44:00PM +0200, C=E9dric Le Goater wrote:
>> On 07/24/2017 08:35 AM, David Gibson wrote:
>>> On Wed, Jul 05, 2017 at 07:13:27PM +0200, C=E9dric Le Goater wrote:
>>>> The Thread Interrupt Management Area for the OS is mostly used to
>>>> acknowledge interrupts and set the CPPR of the CPU.
>>>>
>>>> The TIMA is mapped at the same address for each CPU. 'current_cpu' i=
s
>>>> used to retrieve the targeted interrupt presenter object.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Am I right in thinking that this shoehorns the XIVE TIMA state into
>>> the existing XICS ICP object.  That.. doesn't seem like a good idea.
>>
>> The TIMA memory region is under the XIVE object because it is=20
>> unique for the system. The lookup of the ICP is simply done using=20
>> 'current_cpu'. The TIMA state is under the ICPState, yes, but this=20
>> model does not seem incorrect to me as this state contains the=20
>> interrupt information presented to a CPU.
>=20
> Yeah, that's not the point I'm making.  My point is that the TIMA
> state isn't really the same as xics ICP state.  You're squeezing one
> into the other in a pretty ugly way.

yes, well, we need to have compatible objects between the XICS and XIVE=20
mode because of the CAS negotiation. for migration compatibility, it is=20
much easier to extend existing objects. This approach I am taking today.


C.
