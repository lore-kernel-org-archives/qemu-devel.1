Received: from eggs.gnu.org ([2001:4830:134:3::10]:39454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d5yek-00049Z-ND
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d5yef-0004tS-JH
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:05:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45859
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d5yef-0004tB-1z
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:05:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v43I33EJ094033
	for <qemu-devel@nongnu.org>; Wed, 3 May 2017 14:05:35 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a7jp9m69t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 14:05:34 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 3 May 2017 15:05:32 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v43I5Sab56557698
	for <qemu-devel@nongnu.org>; Wed, 3 May 2017 15:05:29 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v43I5SnM006354
	for <qemu-devel@nongnu.org>; Wed, 3 May 2017 15:05:28 -0300
References: <20170426212303.27961-1-danielhb@linux.vnet.ibm.com>
	<20170426212303.27961-3-danielhb@linux.vnet.ibm.com>
	<20170503160916.GD2077@work-vm>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 3 May 2017 15:05:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170503160916.GD2077@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <fc06bf7f-050b-2bd1-5184-802f36cd8ca3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/ppc: migrating the DRC state of
 hotplugged devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org



On 05/03/2017 01:09 PM, Dr. David Alan Gilbert wrote:
> * Daniel Henrique Barboza (danielhb@linux.vnet.ibm.com) wrote:
>
> <snip>
>
>>   static void realize(DeviceState *d, Error **errp)
>>   {
>>       sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
>> @@ -540,6 +598,8 @@ static void realize(DeviceState *d, Error **errp)
>>           object_unref(OBJECT(drc));
>>       }
>>       g_free(child_name);
>> +    vmstate_register(DEVICE(drc), drck->get_index(drc), &vmstate_spapr_drc,
>> +                     drc);
>>       trace_spapr_drc_realize_complete(drck->get_index(drc));
>>   }
>>   
>> @@ -658,6 +718,7 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
>>       dk->reset = reset;
>>       dk->realize = realize;
>>       dk->unrealize = unrealize;
>> +    dk->vmsd = &vmstate_spapr_drc;
> Are you sure this is right - isn't it unusual to have both
> a ->vmsd entry AND a vmstate_register?

I've changed the code to use vmstate_register but forgot to remove the
->vmsd entry that was being used in v6.

Thanks for pointing it out Dave. I'll fix it in v9.


Daniel

>
> a ->vmsd =   is the preferable way I think, but I see you're
> doing something with the 2nd parameter of vmstate_register;
> if you *need* to do that then I think it's the only way.
>
> Dave
>
>>       drck->set_isolation_state = set_isolation_state;
>>       drck->set_indicator_state = set_indicator_state;
>>       drck->set_allocation_state = set_allocation_state;
>> -- 
>> 2.9.3
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
