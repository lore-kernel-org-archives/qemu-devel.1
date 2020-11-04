Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35148C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96F721556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPE5vJ2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96F721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGhx-0005Uj-J7
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaGgQ-00043A-6l
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:10:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaGgN-000899-Uh
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604488227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ym4stqHdPxs79GqIvHAcsYAOMhOSVuYJHxCAfplz2U=;
 b=VPE5vJ2QvGeu6gGRj/56MHRKBU+jKLMM5bvFfM/H5MVU5VVsp/kF8Sbli16amyJ8LYgshw
 tIAxuHtv8ixM+AkmOCSq7Nq/KiryHaVrOMuVAC4GZbs5DVyYtURe64D3wqzDrUiUlSw0ea
 dtq+11mXeqsei0jTu1jaK2RKUMZUbOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-eoqzKHPSNemakeTb5A_Wvg-1; Wed, 04 Nov 2020 06:10:25 -0500
X-MC-Unique: eoqzKHPSNemakeTb5A_Wvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91905879510;
 Wed,  4 Nov 2020 11:10:23 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47C317E19C;
 Wed,  4 Nov 2020 11:10:20 +0000 (UTC)
Subject: Re: [PATCH for-5.2 3/3] hw/block/nvme: fix free of array-typed value
To: Klaus Jensen <its@irrelevant.dk>
References: <20201104102248.32168-1-its@irrelevant.dk>
 <20201104102248.32168-4-its@irrelevant.dk>
 <6b54b9a6-a6f8-3009-b3a9-99aecad6fb3b@redhat.com>
 <20201104110405.GB35038@apples.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c4ccc808-9771-e07e-bd1a-cf9e7fa66d5a@redhat.com>
Date: Wed, 4 Nov 2020 12:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104110405.GB35038@apples.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04.11.20 12:04, Klaus Jensen wrote:
> On Nov  4 11:59, Max Reitz wrote:
>> On 04.11.20 11:22, Klaus Jensen wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> Since 7f0f1acedf15 ("hw/block/nvme: support multiple namespaces"), the
>>> namespaces member of NvmeCtrl is no longer a dynamically allocated
>>> array. Remove the free.
>>>
>>> Fixes: 7f0f1acedf15 ("hw/block/nvme: support multiple namespaces")
>>> Reported-by: Coverity (CID 1436131)
>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>> ---
>>>  hw/block/nvme.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>
>> Thanks! :)
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
> 
> Will Peter pick up fixes like this directly so we don't have to go
> through a pull request from nvme-next?

AFAIA, Peter only picks up build fixes.  Since the build wasn’t broken,
I think someone™ will have to send a pull request...

I understand you don’t necessarily want to be that someone, so I suppose
I might as well.

> Did I correctly annotate with "for-5.2"? :)

Yes!

Max


