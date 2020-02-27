Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16568C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D369C2468F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZ8hm1mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D369C2468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7H7C-0005qU-0V
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7H6d-0005PL-1X
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7H6b-0002Yw-Uc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:13:26 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7H6b-0002Xk-Pi
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:13:25 -0500
Received: by mail-oi1-x241.google.com with SMTP id l136so2924233oig.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 03:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y4e457AjLxJv/C+S+2p2YCoTP2zMilablRlJldlXZRk=;
 b=nZ8hm1muRVBkAAt2iCO4XOXX0kRaqhom3TIKk6X8NPkXAdIPoJ4yDn2wKP4KP5RL9K
 zNyCPBrpcoeRDxFWOhZhxb5U2wS85rLlCUGyysgWHrlwUIXsnXgpa86rTeAUoc6ohdTt
 UsAy+8tjxueAmp2C3KS3C1eYBxCLAxrpzbH7amIDOHFozVlJ9jAUCS8z3vqM6z4snQv9
 QuuLGhZwsf+kg17cOeFagOaLCbXdQ/E297on7hA7Fy9x9ludFADQohRdsaJBMaEi6L41
 cjg0A2PWWVR02wG+mR9o2djHTHbSWGqdirJzJzxAw9Ewe32tmGmSF9k2Ea6M3ShQvZGk
 Nx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y4e457AjLxJv/C+S+2p2YCoTP2zMilablRlJldlXZRk=;
 b=LZIDsMH9Qlcd4JR5ADod6wvT7kww3NT7ebkZYiPRpOUiMFjeaAxt2fkcur6DpeN9DJ
 W2rpd4D9H+0RSVBeoMPNk22eSOLgu5xlg+SHpIQvfSCIWjd6DDL/D/8s8Md/iNtn6R+R
 u3KCjTJBR87XenS7IxtqOMbHeWbW38Za/DIDSA2lDe5/dOqv8I1ATsY+t7WQ7QddLomq
 HNF5SNC0lyCB314hCStPTRNvXmJB3Hq0rQAFyd9etRmoEbshJgBeb2AfEm5DIUdLfBwX
 Dxzl0DsrGr181aylSn5DjE7vw3vHZ4Q+K58d2UkCmTaaXN/YoKY7KERssYNRip3i/DrD
 fEeg==
X-Gm-Message-State: APjAAAVI4IX7KFLIInF3IfiFjZjcrw2aIvqkgN/MlpqcyOTFTDVpYUPz
 zT5mwAlwrKfne4wQ9LbVacYk+d10oe3Oc/yfyq7PHg==
X-Google-Smtp-Source: APXvYqzkcNrM9oDEFT77QZbNJsXbWoHo96fovgVZGzc4f5a+A8t77+Bwpl6fV9dJjUjN1dSvvJ26C9aQd5vgpu8m9gs=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2852754oif.163.1582802004752; 
 Thu, 27 Feb 2020 03:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-4-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-4-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 11:13:13 +0000
Message-ID: <CAFEAcA_D_XhGUtZkFg44sU5hd_VYa3K9GHXGyh7PgV=8j9=XEg@mail.gmail.com>
Subject: Re: [PATCH 03/18] texi2pod: parse @include directives outside "@c
 man" blocks
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This enables splitting the huge qemu-doc.texi file and keeping parallel
> Texinfo and rST versions of the documentation.  texi2pod is not going to
> live much longer and hardly anyone cares about its upstream status,
> so the temporary fork should be acceptable.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/texi2pod.pl | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
> index 839b7917cf..8bfc6f6f4c 100755
> --- a/scripts/texi2pod.pl
> +++ b/scripts/texi2pod.pl
> @@ -143,6 +143,24 @@ while(<$inf>) {
>         next;
>      };
>
> +    # Single line command handlers.
> +
> +    /^\@include\s+(.+)$/ and do {
> +       push @instack, $inf;
> +       $inf = gensym();
> +       $file = postprocess($1);
> +
> +       # Try cwd and $ibase, then explicit -I paths.
> +       $done = 0;
> +       foreach $path ("", $ibase, @ipath) {
> +           $mypath = $file;
> +           $mypath = $path . "/" . $mypath if ($path ne "");
> +           open($inf, "<" . $mypath) and ($done = 1, last);
> +       }
> +       die "cannot find $file" if !$done;
> +       next;
> +    };
> +
>      next unless $output;
>
>      # Discard comments.  (Can't do it above, because then we'd never see
> @@ -242,24 +260,6 @@ while(<$inf>) {
>         s/>/&GT;/g;
>      }
>
> -    # Single line command handlers.
> -
> -    /^\@include\s+(.+)$/ and do {
> -       push @instack, $inf;
> -       $inf = gensym();
> -       $file = postprocess($1);
> -
> -       # Try cwd and $ibase, then explicit -I paths.
> -       $done = 0;
> -       foreach $path ("", $ibase, @ipath) {
> -           $mypath = $file;
> -           $mypath = $path . "/" . $mypath if ($path ne "");
> -           open($inf, "<" . $mypath) and ($done = 1, last);
> -       }
> -       die "cannot find $file" if !$done;
> -       next;
> -    };
> -
>      /^\@(?:section|unnumbered|unnumberedsec|center)\s+(.+)$/
>         and $_ = "\n=head2 $1\n";
>      /^\@subsection\s+(.+)$/

This changes the semantics subtly -- we now honour @include
even if it's found inside an @ignore..@end ignore comment
block, for instance. But as you say this script isn't going
to be around much longer, so we can just avoid doing that
sort of thing.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

