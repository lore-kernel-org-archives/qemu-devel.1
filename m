Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5DBC54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DD3206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ag4hoyA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DD3206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnhb-00045I-SU
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1jGngQ-0003Yt-Rz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1jGngP-0001Nl-Nm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:49:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21123)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1jGngP-0001NS-JO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585072184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NcH8ZM43mh7E9UdGsgKR8s8Vneh4n5V58XTxzGRgV0Q=;
 b=Ag4hoyA0jjU2bcdSxAci/yDPSRYqFWnMc1AvkbBrHj5yIdi3OsxChtoCpFQ23kJaZX3KPr
 7cQNadJl7XD/9tLpYkx04NVOnssRgdtsrouwv39r6eTaDidQ6xtFxf12uunDxZaB+Gpp7r
 Zhyr8jWF2S8lsorOk3f11iy0batnQfs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-p_PjcOTmNaKTDL9NfD7f7w-1; Tue, 24 Mar 2020 13:49:43 -0400
X-MC-Unique: p_PjcOTmNaKTDL9NfD7f7w-1
Received: by mail-ot1-f70.google.com with SMTP id 4so13051130otd.17
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 10:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NcH8ZM43mh7E9UdGsgKR8s8Vneh4n5V58XTxzGRgV0Q=;
 b=ZBFFBMibZIQtyEOoCYzYS9PyFIGlkc/2QeXtQ8mqEUCIKmOyZmEl1CMO1rxasq8MYe
 yMCl+ePtDUK98T+sndA51cWtKfsHzXeOKx8VZ6pYKIvXQyCvWiudd0qeGm+PSfsvIhbL
 ueC/6sJeEHMZfVH+aT++dyLAVkJtG9307r8Xsf/ZcuKe2yIeOw+udaxZoxO6WH6BspYZ
 UfFge9qMDzQpcgl9CXV6yX98MLK9jTDS8KHlmi9ywPNNlcOdJrepgjYHMj/JGczy8bZZ
 GLDrn2EEOBFiYDFESiAjPXNbuA4uufu5xkyJU7H06mPnxMAp4+zSUFkZKM5VyMDnge0S
 4LVQ==
X-Gm-Message-State: ANhLgQ10HU3N+YiP6eloeT9RtW85/NdNNmG5AQc7okpDDNu2s0TZK4DU
 ewlH5lZFAwGf3wRp4HEW2A7yb/r6ZJeVJ+xf1Y7KbjEUu6dY/gRh9AjHxm7Fw+DKxWpvYjrsRZV
 8YoIFCIYK1IurMEnoZ5bTUYp9tCLYA8k=
X-Received: by 2002:aca:4c1:: with SMTP id 184mr4366881oie.76.1585072182649;
 Tue, 24 Mar 2020 10:49:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt7tpraj7Y0cNXV1j2ljEXhVge27bXl5YUMxbqphCxDSbRCTv/pIw27F3WP66CBQGCG/gV+lCDOVcXVNdLd8w0=
X-Received: by 2002:aca:4c1:: with SMTP id 184mr4366847oie.76.1585072182185;
 Tue, 24 Mar 2020 10:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200324173630.12221-1-peter.maydell@linaro.org>
In-Reply-To: <20200324173630.12221-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Mar 2020 18:49:29 +0100
Message-ID: <CAMxuvawMhTCHkx1CA7XG6watFre8SzHn7eHVQR7sYSXMmXiGBA@mail.gmail.com>
Subject: Re: [PATCH for-5.0] dump: Fix writing of ELF section
To: Peter Maydell <peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Mar 24, 2020 at 6:36 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> In write_elf_section() we set the 'shdr' pointer to point to local
> structures shdr32 or shdr64, which we fill in to be written out to
> the ELF dump.  Unfortunately the address we pass to fd_write_vmcore()
> has a spurious '&' operator, so instead of writing out the section
> header we write out the literal pointer value followed by whatever is
> on the stack after the 'shdr' local variable.
>
> Pass the correct address into fd_write_vmcore().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> I have not tested this because I can't reproduce the conditions
> under which we try to actually use write_elf_section() (they
> must be rare, because currently we produce a bogus ELF file
> for this code path). In dump_init() s->list.num must be
> at least UINT16_MAX-1, which I think means it has to be a
> paging-enabled dump and the guest's page table must be
> extremely fragmented ?

yeah, I can't help either without spending more time playing with it,
but the fix looks good nonetheless.

> ---
>  dump/dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 6fb6e1245ad..22ed1d3b0d4 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -364,7 +364,7 @@ static void write_elf_section(DumpState *s, int type,=
 Error **errp)
>          shdr =3D &shdr64;
>      }
>
> -    ret =3D fd_write_vmcore(&shdr, shdr_size, s);
> +    ret =3D fd_write_vmcore(shdr, shdr_size, s);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret,
>                           "dump: failed to write section header table");
> --
> 2.20.1
>


