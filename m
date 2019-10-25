Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4651CA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4C421929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4C421929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu6k-0000yu-0s
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cenjiahui@huawei.com>) id 1iNtVS-0000Wv-5F
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cenjiahui@huawei.com>) id 1iNtVP-0006rc-Tx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:55:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2182 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cenjiahui@huawei.com>)
 id 1iNtVP-0006p4-Fb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:55:27 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D07F5175642E26038DAF;
 Fri, 25 Oct 2019 14:55:22 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.89) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 14:55:15 +0800
Subject: Re: [PATCH 3/3] migration/multifd: fix potential wrong acception
 order of IOChannel
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191023033214.31592-1-cenjiahui@huawei.com>
 <20191023033214.31592-3-cenjiahui@huawei.com>
 <20191024095227.GC3700@redhat.com>
 <1356aa1a-346d-29a7-8064-ac1e572b6512@huawei.com>
 <20191024143450.GF8381@redhat.com>
From: Jiahui Cen <cenjiahui@huawei.com>
Message-ID: <99e4b06e-c36b-b8a8-96bf-623a43e032b8@huawei.com>
Date: Fri, 25 Oct 2019 14:55:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024143450.GF8381@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.173.220.89]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, zhouyibo3@huawei.com,
 dgilbert@redhat.com, peterx@redhat.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/10/24 22:34, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Oct 24, 2019 at 09:53:24PM +0800, cenjiahui wrote:
>> On 2019/10/24 17:52, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Oct 23, 2019 at 11:32:14AM +0800, cenjiahui wrote:
>>>> From: Jiahui Cen <cenjiahui@huawei.com>
>>>>
>>>> Multifd assumes the migration thread IOChannel is always established=
 before
>>>> the multifd IOChannels, but this assumption will be broken in many s=
ituations
>>>> like network packet loss.
>>>>
>>>> For example:
>>>> Step1: Source (migration thread IOChannel)  --SYN-->  Destination
>>>> Step2: Source (migration thread IOChannel)  <--SYNACK  Destination
>>>> Step3: Source (migration thread IOChannel, lost) --ACK-->X  Destinat=
ion
>>>> Step4: Source (multifd IOChannel) --SYN-->    Destination
>>>> Step5: Source (multifd IOChannel) <--SYNACK   Destination
>>>> Step6: Source (multifd IOChannel, ESTABLISHED) --ACK-->  Destination
>>>> Step7: Destination accepts multifd IOChannel
>>>> Step8: Source (migration thread IOChannel, ESTABLISHED) -ACK,DATA-> =
 Destination
>>>> Step9: Destination accepts migration thread IOChannel
>>>>
>>>> The above situation can be reproduced by creating a weak network env=
ironment,
>>>> such as "tc qdisc add dev eth0 root netem loss 50%". The wrong accep=
tion order
>>>> will cause magic check failure and thus lead to migration failure.
>>>>
>>>> This patch fixes this issue by sending a migration IOChannel initial=
 packet with
>>>> a unique id when using multifd migration. Since the multifd IOChanne=
ls will also
>>>> send initial packets, the destination can judge whether the processi=
ng IOChannel
>>>> belongs to multifd by checking the id in the initial packet. This me=
chanism can
>>>> ensure that different IOChannels will go to correct branches in our =
test.
>>>
>>> Isn't this going to break back compatibility when new QEMU talks to o=
ld
>>> QEMU with multifd enabled ? New QEMU will be sending a packet that ol=
d
>>> QEMU isn't expecting IIUC.
>>
>> Yes, it actually breaks back compatibility. But since the old QEMU has=
 bug with
>> multifd, it may be not suitable to use multifd to migrate from new QEM=
U to old
>> QEMU in my opinion.
>=20
> We declared multifd supported from v4.0.0 onwards, so changing the wire
> protocol in non-backwards compatibles ways is not acceptable IMHO.
>=20
> Ideally we'd change QEMU so that the src QEMU serializes the connection=
s,
> such that the migration thread I/O channel is established before we att=
empt
> to establish the multifd channels.
>=20
> If changing the wire protocol is unavoidable, then we'd need to invent
> a new migration capability for the mgmt apps to detect & opt-in to when
> both sides support it.

I think the src QEMU cannot promise the serialization of the connections.
Multifd is designed as that the migration thread I/O channel is establish=
ed
first which only promises the serialization in the source. Whether the
destination can establish the connections in order depends on the network=
.

Without the correct order, the Destination cannot distinguish the connect=
ions
unless it reads something from the channels.

I think there is a somewhat ugly solution to fix this issue, since the mi=
gration
thread will first send vm state header with a MAGIC different from the mu=
ltifd
initial packet's at the beginning of the migration, we may read it in adv=
ance to
judge the connection so that we do not need to send an additional packet =
for
migration thread I/O channel. But it has to keep the content of the packe=
t for
the future use. And in this way, the Source has already been sending data=
 to
migrate, but the Destination is just ready to start migration.

Have you got any good idea on this issue ?

Regrads,
Jiahui Cen


