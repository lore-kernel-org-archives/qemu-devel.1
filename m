Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34184C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE742467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJuPVVk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE742467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdnT-0008Vx-7V
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBdmn-000819-IZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBdml-0007Fc-E5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:15:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBdml-0007Cj-AM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583842498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqUUrz0H4lvXMF+z5qzFmF3j/irEEY96qbm1I+4VfDs=;
 b=WJuPVVk8iFHjvZItaW8JEWX4zsXk+K7LQBVskAmkGkxoBwiC8xJEe2PkzfSZ4RNieLwhA9
 CWsQ99+JnnyxXwJWU7bBQkIyHbFudpHf+SX7zPW1+EWxkSspDtYb1LhkkAdPFlLHTrQ41q
 N1DWm56pLbx5w0KKR1OQM21GkP5Ok2Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-nEFSYl9fMPio5F-foa78yA-1; Tue, 10 Mar 2020 08:14:56 -0400
X-MC-Unique: nEFSYl9fMPio5F-foa78yA-1
Received: by mail-qt1-f198.google.com with SMTP id n4so8993418qtv.5
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SA0qZzwb0M27BBCl4ZnGnPZQ3y2sjwaTauGLAS3IWJU=;
 b=ij6fJtGVX+olpkad1MvsbLfffWGBmaKaYPQq7R85sADlWt0/u0M1PP2Sz45qOVVLVh
 GZ0IqHz67uoZWUHNwwdHQAt0uqyxddWkiFwBMtJ0ZRQcv8x58mK9pcUn5gnaMzsEfusH
 zgtoruhWvozRYPcjK/ZLX8Ytpn5d3ZJTH0mRCK4bwZ5/KHtSfnO8i6VAA/P9fHeybIr1
 qceOqVlkC9WMka2dQ65vxKC9Bd87e/w/fedrHjwWYy0olXTS23Zsve7LxYHTEZyq1l73
 oTzXtboqVXWyx+trWU9rZUAurgqAoTlXqQxeS1fGGeiDcCo1Y+BeW1VIYQ8EzO+pS7Vs
 KVcA==
X-Gm-Message-State: ANhLgQ0kONpuNJR2+DFNdTJfiUAigOrXHQS7BHjyWGirYKlQCH5GhfF8
 yf7KV/YpayvbfGmhhqIZZewqhCoFRX/l0aQHI/TCA7XlBobgjxjO/na/6KZJSQOxq13uQrD6YcF
 6BV5oIEWiroU6/iU=
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr5370505qtp.250.1583842496185; 
 Tue, 10 Mar 2020 05:14:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsqQGN9KuHDdxcNA7mtgkQPL97gDN9hx0aXLJWYmo5/4a7akt5VmEquLagmdYd99m5F1xsC7g==
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr5370485qtp.250.1583842495943; 
 Tue, 10 Mar 2020 05:14:55 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id j4sm16427513qtv.45.2020.03.10.05.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 05:14:55 -0700 (PDT)
Date: Tue, 10 Mar 2020 08:14:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310081144-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200309235411.76587-6-liran.alon@oracle.com>
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

On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
> As can be seen from VmCheck_GetVersion() in open-vm-tools code,
> CMD_GETVERSION should return VMX type in ECX register.
>=20
> Default is to fake host as VMware ESX server. But user can control
> this value by "-global vmport.vmx-type=3DX".
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/i386/vmport.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index a2c8ff4b59cf..c03f57f2f636 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -36,6 +36,15 @@
>  #define VMPORT_ENTRIES 0x2c
>  #define VMPORT_MAGIC   0x564D5868
> =20
> +typedef enum {
> +   VMX_TYPE_UNSET =3D 0,
> +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Express */
> +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
> +   VMX_TYPE_WGS,        /* Deprecated type used for VMware Server */
> +   VMX_TYPE_WORKSTATION,
> +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for ACE 1.x *=
/
> +} VMX_Type;
> +

Is this really VMX type? And do users care what it is?
Also, how about friendlier string values so people don't need to
figure out code numbers?

>  #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
> =20
>  typedef struct VMPortState {
> @@ -46,6 +55,7 @@ typedef struct VMPortState {
>      void *opaque[VMPORT_ENTRIES];
> =20
>      uint32_t vmx_version;
> +    uint8_t vmx_type;
>  } VMPortState;
> =20
>  static VMPortState *port_state;
> @@ -114,6 +124,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, =
uint32_t addr)
>      X86CPU *cpu =3D X86_CPU(current_cpu);
> =20
>      cpu->env.regs[R_EBX] =3D VMPORT_MAGIC;
> +    cpu->env.regs[R_ECX] =3D port_state->vmx_type;
>      return port_state->vmx_version;
>  }
> =20
> @@ -173,6 +184,8 @@ static void vmport_realizefn(DeviceState *dev, Error =
**errp)
>  static Property vmport_properties[] =3D {
>      /* Default value taken from open-vm-tools code VERSION_MAGIC definit=
ion */
>      DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
> +    DEFINE_PROP_UINT8("vmx-type", VMPortState, vmx_type,
> +                      VMX_TYPE_SCALABLE_SERVER),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> --=20
> 2.20.1


