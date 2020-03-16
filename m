Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530B4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C27C20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSST7MUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C27C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuic-0003fm-Da
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jDtoO-0001RK-I5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jDtoM-0003dL-Av
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:45:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29381)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jDtoM-0003RG-54
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584380756;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FOywFMwykn3RqRxJjL73ctBYdJYeQHkwMxdYnJ2Elrs=;
 b=QSST7MUjlUHa0Yc+DJjRxJYChmXsitPxYP4cX9iyg6EOSfBb6QwuvrXxSfi823VSdISOCA
 5NYTy2DcCWO8xcJbthJ/4srhr27/oxgnLzweUBrvdJAWgqeWjiR3iQxMJxYl8IEvSxMZ4o
 2fkqRPZTT4JG4NI7c49vUtlBIimH0TE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-fXZsOh3ZPkasCpZnQ_GQ-A-1; Mon, 16 Mar 2020 13:45:55 -0400
X-MC-Unique: fXZsOh3ZPkasCpZnQ_GQ-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE156127A6F5;
 Mon, 16 Mar 2020 17:25:10 +0000 (UTC)
Received: from redhat.com (ovpn-116-35.ams2.redhat.com [10.36.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ED877E303;
 Mon, 16 Mar 2020 17:25:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/2] migration: avoid suspicious strncpy() use
In-Reply-To: <20200316160702.478964-2-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Mon, 16 Mar 2020 16:07:01 +0000")
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-2-stefanha@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 16 Mar 2020 18:25:04 +0100
Message-ID: <87pndcnrf3.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> wrote:
> gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1) with sanitizers enabled
> reports the following error:
>
>     CC      migration/global_state.o
>   In file included from /usr/include/string.h:495,
>                    from /home/stefanha/qemu/include/qemu/osdep.h:101,
>                    from migration/global_state.c:13:
>   In function =E2=80=98strncpy=E2=80=99,
>       inlined from =E2=80=98global_state_store_running=E2=80=99 at migrat=
ion/global_state.c:47:5:
>   /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 100 equals destination size [-Werror=3Dstr=
ingop-truncation]
>     106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
>         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>
> Use pstrcpy() instead of strncpy().  It is guaranteed to NUL-terminate
> strings.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

This is the film where:
- one put a size 100
- none of the current elements has a size of 20
- for extra security one put one assert to make sure tha there are
  space.

And compiler still find a reason for complaining O:-)


