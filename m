Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587D2C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294F620663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yMXfhI5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294F620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCSuA-0003rH-AA
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 14:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCStC-00011y-Rl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCStB-00025F-Bw
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:49:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCStB-00023v-1i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:49:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CIdRsl007431;
 Thu, 12 Mar 2020 18:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1pZKESU6clCTdDAUXIg++LDttMxk9AzmoIA9iqpwR0o=;
 b=yMXfhI5GZG6sUXH/kYmPYaJS0ct7iFFIjyEinZgcXJcCOvaLYOHECbfXVUTVs7zZuOS0
 aAUu+ZHaBgfNyjB+fDEPhM7JvKuqEDSM7biOezEtxwehMXYTcY9qBixtCk57DuBac2iU
 BledkgnkaZciSx3e/ZYnRf72TjfipoxPBrWR69Q3yPvq2MQuBwrJpPzl0/nNO9/l0Ne6
 CA/IGrE91Vg8qLuFG/D8LPZp9dLqHRjJMPyvRsn+3XIRS0rd+9xVhCXU1Itwvft0vHJx
 wjnDzt07m2jZdiVequUisBAwVvxj3Vfgsq7LyPGf+BvDQGCy1ZlU3PUFeEJfzK2eJKBP Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yqtavg4d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 18:48:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CIhExw069070;
 Thu, 12 Mar 2020 18:48:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yqtata53f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 18:48:57 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CImu1t022049;
 Thu, 12 Mar 2020 18:48:56 GMT
Received: from Lirans-MacBook-Pro.local (/10.74.126.186)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 11:48:56 -0700
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: Igor Mammedov <imammedo@redhat.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200311162509-mutt-send-email-mst@kernel.org>
 <92564357-25c1-0a0f-537b-6902f45a88d0@oracle.com>
 <20200312012859-mutt-send-email-mst@kernel.org>
 <8cab6eba-22bc-a62e-d4a8-e2138b815a01@oracle.com>
 <20200312080602-mutt-send-email-mst@kernel.org>
 <adbb172c-a6b2-f2a5-3f35-dbc353e4f716@oracle.com>
 <20200312173527.3a218dc0@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <1cd97deb-be90-5698-a99a-14bd4918a82d@oracle.com>
Date: Thu, 12 Mar 2020 20:48:48 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312173527.3a218dc0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120093
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
Cc: ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/03/2020 18:35, Igor Mammedov wrote:
> On Thu, 12 Mar 2020 14:55:50 +0200
> Liran Alon <liran.alon@oracle.com> wrote:
>
>> On 12/03/2020 14:19, Michael S. Tsirkin wrote:
>>> On Thu, Mar 12, 2020 at 01:30:01PM +0200, Liran Alon wrote:
>>>> On 12/03/2020 8:12, Michael S. Tsirkin wrote:
>>>>> On Thu, Mar 12, 2020 at 01:20:02AM +0200, Liran Alon wrote:
>>>>>> But this is just a good practice in general and in the past it was said by
>>>>>> maintainers that this is one of the main reasons that ACPI and SMBIOS
>>>>>> generation have moved from SeaBIOS to QEMU.
>>>>> I think a flag to disable this might make sense though. For example,
>>>>> some guests might behave differently and get broken.
>>>> Right. That's why I think it's a good practice to have this flag and tie it
>>>> to machine-type.
>>> Tying things to the machine type is not what I had in mind.
>>> A separate flag would also be helpful so users can tweak this
>>> for new machine types, too.
>> I think it's unnecessary, given how common WAET ACPI table is exposed by
>> default by other hypervisors.
>>
>> But if you insist, I can add such flag on a separate commit in v2...
>> Where do you want to have such flag? It cannot be a property of some
>> qdev object.
>> So you want to add a new QEMU_OPTION_no_weat in vl.c?
> If it doesn't break any windows guests we probably don't need an option.
> Can you test if old guests are booting fine with new table, to confirm
> that it's fine? (starting with XPsp3)

Old guests boot fine with the new WAET table.
We are running with this table in production for many years with many 
Windows XP guests (and much more esoteric guests)

Just to verify, I've just now run it with a WinXP SP3 VM and it works 
just fine.
So should I remove the flag completely or remain with the current 
functionality I have that makes sure WAET is only exposed on new 
machine-types?

-Liran

>>>> Guest-visible changes shouldn't be exposed to old machine-types.
>>> Well almost any change in qemu is guest visible to some level.
>>> Even optimizations are guest visible.
>>> We made changes in ACPI without versioning in the past but I'm not
>>> opposed to versioning here. However in that case pls do add a bit
>>> of documentation about why this is done here.
>> I remember that maintainers have explicitly specified that ACPI/SMBIOS
>> should not be changed between machine-types.
>> This have been one of the reasons to move ACPI/SMBIOS generation from
>> SeaBIOS to QEMU control.
>>
>> What can of documentation you want me to add and where?
>> The only thing I can say is that I tie it to machine-type because I do
>> not think a given machine-type should suddenly change BIOS exposed info
>> to guest.
>> But that's kinda generic. I haven't found similar documentation in other
>> ACPI-disable flags to copy from (E.g. do_not_add_smb_acpi).
>>
>>> What I am asking about is whether we need a flag to disable
>>> this as part of the stable interface.
>> I personally think not. But if you think otherwise, can you provide
>> guidance of where you suggest to add this flag?
>> As the only place I see fit is adding a new QEMU_OPTION_no_weat.


