Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3025DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651E421534
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiDdlumT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651E421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwZF-00051F-H3
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZwYS-00044o-RJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZwYQ-0003w6-SY
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604410853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpaG3BHBdogcMUMYXWiyQnZNn1HxFTy5lZjwuwQTBag=;
 b=EiDdlumTTZTNUchL7ZqapoJU4momxyttzxxmESIwSxnJ8x3uazwRWRrEnZqH6HgG/Hk1A5
 vMOMrGigw9LHplPMQkX1i9YpLLjdXwiafeNZgQ3FLWmJyrBgqrT+yoahg0Xm0JZNp6esFs
 /8UHfsIgzpUO8mIOUfRwHihAciDNsPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-LwaSWJrnNwapQBxg1oIzMQ-1; Tue, 03 Nov 2020 08:40:50 -0500
X-MC-Unique: LwaSWJrnNwapQBxg1oIzMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F71B1009E23;
 Tue,  3 Nov 2020 13:40:49 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.195.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 221B575121;
 Tue,  3 Nov 2020 13:40:45 +0000 (UTC)
Subject: Re: [PATCH] block: Move bdrv_drain_all_end_quiesce() to block_int.h
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <160387245480.131299.13430357162209598411.stgit@bahia>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1e7a2ba5-6e91-af27-30d6-8dca701b7350@redhat.com>
Date: Tue, 3 Nov 2020 14:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160387245480.131299.13430357162209598411.stgit@bahia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28.10.20 09:07, Greg Kurz wrote:
> This function is really an internal helper for bdrv_close(). Update its
> doc comment to make this clear and make the function private.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> As suggested by Stefan here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg08235.html
> ---
>  include/block/block.h     |    6 ------
>  include/block/block_int.h |    9 +++++++++
>  2 files changed, 9 insertions(+), 6 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


