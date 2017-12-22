Received: from eggs.gnu.org ([2001:4830:134:3::10]:42878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eSK2d-0006zs-Do
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eSK2Z-0004Bz-9j
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:54:59 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:38570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eSK2Z-0003yM-33
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:54:55 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id ECDF992250
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 10:54:42 +0100 (CET)
References: <20171221165456.8609-1-clg@kaod.org>
	<20171222003906.GA26042@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <565d9742-43db-bca0-f5a5-593ed36e138a@kaod.org>
Date: Fri, 22 Dec 2017 10:54:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171222003906.GA26042@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: more use of the PPC_*() macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

>>  
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 370b05e76ede..894fb76fabe1 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -93,6 +93,12 @@
>>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
>>  #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>>                                   PPC_BIT32(bs))
>> +#define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT8(bs))
>> +
>> +#define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)

This macro does not work on 32bits, we would need to use '__builtin_ffsll'.
I will send a v2.

C. 

>> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>> +#define SETFIELD(m, v, val)                             \
>> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
