Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BC1C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891A120789
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cTidynDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891A120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDC6L-0000Ki-MV
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 15:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jDC5V-00083i-Oy
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jDC5T-0006Tg-PM
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:04:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jDC5T-0006Sv-Hb
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:04:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EIwYtD073663;
 Sat, 14 Mar 2020 19:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GQwWZAiEg3lGLoDvcSBVQ/9gBlHzN0owBcxjuuCop6Q=;
 b=cTidynDQfXDyAzSuJfu233JpGVuaCZmRgDOkYZMTUPmDUbML+zr1w7B/AoCq46pg0QHb
 kUMDjK6FrBF2K62T3G8MuVSPVSqu+38pebJIxPMFEFUhaygfHn8A7fd3jcggYnnQjTuL
 UeB7JAi9QHdpFHLSSc2OpvIpQgTj1NxbdusefXmAISGUyrTaUhVjUPMSHdJDBhirq/bQ
 PAWOMGYZPE16cEUZ0vPAko3aB40EkwAaGfPLAE/2i34R2RquR/UuPz0rA0n38+aHnbsw
 AHL1GjXpI4u2D00D4tMOxjZLPvaL/spxQIF2tAH890p/wB0Sm2px1nT6FXgIvPih/3Pp ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2yrq7khfgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 19:04:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EIwNb7134646;
 Sat, 14 Mar 2020 19:04:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2yrna9wcmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 19:04:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02EJ4bIL029356;
 Sat, 14 Mar 2020 19:04:37 GMT
Received: from [192.168.14.112] (/79.179.237.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 14 Mar 2020 12:04:36 -0700
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
Date: Sat, 14 Mar 2020 21:04:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313170914-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003140102
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


On 14/03/2020 20:18, Michael S. Tsirkin wrote:
> On Fri, Mar 13, 2020 at 06:26:54PM +0200, Liran Alon wrote:
>> On 13/03/2020 17:47, Michael S. Tsirkin wrote:
>>> On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
>>>>>> @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>>>>>>         return ram_size;
>>>>>>     }
>>>>>> +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
>>>>>> +{
>>>>>> +    X86CPU *cpu = X86_CPU(current_cpu);
>>>>>> +    qemu_timeval tv;
>>>>>> +
>>>>>> +    if (qemu_gettimeofday(&tv) < 0) {
>>>>>> +        return UINT32_MAX;
>>>>>> +    }
>>>>>> +
>>>>>> +    cpu->env.regs[R_EBX] = (uint32_t)tv.tv_usec;
>>>>>> +    cpu->env.regs[R_ECX] = port_state->max_time_lag_us;
>>>>>> +    return (uint32_t)tv.tv_sec;
>>>>>> +}
>>>>>> +
>>>>>>     /* vmmouse helpers */
>>>>>>     void vmmouse_get_data(uint32_t *data)
>>>>>>     {
>>>>> That's a very weird thing to return to the guest.
>>>>> For example it's not monotonic across migrations.
>>>> That's the VMware PV interface... I didn't design it. :P
>>>> Regarding how it handles the fact time is not monotonic across migrations,
>>>> see big comment at the start of services/plugins/timeSync/timeSync.c in
>>>> open-vm-tools regarding the time-sync algorithm used by VMware Tools.
>>>> Specifically:
>>>> """
>>>> During normal operation this plugin only steps the time forward and only if
>>>> the error is greater than one second.
>>> Looks like guest assumes this time only moves forward.
>>> So something needs to be done to avoid it moving
>>> backward across migrations.
>> Where do you see this assumption in guest code? I don't think this is true.
>> Guest code seems to handle this by making sure to only step the time
>> forward.
> Exactly. So if host time moved backward e.g. by 100s, then for 100s
> time is not correcting. Which possibly vmware has a way to mitigate
> against e.g. by synchronising host time using their
> management app.
>
>> Read carefully services/plugins/timeSync/timeSync.c and point me to what I'm
>> missing if you think otherwise (i.e. I missed something).
> I'm just going by what you write in a patch.
>
So guest doesn't assume that this time only moves forward...

Can you clarify then which change do you suggest making to this patch in 
this regard? It seems correct to me.
i.e. The CMD_GETTIME implementation seems correct to me and it doesn't 
need to do anything special to handle host time moving backwards.

-Liran



