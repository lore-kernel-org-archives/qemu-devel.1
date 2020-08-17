Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAE9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98D22072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxoMfQqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98D22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Z9s-0004AZ-3Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 03:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k7Z97-0003lJ-SX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 03:01:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k7Z95-0000hq-8S
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 03:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597647685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwa0oIlPecwy5d2DLISCjR+TTGbaD8RhwTZIoZS5RPc=;
 b=cxoMfQqyyWuSBQB8ZNKCGUyqsO8gRu82PhkeIffaT3Hud5udcLFSKvUZsPMT7X26oAjDOq
 bOGCtXsaDjJ7ibXsOyqT2wjk5fLKITmRCHPlW77y/S2ABJeo1+uPcx1nVTa+HPG4prQhoV
 egwrTgwPBIq/lZzO/3UBWd/jbms5Rbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-kfpOWL70M5Om9tAfvme8qg-1; Mon, 17 Aug 2020 03:01:23 -0400
X-MC-Unique: kfpOWL70M5Om9tAfvme8qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B115C18551AB;
 Mon, 17 Aug 2020 07:01:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E49C6709E1;
 Mon, 17 Aug 2020 07:01:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EC2C41753B; Mon, 17 Aug 2020 09:01:16 +0200 (CEST)
Date: Mon, 17 Aug 2020 09:01:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH] hw: virtio-gpu: remove duplicated 'virtqueue_pop'
Message-ID: <20200817070116.ox4du6d6jva6wico@sirius.home.kraxel.org>
References: <20200813153614.39917-1-liq3ea@163.com>
 <47b9f12f-2874-1e1c-2fc1-7ea1a81cc401@redhat.com>
MIME-Version: 1.0
In-Reply-To: <47b9f12f-2874-1e1c-2fc1-7ea1a81cc401@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:54:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: liq3ea@gmail.com, Li Qiang <liq3ea@163.com>, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> - If the get_next() invocation is simple, then style (1) is perfectly fine.

Fully agree.  Duplicating a single line is perfectly fine if it is
simple enough that you can hardly get it wrong.

> - Style (2) is the worst of all.

Yes, especially because the break is three lines not two due to qemu
code style.

> - If style (1) is not appropriate for whatever reason, then style (3) is frequently a good replacement. Style (3) is sometimes rejected by coding style documents though. Style (3) is not usable if is_valid() is a function-like macro that does not evaluate its argument exactly once. Frequently, is_valid() is simply open-coded with C operators (using extra parens), for example:

> or more verbosely
> 
>     while ((cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command))) !=
>            NULL) {

Style 3 tends to generate long lines, which in turn need line breaks
like this.  Also many parens don't help making code more readable.
So I'd prefer to just leave things as-is.

take care,
  Gerd


