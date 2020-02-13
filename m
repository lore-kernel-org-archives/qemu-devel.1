Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D612C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5976120848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eW8NVRP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5976120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B5s-0003Dc-2L
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2B3e-0001o4-UY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2B3e-0003Au-1H
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:45:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2B3d-00038E-Sk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581587113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCNTPyEWMXf9wrdmS2tbaQJMrdWUEm18wgUPvgql4HI=;
 b=eW8NVRP1J9h6OWO/uCrrLdtUmzc9/vZUfV6M1l6ys18l1NI5DqKwBDUQmjJ0x3DZi+dOpc
 N4KZ79qbAqjcnLS+gc0b7eIly9PBjpP7Mtu3YmUR+XTaFExPMJXXHAT/jpeqfsJiSDMNe/
 /2FDymZpP2GVX8YNcHrhyf0dPI4dubA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-uFUKQ3bgPJKIGihYqZxyiw-1; Thu, 13 Feb 2020 04:45:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6472618C8C15;
 Thu, 13 Feb 2020 09:45:10 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F14C45C1C3;
 Thu, 13 Feb 2020 09:45:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH] migration: Maybe VM is paused when migration is cancelled
In-Reply-To: <20200114094309.1309-1-fengzhimin1@huawei.com> (Zhimin Feng's
 message of "Tue, 14 Jan 2020 17:43:09 +0800")
References: <20200114094309.1309-1-fengzhimin1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 10:45:06 +0100
Message-ID: <87r1yy95y5.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: uFUKQ3bgPJKIGihYqZxyiw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhimin Feng <fengzhimin1@huawei.com> wrote:
> If the migration is cancelled when it is in the completion phase,
> the migration state is set to MIGRATION_STATUS_CANCELLING.
> The VM maybe wait for the 'pause_sem' semaphore in migration_maybe_pause
> function, so that VM always is paused.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


