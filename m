Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E2DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3B72072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABjERMJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3B72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9uDL-00067H-JP
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9uAx-0002H4-Ac
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9uAw-0003Id-4G
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:20:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41312
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9uAv-0003HM-Nk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583428845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLkB9BSm7Is6yJ0510IOvVsMgRVA2lYlOEvMCiPgrwI=;
 b=ABjERMJXMx0UEaVmbjZIIcKNViQ41EUD7zvqZcEzg46ifZFmW2qv/PmzOAQAT03PjNsIhH
 wfgujvTPJDTb1vVrUCKAezsXHMVZdjnshh/SmuwavVHXlFkxrNaxnbQB8chQSJaGWT1UCf
 CDAiXf/GBEH9FdFacfLNx5+FzUQFVAA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-icoXBAkrNkqJ59hdHl9BTA-1; Thu, 05 Mar 2020 12:20:43 -0500
X-MC-Unique: icoXBAkrNkqJ59hdHl9BTA-1
Received: by mail-wm1-f72.google.com with SMTP id p17so998486wmc.9
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dLkB9BSm7Is6yJ0510IOvVsMgRVA2lYlOEvMCiPgrwI=;
 b=jWayFHxQOcnfNKTVo/LI9v7273KyuVppu0iui3WS01X9zsW0VTdHryKWZKlDSxTwM6
 4X7AUSED6VYuTD+dIjGOC7HwYNtMeyPc64uGqMHgme+y2r4pgtjtyizocIsxbB1Hfx7V
 EIFz7wJ0ERCHQKfVAxYfdGYJh2peISzUDtXB9rfoN9wBlIcC/bfkUP9OUZqSITEopx/p
 kkDCEvqMeIutPZodcpjtG4cZoHvCK7decZfLHpXkPwQwZ/eU0p7EsCHd2Td727bwxo/J
 AfnqZmuv+bEhlCcX5FZZTViNTQHQApk5DiaqivbTsqkeLSCdxQMi9XWV4p8vh963lc4/
 kLWw==
X-Gm-Message-State: ANhLgQ3kly+EOesLrE5dhXBTF0F8/alaxfTLWhbRQva340d07veHDjqy
 Hlt2mglMolZXSmVkhKxrJrKp+/1nkx4BAaPSHX1uhMJYGTn3VjU86iP+OO+Pup/h3QPumNbYE7n
 1ptmuRTTPyuToz+ADnu8kz30bzfYmQkU=
X-Received: by 2002:a7b:ca55:: with SMTP id m21mr10644559wml.162.1583428842505; 
 Thu, 05 Mar 2020 09:20:42 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsDv7+ycUAaUOWYb2OGm5L5VPnf3T9wqIt5vfbbAL5YXY9uzfsn5W3Zr1qa7SQnVZaZuoQMy/0TiVnC27tmMpI=
X-Received: by 2002:a7b:ca55:: with SMTP id m21mr10644540wml.162.1583428842269; 
 Thu, 05 Mar 2020 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20200305164839.201311-1-palmerdabbelt@google.com>
 <cfc728aa-56a5-6a2d-a997-e1dfd871885c@redhat.com>
In-Reply-To: <cfc728aa-56a5-6a2d-a997-e1dfd871885c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 5 Mar 2020 18:20:31 +0100
Message-ID: <CAP+75-XPHkSkcOmLct=jerOPx_WmYTc6a-=f2LfvtFku_p1WBw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add a missing "," in riscv_excp_names
To: Palmer Dabbelt <palmerdabbelt@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "open list:RISC-V" <qemu-riscv@nongnu.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@ in case there is a pending PR in  progress, it
might get merged quicker.

On Thu, Mar 5, 2020 at 6:19 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 3/5/20 5:48 PM, Palmer Dabbelt wrote:
> > THis would almost certainly cause the exception names to be reported
> > incorrectly.  Covarity found the issue (CID 1420223).  As per Peter's
>
> "This", "Coverity" typos.
>
> Fixes: ab67a1d07a4
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > suggestion, I've also added a comma at the end of the list to avoid the=
 issue
> > reappearing in the future.
> >
> > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >   target/riscv/cpu.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index c47d10b739..c0b7023100 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -66,7 +66,7 @@ const char * const riscv_excp_names[] =3D {
> >       "exec_page_fault",
> >       "load_page_fault",
> >       "reserved",
> > -    "store_page_fault"
> > +    "store_page_fault",
> >       "reserved",
> >       "reserved",
> >       "reserved",
> > @@ -74,7 +74,7 @@ const char * const riscv_excp_names[] =3D {
> >       "guest_exec_page_fault",
> >       "guest_load_page_fault",
> >       "reserved",
> > -    "guest_store_page_fault"
> > +    "guest_store_page_fault",
> >   };
> >
> >   const char * const riscv_intr_names[] =3D {
> >


