Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5222072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vITi8iYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5222072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJG8M-0005Bm-JK
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jJG7h-0004gE-Ab
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jJG7f-0002kN-Ca
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:36:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jJG7f-0002hU-3d
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:36:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VCRaoc033169;
 Tue, 31 Mar 2020 12:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=T/tOJ0go8pHME2jIhdsTJ3Yl9/RlCFmTn7CXmAC6+nc=;
 b=vITi8iYrNoPC9veFmVKItc0s9z5ljiFPc+JCDyBGNt2h6TcuAB9YuU6NT9+D5ItpSFX2
 ze9R4k7Yc92P45pIydsvgQaUR7NzP7wlHHqDnoYKZbfhv/HtXetnMHLyTVj2cGATmEys
 BvoVE/rnFc+HYchGccRamwmIRGg8KbjEtU6YWpTToPerEOOwJzJTKFvcwLs0iOFz1YWr
 SfgZRtFGJV4u1MCR9/HBbahWkr2tW1iuU9SqWY8TQbzBlALitIJmfgPMzwRFtL5iJ2CK
 9irhNn3ZVzBFwy1YApg2V+SKKfziZV+B9BDyAtkQAivTzI3k4fELsAEyOYPeE4mY6C6q 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 303ceuy8nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 12:35:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VCR1xd099443;
 Tue, 31 Mar 2020 12:35:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 302gccf4px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 12:35:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02VCZsD5003166;
 Tue, 31 Mar 2020 12:35:54 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 31 Mar 2020 05:35:54 -0700
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
From: Liran Alon <liran.alon@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
 <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
 <20200314151236-mutt-send-email-mst@kernel.org>
 <a9ac1106-67be-5d5d-fd30-669a483f09b0@oracle.com>
 <20200314152119-mutt-send-email-mst@kernel.org>
 <C3D0DD6C-592E-4230-A7D6-FF423265DF03@oracle.com>
 <5f9f6b13-d382-b9a6-52cd-80014c2f01b8@oracle.com>
 <20200314164850-mutt-send-email-mst@kernel.org>
 <641cf9e0-f24d-3387-1db8-0fd768967121@oracle.com>
 <94a0992f-e163-9664-d9e6-89a35259b73a@oracle.com>
Message-ID: <a849e7e6-8dda-921a-4cac-a2ca770bc61d@oracle.com>
Date: Tue, 31 Mar 2020 15:35:50 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <94a0992f-e163-9664-d9e6-89a35259b73a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310114
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 02VCRaoc033169
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


On 22/03/2020 13:22, Liran Alon wrote:
>
> On 15/03/2020 13:56, Liran Alon wrote:
>>
>> On 14/03/2020 22:56, Michael S. Tsirkin wrote:
>>> On Sat, Mar 14, 2020 at 10:05:20PM +0200, Liran Alon wrote:
>>>> Michael, you can also refer to this VMware time-keeping whitepaper:
>>>> https://urldefense.com/v3/__https://www.vmware.com/pdf/vmware_timeke=
eping.pdf__;!!GqivPVa7Brio!K8sfnfvVgKwrQ4SMwX-K6-S5yR4ln9_qZ6o4GzIpQkohfW=
tinlplNhXzFlyUgks$=20
>>>> .
>>>> According to section "Initializing and Correcting Wall-Clock Time":
>>>> """
>>>> VMware Tools can also optionally be used to correct long=E2=80=90ter=
m drift=20
>>>> and
>>>> errors by periodically
>>>> resynchronizing the virtual machine=E2=80=99s clock to the host=E2=80=
=99s clock,=20
>>>> but the
>>>> current version at this writing is limited.
>>>> In particular, in guest operating systems other than NetWare, it=20
>>>> does not
>>>> correct errors in which the guest clock
>>>> is ahead of real time, only those in which the guest clock is behind.
>>>>
>>>> """
>>> This talks about guest time.
>>> What this does not mention is whether hosts need to employ any=20
>>> mechanisms
>>> to synchronise wall clock between hosts.
>> The above mentioned whitepaper also discuss how VMware maintains the=20
>> wallclock time across migrations (vMotion).
>> See section "Using VMware Tools Clock Synchronization" in whitepaper.
>>
>> Specifically, there is an option in .vmx file named=20
>> "time.synchronize.resume.disk" which:
>> """
>> If set to TRUE, the clock syncs after resuming from suspend and after=20
>> migrating to a new host using the VMware VMotion feature.
>> """
>>
>> The matching functionality in open-vm-tools can can be seen in=20
>> services/plugins/timeSync/timeSync.c where ToolsOnLoad()
>> registers the "Time_Synchronize" RpcCallback, which is=20
>> TimeSyncTcloHandler(), that is possibly allowed to sync time=20
>> backwards (Note the "backwardSync" var).
>>
>> The current patch-series I have submitted doesn't implement this=20
>> RpcCallback functionality.
>> That work can be delayed to a future patch-series that will add this=20
>> extra functionality as-well.
>>
>>>> If I understand correctly, this seems to validate my assumption=20
>>>> that current
>>>> implementation for CMD_GETTIME is sufficient.
>>> So I am concerned this does not interact well with other time sources
>>> in QEMU. For example, it's very useful to set guest time with -rtc ba=
se
>>> flag.
>>>
>>> Can you use qemu_get_timedate?
>>>
>> This is a very good point.
>> VMware also have the ability that allows user to explicitly set guest=20
>> time with .vmx "rtc.startTime" option.
>> (The time-zone can also be set by specifying an offset from UTC with=20
>> "rtc.diffFromUTC" option)
>>
>> However, if you will read section "Using VMware Tools Clock=20
>> Synchronization -> Disabling All Synchronization" in above mentioned=20
>> whitepaper,
>> you will notice that in VMware's design, VMPort CMD_GETTIME command=20
>> is intentionally not synced with virtual CMOS TOD. i.e. The section=20
>> explicitly
>> documents that if a user wants to set guest time to fictitious time,=20
>> user must disable VMware Tools time sync functionality by manipulating
>> "tools.syncTime" and "time.synchronize.*" configuration options as=20
>> desired.
>>
>> Therefore, I think current patch VMPort CMD_GETTIME command=20
>> implementation is correct.
>> What do you think?
>>
>> -Liran
>>
> Gentle ping.
>
> I would like to send the next version of the patch-series.
> But before I do, I would like to know what we have agreed upon=20
> regarding this patch.
>
> Thanks,
> -Liran
>
Another gentle ping before I send v4 of patch-series.

Thanks,
-Liran



