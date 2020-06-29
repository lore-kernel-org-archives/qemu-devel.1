Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4125A25500
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JohjUzvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4125A25500
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpw6v-00073Z-J4
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jpw68-0006ao-Rt
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:53:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42420
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jpw67-0006we-AJ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593446010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9uliNlBDyG0ClW0G9ORtNvWZzobXMY9rP0m1A3WEGI=;
 b=JohjUzvE78ANXyg8MT802ITw0jZW/sXJqw+S7kzccdQtLdYbXygEhpj/FZBv6Cxeq4r0yt
 Lnj9NnqRaxUBqxcKUMUuuDluc0q0GVJ3RdA5mov1+l3cxWzYFTX+ASHbNTZ6wn3Yu8RMeq
 vS9LYx2XGOc1r1aiSf1aziiv4m9HsP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-FZW9uT5JPIaHtkTb6hxHpw-1; Mon, 29 Jun 2020 11:53:26 -0400
X-MC-Unique: FZW9uT5JPIaHtkTb6hxHpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C71BC804016;
 Mon, 29 Jun 2020 15:53:25 +0000 (UTC)
Received: from gondolin (ovpn-113-61.ams2.redhat.com [10.36.113.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F27119D7E;
 Mon, 29 Jun 2020 15:53:18 +0000 (UTC)
Date: Mon, 29 Jun 2020 17:52:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 04/12] pc-bios: s390x: Get rid of magic offsets into
 the lowcore
Message-ID: <20200629175235.0181b513.cohuck@redhat.com>
In-Reply-To: <20200624075226.92728-5-frankja@linux.ibm.com>
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 03:52:18 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> If we have a lowcore struct that has members for offsets that we want
> to touch, why not use it?
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  pc-bios/s390-ccw/cio.h  | 17 +++++++++++------
>  pc-bios/s390-ccw/main.c |  8 +++-----
>  2 files changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


