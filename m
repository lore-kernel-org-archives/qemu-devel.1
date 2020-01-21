Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F87C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348FC22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1mRolPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348FC22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itn1w-00065A-C4
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 01:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1itn1H-0005eI-C8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1itn1E-0003VM-Do
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:28:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1itn1D-0003UT-Tk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579588087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jD6lpgEwjJk4Ey37KAMhYX1mEQzoxqDWuO7ItrNIksE=;
 b=B1mRolPL/yM44/UJr8K3Kbe/z6tLKxf/73sx0OWfJx2PhnMTP1cyDK+crF8S/5W9I0Fl5Y
 C7r0PRC9izEnXZTk7T4YE4Q0fzNaW59iqO7vJZtU+aZkLdoSy1eDTEFumIVpRitxke5/Q1
 C/qHyGJE0gVF7kygin7N7dMtYuSfnPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-9reJV18cPsCOIAVig5Ffcg-1; Tue, 21 Jan 2020 01:28:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B891F800A02;
 Tue, 21 Jan 2020 06:28:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5444884DA6;
 Tue, 21 Jan 2020 06:28:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 730C41747D; Tue, 21 Jan 2020 07:28:01 +0100 (CET)
Date: Tue, 21 Jan 2020 07:28:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v2 1/2] vnc: fix VNC artifacts
Message-ID: <20200121062801.ror55cdypt3zmci7@sirius.home.kraxel.org>
References: <cover.1579582674.git.dirty@apple.com>
 <c28241e087b10b4561468b7dae47fe63381df259.1579582674.git.dirty@apple.com>
MIME-Version: 1.0
In-Reply-To: <c28241e087b10b4561468b7dae47fe63381df259.1579582674.git.dirty@apple.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9reJV18cPsCOIAVig5Ffcg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 09:00:51PM -0800, Cameron Esfahani wrote:
> Patch de3f7de7f4e257ce44cdabb90f5f17ee99624557 was too simplistic in its
> implementation: it didn't account for the ZLIB z_stream mutating with
> each compression.  Because of the mutation, simply resetting the output
> buffer's offset wasn't sufficient to "rewind" the operation.  The mutated
> z_stream would generate future zlib blocks which referred to symbols in
> past blocks which weren't sent.  This would lead to artifacting.
>=20
> This reverts commit de3f7de7f4e257ce44cdabb90f5f17ee99624557.
>=20
> Fixes: <de3f7de7f4e257> ("vnc: allow fall back to RAW encoding")
> Signed-off-by: Cameron Esfahani <dirty@apple.com>

Looks like you didn't realize that "revert" was meant literally.  Git has a
revert subcommand, i.e. you can simply run "git revert de3f7de7f4e257" to
create a commit undoing the changes, with a commit message saying so.  The
generated text should be left intact, to make the job for tools analyzing g=
it
commits easier.  The commit message (for reverts typically explaining why t=
he
reverted commit was buggy) can go below the generated text.

Also note that only the patch commit messages end up in the commit log, the
cover letter text doesn't.  So any important details should (also) be in th=
e
commit messages so they are recorded in the log.

Reworked the commit message, looks like this now:

-----------------------------------------------------------------
commit 0780ec7be82dd4781e9fd216b5d99a125882ff5a (HEAD -> queue/ui)
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Tue Jan 21 07:02:10 2020 +0100

    Revert "vnc: allow fall back to RAW encoding"
   =20
    This reverts commit de3f7de7f4e257ce44cdabb90f5f17ee99624557.
   =20
    Remove VNC optimization to reencode framebuffer update as raw if it's
    smaller than the default encoding.
   =20
    QEMU's implementation was naive and didn't account for the ZLIB z_strea=
m
    mutating with each compression.  Because of the mutation, simply
    resetting the output buffer's offset wasn't sufficient to "rewind" the
    operation.  The mutated z_stream would generate future zlib blocks whic=
h
    referred to symbols in past blocks which weren't sent.  This would lead
    to artifacting.
   =20
    Considering that ZRLE is never larger than raw and even though ZLIB can
    occasionally be fractionally larger than raw, the overhead of
    implementing this optimization correctly isn't worth it.
   =20
    Signed-off-by: Cameron Esfahani <dirty@apple.com>
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
-----------------------------------------------------------------

Modified patch queued up.
Patch 2/2 is fine as-is.

thanks,
  Gerd


