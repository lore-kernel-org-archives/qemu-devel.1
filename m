Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD2DC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0FC20733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaP5p7uB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0FC20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuSM-0007PR-VS
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIuR2-0006R7-5e
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIuR0-0006nq-2F
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:26:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIuQz-0006kk-T8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585574793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7gJlPOL1Z+hxa4i8A/fTq6lrhFzYdyDRoYnXLJtaQ24=;
 b=YaP5p7uBUpY3VJmjeb6UWwbLRR3Dnek2xX9raQZRpuFzTi4bdGsSqAa4eDW1AYTH8fyaWJ
 nSIloV/l3pid2KcVCQ4Cn91ZFmO5jc6Clc/Obs8DirInkANjCa8er6wU5kRMfoziC7F7zm
 lkbV5ZU5HvbzhpCF0c0zQlC7uBT5StA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-Rh7LK2uyNxiHOhr3mwMtyw-1; Mon, 30 Mar 2020 09:26:28 -0400
X-MC-Unique: Rh7LK2uyNxiHOhr3mwMtyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B801005509;
 Mon, 30 Mar 2020 13:26:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53E4F60BE2;
 Mon, 30 Mar 2020 13:26:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D7CA411385E2; Mon, 30 Mar 2020 15:26:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: deprecation of in-tree builds
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
Date: Mon, 30 Mar 2020 15:26:24 +0200
In-Reply-To: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 (Peter Maydell's message of "Sat, 21 Mar 2020 20:50:34 +0000")
Message-ID: <87v9mmug73.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> AIUI from Paolo, the intention is to deprecate and eventually
> stop supporting "in-tree" builds, so that the only option is
> building in a separate build directory. I thought we should
> probably mention that in the 5.0 changelog, so I wrote up some
> text:
>
> https://wiki.qemu.org/ChangeLog/5.0#Build_Information

Overdue.  Thanks for doing this!

> Suggestions for changes/comments etc welcome.

Looks fine to me.

> (One thing we will need to fix before we can do separate build
> tree is the Coverity Scan build process, which (a) does an
> in-tree build (b) can't be easily switched to a builddir because
> all the source paths get baked into the scan results and moving
> to a builddir changes them all...)
>
> We could also make configure actively warn if used in
> the source tree.

Unless we commit to automatically creating a default out-of-tree build
directory for this usage.  I wouldn't bother myself.


