Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531B2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207412075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq8JpPzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207412075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdscs-0005s3-AE
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdscH-0004z5-Bw
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:44:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdscG-0001Iz-5d
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590572691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCvEEQ/p8M/Vgn3cdBkpMRkjXChQpaHHiRO0uPR1iD4=;
 b=Vq8JpPzqFmlamE2pfCRcTE1H4ROoSf3AHe4Ps55+MGLguY/kAmvxH2AceTLMgelDXp9gQW
 qscIOXaLZjE6APQLKRBlPqTxoHACB51yQee+3z+Aencp/usBmHGfTqzjL6kC/qh4m9jKLK
 xorT3heXnVctRm7uR2UnsZDmAj6MuBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-lwDqASRmM6KE7hE20M2_Rw-1; Wed, 27 May 2020 05:44:49 -0400
X-MC-Unique: lwDqASRmM6KE7hE20M2_Rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0778C835B40;
 Wed, 27 May 2020 09:44:48 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C280A12A4D;
 Wed, 27 May 2020 09:44:46 +0000 (UTC)
Date: Wed, 27 May 2020 10:44:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Subject: Re: [PATCH v4 1/3] crypto/secret: move main logic from 'secret' to
 'secret_common'.
Message-ID: <20200527094443.GE2665520@redhat.com>
References: <20200525111655.4127-1-alex-krasikov@yandex-team.ru>
 <20200525111655.4127-2-alex-krasikov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200525111655.4127-2-alex-krasikov@yandex-team.ru>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 02:16:53PM +0300, Alexey Krasikov wrote:
> Create base class 'common secret'. Move common data and logic from
> 'secret' to 'common_secret' class. This allowed adding abstraction layer
> for easier adding new 'secret' objects in future.
> Convert 'secret' class to child from basic 'secret_common' with 'data'
> and 'file' properties.
> 
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  crypto/Makefile.objs           |   1 +
>  crypto/secret.c                | 347 +---------------------------
>  crypto/secret_common.c         | 403 +++++++++++++++++++++++++++++++++
>  include/crypto/secret.h        |  20 +-
>  include/crypto/secret_common.h |  68 ++++++
>  5 files changed, 482 insertions(+), 357 deletions(-)
>  create mode 100644 crypto/secret_common.c
>  create mode 100644 include/crypto/secret_common.h

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


