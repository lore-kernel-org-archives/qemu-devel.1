Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BC4C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CC1206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nq5mukDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CC1206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnA5-00052y-EV
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCn9O-0004Y6-UG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCn9N-0002ch-6L
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:27:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCn9M-0002Wg-UV
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:27:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DGMmFE010874;
 Fri, 13 Mar 2020 16:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=mPzz1Rj0eMtldZtOwkZRCP7afKaYbjg99oEtLsmhb6E=;
 b=nq5mukDEnrGo1G+xcqFWE3QlmYMTarlPMrArCyiG8dx0XNdGPF8kqdEGxPEDlqg5S6K6
 B43NzvJjFNCUoOiVp/wOMMculTKHzDwqsK2JCjt1Ki6MgWt7T3ogRXP3QgPYhyjdLuY0
 SclqfDvKF+4bwMVvCvBpgz8iN3GLXlV15JupFGw6db0xD/titFI8qA6qlF22uRvEbMyg
 ZXvOPLkxYZOGITadb31uUSlmBMaLEQOBM3u2gOHGxBqYthHAiSwVSt0n/YZeMktj5gk4
 QmSd298HO4K3k9ky/0PJAyM6RJrBCuwwIY4TIqIFWlBZzbez96KDx7cy5jjfvQ5AEPMU mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yqtaevpnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 16:27:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DGNM1V038105;
 Fri, 13 Mar 2020 16:27:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yqtawabxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 16:27:02 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DGQxfc012813;
 Fri, 13 Mar 2020 16:26:59 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 09:26:59 -0700
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
Date: Fri, 13 Mar 2020 18:26:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313113049-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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


On 13/03/2020 17:47, Michael S. Tsirkin wrote:
> On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
>>>> @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>>>>        return ram_size;
>>>>    }
>>>> +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
>>>> +{
>>>> +    X86CPU *cpu = X86_CPU(current_cpu);
>>>> +    qemu_timeval tv;
>>>> +
>>>> +    if (qemu_gettimeofday(&tv) < 0) {
>>>> +        return UINT32_MAX;
>>>> +    }
>>>> +
>>>> +    cpu->env.regs[R_EBX] = (uint32_t)tv.tv_usec;
>>>> +    cpu->env.regs[R_ECX] = port_state->max_time_lag_us;
>>>> +    return (uint32_t)tv.tv_sec;
>>>> +}
>>>> +
>>>>    /* vmmouse helpers */
>>>>    void vmmouse_get_data(uint32_t *data)
>>>>    {
>>> That's a very weird thing to return to the guest.
>>> For example it's not monotonic across migrations.
>> That's the VMware PV interface... I didn't design it. :P
>> Regarding how it handles the fact time is not monotonic across migrations,
>> see big comment at the start of services/plugins/timeSync/timeSync.c in
>> open-vm-tools regarding the time-sync algorithm used by VMware Tools.
>> Specifically:
>> """
>> During normal operation this plugin only steps the time forward and only if
>> the error is greater than one second.
> Looks like guest assumes this time only moves forward.
> So something needs to be done to avoid it moving
> backward across migrations.
Where do you see this assumption in guest code? I don't think this is true.
Guest code seems to handle this by making sure to only step the time 
forward.
Read carefully services/plugins/timeSync/timeSync.c and point me to what 
I'm missing if you think otherwise (i.e. I missed something).
>> """
>>> And what does max_time_lag_us refer to, anyway?
>> According to the comment in open-vm-tools TimeSyncReadHost():
>> """
>> maximum time lag allowed (config option), which is a threshold that keeps
>> the tools from being over eager about resetting the time when it is only a
>> little bit off.
>> """
>>
>> Looking at open-vm-tools timeSync.c code, it defines the threshold of how
>> far guest time can be from host time before deciding to do a "step
>> correction".
>> A "step correction" is defined as explicitly setting the time in the guest
>> to the time in the host.
>>>
>>> So please add documentation about what this does.
>> You are right. I agree.
>> I think it would be best to just point to open-vm-tools
>> services/plugins/timeSync/timeSync.c.
>> Do you agree or should I copy some paragraphs from there?
> Neither. Their documentation will be from guest point of view.  Please
> look at that code and write documentation from host point of view.
> Your documentation for the lag parameter is I think a good
> example of how to do it.
Ok. Will try to phrase something for v4.
>
>>> If there's no document to refer to then pls write
>>> code comments or a document under docs/ - this does not
>>> belong in commit log.
>>>
>>>
>>>
>>>> @@ -214,6 +229,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
>>>>        vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
>>>>        if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
>>>>            vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
>>>> +        vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
>>>>        }
>>>>    }
>>>> @@ -249,6 +265,11 @@ static Property vmport_properties[] = {
>>>>         * 5 - ACE 1.x (Deprecated)
>>>>         */
>>>>        DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_type, 2),
>>>> +    /*
>>>> +     * Max amount of time lag that can go uncorrected.
>>> What does uncorrected mean?
>> You are right this is a bad phrasing taken from open-vm-tools.
>> It should mean "How far we allow guest time to go from host time before
>> guest VMware Tools will sync it to host time".
>> How you prefer to phrase this?
> Sounds like a good explanation. Maybe we allow -> can
> since "we" is hypervisor and it's actually under guest control.
Ok. Will add this to v4.
>
>
>>>> +     * Value taken from VMware Workstation 5.5.
>>> How do we know this makes sense for KVM? That has significantly
>>> different runtime characteristics.
>> This is just a threshold as you can understand from the above reply of mine
>> (I should rephrase the comments to make this clearer).
>> So we just chose a threshold that makes sense for common workloads.
>> One of the reasons to put this as a property, is to still allow user to
>> override it.
> Well close to 100% of users will have no idea what to set it to.
I agree. :) That's why there is a default value.
>
>
>>>
>>> Also, the version returns ESX server, why does it make
>>> sense to take some values from workstation?
>> I believe (don't remember) that ESXi was observed to return similar value.
>> Most of our workloads that runs with this came from ESXi and we never
>> examined an issue regarding this in our production environment.
>> Which makes sense as this is just a thresthold that specifies when guest
>> time should be synced to host time.
>> You prefer I would just remove this comment?
> Maybe add " TODO: should this depend on vmare-vmx-type? ".

Ok. Will add to v4.

Thanks,
-Liran



