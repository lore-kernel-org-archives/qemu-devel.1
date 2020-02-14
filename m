Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3646C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926512187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC7Lk9Uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926512187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2azC-0007Mk-Rw
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j2avT-0002uB-Jx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j2avS-0002Zi-KR
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:22:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j2avS-0002XB-GE
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581686553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rX4XOchnJrCIZQxM22uAMuEb5CRFoK6tNzB5SgCe3Ns=;
 b=UC7Lk9UvhiVmzOXyMil5LWntbhXAMbyhA5ZkzCCSf5zGNSI0sQV9KwPlFcpVTYoWJIo3Ev
 MrI3GtzdaFT4nPw8oxVJm2sJhpgHEPCa3FE3H7D5iNsSEfwxJ8RzjIfNLsk/+zGGZMTXYD
 PQjhtU4HaNwa/It2XUqpxhJ3HTIg1r0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-2ZrMBDTQNVK81HYgI1kYaw-1; Fri, 14 Feb 2020 08:22:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F98107ACC4;
 Fri, 14 Feb 2020 13:22:28 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C13060BF1;
 Fri, 14 Feb 2020 13:22:26 +0000 (UTC)
Date: Fri, 14 Feb 2020 14:22:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH 0/3] qcow2: Fix write/copy error path with data file
Message-ID: <20200214132225.GD5443@linux.fritz.box>
References: <20200211094900.17315-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200211094900.17315-1-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2ZrMBDTQNVK81HYgI1kYaw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pbutsykin@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.02.2020 um 10:48 hat Kevin Wolf geschrieben:
> Kevin Wolf (3):
>   qcow2: update_refcount(): Reset old_table_index after
>     qcow2_cache_put()
>   qcow2: Fix qcow2_alloc_cluster_abort() for external data file
>   iotests: Test copy offloading with external data file

Applied to the block branch.

Kevin


