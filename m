Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D0C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7782E20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ali/EIo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7782E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5hG-0004f5-GW
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU5gM-00048w-RH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU5gL-0003UF-SY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:40:38 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:33638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU5gL-0003N9-Dw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:40:37 -0400
Received: by mail-oo1-xc42.google.com with SMTP id b17so1139740ooa.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Gc9fJgMRaRVWJ8uv/8iHoa5RbPsoflBZLifGxhv3u/0=;
 b=ali/EIo0mKJzIF8MhEYPoL9oahVDJEEwnKMUMOoUMmelqn+2Ul5j8CTHauKw0OlsNk
 6+6R/78T1iEXln2913KDOvB/X2jGKefhX86/4m/vtTQaYX/SbDp9lKxF2GeBUuUlV0ta
 Bi2pBCJ1NGNieG77hA1+Uq5s1aCwArCdlR3YctbJtYTNvn9AxwOYBN8zvBTzCB6C6K6d
 9EOkOMEqZdJRD3XRyN7TCuAymzXiCKVlT3PalrDbKnG108GntogYglsIMt21QqFewrjZ
 tkldcGZHc0L+oVW0gNztIVXJPTQZj/njEKg7yUOgJCS4wovX8OEZDXcV/ANyKz2amSzl
 0cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Gc9fJgMRaRVWJ8uv/8iHoa5RbPsoflBZLifGxhv3u/0=;
 b=dj/YBvPi5GHJvwe5PhZ34fbhdTDCWkgrurN9JidwHLgGtGB2GnbnAGJJKr7vT6n/w0
 VAfV3zP984Jnm+Wz/YN/elMwTl377WS8TibSjR071z2ZtV5kzcNySMpy3YCWCv6NW2DI
 i76HMz5zo7qDDqpAmZgF2Q3wny3bo9u8KQ1wzAD/tw/J+ujHhQNruK42zVbv2T1md8s4
 WiJZ04Ia/oe+mSV6I2hogp7ivH5xmjXalq+oPBlhmzyBOCtawMvV4zpO8tzG2NeXEEzi
 6FJo8UxWHbfDuv4s1DiwELK4DBVrw2HBJLd/9KE9HUBYenwOXu1zWBMNbRJtg01mED1q
 PoqA==
X-Gm-Message-State: AGi0Pua+dLR/2eg33P2H/5IecrzXPLCUHg6TevyfD+JfUc0PwxPVa2IP
 GIKS9uzuVrOXYJC9Qm2/KGWjt+biSKytXrQLO+T+Mg==
X-Google-Smtp-Source: APiQypKkbxcPL1BlT0m+QqbOH3pnRAP9GInjhWfgYmIrQaYE3/s0HeCs8ZgeLFJRGWBPvOsbgVW4p8z28tY3T8z2zQA=
X-Received: by 2002:a4a:3113:: with SMTP id k19mr2061292ooa.20.1588239636086; 
 Thu, 30 Apr 2020 02:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
In-Reply-To: <20200430080946.31286-1-yan.y.zhao@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 10:40:25 +0100
Message-ID: <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 09:20, Yan Zhao <yan.y.zhao@intel.com> wrote:
>
> for ram device regions, drop guest writes if the region is read-only.
>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>  memory.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/memory.c b/memory.c
> index 601b749906..a1bba985b9 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -34,6 +34,7 @@
>  #include "sysemu/accel.h"
>  #include "hw/boards.h"
>  #include "migration/vmstate.h"
> +#include "qemu/log.h"
>
>  //#define DEBUG_UNASSIGNED
>
> @@ -1307,12 +1308,19 @@ static uint64_t memory_region_ram_device_read(voi=
d *opaque,
>      return data;
>  }
>
> -static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> -                                           uint64_t data, unsigned size)
> +static MemTxResult memory_region_ram_device_write(void *opaque, hwaddr a=
ddr,
> +                                                  uint64_t data, unsigne=
d size,
> +                                                  MemTxAttrs attrs)
>  {
>      MemoryRegion *mr =3D opaque;
>
>      trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data=
, size);
> +    if (mr->readonly) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid write to read-only ram device region addr=
 0x%"
> +                      HWADDR_PRIx" size %u\n", addr, size);
> +        return MEMTX_ERROR;
> +    }

This does not "drop" a write to a r/o region -- it causes it to generate
whatever the guest architecture's equivalent of a bus error is (eg data
abort on Arm).

More generally, this change seems a bit odd: currently we do not
check the mr->readonly flag here, but in general guests don't get
to write to ROM areas. Where is that check currently done, and
should the vfio case you're trying to fix do its check in whatever
the equivalent of that place is? Alternatively, if we want to make
memory_region_ram_device_write() do the check, does that mean we
now have unnecessary checks elsewhere.

My guess is that memory_region_ram_device_write() isn't the
right place to check for read-only-ness, because it only applies
to RAM-backed MRs, not to any other kind of MR which might equally
be readonly.

thanks
-- PMM

