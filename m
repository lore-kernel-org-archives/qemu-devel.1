Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CDDC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FA4206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXQJOGQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FA4206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2BIz-0002EU-Nt
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2BID-0001Wc-BI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2BI8-0001gq-H1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:00:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44869
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2BI8-0001gN-Ca
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581588015;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUTKmGh1dU0s/Jg3OtuJdSCGHkJ32FuVWGo2///9CbE=;
 b=EXQJOGQJMcIYWaMa+BBXpmm0zrNS2Ar76KazVVcfOKjL9dRD4ueG+flHtFEQQyCUX6yoDR
 w9AJT0IAiF+xe4D+iMXxINHDt34hu2/8q3WwOHN6oYCtAsxU6yEaGADqiFHvOCA9VdQx5A
 8eWrrWQDb/YE8P5m0EIJh1oathF+2Xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-Zti-tgdPPbGPsG7FIvGW_A-1; Thu, 13 Feb 2020 05:00:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32FFDB1B9A;
 Thu, 13 Feb 2020 10:00:10 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA78C277B6;
 Thu, 13 Feb 2020 10:00:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: <pannengyuan@huawei.com>
Subject: Re: [PATCH] migration-test: fix some memleaks in migration-test
In-Reply-To: <20200211084557.32109-1-pannengyuan@huawei.com>
 (pannengyuan@huawei.com's message of "Tue, 11 Feb 2020 16:45:57
 +0800")
References: <20200211084557.32109-1-pannengyuan@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 10:59:58 +0100
Message-ID: <87mu9m959d.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Zti-tgdPPbGPsG7FIvGW_A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: lvivier@redhat.com, thuth@redhat.com, zhang.zhanghailiang@huawei.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<pannengyuan@huawei.com> wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> spotted by asan, 'check-qtest-aarch64' runs fail if sanitizers is enabled=
.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


