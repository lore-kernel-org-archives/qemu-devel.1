Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01AFC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C19F206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bpk592PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C19F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCXqv-0004Wy-Ng
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCXqI-0003Kf-Pk
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCXqH-0001Af-O4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:06:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21214
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCXqH-0001A3-Hq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584057980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wkBkrLPtaNbKE6fo9mKv9F/Z+gimgYA+hpYGJYsU2U=;
 b=Bpk592PQt7z2veOrHohjGR1b8CiUkOrcNylidftuL/UKyX81eRfejQLqFcJblLUAqo1VbD
 oxgVZrr2+YRRjlH2AnD0FnuCmkaK8PhgEGh7z/PFsiHLMEQvz3+rcOosmCM4hWxTUG+XWe
 lJQVjhTCMWy/HJTBCGshMl+a9WYcmXk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-ttCZ6cVVOwKfCpRHoBmnCA-1; Thu, 12 Mar 2020 20:06:19 -0400
X-MC-Unique: ttCZ6cVVOwKfCpRHoBmnCA-1
Received: by mail-wr1-f69.google.com with SMTP id j17so3397000wru.19
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 17:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q2X+t0E8XeMLXyYG++iN5sUs/z0ZRVCm6c40Vin5RJs=;
 b=TlsgTiwVClDP7XVgIxHhM9Po4vENqp9uumkrzrgnIKuk4EnFmDCeI53sCouNM5rCHi
 glxG5SdByxbrdon5U+IjJduzAElQs3JZcfKN9c4nJ/rHOo28UpWOqsfncicD42EnTKy9
 GbYU1cZicKZo9nfChjsWIjq/PzS6n54Uz9P1LJNXvsbs9aE/YhnIcVhUxExr2VOYwU1F
 taZW5Twc7qPdHd5AxhGcVatwjVXpgpbt9b5Fmxb4+yCnYA680t/COZOJ8xNFdLN82gv4
 wE8udSGK71A7QZBxyXJ03qNf6+JElyqtoWLYnNBRZDc3+R6XKnse+xRD3cEkPsagT1QA
 mQHw==
X-Gm-Message-State: ANhLgQ2chLdkU6IQ+oIagwGUL+xEXl1KeurIXG3WSEPiqy45j6eWTTQl
 zFxswmhvUrYgHs5oStOSOFhJ41SD9Jg37GFaxYnAJUd5XvE1mCyZ+VypwNUGGpsfxx24aHgPKtc
 aPKSQAD3gGV90QNQ=
X-Received: by 2002:a1c:8149:: with SMTP id c70mr7219923wmd.123.1584057977991; 
 Thu, 12 Mar 2020 17:06:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvV3T+EVHi43Z7iHXmb55I4LoyDfIo80LdRUsgdM/zT41J5jQm7qbwwTgxz8OBV1NNDNwDnKw==
X-Received: by 2002:a1c:8149:: with SMTP id c70mr7219907wmd.123.1584057977757; 
 Thu, 12 Mar 2020 17:06:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id q7sm24687078wrd.54.2020.03.12.17.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 17:06:17 -0700 (PDT)
Date: Thu, 12 Mar 2020 20:06:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 11/16] hw/i386/vmport: Add support for CMD_GETTIMEFULL
Message-ID: <20200312200518-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-12-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-12-liran.alon@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 06:54:26PM +0200, Liran Alon wrote:
> Similar to CMD_GETTIME but lacks the 136-year overflow issue,
> by returning full 64-bit of host uSeconds.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/i386/vmport.c         | 17 +++++++++++++++++
>  include/hw/i386/vmport.h |  1 +
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index c5b659c59343..7e57eda4b526 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -183,6 +183,22 @@ static uint32_t vmport_cmd_time(void *opaque, uint32=
_t addr)
>      return (uint32_t)tv.tv_sec;
>  }
> =20
> +static uint32_t vmport_cmd_time_full(void *opaque, uint32_t addr)
> +{
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    qemu_timeval tv;
> +
> +    if (qemu_gettimeofday(&tv) < 0) {
> +        return UINT32_MAX;
> +    }
> +
> +    cpu->env.regs[R_ESI] =3D (uint32_t)((uint64_t)tv.tv_sec >> 32);
> +    cpu->env.regs[R_EDX] =3D (uint32_t)tv.tv_sec;
> +    cpu->env.regs[R_EBX] =3D (uint32_t)tv.tv_usec;
> +    cpu->env.regs[R_ECX] =3D port_state->max_time_lag_us;
> +    return VMPORT_MAGIC;
> +}
> +
>  /* vmmouse helpers */
>  void vmmouse_get_data(uint32_t *data)
>  {

And with usec precision, same comments apply in an even stronger way.


> @@ -230,6 +246,7 @@ static void vmport_realizefn(DeviceState *dev, Error =
**errp)
>      if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
>          vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid=
, NULL);
>          vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
> +        vmport_register(VMPORT_CMD_GETTIMEFULL, vmport_cmd_time_full, NU=
LL);
>      }
>  }
> =20
> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
> index 50416c8c8f3e..5d19963ed417 100644
> --- a/include/hw/i386/vmport.h
> +++ b/include/hw/i386/vmport.h
> @@ -12,6 +12,7 @@ typedef enum {
>      VMPORT_CMD_VMMOUSE_DATA     =3D 39,
>      VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
>      VMPORT_CMD_VMMOUSE_COMMAND  =3D 41,
> +    VMPORT_CMD_GETTIMEFULL      =3D 46,
>      VMPORT_ENTRIES
>  } VMPortCommand;
> =20
> --=20
> 2.20.1


