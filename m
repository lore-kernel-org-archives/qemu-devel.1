Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE3CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD933206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjwamhG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD933206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDutS-00006H-01
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jDtry-0007on-Dj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jDtrx-00086g-CT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:49:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jDtrx-00085V-8V
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584380981;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJiape8B+6U7MnH0ijn0REvFQTDRIRYrPN6S7hbtkHw=;
 b=cjwamhG2ttUYvKHdG2wY8iTmqhweb8VcD18CPkq6GeKMjWmOaTJBUtgSROk2XPscHVSG6H
 4pONLcfYnXERslssdlj6GRt1gOV6EHgTBJEPvR3Rd47olLZgqNZsMJBjtNrl9tkS2GbSAx
 rhBA2M1I+s/mgn/TFdM00igbk+KvVxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-zSw07NsYNNGguLsWXNqv1Q-1; Mon, 16 Mar 2020 13:49:39 -0400
X-MC-Unique: zSw07NsYNNGguLsWXNqv1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8B8E192C67C;
 Mon, 16 Mar 2020 17:28:39 +0000 (UTC)
Received: from redhat.com (ovpn-116-35.ams2.redhat.com [10.36.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79AC91001B28;
 Mon, 16 Mar 2020 17:28:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] hw/rdma: avoid suspicious strncpy() use
In-Reply-To: <20200316160702.478964-3-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Mon, 16 Mar 2020 16:07:02 +0000")
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-3-stefanha@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 16 Mar 2020 18:28:33 +0100
Message-ID: <87lfo0nr9a.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
>   CC      x86_64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
> In file included from /usr/include/string.h:495,
>                  from include/qemu/osdep.h:101,
>                  from hw/rdma/vmw/pvrdma_dev_ring.c:16:
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98pvrdma_ring_init=E2=80=99 at hw/rdma/vmw/pvrdma=
_dev_ring.c:33:5:
> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_st=
rncpy=E2=80=99 specified bound 32 equals destination size [-Werror=3Dstring=
op-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__=
dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>
> Use pstrcpy() instead of strncpy().  It is guaranteed to NUL-terminate
> strings.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


