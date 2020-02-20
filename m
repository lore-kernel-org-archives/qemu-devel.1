Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC56C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB11206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6gPmvlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB11206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ln9-0008KP-2H
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4llx-0006oU-Qg
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4llw-0003Kg-I5
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:21:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56432
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4llw-0003KR-Ek
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4PJnWfahZa1TNC6+g1IhMFCY1W/sixaIQI4WNkTwR8=;
 b=J6gPmvlEcAYYGB7M6Me9KtlP+OJsJz3Ir8MvgOQVGFpL5laD/vBg5mTJv67l+4erZ0CkN2
 m6aegXauLyCAdQWW8ZhyAHhvGZA1ObzLh9jJWUtzJTFrKVqg11x+fPYqn1vd10AOV6v4tu
 cjOX/e0T3UY+62J339+YPDrSJKJoCsQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-CwOULh03NfSiWDriaaJwcg-1; Thu, 20 Feb 2020 08:21:42 -0500
Received: by mail-wm1-f69.google.com with SMTP id y7so591832wmd.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8fOoSsSz7tsTUHvX+UaUO6G7U94kDGpWqoCWwnJ/CO0=;
 b=GoNGXX1ev19cghvKHJCWGTTjlNcyx5zGkkBQ6YkUYnc4L+smEK2eJSpZBTotg49BRd
 auiHp75igcE4+mSmG+EutDMyA0gQ7YnJAVWofgq1/XC6q1v4sFGPoVuofQhkw2KxZxUz
 ZokVbyCFBc2M4th6JT2WYMQuydoBuUGOAyh4mczac/dlOUxezoerCGkEyGLL0YtU9hNU
 demmYvOzMHImdmWNsIjMOBFvlTrVFXucJ+NBEzzYbUio+YVlGvLrL0Qx+rhL8YxApIxh
 ryKWQqMMGvoSTPzund0T3OExBdpRzsN7wE+NTofbE9soVNXKsnIQqipJe/WVDCb4XAxo
 /vEQ==
X-Gm-Message-State: APjAAAX5kR0MdKbzXuw4Lt4cniaMtJLzyTpw4+CffmoiLIYDf1zlcAi5
 jKUMxOIOgxXangnea+QRgw6D78vO8ULhKHZrDmuYEEDEhi1ddKVSGI389MY7MZBZE2865kzhhcZ
 KyBCShW8zB19DWQs=
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr4782605wml.50.1582204900628;
 Thu, 20 Feb 2020 05:21:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKxcQLqflxe9qCIU9rTsjyGiEk6CQgzPBe/H4AxjLFCiLPx9wCf3WQ03jwpKNmMAnM1bKEcw==
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr4782560wml.50.1582204900358;
 Thu, 20 Feb 2020 05:21:40 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id i2sm4415838wmb.28.2020.02.20.05.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 05:21:39 -0800 (PST)
Subject: Re: [PATCH v3 03/20] exec: Let qemu_ram_*() functions take a const
 pointer argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200220130548.29974-1-philmd@redhat.com>
 <20200220130548.29974-4-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fce0956e-e542-e8a5-bd02-a7941a9db627@redhat.com>
Date: Thu, 20 Feb 2020 14:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200220130548.29974-4-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: CwOULh03NfSiWDriaaJwcg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/02/20 14:05, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/exec/cpu-common.h     | 6 +++---
>  include/sysemu/xen-mapcache.h | 4 ++--
>  exec.c                        | 8 ++++----
>  hw/i386/xen/xen-mapcache.c    | 2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 81753bbb34..05ac1a5d69 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -48,11 +48,11 @@ typedef uint32_t CPUReadMemoryFunc(void *opaque, hwad=
dr addr);
> =20
>  void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
>  /* This should not be used by devices.  */
> -ram_addr_t qemu_ram_addr_from_host(void *ptr);
> +ram_addr_t qemu_ram_addr_from_host(const void *ptr);

This is a bit ugly, because the pointer _can_ be modified via
qemu_map_ram_ptr.  Is this needed for the rest of the series to apply?

Paolo

>  RAMBlock *qemu_ram_block_by_name(const char *name);
> -RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
> +RAMBlock *qemu_ram_block_from_host(const void *ptr, bool round_offset,
>                                     ram_addr_t *offset);
> -ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, const void *host);
>  void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *=
dev);
>  void qemu_ram_unset_idstr(RAMBlock *block);
>  const char *qemu_ram_get_idstr(RAMBlock *rb);
> diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.=
h
> index c8e7c2f6cf..81e9aa2fa6 100644
> --- a/include/sysemu/xen-mapcache.h
> +++ b/include/sysemu/xen-mapcache.h
> @@ -19,7 +19,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f,
>                          void *opaque);
>  uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
>                         uint8_t lock, bool dma);
> -ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
> +ram_addr_t xen_ram_addr_from_mapcache(const void *ptr);
>  void xen_invalidate_map_cache_entry(uint8_t *buffer);
>  void xen_invalidate_map_cache(void);
>  uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
> @@ -40,7 +40,7 @@ static inline uint8_t *xen_map_cache(hwaddr phys_addr,
>      abort();
>  }
> =20
> -static inline ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> +static inline ram_addr_t xen_ram_addr_from_mapcache(const void *ptr)
>  {
>      abort();
>  }
> diff --git a/exec.c b/exec.c
> index 8e9cc3b47c..02b4e6ea41 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2614,7 +2614,7 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_bloc=
k, ram_addr_t addr,
>  }
> =20
>  /* Return the offset of a hostpointer within a ramblock */
> -ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, const void *host)
>  {
>      ram_addr_t res =3D (uint8_t *)host - (uint8_t *)rb->host;
>      assert((uintptr_t)host >=3D (uintptr_t)rb->host);
> @@ -2640,11 +2640,11 @@ ram_addr_t qemu_ram_block_host_offset(RAMBlock *r=
b, void *host)
>   * pointer, such as a reference to the region that includes the incoming
>   * ram_addr_t.
>   */
> -RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
> +RAMBlock *qemu_ram_block_from_host(const void *ptr, bool round_offset,
>                                     ram_addr_t *offset)
>  {
>      RAMBlock *block;
> -    uint8_t *host =3D ptr;
> +    const uint8_t *host =3D ptr;
> =20
>      if (xen_enabled()) {
>          ram_addr_t ram_addr;
> @@ -2705,7 +2705,7 @@ RAMBlock *qemu_ram_block_by_name(const char *name)
> =20
>  /* Some of the softmmu routines need to translate from a host pointer
>     (typically a TLB entry) back to a ram offset.  */
> -ram_addr_t qemu_ram_addr_from_host(void *ptr)
> +ram_addr_t qemu_ram_addr_from_host(const void *ptr)
>  {
>      RAMBlock *block;
>      ram_addr_t offset;
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index 5b120ed44b..432ad3354d 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -363,7 +363,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
>      return p;
>  }
> =20
> -ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> +ram_addr_t xen_ram_addr_from_mapcache(const void *ptr)
>  {
>      MapCacheEntry *entry =3D NULL;
>      MapCacheRev *reventry;
>=20


