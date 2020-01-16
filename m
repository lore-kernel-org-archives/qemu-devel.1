Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571EC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE0F206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnGElqag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE0F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is541-0001rG-MG
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1is52u-0000Sv-LY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1is52p-0004Qd-48
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:18:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1is52o-0004Q8-Rx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579180721;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Njat9O9Yvf9BO3EutegTNopEQwKWREg6tK8Trl1cPQ=;
 b=BnGElqagbIc7Yng2xtSdUjlNqVnRY/fD5dFs1C54yljsjvonh/ipl2VBbkO97fV0wPXuH4
 tS3noIxeMzQ2nGOIxVoC7hAx00RmYL44X1kuEdnMkGPkK/sSuD46Sb2sFJsNlRW53jemWn
 bGDJwXYvqRShsa9JkWnBiNCa6+3Qo3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-Dby6_l_uNDiYEXrz89jNFg-1; Thu, 16 Jan 2020 08:18:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7442D8018A7;
 Thu, 16 Jan 2020 13:18:36 +0000 (UTC)
Received: from redhat.com (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47297811FF;
 Thu, 16 Jan 2020 13:18:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 01/12] migration: Add multiRDMA capability support
In-Reply-To: <20200115180907.GH3811@work-vm> (David Alan Gilbert's message of
 "Wed, 15 Jan 2020 18:09:07 +0000")
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-2-fengzhimin1@huawei.com>
 <20200115180907.GH3811@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 16 Jan 2020 14:18:32 +0100
Message-ID: <87r1zz8rpz.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Dby6_l_uNDiYEXrz89jNFg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: quintela@redhat.com
Cc: zhang.zhanghailiang@huawei.com, Zhimin Feng <fengzhimin1@huawei.com>,
 armbru@redhat.com, qemu-devel@nongnu.org, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Zhimin Feng (fengzhimin1@huawei.com) wrote:
>> From: fengzhimin <fengzhimin1@huawei.com>
>>=20
>> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
>
> Instead of creating x-multirdma as a capability and the corresponding
> parameter for the number of channels; it would be better just
> to use the multifd parameters when used with an rdma transport;
> as far as I know multifd doesn't work with rdma at the moment,
> and to the user the idea of multifd over rdma is just the same thing.

I was about to suggest that.  We could setup both capabilities:

multifd + rdma


