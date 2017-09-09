Received: from eggs.gnu.org ([2001:4830:134:3::10]:42920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqb4d-00052w-HC
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 04:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqb4a-0000uq-Ef
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 04:25:07 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:59830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dqb4a-0000sM-8v
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 04:25:04 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9439F95A04
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 10:25:02 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-17-git-send-email-clg@kaod.org>
	<1504942750.12628.81.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6d16d413-cc59-b567-70dc-07eedb974ee3@kaod.org>
Date: Sat, 9 Sep 2017 10:24:58 +0200
MIME-Version: 1.0
In-Reply-To: <1504942750.12628.81.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 16/26] ppc/xive: notify CPU when
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 09/09/2017 09:39 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2017-07-05 at 19:13 +0200, C=C3=A9dric Le Goater wrote:
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xive.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index c3c1e9c9db2d..cda1fa18e44d 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -53,6 +53,21 @@ static uint64_t xive_icp_accept(XiveICPState *xicp)
>>      return (nsr << 8) | xicp->tima_os[TM_CPPR];
>>  }
>> =20
>> +static uint8_t ipb_to_pipr(uint8_t ibp)
>> +{
>> +    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
>> +}
>=20
> The PIPR needs to be updated also on accept etc... anything that change
> IPBs or CPPR really.

but not for the SET_OS_PENDING special write I suppose.

C.
