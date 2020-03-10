Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4AEC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF358227BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndn3F0CC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF358227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfs4-0008MP-5I
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBfr3-0006cy-1r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBfr1-0007LK-Em
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:27:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBfr1-0007HX-51
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:27:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AERL4e165798;
 Tue, 10 Mar 2020 14:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7sPEnsZlh0Q+4ldNlqJPshQOalB+S3XCEAJJPYrSVzY=;
 b=ndn3F0CCGhYP0VeLCRG70SDChRKrO8XHZYWsOHUtCB8ZuaDFWj12bc1w/3edd+vpmS5d
 3nyRPzrLBAKj1TrrQGYxV29Ups6/gA8hFP2sntTYyAKtPiRxiLkpP1+eBTbw7ht8OgXo
 sJjXYw5akLEpvqBj/Gy/ONt1L0+KAQeDMh3tEBm4G8FS/NAgQPMVTfq04hzpullJg0kX
 slpkq+kQ1W7jbzgghYdhs0ulKRQc8RDABgen7ijjEEa+YJFmiXv2n7UAclkFz3qgHQHx
 oO5PlATmhDVwU16oFs8ehmFTp0oCMVxIjf3wY76H0sq8rhZj543VmEI+DgEa/ZGlAitp 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yp9v60x02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 14:27:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AENC0f156084;
 Tue, 10 Mar 2020 14:24:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2yp8qndv6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 14:24:51 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AEOnKH005295;
 Tue, 10 Mar 2020 14:24:49 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 07:24:49 -0700
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
 <20200310053305-mutt-send-email-mst@kernel.org>
 <9213671d-75e9-b4d6-6e3d-c9221c2b7cc4@oracle.com>
 <20200310071934-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <0a826472-2fd4-75f8-2b32-9029fe980556@oracle.com>
Date: Tue, 10 Mar 2020 16:24:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310071934-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100097
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


On 10/03/2020 13:22, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:13:21PM +0200, Liran Alon wrote:
>> On 10/03/2020 11:34, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 01:54:04AM +0200, Liran Alon wrote:
>>>> This is VMware documented functionallity that some guests rely on.
>>>> Returns the BIOS UUID of the current virtual machine.
>>>>
>>>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>> So this at least seems guest-visible.
>>>
>>> So I suspect you need to add properties to
>>> disable this for old machine types, to avoid
>>> breaking compatibility with live-migration.
>> It is indeed guest visible.
>> In theory, you are right that for every guest-visible change, we should make
>> sure to expose it to only new machine-types.
>>
>> However, in this case, I feel it just unnecessary over-complicates the code.
>> I don't see how a guest which previously failed to use this command, will
>> fail because after Live-Migration it could succeed.
> The reverse can happen, start guest on a new qemu, command seems to
> work, then we migrate and it fails.
>
> And I guess this applies to the version right?
>
>> If you insist, I will add such functionality. In that case, do you think a
>> single flag will suffice for the addition of all new commands
>> (i.e. "commands-version" that it's number specifies set of commands to
>> expose), or you want to have a per-command flag?
>>
>> -Liran
> Can be a single flag but I'd just do it a boolean that enables a group
> of commands. E.g. "commands-v2".
>
Re-thinking about this...

QEMU VMPort interface was quite broken already (See first patch in 
series "hw/i386/vmport: Propagate IOPort read to vCPU EAX register").
The introduction of that fix already changes the result of all existing 
commands from guest perspective which relied on return-value from 
vmport_ioport_read().
E.g. CMD_GETVERSION and CMD_GETRAMSIZE.

In theory, we should have also made that bug-fix be tied to 
machine-type. To similarly avoid the issue of migrating a VM from a 
working VMPort command implementation to a non-working one.
i.e. In case of migrating from new QEMU to old QEMU. Do we wish to 
create a property-flag for that fix as-well? Or can we just drop all the 
machine-type flags alltogether (Including the suggested "commands-v2")
and declare this the first actually working VMPort implementation?

-Liran






