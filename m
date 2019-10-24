Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95259CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6715E20578
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6715E20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeXk-00077p-V7
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cenjiahui@huawei.com>) id 1iNdYp-0001BU-Jm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cenjiahui@huawei.com>) id 1iNdYm-0002FR-SN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:53:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2254 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cenjiahui@huawei.com>)
 id 1iNdYm-00027P-GS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:53:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2DFB7ED8112EB3F97DF3;
 Thu, 24 Oct 2019 21:53:45 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.89) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 24 Oct 2019
 21:53:35 +0800
Subject: Re: [PATCH 3/3] migration/multifd: fix potential wrong acception
 order of IOChannel
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191023033214.31592-1-cenjiahui@huawei.com>
 <20191023033214.31592-3-cenjiahui@huawei.com>
 <20191024095227.GC3700@redhat.com>
From: cenjiahui <cenjiahui@huawei.com>
Message-ID: <1356aa1a-346d-29a7-8064-ac1e572b6512@huawei.com>
Date: Thu, 24 Oct 2019 21:53:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024095227.GC3700@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.173.220.89]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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

On 2019/10/24 17:52, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Oct 23, 2019 at 11:32:14AM +0800, cenjiahui wrote:
>> From: Jiahui Cen <cenjiahui@huawei.com>
>>
>> Multifd assumes the migration thread IOChannel is always established b=
efore
>> the multifd IOChannels, but this assumption will be broken in many sit=
uations
>> like network packet loss.
>>
>> For example:
>> Step1: Source (migration thread IOChannel)  --SYN-->  Destination
>> Step2: Source (migration thread IOChannel)  <--SYNACK  Destination
>> Step3: Source (migration thread IOChannel, lost) --ACK-->X  Destinatio=
n
>> Step4: Source (multifd IOChannel) --SYN-->    Destination
>> Step5: Source (multifd IOChannel) <--SYNACK   Destination
>> Step6: Source (multifd IOChannel, ESTABLISHED) --ACK-->  Destination
>> Step7: Destination accepts multifd IOChannel
>> Step8: Source (migration thread IOChannel, ESTABLISHED) -ACK,DATA->  D=
estination
>> Step9: Destination accepts migration thread IOChannel
>>
>> The above situation can be reproduced by creating a weak network envir=
onment,
>> such as "tc qdisc add dev eth0 root netem loss 50%". The wrong accepti=
on order
>> will cause magic check failure and thus lead to migration failure.
>>
>> This patch fixes this issue by sending a migration IOChannel initial p=
acket with
>> a unique id when using multifd migration. Since the multifd IOChannels=
 will also
>> send initial packets, the destination can judge whether the processing=
 IOChannel
>> belongs to multifd by checking the id in the initial packet. This mech=
anism can
>> ensure that different IOChannels will go to correct branches in our te=
st.
>=20
> Isn't this going to break back compatibility when new QEMU talks to old
> QEMU with multifd enabled ? New QEMU will be sending a packet that old
> QEMU isn't expecting IIUC.

Yes, it actually breaks back compatibility. But since the old QEMU has bu=
g with
multifd, it may be not suitable to use multifd to migrate from new QEMU t=
o old
QEMU in my opinion.

Hi, Quintela, how do you think about this ?

>=20
>> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
>> Signed-off-by: Ying Fang <fangying1@huawei.com>

Regards,
Jiahui Cen


