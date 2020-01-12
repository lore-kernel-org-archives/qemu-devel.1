Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE7C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173C122314
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpWz+GXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173C122314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqZsw-0007bY-9i
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 04:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iqZs9-0006gK-Me
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iqZs8-0004xQ-Nq
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:49:29 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iqZs8-0004qM-E5; Sun, 12 Jan 2020 04:49:28 -0500
Received: by mail-lf1-x144.google.com with SMTP id r14so4728379lfm.5;
 Sun, 12 Jan 2020 01:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gFJu0ECQYPDpnOY6gf8MGQ1UvMvuAoTJib9HaOc9GXQ=;
 b=cpWz+GXZHIjC9AHIUR8spRUWa7LF2oEfJYja5QUKfDA21ScagU0gJWDXznfVZiwP6Z
 i6d7yYztKEm5VOY1zAobQ2PJP4wiIWY1CEej3HOp4jix6w1pSFWEGv0BuKmh4r2NssGI
 PtDNX3+KJ4aEG90UZ69Hnzs4K0UCR8MfW1mdhTYX1zYEJxcK6q/xcbAwWtd/zP4Q0yIq
 cv6Pxh1fbV6rOykH8J9ojGIERfWXdSBdwL32gKpqz5as5oBdrkTeGwwaIjinXMp4bPPC
 sdjqrdakNAec54187FCuKHuAOlQeghe2sbhPFS0d/7U717ljqVO9coZMakqNPQlycQ2f
 IEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gFJu0ECQYPDpnOY6gf8MGQ1UvMvuAoTJib9HaOc9GXQ=;
 b=rx64k5mqK4dCz5hY8Uym2lVUQQf/QrM0fUOvAwJGkz0xUru4dTrbYiMfsg9npMXVz0
 ezPfnVIEVrRaYFG2+Eveu39lNPKrPJIAADhUUUNdE8d0GZx/JnIlYczbphJ4L1MzU+R7
 LqOu0CKu2lubXa24qrszvP6gTHUbzLhkQZ3c421/RNn0xN5ssDTtLaLaBmIIX5e1eHOT
 kdLR8Y3ECWa/jfYntxoYyDqpZhLL0U6CnFb6xDR63ZOcFBVwQKmUiPBD00X/SnKwt5iq
 oLmnWoBkky037LYkO90nyJF8QrIFypitWEy3T7qPrlLTAKKZxJOUuEq+egR9AtKsBT+G
 ClnQ==
X-Gm-Message-State: APjAAAUUwFAKlizglxNptVRrkpSx6YEmAenlHQpsyKW5Wp8lvAVFFqr7
 QEaUl9HmmBrVMAT6/jIPGx9Pukm3pKMgj8jHKCw=
X-Google-Smtp-Source: APXvYqyfFmBy6C5PIruqGp+b0n1EEL++TBcSqCFsy3+IrY7TEH59DfehfRjU5O3OcAzZPQfAAn/XJlYZmr09b0FcjY4=
X-Received: by 2002:ac2:4834:: with SMTP id 20mr6382556lft.166.1578822566702; 
 Sun, 12 Jan 2020 01:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-11-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-11-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 12 Jan 2020 17:48:58 +0800
Message-ID: <CAKmqyKNrgTbiipNK1wrwCMqk_=7cJmc4rBwO1zxjFiVV+TRSgQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] memory: Replace current_machine by
 qdev_get_machine()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 11:29 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As we want to remove the global current_machine,
> replace 'current_machine' by MACHINE(qdev_get_machine()).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/memory.c b/memory.c
> index d7b9bb6951..57e38b1f50 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -3004,6 +3004,7 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
>      int n =3D view->nr;
>      int i;
>      AddressSpace *as;
> +    MachineState *ms;
>
>      qemu_printf("FlatView #%d\n", fvi->counter);
>      ++fvi->counter;
> @@ -3026,6 +3027,7 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
>          return;
>      }
>
> +    ms =3D MACHINE(qdev_get_machine());

Why not set this at the top?

Alistair

>      while (n--) {
>          mr =3D range->mr;
>          if (range->offset_in_region) {
> @@ -3057,7 +3059,7 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
>          if (fvi->ac) {
>              for (i =3D 0; i < fv_address_spaces->len; ++i) {
>                  as =3D g_array_index(fv_address_spaces, AddressSpace*, i=
);
> -                if (fvi->ac->has_memory(current_machine, as,
> +                if (fvi->ac->has_memory(ms, as,
>                                          int128_get64(range->addr.start),
>                                          MR_SIZE(range->addr.size) + 1)) =
{
>                      qemu_printf(" %s", fvi->ac->name);
> --
> 2.21.1
>
>

