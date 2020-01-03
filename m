Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F05C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BCA21734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOu7EGjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BCA21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inHdq-0006CW-RE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 02:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inHcV-0004kj-88
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inHcU-0002ky-4E
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:43:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inHcT-0002iA-UR
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578037421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDimF7fIbTxtTRUI92nW1zt9zIxEXVWBbvsGMpP6FsQ=;
 b=UOu7EGjgPi5sFQ2Vv32hZPgyq+IRt9SJOy2xr9EQIWyR2gMJAxab3BlWV9IVjo4EKW4jyT
 2dXhL1DJvH/FTuehi9tp+rpZwRa4/u6++T0gPeGFoIe+h31s0p3DqFDDv1Gm1ZRzBf6841
 SW0S3D4bJSNgS8QSvUu8xP+DAqO7MsE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-WSnFd9udOKGe_K93U3W3xQ-1; Fri, 03 Jan 2020 02:43:40 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so13956761wrh.5
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 23:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nZrT4nyYzZ2KcRHqDDb0dWGLy1O7r/zheHT3L+B++DE=;
 b=nYXgcRDOMf9ALxcWlhhrXR2WyIsplK/UvsHoUkjYngq69EJiFuwHxh0TjwNLnj7DBw
 IFVAcp2pzu+SFEFKNXQ33655V9ZQOizmKCNbwxE+vsAK8sLc26kUWMIPlYl+dXzRJuKH
 tY7FSl8Usp0wapyPY5EpNW8costlf74IJqKGpce2OkFUdEI1O/pFU2SoN5qmmtQ5fmaM
 caHbM7lEX5QbRV10SxQ775ore3plw9f/rJp0ADUXAzhcCWQhZP5kJ2EyvJAVVApekDKY
 N312vItziSJcNv4R2SRFyWIoHCPAwHTd+3XNr+GdYu8Q41jnsHCos6Yx6nanuNWceoGl
 OelA==
X-Gm-Message-State: APjAAAXXR7mE57d1UI08GzyA7xa6iRWxiY7MRtRg0hzL7nlbn1VE6bMQ
 63NZoh9lQL9xg4q2x/I3TPb68EE1roStCxMZVHTcJ4eBMca47i3/wt98qH73WVNDqoRdHvdSsZY
 jrF/ObY6fWs0HRtw=
X-Received: by 2002:a1c:a543:: with SMTP id o64mr18384886wme.108.1578037418936; 
 Thu, 02 Jan 2020 23:43:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjUW1r2UfUzUEsUpAYjhu7R1oqEdhUORZw7Fxqpj5uShI/H74b1hRhs/tW1KpMmYl1CIi8vg==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr18384875wme.108.1578037418787; 
 Thu, 02 Jan 2020 23:43:38 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id j12sm63176506wrw.54.2020.01.02.23.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 23:43:38 -0800 (PST)
Subject: Re: [PATCH v2 3/3] savevm: check RAM is pagesize aligned
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5cb78b1c-94eb-c0fe-3360-9e2098e82f55@redhat.com>
Date: Fri, 3 Jan 2020 08:43:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103074000.1006389-4-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: WSnFd9udOKGe_K93U3W3xQ-1
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

On 1/3/20 8:40 AM, Marc-Andr=C3=A9 Lureau wrote:
> Check the host pointer is correctly aligned, otherwise we may fail
> during migration in ram_block_discard_range().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   migration/savevm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a71b930b91..bbb7e89682 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2910,6 +2910,11 @@ err_drain:
>  =20
>   void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
>   {
> +    RAMBlock *rb =3D mr->ram_block;
> +
> +    assert(QEMU_PTR_IS_ALIGNED(qemu_ram_get_host_addr(rb),
> +                               qemu_ram_pagesize(rb)));
> +
>       qemu_ram_set_idstr(mr->ram_block,
>                          memory_region_name(mr), dev);
>       qemu_ram_set_migratable(mr->ram_block);
>=20


