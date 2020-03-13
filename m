Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761D2C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D05520724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mBUq0z5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D05520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmCb-0001qk-By
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCmBn-0001Dg-PE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCmBl-0007NZ-Qa
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:25:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCmBl-0007LF-Gs
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:25:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DF9UTB160957;
 Fri, 13 Mar 2020 15:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tclsZajvaVycaXppwOme7wLKuPOkDhycbQU3ro4odMo=;
 b=mBUq0z5n3X4Wm7iLXH/HEo62DV0E+xJZCG6EKOH7oMC69OFec5brSvRjCZInGCYj6dGi
 IebWgfbwf4vKKn2wVT8W8EWf9xtRq8mweTSH3ZPpuRkmpwKXTg6pwwxHovIqhdKBSKcU
 IED2QXQECHMdCS14Mu0fiEMUHqBRcuP+YDdSASAM+j49nIJdcKjNKJYOlz+rFHe0TA+1
 9XzDGWm7W29ofLToOt9SA0EBGefVu2ceZfHHm9SoYVDYM2adBaIklPPZjIdtTJDeb/+e
 I+wNC+xbP8tA99VYKcbipEZe9QOK8RPhHpTB3ukiZ8+pMOXdWyfUIHoqcAMQil7VonwJ +A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yqtavmd86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 15:25:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DFKS1d130890;
 Fri, 13 Mar 2020 15:25:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2yqtacvknd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 15:25:26 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DFPPxB009915;
 Fri, 13 Mar 2020 15:25:25 GMT
Received: from Lirans-MacBook-Pro.local (/10.74.124.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 08:25:25 -0700
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
Date: Fri, 13 Mar 2020 17:25:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312195652-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130080
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/03/2020 2:04, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2020 at 06:54:25PM +0200, Liran Alon wrote:
>> This command is used by guest to gettimeofday() from host.
>> See usage example in open-vm-tools TimeSyncReadHost() function.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>>   hw/i386/vmport.c         | 21 +++++++++++++++++++++
>>   include/hw/i386/vmport.h |  1 +
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>> index 3fb8a8bd458a..c5b659c59343 100644
>> --- a/hw/i386/vmport.c
>> +++ b/hw/i386/vmport.c
>> @@ -66,6 +66,7 @@ typedef struct VMPortState {
>>   
>>       uint32_t vmware_vmx_version;
>>       uint8_t vmware_vmx_type;
>> +    uint32_t max_time_lag_us;
>>   
>>       uint32_t compat_flags;
>>   } VMPortState;
>> @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>>       return ram_size;
>>   }
>>   
>> +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
>> +{
>> +    X86CPU *cpu = X86_CPU(current_cpu);
>> +    qemu_timeval tv;
>> +
>> +    if (qemu_gettimeofday(&tv) < 0) {
>> +        return UINT32_MAX;
>> +    }
>> +
>> +    cpu->env.regs[R_EBX] = (uint32_t)tv.tv_usec;
>> +    cpu->env.regs[R_ECX] = port_state->max_time_lag_us;
>> +    return (uint32_t)tv.tv_sec;
>> +}
>> +
>>   /* vmmouse helpers */
>>   void vmmouse_get_data(uint32_t *data)
>>   {
> That's a very weird thing to return to the guest.
> For example it's not monotonic across migrations.
That's the VMware PV interface... I didn't design it. :P
Regarding how it handles the fact time is not monotonic across 
migrations, see big comment at the start of 
services/plugins/timeSync/timeSync.c in open-vm-tools regarding the 
time-sync algorithm used by VMware Tools.
Specifically:
"""
During normal operation this plugin only steps the time forward and only 
if the error is greater than one second.
"""
> And what does max_time_lag_us refer to, anyway?
According to the comment in open-vm-tools TimeSyncReadHost():
"""
maximum time lag allowed (config option), which is a threshold that 
keeps the tools from being over eager about resetting the time when it 
is only a little bit off.
"""

Looking at open-vm-tools timeSync.c code, it defines the threshold of 
how far guest time can be from host time before deciding to do a "step 
correction".
A "step correction" is defined as explicitly setting the time in the 
guest to the time in the host.
>
>
> So please add documentation about what this does.
You are right. I agree.
I think it would be best to just point to open-vm-tools 
services/plugins/timeSync/timeSync.c.
Do you agree or should I copy some paragraphs from there?
> If there's no document to refer to then pls write
> code comments or a document under docs/ - this does not
> belong in commit log.
>
>
>
>> @@ -214,6 +229,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
>>       vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
>>       if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
>>           vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
>> +        vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
>>       }
>>   }
>>   
>> @@ -249,6 +265,11 @@ static Property vmport_properties[] = {
>>        * 5 - ACE 1.x (Deprecated)
>>        */
>>       DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_type, 2),
>> +    /*
>> +     * Max amount of time lag that can go uncorrected.
> What does uncorrected mean?
You are right this is a bad phrasing taken from open-vm-tools.
It should mean "How far we allow guest time to go from host time before 
guest VMware Tools will sync it to host time".
How you prefer to phrase this?
>
>> +     * Value taken from VMware Workstation 5.5.
>
> How do we know this makes sense for KVM? That has significantly
> different runtime characteristics.
This is just a threshold as you can understand from the above reply of 
mine (I should rephrase the comments to make this clearer).
So we just chose a threshold that makes sense for common workloads.
One of the reasons to put this as a property, is to still allow user to 
override it.
>
>
> Also, the version returns ESX server, why does it make
> sense to take some values from workstation?
I believe (don't remember) that ESXi was observed to return similar value.
Most of our workloads that runs with this came from ESXi and we never 
examined an issue regarding this in our production environment.
Which makes sense as this is just a thresthold that specifies when guest 
time should be synced to host time.
You prefer I would just remove this comment?

Thanks,
-Liran

>
>> +     **/
>> +    DEFINE_PROP_UINT32("max-time-lag", VMPortState, max_time_lag_us, 1000000),
>>   
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
>> index 7f33512ca6f0..50416c8c8f3e 100644
>> --- a/include/hw/i386/vmport.h
>> +++ b/include/hw/i386/vmport.h
>> @@ -8,6 +8,7 @@ typedef enum {
>>       VMPORT_CMD_GETVERSION       = 10,
>>       VMPORT_CMD_GETBIOSUUID      = 19,
>>       VMPORT_CMD_GETRAMSIZE       = 20,
>> +    VMPORT_CMD_GETTIME          = 23,
>>       VMPORT_CMD_VMMOUSE_DATA     = 39,
>>       VMPORT_CMD_VMMOUSE_STATUS   = 40,
>>       VMPORT_CMD_VMMOUSE_COMMAND  = 41,
>> -- 
>> 2.20.1

