Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD92C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EBF222CD
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN+l1G3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EBF222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX54X-0005At-IX
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iX53a-0004YO-RA
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iX53W-0003iE-Mm
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:04:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48278
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iX53W-0003hs-FG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574175877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGjBkIAy5+WhJ7q1IacL/KDYyDC+3EdL9vxspMfaCSc=;
 b=HN+l1G3GXSW3MlFkCHtf+kBbekemnEqKyh/KpwZ4nJG1V/KAWKId/TokQexDEoNFxAf5DV
 A68/uJPXHyuJZB2VNloBTMpfWsclVagPi8UM8yNDzUy2/NpgR+UMbH9bxnJCgHbEC4xIOF
 naL1BI5dHhwC2Hu3/5KZmEhcHaJxHgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-LmWCvOueN6CP0LXzEPRxJw-1; Tue, 19 Nov 2019 10:03:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04E04801E5A;
 Tue, 19 Nov 2019 15:03:18 +0000 (UTC)
Received: from [10.72.12.74] (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE0831001B32;
 Tue, 19 Nov 2019 15:03:12 +0000 (UTC)
Subject: Re: [PATCH v7 0/4] colo: Add support for continuous replication
To: "Zhang, Chen" <chen.zhang@intel.com>, Lukas Straub <lukasstraub2@web.de>, 
 qemu-devel <qemu-devel@nongnu.org>
References: <cover.1571925699.git.lukasstraub2@web.de>
 <20191113173559.0713c27d@luklap>
 <9CFF81C0F6B98A43A459C9EDAD400D7806309C8C@shsmsx102.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <049fdd65-c654-f619-4de1-5a3fe0a2ad5b@redhat.com>
Date: Tue, 19 Nov 2019 23:03:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D7806309C8C@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: LmWCvOueN6CP0LXzEPRxJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/11/19 =E4=B8=8B=E5=8D=888:28, Zhang, Chen wrote:
>
>> -----Original Message-----
>> From: Lukas Straub <lukasstraub2@web.de>
>> Sent: Thursday, November 14, 2019 12:36 AM
>> To: qemu-devel <qemu-devel@nongnu.org>
>> Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
>> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
>> Xie Changlong <xiechanglong.d@gmail.com>; Kevin Wolf
>> <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; qemu-block
>> <qemu-block@nongnu.org>
>> Subject: Re: [PATCH v7 0/4] colo: Add support for continuous replication
>>
>> On Fri, 25 Oct 2019 19:06:31 +0200
>> Lukas Straub <lukasstraub2@web.de> wrote:
>>
>>> Hello Everyone,
>>> These Patches add support for continuous replication to colo. This
>>> means that after the Primary fails and the Secondary did a failover,
>>> the Secondary can then become Primary and resume replication to a new
>> Secondary.
>>> Regards,
>>> Lukas Straub
>>>
>>> v7:
>>>   - clarify meaning of ip's in documentation and note that active and h=
idden
>>>     images just need to be created once
>>>   - reverted removal of bdrv_is_root_node(top_bs) in replication and
>> adjusted
>>>     the top-id=3D parameter in documentation acordingly
>>>
>>> v6:
>>>   - documented the position=3D and insert=3D options
>>>   - renamed replication test
>>>   - clarified documentation by using different ip's for primary and
>>> secondary
>>>   - added Reviewed-by tags
>>>
>>> v5:
>>>   - change syntax for the position=3D parameter
>>>   - fix spelling mistake
>>>
>>> v4:
>>>   - fix checkpatch.pl warnings
>>>
>>> v3:
>>>   - add test for replication changes
>>>   - check if the filter to be inserted before/behind belongs to the
>>> same interface
>>>   - fix the error message for the position=3D parameter
>>>   - rename term "after" -> "behind" and variable "insert_before" ->
>> "insert_before_flag"
>>>   - document the quorum node on the secondary side
>>>   - simplify quorum parameters in documentation
>>>   - remove trailing spaces in documentation
>>>   - clarify the testing procedure in documentation
>>>
>>> v2:
>>>   - fix email formating
>>>   - fix checkpatch.pl warnings
>>>   - fix patchew error
>>>   - clearer commit messages
>>>
>>>
>>> Lukas Straub (4):
>>>    block/replication.c: Ignore requests after failover
>>>    tests/test-replication.c: Add test for for secondary node continuing
>>>      replication
>>>    net/filter.c: Add Options to insert filters anywhere in the filter
>>>      list
>>>    colo: Update Documentation for continuous replication
>>>
>>>   block/replication.c        |  35 +++++-
>>>   docs/COLO-FT.txt           | 224 +++++++++++++++++++++++++++---------=
-
>>>   docs/block-replication.txt |  28 +++--
>>>   include/net/filter.h       |   2 +
>>>   net/filter.c               |  92 ++++++++++++++-
>>>   qemu-options.hx            |  31 ++++-
>>>   tests/test-replication.c   |  52 +++++++++
>>>   7 files changed, 389 insertions(+), 75 deletions(-)
>>>
>> Hello Everyone,
>> So I guess this is ready for merging or will that have to wait until the=
 4.2
>> release is done?
> Due to Qemu 4.2 release schedule, after soft feature freeze(Oct29) the ma=
ster branch does not accept feature changes.
> But I don't know if sub-maintainer(block or net) can queue this series fi=
rst then merge it after 4.2 release?
>
> Thanks
> Zhang Chen


Will try to queue this series.

Thanks


>
>> Regards,
>> Lukas Straub


