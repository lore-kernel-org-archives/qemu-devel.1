Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F89C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FD321582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMLkiFrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FD321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvdM-0005HH-4b
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iyvcf-0004nQ-Hd
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iyvce-0006iL-7x
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:40:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iyvce-0006ff-4a
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580812799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4ojYInArZMYJ6LNNSfKmov86zXzZRffP9Jq71T33n8=;
 b=WMLkiFrIhgLOpPQH2AKKgarhV7JevMoDM1+HnetKTuXiN3wCFXpjnus0Aov0uItEcwHaEk
 lS7L191BOS1i4zio6VncaS2bA+RFLGe0crsfXI+NjD/B78LkwcRcseARopHB3fXDEb2/px
 W8c8pm5Ut/1k/mRLLQz3C/eEJWsGxkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Ym1CemeKNKqeCIA9PDjfLA-1; Tue, 04 Feb 2020 05:39:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41B5F100726F;
 Tue,  4 Feb 2020 10:39:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE0DE60BE0;
 Tue,  4 Feb 2020 10:39:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7CB4E11386A7; Tue,  4 Feb 2020 11:39:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] configure: Allow user to specify sphinx-build binary
References: <20200203132533.21850-1-peter.maydell@linaro.org>
 <20200203132533.21850-2-peter.maydell@linaro.org>
Date: Tue, 04 Feb 2020 11:39:54 +0100
In-Reply-To: <20200203132533.21850-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 3 Feb 2020 13:25:32 +0000")
Message-ID: <87d0au8wlh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Ym1CemeKNKqeCIA9PDjfLA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently we insist on using 'sphinx-build' from the $PATH;
> allow the user to specify the binary to use. This will be
> more useful as we become pickier about the capabilities
> we require (eg needing a Python 3 sphinx-build).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I went with the most common convention for specifying "here's
> an executable", like --make=3D, --install=3D, --python=3D....
>
> The only odd one out for our current configure options seems to be
> that we want --with-git=3DGIT, not --git=3DGIT. You could argue that
> that's a better convention,

It's the one Autoconf uses.

>                             but it makes more sense to me to
> stick with the convention we currently mostly have. (Perhaps
> we should even change --with-git=3D to --git=3D ?)

Paolo, any implications on the Meson conversion?


