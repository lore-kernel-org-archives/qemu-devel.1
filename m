Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61EBC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A9C2072F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiPvfIL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A9C2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2ht-0007Ks-Lo
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jC2h0-0006WE-Ff
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jC2gy-00060A-H9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:50:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jC2gy-0005zH-De
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583938239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdwFDwS5uX4jTU8UzU82g9s5ci5xMynwjle/+4YMNUE=;
 b=BiPvfIL1AjbXkIBEwWgNV2E0dYtd9+rdtnKe7YmqsMpHu6ZRqi827+JlAEEQTWcMxq2KX5
 BDCujvdLfgpzF3hnVYD7KpMPbiBnQqZkG9sJUUGLu0Fgmzonhwk07WYKHuYXMO5A55rOqX
 VpN9l3Ih4CCS6Y1uMXdj0SFp1LcH0PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-GKtmlrgSO2CiTujLj8M_ww-1; Wed, 11 Mar 2020 10:50:37 -0400
X-MC-Unique: GKtmlrgSO2CiTujLj8M_ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB46F8010EF;
 Wed, 11 Mar 2020 14:50:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02DFD8F36D;
 Wed, 11 Mar 2020 14:50:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8830011386A6; Wed, 11 Mar 2020 15:50:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/2] thread: add lock guard macros
References: <20200311123624.277221-1-stefanha@redhat.com>
Date: Wed, 11 Mar 2020 15:50:33 +0100
In-Reply-To: <20200311123624.277221-1-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Wed, 11 Mar 2020 12:36:22 +0000")
Message-ID: <87d09jx7wm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Lock guards automatically call qemu_(rec_)mutex_unlock() when returning f=
rom a
> function or leaving leaving a lexical scope.  This simplifies code and
> eliminates leaks (especially in error code paths).
>
> This series adds lock guards for QemuMutex and QemuRecMutex.  It does not
> convert the entire tree but includes example conversions.

I support the move towards automatic cleanup, but I'm wary of
incremental conversion.  Experience tells that outdated examples
invariably get copied / imitated, with incremental conversion struggling
to keep up.

Are we resigned to having both kinds of mutex cleanup forever?

If not, what's the plan to get the job finished, and until when?


