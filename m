Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73015C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D82C206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAXzBQSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D82C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUgJ-0005W6-Eo
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1ixUfH-0004ZI-BX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1ixUfE-0004Tu-TP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:40:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1ixUfE-0004Qq-3k
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580470843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8tDBCjJBco83ksOotYK8srqaxzDB8cXdtJ9GQR4swQ=;
 b=MAXzBQSfLUnb4d7OqRz2pnUZ6YpI9T6SVcm4q0K3tn7or0eilxOsy2P3PFVDwc82MTcueh
 DrKj4Ms6SGO62VX5SYG97+VnEc1/JPPXNeagkiP/9bNOXJ2J8BeAvyFe6SO45z3u5d0yeI
 0AZIXx3vGx8PngilFXyAIa4yb5sy7NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-ZWPPLWf0Oz-iExVfW4SY4Q-1; Fri, 31 Jan 2020 06:40:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6616108442A;
 Fri, 31 Jan 2020 11:40:37 +0000 (UTC)
Received: from kinshicho.usersys.redhat.com (unknown [10.43.2.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B2565C1B2;
 Fri, 31 Jan 2020 11:40:35 +0000 (UTC)
Message-ID: <a978727290d97ee9b91719ed6173f892991e62b5.camel@redhat.com>
Subject: Re: [RFC PATCH v3 0/6] target/arm/kvm: Adjust virtual time
From: Andrea Bolognani <abologna@redhat.com>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Date: Fri, 31 Jan 2020 12:40:34 +0100
In-Reply-To: <20200120101023.16030-1-drjones@redhat.com>
References: <20200120101023.16030-1-drjones@redhat.com>
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZWPPLWf0Oz-iExVfW4SY4Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-01-20 at 11:10 +0100, Andrew Jones wrote:
> v3:
>  - Added a target/arm/kvm_arm.h comment cleanup patch (1/6)
>  - Minor refactoring of assert_has_feature_enabled/disabled in 4/6,
>    kept Richard's r-b.
>  - Rewrote kvm-no-adjvtime documentation in 6/6.
>  - Reworked approach in 5/6 to properly deal with migration and to
>    track running vs. !running, rather than running vs. paused states.

Probably too late since Peter already queued the series, but FWIW

  Tested-by: Andrea Bolognani <abologna@redhat.com>

-- 
Andrea Bolognani / Red Hat / Virtualization


