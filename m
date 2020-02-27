Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB33AC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FC72468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QublkbxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FC72468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7QAp-0007uo-Kb
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 15:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7QAG-0007VP-8e
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7QAE-0005as-LP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:53:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32236
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7QAE-0005aO-HS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582836825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tm7hINNU1qmzUF8NPKfvYzUFZBbfz0lzQl/5e/6pLvg=;
 b=QublkbxIlpS7RmqVvt49GZWEHHqh7/If9Pm3zUYZ7NHl2NaKIsFyfk1MOpP0HojWreQ2qc
 efS1/kaK+2nnV9qSR6yzmsbnbot2AOduuMpttWdg5+psnshDFnLGg9ps6dldnfE1LfFV9N
 IiHkQIyrkLNbWvjAuWi3YdN80zXPLzY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ZiX6fZa0MiChbC7Z1dK3YA-1; Thu, 27 Feb 2020 15:53:42 -0500
X-MC-Unique: ZiX6fZa0MiChbC7Z1dK3YA-1
Received: by mail-qv1-f72.google.com with SMTP id fc5so496418qvb.17
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 12:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=adk5tx3SG+LZqzieVF/H34sFlTwBnP6qmzEvvFGzKbs=;
 b=BQ98k5XTxTxSKgQL1xrnIjPV1qbjtEGFtPDxTcrqJVwgZctkIx5hUMlN49ewabRpF4
 kQy/w69YxIrCMGdG+7VYxHYqgCwc5unoxEWKX/i7V4Ifd9dQaQYmIbzwPa0fJppUk0OW
 LLW9Ave5pkNzRdmFny+GKPIpVuO11dmECCA6tVvab8z7fy20fmg8x/kqmMKl8xCFDjbs
 WkyD8obWBGLNIzW4XtmqePFyCKxAmLxZ/NzfLoNqDNl5UvWnswh48UTMLGTh1AhTzB53
 xcLmg58xAb+ZGPKgabtNRdyc/ldsaxzcShkHolDcACR8c5wuTVVb6gKEnE7cKTEI1QZB
 IaZg==
X-Gm-Message-State: APjAAAVEQBFGSSudO1GOX8sTUpFq8MAASa2RB41SBt88v1WqDnmiwEw8
 Enyn3YrqgV3AaNFqKT/YnYJBUSyVOpILwqCdJ45WirWtUD8Gzlxc5tXiEODWsPXq1bxLykhlG3J
 MtFuIwWWfjlnyYxc=
X-Received: by 2002:a0c:edcd:: with SMTP id i13mr766033qvr.99.1582836822121;
 Thu, 27 Feb 2020 12:53:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTUNqmLcp7crb/ytCLCxWn4qk7EYorPflAU5H9DVGviwaummRhartyBMgt9KAjihOe/yc7pw==
X-Received: by 2002:a0c:edcd:: with SMTP id i13mr766008qvr.99.1582836821797;
 Thu, 27 Feb 2020 12:53:41 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id 202sm3667613qkg.132.2020.02.27.12.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 12:53:40 -0800 (PST)
Date: Thu, 27 Feb 2020 15:53:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v6 7/8] multifd: Add multifd-zstd-level parameter
Message-ID: <20200227205339.GL180973@xz-x1>
References: <20200213211709.59065-1-quintela@redhat.com>
 <20200213211709.59065-8-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200213211709.59065-8-quintela@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 10:17:08PM +0100, Juan Quintela wrote:
> This parameter specifies the zstd compression level. The next patch
> will put it to use.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

(I didn't look at the rest of patches, but this single patch looks
 sane to me...)

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


