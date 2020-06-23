Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC8EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6772D20771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gc8l4Kae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6772D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnbtW-0003AY-KC
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 01:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jnbsd-000249-3L
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:53:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52007
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jnbsa-0005vV-LH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592891634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nY61ML5SpauzNIz6HOn/xGT/tad0uOH5atuXkEbuv14=;
 b=Gc8l4KaeNuKbzIfkvxxd2a7SWAPn14YP3d0SMWfXdQlUzAsUg0ac1hTnsx34/FhaQuC5tz
 tVjQMVzIVkPISXJv0UnthTq4Py26Tu25P26QeigI0wzE5H430pGiy6DbxsBvool9pZ9t+4
 cUSao+lPkB+d2MkvWAY9RHeewZPqx4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-_ucQCOtbPrq_hzgb4XrsjA-1; Tue, 23 Jun 2020 01:53:51 -0400
X-MC-Unique: _ucQCOtbPrq_hzgb4XrsjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A1AA0BD8;
 Tue, 23 Jun 2020 05:53:50 +0000 (UTC)
Received: from [10.72.12.144] (ovpn-12-144.pek2.redhat.com [10.72.12.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD8951992F;
 Tue, 23 Jun 2020 05:53:48 +0000 (UTC)
Subject: Re: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
To: "Zhang, Chen" <chen.zhang@intel.com>, Lukas Straub <lukasstraub2@web.de>
References: <20200411033824.19389-1-chen.zhang@intel.com>
 <c8ce4348-d81c-1d10-ff82-74be39a03b5a@redhat.com>
 <20200619194611.057b48ed@luklap> <5660d3b43c8d4fb4ab0a42e0bf67eaa4@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cb77d0c2-f3ee-2ba9-e495-3fc325eb122c@redhat.com>
Date: Tue, 23 Jun 2020 13:53:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5660d3b43c8d4fb4ab0a42e0bf67eaa4@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/23 上午9:47, Zhang, Chen wrote:
>
>> -----Original Message-----
>> From: Lukas Straub <lukasstraub2@web.de>
>> Sent: Saturday, June 20, 2020 1:47 AM
>> To: Jason Wang <jasowang@redhat.com>
>> Cc: Zhang, Chen <chen.zhang@intel.com>; qemu-dev <qemu-
>> devel@nongnu.org>; Zhang Chen <zhangckid@gmail.com>
>> Subject: Re: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to
>> users and clean up
>>
>> On Fri, 24 Apr 2020 10:19:48 +0800
>> Jason Wang <jasowang@redhat.com> wrote:
>>
>>> On 2020/4/11 上午11:38, Zhang Chen wrote:
>>>> From: Zhang Chen <chen.zhang@intel.com>
>>>>
>>>> This series make a way to config COLO "max_queue_size" parameters
>>>> according to user's scenarios and environments and do some clean up for
>> descriptions.
>>>> Zhang Chen (2):
>>>>     net/colo-compare.c: Expose compare "max_queue_size" to users
>>>>     qemu-options.hx: Clean up and fix typo for colo-compare
>>>>
>>>>    net/colo-compare.c | 43
>> ++++++++++++++++++++++++++++++++++++++++++-
>>>>    qemu-options.hx    | 33 +++++++++++++++++----------------
>>>>    2 files changed, 59 insertions(+), 17 deletions(-)
>>>
>>> Queued for 5.1.
>>>
>>> Thanks
>>>
>>>
>> Hi,
>> It looks like this hasn't been merged.
> Thanks Lukas.
> Hi Jason, I have double checked on upstream, looks missed this series.
>
> Thanks
> Zhang Chen


Right, but unfortunately it can't be applied cleanly on master.

Please send a new version.

Sorry.

Thanks


>
>> Regards,
>> Lukas Straub


