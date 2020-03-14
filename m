Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA59C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2802078F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LA38qxLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2802078F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDD30-000634-Vm
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 16:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jDD2L-0005d5-QT
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jDD2J-00027T-KL
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:05:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jDD2I-0001wB-AG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:05:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EJwoGc040466;
 Sat, 14 Mar 2020 20:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dX3Ana//VW7Q9Xw/hQ0rYs2v4mD4SSaOtC/gV7OA4Wc=;
 b=LA38qxLKtvxutKwvoxJrd7HynMssPgPOMZgqG15nF5GIiMNyhycGyGaMoJaDUyX/UaGt
 HL/vAyLmJG/TG3rBwRRa1kTnPxwamdzKso0x6TyklsrsujuWZ8M9M2jW5i9Aq//c9a+p
 9EsmbFhTZnU1W9B0CBEAmKWQ0XFkxmVlYyr9eiKVP6IlNqLiMnWsfiCvrwr9CODD04H6
 s9NK+YNmBLiMJ/iZSkTOn2NlRn1+ZpknUQtJQQIfTIyMk9fJsO97gTw2G4EAlJyywuiq
 x8KO4aiE9uGC1Lz/Wua3o5SAZUpJiy2kFFxiloZYGauyKviazftWo/WE2ZD87Hp0u92s Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yrqwmsevm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 20:05:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EJwZDc041497;
 Sat, 14 Mar 2020 20:05:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2yrmcs8chr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 20:05:26 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02EK5P1U026258;
 Sat, 14 Mar 2020 20:05:25 GMT
Received: from [192.168.14.112] (/79.179.237.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 14 Mar 2020 13:05:25 -0700
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
To: Nikita Leshenko <nikita.leshchenko@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
 <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
 <20200314151236-mutt-send-email-mst@kernel.org>
 <a9ac1106-67be-5d5d-fd30-669a483f09b0@oracle.com>
 <20200314152119-mutt-send-email-mst@kernel.org>
 <C3D0DD6C-592E-4230-A7D6-FF423265DF03@oracle.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <5f9f6b13-d382-b9a6-52cd-80014c2f01b8@oracle.com>
Date: Sat, 14 Mar 2020 22:05:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <C3D0DD6C-592E-4230-A7D6-FF423265DF03@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140108
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 02EJwoGc040466
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 14/03/2020 21:58, Nikita Leshenko wrote:
>
>> On 14 Mar 2020, at 21:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Sat, Mar 14, 2020 at 09:17:30PM +0200, Liran Alon wrote:
>>> On 14/03/2020 21:14, Michael S. Tsirkin wrote:
>>>> On Sat, Mar 14, 2020 at 09:04:30PM +0200, Liran Alon wrote:
>>>>> On 14/03/2020 20:18, Michael S. Tsirkin wrote:
>>>>>> On Fri, Mar 13, 2020 at 06:26:54PM +0200, Liran Alon wrote:
>>>>>>> On 13/03/2020 17:47, Michael S. Tsirkin wrote:
>>>>>>>> On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
>>>>>>>>>>> @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void=
 *opaque, uint32_t addr)
>>>>>>>>>>>          return ram_size;
>>>>>>>>>>>      }
>>>>>>>>>>> +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
>>>>>>>>>>> +{
>>>>>>>>>>> +    X86CPU *cpu =3D X86_CPU(current_cpu);
>>>>>>>>>>> +    qemu_timeval tv;
>>>>>>>>>>> +
>>>>>>>>>>> +    if (qemu_gettimeofday(&tv) < 0) {
>>>>>>>>>>> +        return UINT32_MAX;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    cpu->env.regs[R_EBX] =3D (uint32_t)tv.tv_usec;
>>>>>>>>>>> +    cpu->env.regs[R_ECX] =3D port_state->max_time_lag_us;
>>>>>>>>>>> +    return (uint32_t)tv.tv_sec;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>      /* vmmouse helpers */
>>>>>>>>>>>      void vmmouse_get_data(uint32_t *data)
>>>>>>>>>>>      {
>>>>>>>>>> That's a very weird thing to return to the guest.
>>>>>>>>>> For example it's not monotonic across migrations.
>>>>>>>>> That's the VMware PV interface... I didn't design it. :P
>>>>>>>>> Regarding how it handles the fact time is not monotonic across =
migrations,
>>>>>>>>> see big comment at the start of services/plugins/timeSync/timeS=
ync.c in
>>>>>>>>> open-vm-tools regarding the time-sync algorithm used by VMware =
Tools.
>>>>>>>>> Specifically:
>>>>>>>>> """
>>>>>>>>> During normal operation this plugin only steps the time forward=
 and only if
>>>>>>>>> the error is greater than one second.
>>>>>>>> Looks like guest assumes this time only moves forward.
>>>>>>>> So something needs to be done to avoid it moving
>>>>>>>> backward across migrations.
>>>>>>> Where do you see this assumption in guest code? I don't think thi=
s is true.
>>>>>>> Guest code seems to handle this by making sure to only step the t=
ime
>>>>>>> forward.
>>>>>> Exactly. So if host time moved backward e.g. by 100s, then for 100=
s
>>>>>> time is not correcting. Which possibly vmware has a way to mitigat=
e
>>>>>> against e.g. by synchronising host time using their
>>>>>> management app.
>>>>>>
>>>>>>> Read carefully services/plugins/timeSync/timeSync.c and point me =
to what I'm
>>>>>>> missing if you think otherwise (i.e. I missed something).
>>>>>> I'm just going by what you write in a patch.
>>>>>>
>>>>> So guest doesn't assume that this time only moves forward...
>>>>>
>>>>> Can you clarify then which change do you suggest making to this pat=
ch in
>>>>> this regard? It seems correct to me.
>>>>> i.e. The CMD_GETTIME implementation seems correct to me and it does=
n't need
>>>>> to do anything special to handle host time moving backwards.
>>>>>
>>>>> -Liran
>>>>>
>>>> I think something needs to be done to make sure host time as reporte=
d by
>>>> this command does not move backwards significantly. Just forwarding
>>>> gettimeofday won't cut it IMHO. Look at kvm clock for inspiration of
>>>> things to do.
>>>>
>>> It isn't required by the command interface definition.
>>> It's explicitly specified in timeSync.c that guest code handles the c=
ase
>>> host time goes backwards.
>> According to what you wrote it does not crash but also does not do
>> updates. That will work well only if the time difference isn't large.
>> Then with time as guest gets interrupted by host, the time difference
>> shrinks and eventually you are resyncing again.  And I'm guessing ther=
e
>> are hypervisor management interfaces in place to make sure that is so.
>> Linux is not guaranteed to have such interfaces so you have to come
>> up with QEMU specific ones.
>>
>>
>>> We are not inventing the interface, we just implement it according to=
 it's
>>> definition.
>>>
>>> -Liran
>> Host time is a vague enough terminology. I suspect this implementation
>> is too simplistic to cover all cases.
>>
>> --=20
>> MST
> I saw this discussion from the side and I just wanted to point out that=
 as far
> as I understand this interface is needed to sync *wallclock time* betwe=
en the
> guest and the host, mostly for user experience. There is no guarantee t=
hat it's
> monotonic. Unlike TSC, we don't need to take special care with regard t=
o live
> migration or drift.
>
> Just as NTP may report inconsistent time, it's OK if this interface is =
somewhat
> inconsistent.
>
> I think that the reason that open-vm-tools doesn't move time backwards =
is to
> help applications that treat wallclock time as if it's monotonic time a=
nd break
> if the date is moved backwards (which may happen more frequently in vir=
tual
> environment so it's handled specifically). But this doesn't change the =
fact that
> this PV interface is for reporting wall time. So I couldn't understand =
what
> source other than gettimeofday() you were suggesting for Liran to use t=
o report
> wallclock time.
>
> Nikita
>
Michael, you can also refer to this VMware time-keeping whitepaper:=20
https://www.vmware.com/pdf/vmware_timekeeping.pdf.
According to section "Initializing and Correcting Wall-Clock Time":
"""
VMware Tools can also optionally be used to correct long=E2=80=90term dri=
ft and=20
errors by periodically
resynchronizing the virtual machine=E2=80=99s clock to the host=E2=80=99s=
 clock, but the=20
current version at this writing is limited.
In particular, in guest operating systems other than NetWare, it does=20
not correct errors in which the guest clock
is ahead of real time, only those in which the guest clock is behind.

"""

If I understand correctly, this seems to validate my assumption that=20
current implementation for CMD_GETTIME is sufficient.

-Liran




