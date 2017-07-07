Received: from eggs.gnu.org ([2001:4830:134:3::10]:54813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTVtF-0001qC-DN
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTVtB-0006Pr-FQ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:57 -0400
Received: from chuckie.co.uk ([82.165.15.123]:55409
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dTVtB-0006PK-8O
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:53 -0400
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<20170707131300.GG10776@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <cff32187-6bff-ff93-5030-4fea717924e6@ilande.co.uk>
Date: Fri, 7 Jul 2017 17:13:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170707131300.GG10776@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 07/07/17 14:13, Eduardo Habkost wrote:

>>> This should be the same behaviour as before, i.e. a NULL means that the
>>> fw_cfg device couldn't be found. It seems intuitive to me from the name
>>> of the function exactly what it does, so I don't find the lack of
>>> comment too confusing. Does anyone else have any thoughts here?
>> intuitive meaning from the function name would be return NULL if nothing were found,
>> however it's not the case here.
>>
>> taking in account that fwcfg in not user creatable device how about:
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 316fca9..8f6eef8 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -1014,7 +1014,10 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
>>  
>>  FWCfgState *fw_cfg_find(void)
>>  {
>> -    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>> +    bool ambig = false;
>> +    FWCfgState *f = FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, &ambig));
>> +    assert(!ambig);
>> +    return f;
>>  }
>>
>> or if we must to print user friendly error and fail realize gracefully
>> (not sure why) just add errp argument to function so it could report
>> error back to caller, then places that do not care much about graceful
>> exit would use error_abort as argument and realize would use
>> its local_error/errp argument.
> 
> I don't disagree with adding the assert(), but it looks like
> making fw_cfg_find() return NULL if there are multiple devices
> can be useful for realize.
> 
> In this case, it looks like Mark is relying on that in
> fw_cfg_common_realize(): if multiple devices are created,
> fw_cfg_find() will return NULL, and realize will fail.  This
> sounds like a more graceful way to handle multiple-device
> creation than crashing on fw_cfg_find().  This is the solution
> used by find_vmgenid_dev()/vmgenid_realize(), BTW.
> 
> Either way, we have to choose: either we make fw_cfg_find() crash
> when multiple devices exist (in this case, the fw_cfg_find() call
> on realize will be useless), or we make it return NULL and
> document it very clearly.

My personal preference too would be to keep the existing behaviour i.e.
NULL indicates failure and add a comment explaining how this also
matches the behaviour of object_resolve_path_type(). Then it is up the
caller to decide how to handle the severity as they wish.

>>>>> +        error_setg(errp, "at most one %s device is permitted", TYPE_FW_CFG);  
>>>> s/TYPE_FW_CFG/object_get_typename()/
>>>> so it would print leaf type name   
> 
> I disagree.  We allow at most one fw_cfg device (it doesn't
> matter which type), not at most one device of each leaf type.
> Saying "at most one fw_cfg_mem device is permitted" if 1
> fw_cfg_io and 1 fw_cfg_mem device is created would be misleading.

Yes, I agree with you here. FWIW I've just done some more testing with
patch 4 dropped and it seems to be working well, i.e. I can't manage to
reproduce the failure case I was seeing before. Slightly annoying, but
also promising.


ATB,

Mark.
