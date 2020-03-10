Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0032BC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30DF24683
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhJSa31B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30DF24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBb9M-0003eP-0h
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBb6K-0007SM-Sv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBb6J-0000Es-CC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:23:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBb6J-00008Y-7I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583832178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Nhov+lZAi1bE724efsohrm05jpLLpjKIArTFBUXQz8=;
 b=UhJSa31BOduo4/avpsjoQ64uCMUXITOW8Bc4JLZjLf3bM31tUcPtS3xuJlDaPPGzCl1FcF
 6U1nehtqfPggQ2RhVMcJ9abGOYaRP0AHJTRlIgl/iy/K15ZaT4Y45EFJ3aJ0EuaeXmq6qq
 ti3hTOkVaqPFXP6cYJrTXoAbP3qeofk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-wkPDYstbOpeXOSr7rXCnfQ-1; Tue, 10 Mar 2020 05:22:56 -0400
X-MC-Unique: wkPDYstbOpeXOSr7rXCnfQ-1
Received: by mail-qk1-f197.google.com with SMTP id j10so6133943qkm.12
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vhQutCSuzQak2y7ZSN0+qHvJnX7RfoILuxD7UVDHp8Q=;
 b=Sk/pa1ml7tr8dBITVi+9sww/RyYMi0J7Zki51hf7qvXvh0bka/JCpuCZSoIdJ7Xh43
 wmxHdCilI/ILARDpAzLXBDf+OPa0KDlAOoc9lZIN8TiMtXP1y9+5fwEIq51k+cmcaXLw
 QKGpx3BVlu3amhfJCb1IZrnUyDZO3FB+p+nF3lHEVBfP68ROzuXCfVBAvajhiddP7hxC
 uKWwk8uwKogZix1x0Me9dcAc+G57g+mEOmQ66wdRK7iZhqJseT7bQVyvvgQrV+FefWLz
 aryHIku91J8YOFyckHnaLXZhpBzR7HfLrlkMqBjrCd+Zd4o7FYex5LhXyehtQn4DXepk
 BaFQ==
X-Gm-Message-State: ANhLgQ22ruBVLXadXZ9Z1h5QoJ1dSYoHbyu+S79crZesfUUYZWPItEOw
 idcpwniO+DBMtHt3sovLKq5aNevblAsNab64fQ9DWMslWAKi2AjJ+SKJyL5pUyofRsoAGfD8aD5
 QzxdUcbQvGl2uGg0=
X-Received: by 2002:ac8:351c:: with SMTP id y28mr17765547qtb.379.1583832176049; 
 Tue, 10 Mar 2020 02:22:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtbFt27EGeRZe3gMQ0gix9Ic1h7TRVen2dT2LdFm0XMoSMYnUQPgzWApQUV1reM1G41ZCitwA==
X-Received: by 2002:ac8:351c:: with SMTP id y28mr17765527qtb.379.1583832175771; 
 Tue, 10 Mar 2020 02:22:55 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id b145sm3046902qkg.52.2020.03.10.02.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:22:54 -0700 (PDT)
Date: Tue, 10 Mar 2020 05:22:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Message-ID: <20200310052226-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200309235411.76587-8-liran.alon@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Tue, Mar 10, 2020 at 01:54:04AM +0200, Liran Alon wrote:
> This is VMware documented functionallity that some guests rely on.
> Returns the BIOS UUID of the current virtual machine.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/i386/vmport.c     | 14 ++++++++++++++
>  include/hw/i386/pc.h |  1 +
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index 2ae5afc42b50..7687f3368a55 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -26,6 +26,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/input/i8042.h"
>  #include "hw/qdev-properties.h"
> +#include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "qemu/log.h"
>  #include "trace.h"
> @@ -121,6 +122,18 @@ static uint32_t vmport_cmd_get_version(void *opaque,=
 uint32_t addr)
>      return port_state->vmx_version;
>  }
> =20
> +static uint32_t vmport_cmd_get_bios_uuid(void *opaque, uint32_t addr)
> +{
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    uint32_t *uuid_parts =3D (uint32_t*)(qemu_uuid.data);
> +
> +    cpu->env.regs[R_EAX] =3D uuid_parts[0];
> +    cpu->env.regs[R_EBX] =3D uuid_parts[1];
> +    cpu->env.regs[R_ECX] =3D uuid_parts[2];
> +    cpu->env.regs[R_EDX] =3D uuid_parts[3];
> +    return cpu->env.regs[R_EAX];
> +}
> +

Should be LE here?

>  static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>  {
>      X86CPU *cpu =3D X86_CPU(current_cpu);
> @@ -171,6 +184,7 @@ static void vmport_realizefn(DeviceState *dev, Error =
**errp)
>      port_state =3D s;
>      /* Register some generic port commands */
>      vmport_register(VMPORT_CMD_GETVERSION, vmport_cmd_get_version, NULL)=
;
> +    vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NU=
LL);
>      vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
>  }
> =20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 7f15a01137b1..ea87eb93511e 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -140,6 +140,7 @@ typedef uint32_t (VMPortReadFunc)(void *opaque, uint3=
2_t address);
> =20
>  typedef enum {
>      VMPORT_CMD_GETVERSION       =3D 10,
> +    VMPORT_CMD_GETBIOSUUID      =3D 19,
>      VMPORT_CMD_GETRAMSIZE       =3D 20,
>      VMPORT_CMD_VMMOUSE_DATA     =3D 39,
>      VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
> --=20
> 2.20.1


