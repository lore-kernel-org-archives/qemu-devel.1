Received: from eggs.gnu.org ([2001:4830:134:3::10]:33697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT1ry-0000zq-Cv
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT1rs-0007tz-SH
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:15:10 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:51231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT1rs-0007qS-LV
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:15:04 -0400
Received: from player799.ha.ovh.net (unknown [10.109.122.124])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id AEFF3183AC9
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 11:15:02 +0200 (CEST)
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-3-david@gibson.dropbear.id.au>
	<20180613110939.28d30cf0@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e69b80c7-8334-cf7a-5b23-85c5e6c3517b@kaod.org>
Date: Wed, 13 Jun 2018 11:14:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180613110939.28d30cf0@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] pnv: Add missing error check during
 cpu realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

>> index 13ad7d9e04..efb68226bb 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>>  
>>          snprintf(name, sizeof(name), "thread[%d]", i);
>>          object_property_add_child(OBJECT(pc), name, obj, &local_err);
>> +        if (local_err) {
>> +            goto err;
>> +        }
>>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
>>                                    "pir", &local_err);
>>          if (local_err) {
> 
> Hmm... the current error path seems to assume failures to be
> caused by object_property_add_child(). It hence unparents the
> previously parented CPUs, but not the current one. So we'll
> miss one call to object_unparent() if object_property_add_alias()
> fails.

yes, let's just put NULL or &error_abort instead.

C. 
