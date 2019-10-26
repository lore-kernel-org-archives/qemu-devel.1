Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BFFCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 08:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12D8205C9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 08:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4oBIV/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12D8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOHkE-0003Dg-1L
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 04:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iOHiz-0007wA-0n
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 04:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iOHix-0001gQ-Hm
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 04:47:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36944
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iOHix-0001fe-Dz
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 04:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572079621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diUYJmZRk0pksHe8k5n9ZBmMfm/EANcpFE4v2Thes2E=;
 b=O4oBIV/a0/Kc31ddmG9Swyd5M7NkoWOPjHWXk5Hi+1TEMfoifuy3BYRKGMlUObrPKJEDrc
 xULMZN3LcF4mYKbrYySWz0K6R0tcJPelcCg0UcUepjb3XD2u6zXP3e/SVxjqMjBcs2Ik9T
 JsasccoSAd4pcIJNVFVUwXFm+bzJdEo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-OiRvy8zKMRGBWIqJO54zCg-1; Sat, 26 Oct 2019 04:46:58 -0400
Received: by mail-wr1-f72.google.com with SMTP id i10so2594346wrb.20
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 01:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=diUYJmZRk0pksHe8k5n9ZBmMfm/EANcpFE4v2Thes2E=;
 b=ZgKqrTx7sEm2+BM+1y8VRQpML8cvkXgPzCvHMjc1uDxkaahOUYSNVlB0eX44+bXz6e
 m8AWU6Y0F1jKaalMghBR/DGulL0/AWv60zKSfeLfqVmW6/7QksjUjH7Yzdi2DRddIojf
 pW12xRKcwQ2ikPDm5zz1BbcUX+UskTwTmxYZ0LmC0fZO8QaHwGXNIBWhCMs6zSw0OzeI
 cFtgEbFxYxBWNRi79PniLKFJb3/11XafSwFpLQXNE3Tr+sGpEt6W2k/A5kRy0bxoyNw5
 XPwBPVHZqGPOk0ejBf2aDenQBIytGGmWCGFD23P6SBiTYXzXt33MRXOmaV1qs2P8fx5H
 XgEw==
X-Gm-Message-State: APjAAAVncjQG44VUeeZcQdV/DbpNme1TcXIO4xqHGOSXzgEDJYobVJ/B
 v9tDOL85adJfL39ua+2WdV4vJSriy+2u+nTzeJeEtv3BO/UC5T4PEumM/wCp9eJddqEKIEyfwQ1
 eMpsZmzJ2e6h67+YHmAfYMpu3UxMPqBw=
X-Received: by 2002:a1c:a791:: with SMTP id q139mr6874556wme.155.1572079617226; 
 Sat, 26 Oct 2019 01:46:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcG8jZ98YOOgXfTPGgerhIr/n8s/kWy/M8h+71znvc7MvlV6V3zJa/ZGTw7Ay2GNndBhac6sefogq1mi3qliE=
X-Received: by 2002:a1c:a791:: with SMTP id q139mr6874535wme.155.1572079616986; 
 Sat, 26 Oct 2019 01:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <a88742acd6969991d44f897f7232a847e9768f57.1572045246.git.alistair.francis@wdc.com>
 <0178d892-dbb5-8970-08eb-416466b53002@redhat.com>
In-Reply-To: <0178d892-dbb5-8970-08eb-416466b53002@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Sat, 26 Oct 2019 10:46:45 +0200
Message-ID: <CAP+75-XUbnCDp-JH6JRnGLqVMxDWTFa9kPHJaZXm3NfCzZUbYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] opensbi: Upgrade from v0.4 to v0.5
To: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 "open list:RISC-V" <qemu-riscv@nongnu.org>
X-MC-Unique: OiRvy8zKMRGBWIqJO54zCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 26, 2019 at 10:45 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Alistair,
>
> On 10/26/19 1:15 AM, Alistair Francis wrote:
> > This release has:
> >      Lot of critical fixes
> >      Hypervisor extension support
> >      SBI v0.2 base extension support
> >      Debug prints support
> >      Handle traps when doing unpriv load/store
> >      Allow compiling without FP support
> >      Use git describe to generate boot-time banner
> >      Andes AE350 platform support
>
> Do you mind amending the output of 'git shortlog v0.4..v0.5'?

Err this comment is for Palmer, if Alistair agree (no need to repost).

> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > You can get the branch from here if the binaries are causing issues:
> > https://github.com/alistair23/qemu/tree/mainline/alistair/opensbi.next
>
> You can use 'git format-patch --no-binary'.
>
> >
> >   pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 36888 -> 40984 byt=
es
> >   pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 45064 -> 49160 byt=
es
> >   pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 40968 -> 45064 byt=
es
> >   roms/opensbi                                 |   2 +-
> >   4 files changed, 1 insertion(+), 1 deletion(-)
> [...]
> > diff --git a/roms/opensbi b/roms/opensbi
> > index ce228ee091..be92da280d 160000
> > --- a/roms/opensbi
> > +++ b/roms/opensbi
> > @@ -1 +1 @@
> > -Subproject commit ce228ee0919deb9957192d723eecc8aaae2697c6
> > +Subproject commit be92da280d87c38a2e0adc5d3f43bab7b5468f09
> >


