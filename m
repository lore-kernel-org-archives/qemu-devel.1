Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC531C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FC7208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWp5oelX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FC7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvx9-0008NP-SD
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVvw8-0007Vf-IV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVvw3-00006n-2f
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603455162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6nQjWCeN/YNsZcz+5ak5uPQvbxI8eSNoTUYovDRqeI=;
 b=WWp5oelXyEWu/od2N7Bx13PyMHZZx8Kp+6mqEOejIoNR+9nD6DtwF1Xb2+3EoHM7YrJfYK
 iLUTy+4WGTW7L8ZFXQ63draJ1px+vwalnFpEHsuHimSOPlFEyugF7yNjk6YVxP1Xvg8R0j
 OLEiQtx/fw8hoLorEd7cRBdN3Ao0/Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-gdUv__-DN1q0PMXivU1_RQ-1; Fri, 23 Oct 2020 08:12:38 -0400
X-MC-Unique: gdUv__-DN1q0PMXivU1_RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22D345F9DB;
 Fri, 23 Oct 2020 12:12:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 208136EF66;
 Fri, 23 Oct 2020 12:12:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 87D1E113865F; Fri, 23 Oct 2020 14:12:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/6] char/stdio: Fix QMP default for 'signal'
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-2-kwolf@redhat.com>
Date: Fri, 23 Oct 2020 14:12:32 +0200
In-Reply-To: <20201023101222.250147-2-kwolf@redhat.com> (Kevin Wolf's message
 of "Fri, 23 Oct 2020 12:12:17 +0200")
Message-ID: <87d019qgy7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Commit 02c4bdf1 tried to make signal=on the default for stdio chardevs
> except for '-serial mon:stdio', but it forgot about QMP and accidentally
> switched the QMP default from true (except for -nographic) to false
> (always). The documentation was kept unchanged and still describes the

The QMP documentation, actually.  CLI documentation was updated.

> opposite of the old behaviour (which is an even older documentation
> bug).

Hardly surprising, given how vague the documentation was (and is).  See
below.

> Fix all of this by making signal=true the default in ChardevStdio and
> documenting it as such.
>
> Fixes: 02c4bdf1d2ca8c02a9bae16398f260b5c08d08bf
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/char.json       | 3 +--
>  chardev/char-stdio.c | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index b4d66ec90b..43486d1daa 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -321,8 +321,7 @@
>  # Configuration info for stdio chardevs.
>  #
>  # @signal: Allow signals (such as SIGINT triggered by ^C)
> -#          be delivered to qemu.  Default: true in -nographic mode,
> -#          false otherwise.
> +#          be delivered to qemu.  Default: true.
>  #
>  # Since: 1.5
>  ##

What does it mean to "allow signals to be delivered"?

To understand, I had to check what the QEMU code does with it (@signal
off clears termios c_lflag ISIG), and I had to look up what that means
(tcsetattr(3): "When any of the characters INTR, QUIT, SUSP, or DSUSP
are received, generate the corresponding signal").

Stealing that sentence verbatim from tcsetattr(3) would be a marked
improvement over what we have, in my opinion.

Nothing wrong with this patch, of course, but if you need to respin for
some other reason, consider improving the comment.

> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index 82eaebc1db..403da308c9 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -112,9 +112,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
>  
>      qemu_chr_open_fd(chr, 0, 1);
>  
> -    if (opts->has_signal) {
> -        stdio_allow_signal = opts->signal;
> -    }
> +    stdio_allow_signal = !opts->has_signal || opts->signal;
>      qemu_chr_set_echo_stdio(chr, false);
>  }
>  #endif

Preferably with s/documentation/QMP documentation/ in the commit
message:

Reviewed-by: Markus Armbruster <armbru@redhat.com>


