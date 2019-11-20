Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44F5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE8820855
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzv3FC9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE8820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXR5F-0002wR-Ho
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iXR3m-0001Ss-97
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iXR3k-0005Td-HY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:34:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iXR3k-0005TN-EQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574260459;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEWFZJScrrsJxh7XIMrY/BK4cyeO4d+AUE6H8Mb/SpE=;
 b=hzv3FC9Q5Eu/0T59wNb5bScck6QFVeTj79kwkdPenPDXKWmbJdfM9enRrBnspSv1Vv0saV
 ggCCahMHONZJct9Kv0cp8f01g2c0Uqj+sxbdCcx6MCkkxHR/t70RC216uxitz6ijJxuihh
 DxqEHHlQKFLzsaTdYg/Iu1sLvJOaG9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-paZgV2_lMxOhFOcDgr3BaQ-1; Wed, 20 Nov 2019 09:34:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B7A4801FA1;
 Wed, 20 Nov 2019 14:34:17 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBA8D2AA88;
 Wed, 20 Nov 2019 14:34:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] pseries: fix migration-test and pxe-test
In-Reply-To: <20191120142539.236279-1-lvivier@redhat.com> (Laurent Vivier's
 message of "Wed, 20 Nov 2019 15:25:39 +0100")
References: <20191120142539.236279-1-lvivier@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 20 Nov 2019 15:34:12 +0100
Message-ID: <87imneobvf.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: paZgV2_lMxOhFOcDgr3BaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> wrote:
> Commit 29cb4187497d ("spapr: Set VSMT to smp_threads by default")
> has introduced a new default value for VSMT that is not supported
> by old kernels (before 4.13 kernel) and this breaks "make check"
> on these kernels.
>
> To fix that, explicitly set in the involved tests the value that was
> used as the default value before the change.
>
> Cc: Greg Kurz <groug@kaod.org>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

A comment telling that never their use could help for future readers
O:-)


