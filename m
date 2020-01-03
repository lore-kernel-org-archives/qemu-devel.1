Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F915C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E7E21734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/aQAX28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E7E21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inHd6-000587-0l
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 02:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inHcB-0004Di-5k
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inHcA-0001LM-46
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:43:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inHc9-0001HG-Ss
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578037401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5abF9Q39c+zNiqIyk5XQFth4jXhY+93Y+17X94+FYg=;
 b=M/aQAX28kja2/Bw9xY00yluujksBpWQiZcQ+6I/TVQbYSjEYFitptNLu1722XTal05rYyE
 zR8f5cxKflAER9GdT0XVTaA89kpN/5PobazUvCZF6yYhu54CTQDoyvTk4U75+LqTRCzbjO
 ooLfxCRsXA9v2pHYW/qcDc/uY7w0HI8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-w30Gv9GOPdiBC5lnp2f9Kw-1; Fri, 03 Jan 2020 02:43:19 -0500
Received: by mail-wr1-f69.google.com with SMTP id y7so22805957wrm.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 23:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vr2lTX9ocwI51W0049YIcCXsPOGOLNcahfw7DCmHRRI=;
 b=JP55+mzG0PGvnOq3yPmL9bNb8nDBAOIetLs4S+8Knt+6Fa/4y1DrxdDeQZp83dOq9U
 YmfLoyySA3GfK/AKmiZ2u8zdVW6m8VFN8eI+NTB/0gRcJHdCIc+m3pdlWAEtEW6dtCGO
 +26M17N+vmGs5dk2xh/H4+4K7z+D2PhIHHTRIxpFRgkhzZkZ16ekJ8hypxYpGn8smkm8
 y1smexIHO+Gp9u3WNPpDB6lwRV/0fLfdG2V3GuYR4tCxm8OuyH1TqRIlzjdsM0ZJL48N
 AgeTd0LIX61IsQpGxbCgdzh97k3Wv1O4tzIN1OqS4WLxQr0ychVGx+vLgIMxK8SkuCEr
 87xw==
X-Gm-Message-State: APjAAAVUBboMawtamRVtmnTksu2xgdUWVF3rnyeTEJj9Uu0rEHPTq2ej
 b1O2OoF97VNeOtDr5aGEkJ9chGPy4t+Q2KchcfTwrjbZBlyxj9LPMPP2yl/h8PPq4fK9W+PEL+m
 NYs3zglhqDY0e1mo=
X-Received: by 2002:a1c:a513:: with SMTP id o19mr17110844wme.156.1578037398533; 
 Thu, 02 Jan 2020 23:43:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMbWI/zOuslPUKcT/oz97mGFD2H9ewKAV2i0sTThxzm5Q2lggr0R5IzKVo3LHsf2J9Teqs7A==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr17110827wme.156.1578037398361; 
 Thu, 02 Jan 2020 23:43:18 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id i16sm11265483wmb.36.2020.01.02.23.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 23:43:17 -0800 (PST)
Subject: Re: [PATCH v2 1/3] misc: use QEMU_IS_ALIGNED
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2668c259-8ee9-06eb-9d7e-c09ca12aace4@redhat.com>
Date: Fri, 3 Jan 2020 08:43:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103074000.1006389-2-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: w30Gv9GOPdiBC5lnp2f9Kw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefan Berger <stefanb@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 8:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   exec.c    | 4 ++--
>   roms/SLOF | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index d4b769d0d4..1feda49ca1 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3895,7 +3895,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t =
start, size_t length)
>  =20
>       uint8_t *host_startaddr =3D rb->host + start;
>  =20
> -    if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
> +    if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
>           error_report("ram_block_discard_range: Unaligned start address:=
 %p",
>                        host_startaddr);
>           goto err;
> @@ -3903,7 +3903,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t =
start, size_t length)
>  =20
>       if ((start + length) <=3D rb->used_length) {
>           bool need_madvise, need_fallocate;
> -        if (length & (rb->page_size - 1)) {
> +        if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
>               error_report("ram_block_discard_range: Unaligned length: %z=
x",
>                            length);
>               goto err;
> diff --git a/roms/SLOF b/roms/SLOF
> index 9546892a80..8ebf2f55e1 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
> +Subproject commit 8ebf2f55e1ba1492b942ba4b682160e644fc0f98

Without the SLOF submodule update:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


