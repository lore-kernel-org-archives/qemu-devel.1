Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C313DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B026204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMN8r35Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B026204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZroA-0000Xc-GN
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 02:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZrm2-0008Bq-Sp
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZrm1-0001ZS-Tv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:30:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZrm1-0001Z7-Ql
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574839805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9EGym6HcQm20iq5+X+9ovg39czefHc/2YR5vCx5bmk=;
 b=QMN8r35QsLQeZOUNuuK+2tkms6H0vTASimvQFRjmtAepCxJ3BeekMw7f13g42SztvaKL9d
 MI16NXvgTp7AxgoKZZ+FauAxJzFl6V2pZP/Plt7XXws2Zd876qppBhxF/wNjS9RM4mbXX7
 cwh7kcsn3Fp9g/NjkjD2za5SsIfOgXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-q3dyc6GBNcmTcDIUldmO7Q-1; Wed, 27 Nov 2019 02:30:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32680DB60;
 Wed, 27 Nov 2019 07:30:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3FE85D9D6;
 Wed, 27 Nov 2019 07:30:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EAED71138606; Wed, 27 Nov 2019 08:29:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 3/9] monitor: move hmp_drive_del and hmp_commit to
 blockdev-hmp-cmds.c
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-4-mlevitsk@redhat.com>
Date: Wed, 27 Nov 2019 08:29:58 +0100
In-Reply-To: <20191120185850.18986-4-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Wed, 20 Nov 2019 20:58:44 +0200")
Message-ID: <87muchkc95.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: q3dyc6GBNcmTcDIUldmO7Q-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  blockdev-hmp-cmds.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
>  blockdev.c          | 95 --------------------------------------------
>  2 files changed, 96 insertions(+), 96 deletions(-)
>
> diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
> index 21ff6fa9a9..8884618238 100644
> --- a/blockdev-hmp-cmds.c
> +++ b/blockdev-hmp-cmds.c
> @@ -33,7 +33,7 @@
>  #include "sysemu/sysemu.h"
>  #include "monitor/monitor.h"
>  #include "block/block_int.h"
> -
> +#include "qapi/qapi-commands-block.h"

I prefer keeping qapi/ stuff together.  Please add this right before
#include "qapi/qmp/qdict.h".

[...]


