Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60143C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA62206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWNDr/H3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA62206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41479 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQcU3-0008IT-DN
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQcSZ-0006rf-Bm
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQcSY-0002Lo-Mw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:52:03 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:41513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQcSY-0002Kj-BZ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:52:02 -0400
Received: by mail-io1-xd44.google.com with SMTP id b12so12446840ion.8
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pjcY1QXbaNzG2IvQn4EnPDJtsg1AoXj6J52LPDHRjQY=;
 b=MWNDr/H3DqSTN4c5DiJ9lZOPCYXzQpTTgPGWLjuSs2A0ej8SGyGEdKAl0wXE9PB4bb
 6VnCFRvpy5tZsIaSUYdvYSFVa6Q4T4vZMQZLkWM61tQOmevr/jIuwMBKAjf62PQ/ALAX
 aK3ZnifEJxnXjSAe/FDhFlz9eP4X8BwDfys2IIgDlG44FAGVqj3MVjy7q1WbQ8w5g8eU
 OZ2IKfc4a1WRZNxomMJ+hUCw3Ze9qUpankX6nAvfdo2coBl5cU7s7YArZsSNAx67YlzX
 j6aFzPhI1xo9m2A8PYipvSH3DWKtE7rJrsSOiXuPvmODsWAgItT40Bwcmx5OYGrlUWO7
 0NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pjcY1QXbaNzG2IvQn4EnPDJtsg1AoXj6J52LPDHRjQY=;
 b=RqnGSzxUFqtfrvfE/ATbULfgR2fw0cgRz5+qgNYvCQ43MLUUaM0ycj8dTHOocE+je6
 EM6MxPiNySgUHQDSowiYIN6TM9jSB/HV1i8dbBnNOp29yIZMneBIlUs4khuZL6fJslmn
 wS5oMyJVvu8B5bnLfkUk+2NRHtFeRXD9VXRZf6ghoPJv8sSoJsBRic2Ccs25IWohfeVq
 TzqjsF/q/P4tVRtoljIK4M/65XX/2r3SJiC3Whi0W+OzeV7780Mf0bcqW1vekVaod5rN
 kbW3Ww1gfxAlrag+moas8DqJ5W44Yl2+Cz3r9LQKZlz2L9pFFOOCaoycF98m5qOMkmky
 +H+w==
X-Gm-Message-State: AGi0PuYWLxhp1RhIxNovMEwkDcCu0hTBEHKqqq0X1oBLVJnkaGDe2ULv
 CrHlo/GFC4c+cQH6iqoN9aHRu2RdEwJDmWtYsCM=
X-Google-Smtp-Source: APiQypJGMUe9Uz1yqGdRCMnB6gN6nboq2NxLavM49ZKZv0vHbHnMAuxPwJUYCMV419LNlwC131XnK/YaT88e/IjXgJ8=
X-Received: by 2002:a02:6414:: with SMTP id t20mr17614281jac.8.1587412321178; 
 Mon, 20 Apr 2020 12:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200402162839.76636-1-me@xcancerberox.com.ar>
 <CAKmqyKMrH=4X-ryFYBgSenaM4H4+HZ-uWbCf2hx8oYiHovFbng@mail.gmail.com>
In-Reply-To: <CAKmqyKMrH=4X-ryFYBgSenaM4H4+HZ-uWbCf2hx8oYiHovFbng@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 12:43:34 -0700
Message-ID: <CAKmqyKOgaGZUODTiifyxS-_BHG8NbJUnuWzsE=PHsiFip_bVXQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v2] hw/core/register: Add register_init_block8
 helper.
To: Joaquin de Andres <me@xcancerberox.com.ar>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 2, 2020 at 3:45 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Apr 2, 2020 at 9:29 AM Joaquin de Andres <me@xcancerberox.com.ar> wrote:
> >
> > There was no support for 8 bits block registers. Changed
> > register_init_block32 to be generic and static, adding register
> > size in bits as parameter. Created one helper for each size.
> >
> > Signed-off-by: Joaquin de Andres <me@xcancerberox.com.ar>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for the patch. I have applied this to the device tree pull
request for 5.1.

Alistair

>
> Alistair
>
> > ---
> > This patch is small and I could see that there is not much movement with
> > the release, so, I let my self send this. Also this is my first patch :)
> > Reviews are welcome.
> > ---
> >  hw/core/register.c    | 46 +++++++++++++++++++++++++++++++++----------
> >  include/hw/register.h |  8 ++++++++
> >  2 files changed, 44 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/core/register.c b/hw/core/register.c
> > index 3c77396587..ddf91eb445 100644
> > --- a/hw/core/register.c
> > +++ b/hw/core/register.c
> > @@ -246,16 +246,18 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
> >      return extract64(read_val, 0, size * 8);
> >  }
> >
> > -RegisterInfoArray *register_init_block32(DeviceState *owner,
> > -                                         const RegisterAccessInfo *rae,
> > -                                         int num, RegisterInfo *ri,
> > -                                         uint32_t *data,
> > -                                         const MemoryRegionOps *ops,
> > -                                         bool debug_enabled,
> > -                                         uint64_t memory_size)
> > +static RegisterInfoArray *register_init_block(DeviceState *owner,
> > +                                              const RegisterAccessInfo *rae,
> > +                                              int num, RegisterInfo *ri,
> > +                                              void *data,
> > +                                              const MemoryRegionOps *ops,
> > +                                              bool debug_enabled,
> > +                                              uint64_t memory_size,
> > +                                              size_t data_size_bits)
> >  {
> >      const char *device_prefix = object_get_typename(OBJECT(owner));
> >      RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
> > +    int data_size = data_size_bits >> 3;
> >      int i;
> >
> >      r_array->r = g_new0(RegisterInfo *, num);
> > @@ -264,12 +266,12 @@ RegisterInfoArray *register_init_block32(DeviceState *owner,
> >      r_array->prefix = device_prefix;
> >
> >      for (i = 0; i < num; i++) {
> > -        int index = rae[i].addr / 4;
> > +        int index = rae[i].addr / data_size;
> >          RegisterInfo *r = &ri[index];
> >
> >          *r = (RegisterInfo) {
> > -            .data = &data[index],
> > -            .data_size = sizeof(uint32_t),
> > +            .data = data + data_size * index,
> > +            .data_size = data_size,
> >              .access = &rae[i],
> >              .opaque = owner,
> >          };
> > @@ -284,6 +286,30 @@ RegisterInfoArray *register_init_block32(DeviceState *owner,
> >      return r_array;
> >  }
> >
> > +RegisterInfoArray *register_init_block8(DeviceState *owner,
> > +                                        const RegisterAccessInfo *rae,
> > +                                        int num, RegisterInfo *ri,
> > +                                        uint8_t *data,
> > +                                        const MemoryRegionOps *ops,
> > +                                        bool debug_enabled,
> > +                                        uint64_t memory_size)
> > +{
> > +    return register_init_block(owner, rae, num, ri, (void *)
> > +                               data, ops, debug_enabled, memory_size, 8);
> > +}
> > +
> > +RegisterInfoArray *register_init_block32(DeviceState *owner,
> > +                                         const RegisterAccessInfo *rae,
> > +                                         int num, RegisterInfo *ri,
> > +                                         uint32_t *data,
> > +                                         const MemoryRegionOps *ops,
> > +                                         bool debug_enabled,
> > +                                         uint64_t memory_size)
> > +{
> > +    return register_init_block(owner, rae, num, ri, (void *)
> > +                               data, ops, debug_enabled, memory_size, 32);
> > +}
> > +
> >  void register_finalize_block(RegisterInfoArray *r_array)
> >  {
> >      object_unparent(OBJECT(&r_array->mem));
> > diff --git a/include/hw/register.h b/include/hw/register.h
> > index 5796584588..5d2c565ae0 100644
> > --- a/include/hw/register.h
> > +++ b/include/hw/register.h
> > @@ -185,6 +185,14 @@ uint64_t register_read_memory(void *opaque, hwaddr addr, unsigned size);
> >   *          memory region (r_array->mem) the caller should add to a container.
> >   */
> >
> > +RegisterInfoArray *register_init_block8(DeviceState *owner,
> > +                                        const RegisterAccessInfo *rae,
> > +                                        int num, RegisterInfo *ri,
> > +                                        uint8_t *data,
> > +                                        const MemoryRegionOps *ops,
> > +                                        bool debug_enabled,
> > +                                        uint64_t memory_size);
> > +
> >  RegisterInfoArray *register_init_block32(DeviceState *owner,
> >                                           const RegisterAccessInfo *rae,
> >                                           int num, RegisterInfo *ri,
> > --
> > 2.26.0
> >
> >

