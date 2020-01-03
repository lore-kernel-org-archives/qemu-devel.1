Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F01C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 05:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B427821734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 05:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQIaGh71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B427821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inFB0-000761-Ra
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 00:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inFAK-0006cv-1Q
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inFAH-0002Er-Gy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:06:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55758
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inFAH-00029U-1w
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578027983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0e7IM6FFYqaY0OqhGuJX3oIso53CmeO603gpv21Dd3A=;
 b=MQIaGh71FA4+oxfShy4DtdWghfPRlueuI+K2mTBSqBNl5scyKyWo78zYEXgmFGEi8zWLG6
 TQSel4LM5lVVkcENO0DVxsXSo7+5e5sHXpCnS0VbcYzI4gkG2iy60d82GiXr1hzL6yTU+p
 sBtQQjHS+kMen7sbMvZsLVWwSw+Bgvw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-azEJeDE_M2mvWejzZ4vL-Q-1; Fri, 03 Jan 2020 00:06:21 -0500
Received: by mail-wr1-f72.google.com with SMTP id 90so22490590wrq.6
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 21:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1znOzGs2JxGB7GNeic5dKzBKrJwcITpNgFNCw8yiKAE=;
 b=OYfIiouKS4qs1VsfKrfiCTIXtOEsdVDrDHafBVWH1A4XZkqSYBSj9m+k0h3OcoD7wN
 /yrQB3UL/vs5TO3f66nLJ85DYgkHXg4WY1Sm1MzzB8jaGckMGpPd+OXOY8rwuSqNuSnZ
 Wi2KFpcxg9dL40DMUYqoys57m0RI9sKXJNVno2CfUFpaaO6GNWBt9aeJ+gxJW1zEEMPm
 5Rm9b5yaPr62KrdpgVXpAe70h5FWXckIS5CMZANfc1/Q2KwVdRY6faEOiquWDaNrrn4r
 0k7mM/tsjhZEMDk1RBPMiEelcPhkjkfYAjJs3OvznlAbV8QKrorFS5uZny05BbVb2JKL
 2lGg==
X-Gm-Message-State: APjAAAUzvxkeSiboU/ogyCOgQeeXHGwetYxq16FGC4KnFfJLI4d0VgkE
 hs28aoTx7Q5uct16dIaLdZfeq6F2jtTUYJVYuorHvoJuJbwBtNjE3vjAM4ta+Ra4OwxBlle7tn2
 UVE+7sJ9a1cueQ6U=
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr84660656wre.156.1578027980590; 
 Thu, 02 Jan 2020 21:06:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDoTm/wTLQ8olEfgVeaElo+4rYJVzNptfe47SHw7bJkDFYwjH2EjA6JGtxY23VyunqsPv8Fg==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr84660629wre.156.1578027980351; 
 Thu, 02 Jan 2020 21:06:20 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id a1sm58314712wrr.80.2020.01.02.21.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 21:06:19 -0800 (PST)
Subject: Re: [PATCH 1/2] RFC: savevm: check RAM is page_size aligned
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200102210149.926077-1-marcandre.lureau@redhat.com>
 <20200102210149.926077-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <926dcf48-e309-55a5-cfcd-bd1343c17f27@redhat.com>
Date: Fri, 3 Jan 2020 06:06:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102210149.926077-2-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: azEJeDE_M2mvWejzZ4vL-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc-Andr=C3=A9,

On 1/2/20 10:01 PM, Marc-Andr=C3=A9 Lureau wrote:
> Check the host pointer is correctly aligned, otherwise we may fail
> during migration in ram_block_discard_range().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   migration/savevm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a71b930b91..ab6e02011f 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2910,6 +2910,11 @@ err_drain:
>  =20
>   void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
>   {
> +    RAMBlock *rb =3D mr->ram_block;
> +    uintptr_t hostaddr =3D (uintptr_t)qemu_ram_get_host_addr(rb);
> +
> +    assert((hostaddr & (qemu_ram_pagesize(rb) - 1)) =3D=3D 0);

Can we use the QEMU_PTR_IS_ALIGNED() macro instead?

        assert(QEMU_PTR_IS_ALIGNED(qemu_ram_get_host_addr(rb),
                                   qemu_ram_pagesize(rb)));

>       qemu_ram_set_idstr(mr->ram_block,
>                          memory_region_name(mr), dev);
>       qemu_ram_set_migratable(mr->ram_block);
>=20


