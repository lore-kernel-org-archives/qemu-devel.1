Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263A7C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FF7206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE7zzI63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FF7206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCXtv-0000ZT-1d
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCXt8-0007Vp-Bc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCXt7-0004Z6-6Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:09:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCXt7-0004XG-2P
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584058156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfZ65XEJbZi87jFA7uKtuBsbEs9VRwVoIR6Q2qTTe9M=;
 b=FE7zzI63ySBLN/tU1yPFxWA1kEHIf7UQkmR5SqwtIRahkoK3BYgYGg8eMaBxLgNsA2qD6G
 T6njQOEN4wYOSfj8g5VFvOHZuc7UjtC0yZZdXwv7G66NDnc7P9CbtscpyLj/SemYr7Wos2
 oJo2AQr62p98YPzDPp4uD/YqszX/kmM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-yWOLee8SOMKu5oOZOle9og-1; Thu, 12 Mar 2020 20:09:14 -0400
X-MC-Unique: yWOLee8SOMKu5oOZOle9og-1
Received: by mail-wr1-f71.google.com with SMTP id c16so3430656wrt.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 17:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/nb8v9fUR57iCXN9CyWS3DlE/aBydWOPaKhUlQg0PeM=;
 b=bE9i1sDHZyhzLXlDCMYjR4bZT8MoEGIGhjsQOY5vYCbw3/58lNoVf3/XWndw3ntWBk
 z+xNlrxRHvlt503Pgt9X4F2VMO3Nk5SsadKI+w6iAZ2c38NSYMrSM+5Cg39BbWDpjAwI
 VePzHjzqQYK8vpCqQ35kzY1S7TV0ZGsqwRn5RO2TqDWmC7vh4jVBGJsUZ0ayI0USEFJn
 adeSe74BEHhqi++gvmZ9HLxMRSConBAoJfIsrzhN9jMRFWsUwrlA4r7dYbrEz6ot2WnT
 1w8BXRY2cPxakCUvAb3wPJQbWeCNnzpTSW0ENSVwEw/n61eYHo0st4Io6ZmXA5Nhrdh6
 mfnQ==
X-Gm-Message-State: ANhLgQ28Qmgb7AJsTA+NMZvjSFt/GC/m1Mx6MJH9oPIGaxgJ0EG22BPc
 cNKP9B9cWZihYKmEFnNMiHs9C+1zBf3Rzj7cA6RcGgeVL4tIL4OXyYeEMnwJxD3lIv4UQIGvHku
 nOtwr1P/AMnoTelE=
X-Received: by 2002:adf:b189:: with SMTP id q9mr13413463wra.169.1584058153593; 
 Thu, 12 Mar 2020 17:09:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtH7wrPcUx2GlWcUvBhovvpbFu243B69IlE/KGbTerSEW101fiXmAEoBNOul6QfD9ObDZw1IQ==
X-Received: by 2002:adf:b189:: with SMTP id q9mr13413423wra.169.1584058153303; 
 Thu, 12 Mar 2020 17:09:13 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id k18sm27291692wru.94.2020.03.12.17.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 17:09:12 -0700 (PDT)
Date: Thu, 12 Mar 2020 20:09:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 12/16] hw/i386/vmport: Add support for CMD_GET_VCPU_INFO
Message-ID: <20200312200658-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-13-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-13-liran.alon@oracle.com>
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

On Thu, Mar 12, 2020 at 06:54:27PM +0200, Liran Alon wrote:
> Command currently returns that it is unimplemented by setting
> the reserved-bit in it's return value.
>=20
> Following patches will return various useful vCPU information
> to guest.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/i386/vmport.c         | 14 ++++++++++++++
>  include/hw/i386/vmport.h |  1 +
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index 7e57eda4b526..2ce78aaf7b4c 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -55,6 +55,13 @@
>  #define VMPORT_COMPAT_CMDS_V2                   \
>      (1 << VMPORT_COMPAT_CMDS_V2_BIT)
> =20
> +/* vCPU features reported by CMD_GET_VCPU_INFO */
> +#define VCPU_INFO_SLC64_BIT             0
> +#define VCPU_INFO_SYNC_VTSCS_BIT        1
> +#define VCPU_INFO_HV_REPLAY_OK_BIT      2
> +#define VCPU_INFO_LEGACY_X2APIC_BIT     3
> +#define VCPU_INFO_RESERVED_BIT          31
> +
>  #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
> =20
>  typedef struct VMPortState {


Prefix with VMPORT_ please, and add comments.


> @@ -199,6 +206,11 @@ static uint32_t vmport_cmd_time_full(void *opaque, u=
int32_t addr)
>      return VMPORT_MAGIC;
>  }
> =20
> +static uint32_t vmport_cmd_get_vcpu_info(void *opaque, uint32_t addr)
> +{
> +    return 1 << VCPU_INFO_RESERVED_BIT;
> +}
> +
>  /* vmmouse helpers */
>  void vmmouse_get_data(uint32_t *data)
>  {
> @@ -247,6 +259,8 @@ static void vmport_realizefn(DeviceState *dev, Error =
**errp)
>          vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid=
, NULL);
>          vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
>          vmport_register(VMPORT_CMD_GETTIMEFULL, vmport_cmd_time_full, NU=
LL);
> +        vmport_register(VMPORT_CMD_GET_VCPU_INFO, vmport_cmd_get_vcpu_in=
fo,
> +                        NULL);
>      }
>  }
> =20
> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
> index 5d19963ed417..34cc050b1ffa 100644
> --- a/include/hw/i386/vmport.h
> +++ b/include/hw/i386/vmport.h
> @@ -13,6 +13,7 @@ typedef enum {
>      VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
>      VMPORT_CMD_VMMOUSE_COMMAND  =3D 41,
>      VMPORT_CMD_GETTIMEFULL      =3D 46,
> +    VMPORT_CMD_GET_VCPU_INFO    =3D 68,
>      VMPORT_ENTRIES
>  } VMPortCommand;
> =20
> --=20
> 2.20.1


