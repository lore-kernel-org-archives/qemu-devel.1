Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB77C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E422075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g47xRb1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E422075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5FT-0004a7-Ho
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1is5EA-0003XQ-8h
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1is5E6-0006gs-1R
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:30:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1is5E5-0006ga-Tk
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579181421;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7t0zJWs6ejtSvq9N9dStyGYARrQcQQGuna/gmU6rJw=;
 b=g47xRb1VEJl6uW0ppHg+K7eRFa9Qy1ZFgIy2bs/weujLiufPvibaZ7NYozJDEoRrPQSSkD
 nNJ08Rx2ppbF3uKwd9zxh/wlHbsI5SQuY/T7OB1nf6SGuH/Fupte9RBhAN4Wj4HJtNd1PI
 pwzxp8VmXacu6oEt9tfc7henwAkvI8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-NSqoRSEIM3Skt1fV948j_Q-1; Thu, 16 Jan 2020 08:30:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B904C800D48;
 Thu, 16 Jan 2020 13:30:16 +0000 (UTC)
Received: from redhat.com (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E80488894;
 Thu, 16 Jan 2020 13:30:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 05/12] migration/rdma: Create the multiRDMA channels
In-Reply-To: <20200109045922.904-6-fengzhimin1@huawei.com> (Zhimin Feng's
 message of "Thu, 9 Jan 2020 12:59:15 +0800")
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-6-fengzhimin1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 16 Jan 2020 14:30:14 +0100
Message-ID: <87a76n8r6h.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: NSqoRSEIM3Skt1fV948j_Q-1
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
Cc: zhang.zhanghailiang@huawei.com, armbru@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhimin Feng <fengzhimin1@huawei.com> wrote:
> From: fengzhimin <fengzhimin1@huawei.com>
>
> In both sides. We still don't transmit anything through them,
> and we only build the RDMA connections.
>
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>

We need to abstract this on top of multifd, we are doing the equivalent
of the code for thread creation (you have it easier because you are able
to do it with a for, but it is basically the same.


Later, Juan.


