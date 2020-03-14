Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BC0C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0482078B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aUn0QAfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0482078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDCIm-0005qn-8H
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 15:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jDCI2-0005Lh-0D
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jDCI0-0005Wd-L8
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:17:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jDCHz-0005TN-8s
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:17:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EJ9s5l074229;
 Sat, 14 Mar 2020 19:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qBKNrDlhdlvFiXoMBBDXsyLO2PqRs18TEl48U4SZQEY=;
 b=aUn0QAfApfONy51VwXzqY9uGyC/mtjuxluGhjA4QDsJEx5unRchVx+bIdUi6pUSvrjNu
 PZCsevW98UC2QV7+S4+EiJTYbkFqdL4piCMvuvzWAjGzsbG9ObiUgh7NB23fMBHY09qg
 eHmJTXJcrTC28FTmHC7VjHV26LE7TI5wR63xAb1oUKKnFgVXZaj/xPIY3Oj03WtfUwZ0
 5oLd+7SkpxBfo/ZI/96Gmeqejw3m65EzdM0kUq6WDRGSmRD+9IUlUVB+/urxNd9OzPjo
 4S6f6uIV9ZSK9V/YtP1ElgtY9kjvV6hJdOZMH34H+Ea187Q+w3h5WlZt+QOMRJE4HNBp 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yrppqsheb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 19:17:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EJ8uWK150224;
 Sat, 14 Mar 2020 19:17:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yrna9wrce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 19:17:35 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02EJHY95010223;
 Sat, 14 Mar 2020 19:17:34 GMT
Received: from [192.168.14.112] (/79.179.237.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 14 Mar 2020 12:17:34 -0700
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
 <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
 <20200314151236-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <a9ac1106-67be-5d5d-fd30-669a483f09b0@oracle.com>
Date: Sat, 14 Mar 2020 21:17:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200314151236-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003140103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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


On 14/03/2020 21:14, Michael S. Tsirkin wrote:
> On Sat, Mar 14, 2020 at 09:04:30PM +0200, Liran Alon wrote:
>> On 14/03/2020 20:18, Michael S. Tsirkin wrote:
>>> On Fri, Mar 13, 2020 at 06:26:54PM +0200, Liran Alon wrote:
>>>> On 13/03/2020 17:47, Michael S. Tsirkin wrote:
>>>>> On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
>>>>>>>> @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>>>>>>>>          return ram_size;
>>>>>>>>      }
>>>>>>>> +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
>>>>>>>> +{
>>>>>>>> +    X86CPU *cpu = X86_CPU(current_cpu);
>>>>>>>> +    qemu_timeval tv;
>>>>>>>> +
>>>>>>>> +    if (qemu_gettimeofday(&tv) < 0) {
>>>>>>>> +        return UINT32_MAX;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    cpu->env.regs[R_EBX] = (uint32_t)tv.tv_usec;
>>>>>>>> +    cpu->env.regs[R_ECX] = port_state->max_time_lag_us;
>>>>>>>> +    return (uint32_t)tv.tv_sec;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      /* vmmouse helpers */
>>>>>>>>      void vmmouse_get_data(uint32_t *data)
>>>>>>>>      {
>>>>>>> That's a very weird thing to return to the guest.
>>>>>>> For example it's not monotonic across migrations.
>>>>>> That's the VMware PV interface... I didn't design it. :P
>>>>>> Regarding how it handles the fact time is not monotonic across migrations,
>>>>>> see big comment at the start of services/plugins/timeSync/timeSync.c in
>>>>>> open-vm-tools regarding the time-sync algorithm used by VMware Tools.
>>>>>> Specifically:
>>>>>> """
>>>>>> During normal operation this plugin only steps the time forward and only if
>>>>>> the error is greater than one second.
>>>>> Looks like guest assumes this time only moves forward.
>>>>> So something needs to be done to avoid it moving
>>>>> backward across migrations.
>>>> Where do you see this assumption in guest code? I don't think this is true.
>>>> Guest code seems to handle this by making sure to only step the time
>>>> forward.
>>> Exactly. So if host time moved backward e.g. by 100s, then for 100s
>>> time is not correcting. Which possibly vmware has a way to mitigate
>>> against e.g. by synchronising host time using their
>>> management app.
>>>
>>>> Read carefully services/plugins/timeSync/timeSync.c and point me to what I'm
>>>> missing if you think otherwise (i.e. I missed something).
>>> I'm just going by what you write in a patch.
>>>
>> So guest doesn't assume that this time only moves forward...
>>
>> Can you clarify then which change do you suggest making to this patch in
>> this regard? It seems correct to me.
>> i.e. The CMD_GETTIME implementation seems correct to me and it doesn't need
>> to do anything special to handle host time moving backwards.
>>
>> -Liran
>>
> I think something needs to be done to make sure host time as reported by
> this command does not move backwards significantly. Just forwarding
> gettimeofday won't cut it IMHO. Look at kvm clock for inspiration of
> things to do.
>
It isn't required by the command interface definition.
It's explicitly specified in timeSync.c that guest code handles the case 
host time goes backwards.
We are not inventing the interface, we just implement it according to 
it's definition.

-Liran




