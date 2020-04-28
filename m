Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538AC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF2620746
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BV1CqI82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF2620746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTT8g-0004RT-Oh
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:31:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTT5S-0007hr-6G
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTT3R-0003xq-Ve
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:27:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTT3R-0003wW-Hs
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091152;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tekVEtqqrpJSUhiUvVPpRLzpvComuinsn8PrnIcqN2Y=;
 b=BV1CqI824bM17MqiGzDcegqT4wWgqEBmlGhKla5PDpVCcflHBda5tLeI+XmRMBAVYjdwoh
 yXjtCLmHYHWxIBUbDX27U9JGnWsMFkAZJyBPTOH7Dlk126tjQJsh26Pkg2AljmoXpWWkNX
 yP7Gd4ttaeFI9oEKuTOrgdQPYnatYQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-BdxohwE3PiS-MBc-V3HigQ-1; Tue, 28 Apr 2020 12:25:50 -0400
X-MC-Unique: BdxohwE3PiS-MBc-V3HigQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD291902EA0;
 Tue, 28 Apr 2020 16:25:49 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB97B5C1D4;
 Tue, 28 Apr 2020 16:25:46 +0000 (UTC)
Date: Tue, 28 Apr 2020 17:25:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 11/14] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
Message-ID: <20200428162543.GI1467943@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-12-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308151903.25941-12-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 08, 2020 at 05:19:00PM +0200, Maxim Levitsky wrote:
> blockdev-amend will be used similiar to blockdev-create
> to allow on the fly changes of the structure of the format based block de=
vices.
>=20
> Current plan is to first support encryption keyslot management for luks
> based formats (raw and embedded in qcow2)
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/Makefile.objs       |   2 +-
>  block/amend.c             | 108 ++++++++++++++++++++++++++++++++++++++
>  include/block/block_int.h |  21 +++++---
>  qapi/block-core.json      |  42 +++++++++++++++
>  qapi/job.json             |   4 +-
>  5 files changed, 169 insertions(+), 8 deletions(-)
>  create mode 100644 block/amend.c

> diff --git a/block/amend.c b/block/amend.c
> new file mode 100644
> index 0000000000..2db7b1eafc
> --- /dev/null
> +++ b/block/amend.c
> @@ -0,0 +1,108 @@
> +/*
> + * Block layer code related to image options amend
> + *
> + * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>
> + * Copyright (c) 2019 Maxim Levitsky <mlevitsk@redhat.com>

I would have expected these to be  "Copyright (C) 2019 Red Hat, Inc"
since employees usually have to assign copyright, unless they were
done outside of work context.

Aside from that=20

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


