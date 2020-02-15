Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94023C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0DA2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVgFa5j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0DA2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ukS-0003xo-K4
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 05:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j2ujc-0003Kb-SJ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j2ujb-0007PL-PD
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:31:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j2ujb-0007P4-Lm
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581762699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7iLZTGf25Uxwkp/lZ7GWn7RzFFsshkWeVAKM7qnHjCY=;
 b=BVgFa5j0dtmzKDhfhL35PKR1U4PSCr79HsdfEd9pQHhTGG1FY1sOZqmiKKdU/bwYEKILIH
 t9BeySiPWMMY/+JHIYPY8qLc0AiMTEpZc6CTbN3DDktL5WicFIXzt2fopvF/8WNYLxucRz
 MURUP/Kmi2kAUzvvWCDjPPvFLs0CEkc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-NoK1LzQvOHWiLe4EKXnSxA-1; Sat, 15 Feb 2020 05:31:33 -0500
Received: by mail-ot1-f71.google.com with SMTP id a20so6847179otl.11
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 02:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2PciwqUtz3Mscoh7BpGZAGuor+qWYGdNiwUK9voh0HU=;
 b=e5TaSvfPkMT9+oXvz3BYjK3z5lFHb3J/yem/Dx6s390XBCura4kbgrCB426Nfq1zX1
 GudSidtttYo+b5jZ/YFyiJ6WlO1/IaMnu9hlvyq92RrmpQAd0mVEk6t+OH7J4HA8SHlk
 cujYvZcdHqx1Du7RnkYohVwLwsciJCkxgbE+cZ/RyP+UbP8NYebhCvwsET7MkyBDQ8hp
 5i4Y80v8W6PNiYQVgiJn7YiAVt9z5dYOZ+u7OejeQQNWTuQCH44rJfCAsPRt/meb/1k2
 UXMLs8pLuy/APfviNJ1E7ywlRQJLCv7ZLSNpJTc3CE6vn2Kj/kJvYmBPD5JUOnx7c8Z/
 2ziw==
X-Gm-Message-State: APjAAAW2JNqEcaDAkHrGMNi/K1s3q4cErWOk3nZHzX071R6NGpha/UcW
 lh1+WRMsKiJoaKDys2hjm3s1viFTXqE+eTb00yhpQgjzYXtouSihpF0MZ1f5aFnBod2Cf03TW1h
 oQzMa9xFFo2+YPV1t0kB5jjky/12LTcY=
X-Received: by 2002:a05:6830:138b:: with SMTP id
 d11mr5262315otq.38.1581762692656; 
 Sat, 15 Feb 2020 02:31:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwMaIROT/zHWSdXNW/FkbdjnSiJUObzdhXrohavNCWbYKla6MQuA6X7+UkcF6HYQw36hgcxB+M1+ywULfVr5U=
X-Received: by 2002:a05:6830:138b:: with SMTP id
 d11mr5262292otq.38.1581762692210; 
 Sat, 15 Feb 2020 02:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20200215003356.36352-1-kevinb@redhat.com>
In-Reply-To: <20200215003356.36352-1-kevinb@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 15 Feb 2020 11:31:21 +0100
Message-ID: <CAMxuvay=_pqyz6g4Z8kti+aNNdwsQ5MCOadyAJV5e4Af0SkwEg@mail.gmail.com>
Subject: Re: [PATCH v2] Handle gdb.MemoryError exception in
 dump-guest-memory.py
To: Kevin Buettner <kevinb@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
X-MC-Unique: NoK1LzQvOHWiLe4EKXnSxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: keiths@redhat.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sat, Feb 15, 2020 at 1:34 AM Kevin Buettner <kevinb@redhat.com> wrote:
>
> [Included a "Signed-off-by" line in this version.]
>
> I recently investigated a bug in which the dump-guest-memory.py script
> sees a gdb.MemoryError exception while attempting to dump memory
> obtained from a QEMU core dump.  (And, yes, dump-guest-core=3Don was
> specified in the -machine option of the QEMU invocation.)
>
> It turns out that memory region in question is not being placed in the
> core dump and, after stepping through the kernel core dumping code
> responsible for making this decision, it looks reasonable to me to not
> include that region in the core dump.  The region in question consists
> of all zeros and, according to the kernel's logic, has never been
> written to.
>
> This commit makes a small change to the dump-guest-memory script to
> cause inaccessible memory to be dumped as zeroes.  This avoids the
> exception and places the correct values in the guest memory dump.
>
> Signed-off-by: Kevin Buettner <kevinb@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
> index 4177261d33..fbdfba458b 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -539,7 +539,12 @@ shape and this command should mostly work."""
>
>              while left > 0:
>                  chunk_size =3D min(TARGET_PAGE_SIZE, left)
> -                chunk =3D qemu_core.read_memory(cur, chunk_size)
> +                try:
> +                    chunk =3D qemu_core.read_memory(cur, chunk_size)
> +                except gdb.MemoryError:
> +                    # Consider blocks of memory absent from a core file
> +                    # as being zeroed.
> +                    chunk =3D bytes(chunk_size)

That seems reasonable, but it will silently ignore any other memory error.

Keith Seitz also looked at this bug, and he was wondering if BFD
shouldn't treat the missing section differently:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1777751#c6

Keith, what do you think?

thanks


