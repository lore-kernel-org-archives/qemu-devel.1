Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB8C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395472073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVyEpyom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395472073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9n6a-000716-FG
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j9n5r-0006YK-8q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j9n5q-000484-0m
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:47:03 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j9n5p-00047H-R8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:47:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so6146350wrn.6
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VoqB4fj3vq2enb6TIRu2nalkBbBsw3alKUlqWoChH3w=;
 b=TVyEpyomOVfJD8e75oc/vVTskBF3PDd1aCWmF99hyNpe/dadGLSTk4OtbTIq+OyA5F
 aqnP78YMxDLcmXIqzYDWGOpx9VPuNA451eGXhcV6lTZSBlfwIFVdlmM6DbJEfp6Tzdzc
 lmlZKLaxLFGsUE1HyZTnV42/Kw1aJZYIbPjX3wqN/9N6sRsxoGwPo43fjshaIrWmeE0+
 TAzTYkkt9XAPVcFGICZCLlLEhG/0n/57jr4tW+fHb/UCfVTINJHP6kQA97YgtHB/eGXv
 ppjIPffBz9r8MBXRl/lIvWprWZCXvY8kW5krfGxd80mInJJGUR40mSf8wqLvFebQ8Kpf
 Dh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VoqB4fj3vq2enb6TIRu2nalkBbBsw3alKUlqWoChH3w=;
 b=Kw5B0UB3XWtY8beRlMAzQJhpDoEK+XcSV6PX4Ivm54wO7Zwk02GgMKFjyJ2qudwxRz
 jGrKxGQQjvWd662W9j4BIjyHQiwfzrwtD+FVY9LQR9X0Sh47/8w3My8NJfo/b/PJVe7a
 deo5+XrvSF235x5lH4U1HrqKTBX3IhIi4pW7qPgNOvBAlxzGXrGNbrtE3v176NUHUzHx
 cEeh9DzSCa5sa2/2ofNWypQI6W40vWFo6cCFDv4PSQ4z5UF++Gc79mAMJn69R366ol58
 PuupPBOyisyl3H+eKCC1jmhtBNlMj1ye64CcPj1CPsHxTOdi5YRqFLDQn5HgVySP+y52
 T24w==
X-Gm-Message-State: ANhLgQ1Jy3wC223V/OJTIGjMBVit5kARu+TA2SVmFCx8qGeaIIRhqTmb
 MjdN6j83BbgsVUnq/cARrOeRNG6kWIzBJk5QtSI=
X-Google-Smtp-Source: ADFU+vvEkE/jJQyfnNNlHN20YnK0u/M077jcBcZOY4QxNlIQUlGJSmAw4NeYXr7nHpWhkSJuyypl1UmbKcSHjX6DDVE=
X-Received: by 2002:adf:f604:: with SMTP id t4mr9414551wrp.96.1583401620463;
 Thu, 05 Mar 2020 01:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20200215003356.36352-1-kevinb@redhat.com>
In-Reply-To: <20200215003356.36352-1-kevinb@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Mar 2020 10:46:48 +0100
Message-ID: <CAJ+F1CJGQNZ+uYC3_M2BqyvnEn0dNHT3SHArHZA_N6JD3XWUYg@mail.gmail.com>
Subject: Re: [PATCH v2] Handle gdb.MemoryError exception in
 dump-guest-memory.py
To: Kevin Buettner <kevinb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: QEMU <qemu-devel@nongnu.org>
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

fwiw, Kevin fixed it in gdb:
https://sourceware.org/ml/gdb-patches/2020-03/msg00106.html

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
>                  vmcore.write(chunk)
>                  cur +=3D chunk_size
>                  left -=3D chunk_size
> --
> 2.24.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

