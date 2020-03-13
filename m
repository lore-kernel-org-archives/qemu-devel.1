Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31CCC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA52F206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8sDtSqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA52F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCXpw-000285-Rv
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCXp7-0000Xe-30
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCXp5-0007wC-AO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:05:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCXp5-0007ux-5U
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584057906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xRf9fwELkla6GyjtcXPfUMQevxEIiO2WERKGJZ54/4=;
 b=G8sDtSqZoysDwWM3op88dGwTCeIlAMibUE6qbg2gz6gK/DAl9iLYqvjojMfy8F7avjcTS9
 NHgmVwpttvqjRZ6vj4cv3Y5Ie4CmpbqC2HV0JzWUDPN1wzzSrTfFt3aFouWRJF2htW/rIK
 nYzwxVSqr7z84/uQ8OCMf0+Qd0htyms=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-IX_MXkI0O4W9xnqLHOZ5Rg-1; Thu, 12 Mar 2020 20:05:04 -0400
X-MC-Unique: IX_MXkI0O4W9xnqLHOZ5Rg-1
Received: by mail-wr1-f70.google.com with SMTP id n11so2895429wrs.13
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 17:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sIzHWnsSzSJnWhGA9CmZfB2zY/pjM+U+sIQTGE7JyzY=;
 b=rUd0WAch/oWdJrfGygERBCORi069RnlG5W4b2AssdOpDWU8M9PeWFAXo1a8/1ulCUR
 AP/E54HXTFNGviky42bGc/YbycADX5vVkiygDiEXeWmrAiMxehzzJ0wqia8cSRQZ3Xyl
 JGMEZaEPXacR3TUQQjIXoZ1o6mQ/mxFPQxOw+FGi5xjhFHHYKZpg4ePRLwAsW3z2katG
 zaUG2HlJPm1pBogGtRGv80Y+Yi6u3MPalhXm2Zv7H4nO8cx3dT7OA7mydprJx7IjBSuB
 jLZfRi4UB46bfB9sD36kAAIvg3nE2cb/9UZVRGt4jSmc1kB/VT6/tkbfe/rj07ppzKYw
 ymOQ==
X-Gm-Message-State: ANhLgQ0VT0jss2dpzvIr/GOElwDWV3wTW2dropMeGix7NvgpqWLZpUeF
 5HfRoUhwQSqwGdC0jJFOWCSs04MQ3Xat7L8I2KYWoH8jv9YOAsU2XDlpSXtjWGwVKU2ggZxRSXs
 k9GNijnzf2sWiDFI=
X-Received: by 2002:a7b:c413:: with SMTP id k19mr6862624wmi.184.1584057903221; 
 Thu, 12 Mar 2020 17:05:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtdfDNA49OGnMmKu+1QVCdMn1tEJBROiOXjAeIL6TUL0L6QEs2znRMAm2U4jEPS/Sqoq/Ldsg==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr6862563wmi.184.1584057902582; 
 Thu, 12 Mar 2020 17:05:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id s7sm38702176wrm.13.2020.03.12.17.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 17:05:01 -0700 (PDT)
Date: Thu, 12 Mar 2020 20:04:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
Message-ID: <20200312195652-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-11-liran.alon@oracle.com>
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

On Thu, Mar 12, 2020 at 06:54:25PM +0200, Liran Alon wrote:
> This command is used by guest to gettimeofday() from host.
> See usage example in open-vm-tools TimeSyncReadHost() function.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/i386/vmport.c         | 21 +++++++++++++++++++++
>  include/hw/i386/vmport.h |  1 +
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index 3fb8a8bd458a..c5b659c59343 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -66,6 +66,7 @@ typedef struct VMPortState {
> =20
>      uint32_t vmware_vmx_version;
>      uint8_t vmware_vmx_type;
> +    uint32_t max_time_lag_us;
> =20
>      uint32_t compat_flags;
>  } VMPortState;
> @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void *opaque, ui=
nt32_t addr)
>      return ram_size;
>  }
> =20
> +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
> +{
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    qemu_timeval tv;
> +
> +    if (qemu_gettimeofday(&tv) < 0) {
> +        return UINT32_MAX;
> +    }
> +
> +    cpu->env.regs[R_EBX] =3D (uint32_t)tv.tv_usec;
> +    cpu->env.regs[R_ECX] =3D port_state->max_time_lag_us;
> +    return (uint32_t)tv.tv_sec;
> +}
> +
>  /* vmmouse helpers */
>  void vmmouse_get_data(uint32_t *data)
>  {

That's a very weird thing to return to the guest.
For example it's not monotonic across migrations.
And what does max_time_lag_us refer to, anyway?


So please add documentation about what this does.
If there's no document to refer to then pls write
code comments or a document under docs/ - this does not
belong in commit log.



> @@ -214,6 +229,7 @@ static void vmport_realizefn(DeviceState *dev, Error =
**errp)
>      vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
>      if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
>          vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid=
, NULL);
> +        vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
>      }
>  }
> =20
> @@ -249,6 +265,11 @@ static Property vmport_properties[] =3D {
>       * 5 - ACE 1.x (Deprecated)
>       */
>      DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_type, 2=
),
> +    /*
> +     * Max amount of time lag that can go uncorrected.

What does uncorrected mean?

> +     * Value taken from VMware Workstation 5.5.


How do we know this makes sense for KVM? That has significantly
different runtime characteristics.


Also, the version returns ESX server, why does it make
sense to take some values from workstation?

> +     **/
> +    DEFINE_PROP_UINT32("max-time-lag", VMPortState, max_time_lag_us, 100=
0000),
> =20
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
> index 7f33512ca6f0..50416c8c8f3e 100644
> --- a/include/hw/i386/vmport.h
> +++ b/include/hw/i386/vmport.h
> @@ -8,6 +8,7 @@ typedef enum {
>      VMPORT_CMD_GETVERSION       =3D 10,
>      VMPORT_CMD_GETBIOSUUID      =3D 19,
>      VMPORT_CMD_GETRAMSIZE       =3D 20,
> +    VMPORT_CMD_GETTIME          =3D 23,
>      VMPORT_CMD_VMMOUSE_DATA     =3D 39,
>      VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
>      VMPORT_CMD_VMMOUSE_COMMAND  =3D 41,
> --=20
> 2.20.1


