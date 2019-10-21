Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BD1CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1DD2089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyUokGhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1DD2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMRpV-0000oA-0Y
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 03:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMRol-0000Ox-Ur
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMRoj-0002Qc-NN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:09:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMRoj-0002Q4-Br
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571641763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkkDZN0QkjQtHhcSKnzw8GvjWVxnx6MfIEB7FUrR8mQ=;
 b=YyUokGhWApOfz7flsQmfsWlpllhXavU2NZFgzqW3w/G93nRcMGZgKZmc9d5okn+/xiDvSA
 mTU4OdOUx/ZAXY2E0DsFahulWS7mwNfRhDiSBqe12xqTRW/p0D+8yClB3RgbeiU2R7WXOz
 1fzlLb1OWtXMKp0LSJIlpAPo62KvHzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-P6HcmaUGNDeKtxz4rO7UEQ-1; Mon, 21 Oct 2019 03:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B47800D41;
 Mon, 21 Oct 2019 07:09:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C542B1A95;
 Mon, 21 Oct 2019 07:03:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 759CF1138619; Mon, 21 Oct 2019 09:03:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] error: Fix -msg timestamp default
References: <20191010081508.8978-1-armbru@redhat.com>
 <167c9b31-7592-de9f-a1a3-e79d8e66fc5c@redhat.com>
Date: Mon, 21 Oct 2019 09:03:20 +0200
In-Reply-To: <167c9b31-7592-de9f-a1a3-e79d8e66fc5c@redhat.com> (Paolo
 Bonzini's message of "Thu, 10 Oct 2019 13:22:02 +0200")
Message-ID: <878spe8ts7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: P6HcmaUGNDeKtxz4rO7UEQ-1
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
Cc: msmarduch@digitalocean.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> I'll queue this patch.

Thanks!

> On 10/10/19 10:15, Markus Armbruster wrote:
>> -bool enable_timestamp_msg;
>
> Would you like me to also rename his enable_guestname_msg variable to
> error_with_guest_name?

In my review, I proposed replacing it by error_guest_name, to avoid
having to get -name parameter "guest" all the time.  I included a
revised patch to illustrate.  Goes on top of this one.  My revised patch
doesn't fully address my review.  In particular, there's a TODO in the
commit message.  Mario, would you be willing to complete it and post it?


