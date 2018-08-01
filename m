Received: from eggs.gnu.org ([2001:4830:134:3::10]:41421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fklLU-0007rM-Iy
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 03:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fklLP-0001Ei-DM
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 03:14:56 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:54333)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fklLP-0001EM-6m
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 03:14:51 -0400
Received: from player758.ha.ovh.net (unknown [10.109.159.62])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6955EC0D19
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 09:14:49 +0200 (CEST)
References: <20180730141134.31153-1-clg@kaod.org>
	<20180730141134.31153-3-clg@kaod.org>
	<20180731193945.35360b15@bahia.lan>
	<20180801063823.GQ2708@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b510d9a7-fbda-b3c9-98a7-9fffee7a12cf@kaod.org>
Date: Wed, 1 Aug 2018 09:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180801063823.GQ2708@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 2/4] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

[ ... ]

>>> +typedef struct sPAPRMachineState sPAPRMachineState;
>>> +
>>
>> Old compilers (GCC < 4.6) might complain about 'redefinition of typedef' if
>> some file, say hw/ppc/spapr.c, includes both this header and "hw/ppc/xics.h".
>> We had several build breaks detected by 'make docker-test-build@centos6'...
>> The correct way to address this would be to move the typedef to the
>> "qemu/typedefs.h" header.
>>
>> This being said, docker-test-build@centos6 vanished with commit e7b3af81597,
>> so I guess we don't support such old distros anymore, and we can live with
>> duplicate typedefs.

I have a rhel6 vm for such tests but QEMU now requires python3 and 
glib-2.40 and maybe more stuff. I am not sure one can compile QEMU 3.1
on rhel/centos 6 anymore :/


[ ... ]

>>>      /* Release previous MSIs */
>>>      if (msi) {
>>> +        if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>>> +            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
>>> +        }
>>
>> SPAPR_MACHINE_GET_CLASS() does all the recursive type checking, and you
>> call it three times. Even if this isn't a hot path, maybe cache this in
>> an smc variable at the beginning of the function as we do pretty much
>> everywhere else. Also this would give prettier code IMHO.
> 
> I agree with Greg that this would be a nice improvement, but it can
> wait until a followup.

The sPAPR code base is very stable so it's not too much work to respin.
FYI, most of the XIVE v4 patchset still applies without a change.

Tell me if you find any other issues and I will resend.

Thanks,

C.
