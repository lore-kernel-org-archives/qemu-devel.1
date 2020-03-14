Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65849C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D9C2078D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VEM2Er9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D9C2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDD8X-0007lU-BL
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 16:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nikita.leshchenko@oracle.com>) id 1jDCve-0004Lj-OF
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nikita.leshchenko@oracle.com>) id 1jDCvc-00088Q-Qu
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:58:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nikita.leshchenko@oracle.com>)
 id 1jDCvc-000832-Gu
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:58:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EJmfKr110441;
 Sat, 14 Mar 2020 19:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=JCC0toQ8BKs5HzKV+cemPvXmyN5C1SAkHV880LQftEw=;
 b=VEM2Er9DCfMDEQyLb0ZnfaB/GXqWn1aK1nCL24oSGC7/GeE/ow817lQIfi0Yo1Hh1Hbb
 fAwxMNB8i9rOJJZYGGNTK1KC4fydBs8R8hqeZshr1bCEUZq3LtKrybrvgQcxAs2FCO5G
 MgthBPjjpcnj5dTHvUHcTm1yT2Gt36H3+r6W2Z/PjTkJce93mC0o/bF9kiYR1fAIVbVx
 V3kfaT083Zx9ieXXOpHXbXaMr5zLJMDd2arMFtvnqyrwVft0hI30Gnlx4Ez4z5kMoKPd
 UPxAUWCraiNfe6sRp9GRs/9hXD5mKSkgGdwSctj+Lfm6sMpSeI0b7pL/dFBJUMlKQLXt iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2yrppqsjum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 19:58:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EJwS9a128445;
 Sat, 14 Mar 2020 19:58:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yrpkhew45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 19:58:31 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02EJwUee024157;
 Sat, 14 Mar 2020 19:58:30 GMT
Received: from wintermute.home (/213.57.201.13)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 14 Mar 2020 12:58:29 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
From: Nikita Leshenko <nikita.leshchenko@oracle.com>
In-Reply-To: <20200314152119-mutt-send-email-mst@kernel.org>
Date: Sat, 14 Mar 2020 21:58:23 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3D0DD6C-592E-4230-A7D6-FF423265DF03@oracle.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003140107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
X-Mailman-Approved-At: Sat, 14 Mar 2020 16:11:22 -0400
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
 Liran Alon <liran.alon@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 14 Mar 2020, at 21:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Sat, Mar 14, 2020 at 09:17:30PM +0200, Liran Alon wrote:
>>=20
>> On 14/03/2020 21:14, Michael S. Tsirkin wrote:
>>> On Sat, Mar 14, 2020 at 09:04:30PM +0200, Liran Alon wrote:
>>>> On 14/03/2020 20:18, Michael S. Tsirkin wrote:
>>>>> On Fri, Mar 13, 2020 at 06:26:54PM +0200, Liran Alon wrote:
>>>>>> On 13/03/2020 17:47, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
>>>>>>>>>> @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void =
*opaque, uint32_t addr)
>>>>>>>>>>         return ram_size;
>>>>>>>>>>     }
>>>>>>>>>> +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
>>>>>>>>>> +{
>>>>>>>>>> +    X86CPU *cpu =3D X86_CPU(current_cpu);
>>>>>>>>>> +    qemu_timeval tv;
>>>>>>>>>> +
>>>>>>>>>> +    if (qemu_gettimeofday(&tv) < 0) {
>>>>>>>>>> +        return UINT32_MAX;
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    cpu->env.regs[R_EBX] =3D (uint32_t)tv.tv_usec;
>>>>>>>>>> +    cpu->env.regs[R_ECX] =3D port_state->max_time_lag_us;
>>>>>>>>>> +    return (uint32_t)tv.tv_sec;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>     /* vmmouse helpers */
>>>>>>>>>>     void vmmouse_get_data(uint32_t *data)
>>>>>>>>>>     {
>>>>>>>>> That's a very weird thing to return to the guest.
>>>>>>>>> For example it's not monotonic across migrations.
>>>>>>>> That's the VMware PV interface... I didn't design it. :P
>>>>>>>> Regarding how it handles the fact time is not monotonic across =
migrations,
>>>>>>>> see big comment at the start of =
services/plugins/timeSync/timeSync.c in
>>>>>>>> open-vm-tools regarding the time-sync algorithm used by VMware =
Tools.
>>>>>>>> Specifically:
>>>>>>>> """
>>>>>>>> During normal operation this plugin only steps the time forward =
and only if
>>>>>>>> the error is greater than one second.
>>>>>>> Looks like guest assumes this time only moves forward.
>>>>>>> So something needs to be done to avoid it moving
>>>>>>> backward across migrations.
>>>>>> Where do you see this assumption in guest code? I don't think =
this is true.
>>>>>> Guest code seems to handle this by making sure to only step the =
time
>>>>>> forward.
>>>>> Exactly. So if host time moved backward e.g. by 100s, then for =
100s
>>>>> time is not correcting. Which possibly vmware has a way to =
mitigate
>>>>> against e.g. by synchronising host time using their
>>>>> management app.
>>>>>=20
>>>>>> Read carefully services/plugins/timeSync/timeSync.c and point me =
to what I'm
>>>>>> missing if you think otherwise (i.e. I missed something).
>>>>> I'm just going by what you write in a patch.
>>>>>=20
>>>> So guest doesn't assume that this time only moves forward...
>>>>=20
>>>> Can you clarify then which change do you suggest making to this =
patch in
>>>> this regard? It seems correct to me.
>>>> i.e. The CMD_GETTIME implementation seems correct to me and it =
doesn't need
>>>> to do anything special to handle host time moving backwards.
>>>>=20
>>>> -Liran
>>>>=20
>>> I think something needs to be done to make sure host time as =
reported by
>>> this command does not move backwards significantly. Just forwarding
>>> gettimeofday won't cut it IMHO. Look at kvm clock for inspiration of
>>> things to do.
>>>=20
>> It isn't required by the command interface definition.
>> It's explicitly specified in timeSync.c that guest code handles the =
case
>> host time goes backwards.
>=20
> According to what you wrote it does not crash but also does not do
> updates. That will work well only if the time difference isn't large.
> Then with time as guest gets interrupted by host, the time difference
> shrinks and eventually you are resyncing again.  And I'm guessing =
there
> are hypervisor management interfaces in place to make sure that is so.
> Linux is not guaranteed to have such interfaces so you have to come
> up with QEMU specific ones.
>=20
>=20
>> We are not inventing the interface, we just implement it according to =
it's
>> definition.
>>=20
>> -Liran
>=20
> Host time is a vague enough terminology. I suspect this implementation
> is too simplistic to cover all cases.
>=20
> --=20
> MST

I saw this discussion from the side and I just wanted to point out that =
as far
as I understand this interface is needed to sync *wallclock time* =
between the
guest and the host, mostly for user experience. There is no guarantee =
that it's
monotonic. Unlike TSC, we don't need to take special care with regard to =
live
migration or drift.

Just as NTP may report inconsistent time, it's OK if this interface is =
somewhat
inconsistent.

I think that the reason that open-vm-tools doesn't move time backwards =
is to
help applications that treat wallclock time as if it's monotonic time =
and break
if the date is moved backwards (which may happen more frequently in =
virtual
environment so it's handled specifically). But this doesn't change the =
fact that
this PV interface is for reporting wall time. So I couldn't understand =
what
source other than gettimeofday() you were suggesting for Liran to use to =
report
wallclock time.

Nikita


