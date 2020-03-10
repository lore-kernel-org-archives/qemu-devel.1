Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400BC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD9A20727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="le8L/ns4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD9A20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgVu-00056Q-T2
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBgJI-0001rx-7X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBgJG-0006j1-OU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:56:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBgJF-0006Ze-5m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:56:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AEqx3N160864;
 Tue, 10 Mar 2020 14:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=o/gBr0ijaiU8tOfu2ljig2IMh4oadadSpk649OMhkC8=;
 b=le8L/ns4kLPJtkxgjGdD9ADR3pKI6v/uW6vvU4Ip0/sAYqS5ta20MUMkXjRAb3dw7ei5
 C5QtjosJ6zz4EH5PZ3O72gj7hopECZhYjfdGB5JVaNjDklUX54J96WvVAmbmMQYa9/4J
 Vl3klVJKQIgFgOiGnrhkNYBZKeHZ+1x5RUKy9c2aNu2b884J8VTcQcIqFNGC3U+dsq9b
 YIYiNPC1T7NQJRQ0mLIqKLOoYdiDFHjpb10FAjYCTBf0eDE20qVPxpcuqXvtq3WVxPlX
 /FO1zL9tcKftGMg4Zl3+NmDV6Icj9ja0Uyb1VO0AV8J9V1x41+/1+kRS/VwiyjvXkIIR 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2ym31ue2gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 14:56:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AEWQUc001299;
 Tue, 10 Mar 2020 14:56:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yp8nt8pj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 14:56:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AEuXAp025811;
 Tue, 10 Mar 2020 14:56:33 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 07:56:32 -0700
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
 <20200310053305-mutt-send-email-mst@kernel.org>
 <9213671d-75e9-b4d6-6e3d-c9221c2b7cc4@oracle.com>
 <20200310071934-mutt-send-email-mst@kernel.org>
 <0a826472-2fd4-75f8-2b32-9029fe980556@oracle.com>
 <20200310103555-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <81a85aa1-2ae7-bbe0-3b66-754281d6fa86@oracle.com>
Date: Tue, 10 Mar 2020 16:56:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310103555-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100098
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


On 10/03/2020 16:39, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 04:24:45PM +0200, Liran Alon wrote:
>
>> Re-thinking about this...
>>
>> QEMU VMPort interface was quite broken already (See first patch in series
>> "hw/i386/vmport: Propagate IOPort read to vCPU EAX register").
>> The introduction of that fix already changes the result of all existing
>> commands from guest perspective which relied on return-value from
>> vmport_ioport_read().
>> E.g. CMD_GETVERSION and CMD_GETRAMSIZE.
>>
>> In theory, we should have also made that bug-fix be tied to machine-type. To
>> similarly avoid the issue of migrating a VM from a working VMPort command
>> implementation to a non-working one.
>> i.e. In case of migrating from new QEMU to old QEMU. Do we wish to create a
>> property-flag for that fix as-well?
> Yes, I meants that too. Just include everything in the same property.
It ugly the code with a lot of "if"s for maintaining compatibility for 
guests that somehow relies on interface being broken and unusable.
Can do this but am wondering if it's worth it.
>
>> Or can we just drop all the machine-type
>> flags alltogether (Including the suggested "commands-v2")
>> and declare this the first actually working VMPort implementation?
>>
>> -Liran
> It's hard to be sure no one used this

Well... Both implemented commands (CMD_GETVERSION and CMD_GETRRAMSIZE) 
fails to return their proper value.
CMD_GETVERSION will always return VMPORT_MAGIC that happened to be in 
EAX previously (i.e. return 0x564D5868 instead of 6).
CMD_GETRAMSIZE will always return VMPORT_MAGIC that happened to be in 
EAX previously (i.e. return 0x564D5868 instead of VM RAM size).

If guest somehow relied on this, it is already quite broken...
My belief is that all upstream QEMU users today relies on VMPort only 
for the sake of a functioning VMMouse which is indeed not broken because 
vmmouse_set_data() explicitly override EAX.

> , and the overhead isn't big.  But
> that would be a maintainer call. In any case you need to call this out
> explicitly in the commit log, and I guess block migration for old
> machine types.
>
Blocking migration for old machine-types is a "no go" in my opinion as 
vmport is enabled by default. It will cause too many VMs to need be able 
to backwards migrate.

So it's either doing nothing (as patch-series is now) or adding a flag 
that adds a bunch of ugly "ifs" and is tied to a machine-type.

-Liran



