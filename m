Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4DCC4CECD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD91206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzEl0SvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD91206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJHI-0004G9-Lz
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBJCq-0002cV-QC
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBJCp-00087Q-OW
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:44:16 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBJCp-00087H-Iu
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:44:15 -0400
Received: by mail-oi1-x242.google.com with SMTP id w6so1756603oie.11
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eBLpyKsJ5K3YL3HUP7CdRD+9D20YQIhfTMOvkM1wq9c=;
 b=FzEl0SvCFx9kyee1lk/HvqbOXvO/I9TeOcenV4nGTs2iXKjR5j0AdfjvnxKNZFFRvd
 xKheHoLLgfpoROkeZyLWw49HWNGe/WYtiDSUEtNdEjxWJqOkaGYdAYzWiF9XBPDSIaWL
 IZuYdm0sjK3ZhaQru2uVmEPF9xU26TyIjeZ2zJ3jUDJwWxjQ/YLYrHYD9igkEV/MvRKW
 hUaG2jSJhkg0936HgQk5g5jeLbnXUTbFI7uPOYJrfKTqfjdQbaGKe1ZD9M/KA1fdcRuj
 lOJ6bUChYQdf6xXYpu7ByphtdNjf3g7ODopOGems932mANFocra0/hEZiGMOdQXInLcH
 pDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eBLpyKsJ5K3YL3HUP7CdRD+9D20YQIhfTMOvkM1wq9c=;
 b=VV2Iqq2oPJDvUu2iKiK0CStLy4/MJbJQSBHRIV+ZlEPm7oq0ADL4DJOyPtFqHRFpcM
 +DeJq1T43Mhf/cJ8PZAcJSD4up6lVwjq0kfQd6b6cJyen2IZYDM+wt8gPzItrf4ZimDw
 iqxW1E3qAT60KQvKrD/DC83uGIz2qIkq8hkWJB8IWcY0jn9yaECVnz/qB2S4l9L0RaIy
 3xorachoVhAoi2g1sUetYwTKBvogtOqYMPHz/Zg7ta0HvLHMKXnhi/KIYafCoLJF8E0r
 h2ApAgM30zqEB4OPFgQSzx19qUwbg3UyYmrkAb6LEleAeLp2AEaPlCLOnjJRVXTuRW7u
 rLKg==
X-Gm-Message-State: APjAAAXEwQI03Rbn+vyRYBFJXD6MOLHZKtUfDXwNvPHbTuGC28QAnHQt
 YCzyX9bzel8SfSgyV6KoCLiI6NGQTOSKZxme4dAG8g==
X-Google-Smtp-Source: APXvYqxvLmHMgpQ7RSO28lvLn84hXN7eyod2xP7ftEQpSLQCEYJizZRN0jg/tEYaLptc7DZhSTs4T281rpJsBhETN8o=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr3023285oif.98.1568987054727; 
 Fri, 20 Sep 2019 06:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190920125008.13604-1-peter.maydell@linaro.org>
 <c441b9fb-744e-428e-9b20-c1c21cc7b6a5@redhat.com>
In-Reply-To: <c441b9fb-744e-428e-9b20-c1c21cc7b6a5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 14:44:03 +0100
Message-ID: <CAFEAcA_xwb1yJnWhR2kNu4___t2ddNX0ODaNyNkuq4-8mMuh8A@mail.gmail.com>
Subject: Re: [PATCH] Remove unassigned_access CPU hook
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Fri, 20 Sep 2019 at 14:36, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 9/20/19 2:50 PM, Peter Maydell wrote:
> > All targets have now migrated away from the old unassigned_access
> > hook to the new do_transaction_failed hook. This means we can remove
> > the core-code infrastructure for that hook and the code that calls it.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Based-on: <cover.1568762497.git.alistair.francis@wdc.com>
> > ("[PATCH v1 0/2] RISC-V: Convert to do_transaction_failed hook")
> >  -- the last of the conversions isn't in master yet, but I figured
> > I might as well put the cleanup patch out for review.
>
> Hopefully this hook is neither implemented by the RX/AVR targets posted
> on the list recently.

Good point -- luckily a quick email archive search says they don't
try to implement the old hook.

> > @@ -1291,9 +1287,6 @@ static void unassigned_mem_write(void *opaque, hw=
addr addr,
> >  #ifdef DEBUG_UNASSIGNED
> >      printf("Unassigned mem write " TARGET_FMT_plx " =3D 0x%"PRIx64"\n"=
, addr, val);
> >  #endif
> > -    if (current_cpu !=3D NULL) {
> > -        cpu_unassigned_access(current_cpu, addr, true, false, 0, size)=
;
> > -    }
> >  }
>
> Having unassigned_mem_read/unassigned_mem_write with
> CPUReadMemoryFunc/CPUWriteMemoryFunc prototype only used for logging is
> rather confusing. We can kill them and use trace events instead in
> memory_region_dispatch_read/write. I'll send a follow-up cleanup patch.

You still need some function to do the "return 0" on read, though, don't yo=
u?
(Having unassigned_mem_accepts returning false also leaves me a bit
confused about when these functions would actually get called, now
I look at the code again...)

thanks
-- PMM

