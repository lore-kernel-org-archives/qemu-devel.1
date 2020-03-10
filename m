Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EC9C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043F32051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUZzYLGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043F32051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBb6w-00087O-73
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBb4X-0004m1-Aj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBb4V-0003ZB-4U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:21:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38750
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBb4V-0003Y2-0E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583832066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=up7rmilaV2crQ934L+7yx+i2C2JCkAoujvw0Bn7Cohk=;
 b=ZUZzYLGdCYWP4qODaZon5PNwO4b0uHAfQvBLA0p/GL4Bef5J0LknH78FrOCFYG/LicXiE+
 AfUZNbfl78WShlVB4cAMuOiVWWibZG/3CQhPr6wG7tu/Nq5xzFjZimvonTEBxA+Edh2uBS
 fxLCjiwWi1MIemoKeaY4Ui4AMPfu2uo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-Z1LN8pxvM-mLjlhvc3Slrw-1; Tue, 10 Mar 2020 05:21:04 -0400
X-MC-Unique: Z1LN8pxvM-mLjlhvc3Slrw-1
Received: by mail-qt1-f198.google.com with SMTP id i25so8694653qtm.17
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kG6qHaxeuj6VW1PfhEColy9fmZ6hVhonZmfHcv/lRPA=;
 b=Uyeivd4vfBOEey4TjGsRmQjah4N0WqXnKmxJY8k0qICi9IJ1fK0tN9Rz7VZlXM+LY1
 o2SXgG361CidWX1XrxG6hiCTxAHq82moFhFIuGbcJsdgpsxQW9tT1Jlm6yH7UHx2pynl
 1m8LXR4/bLRo0VYXn1K4QxZ2K62LbfKDL08GFEBrPQ1iIFCwRlVHBjM5svTZHqb+oiRP
 AnJhWqC64s3Meoi2sU6IC2U9lBzAkcSxsTA07a0aChQ40mcnq7eAcKLASkMZVSnrOSxZ
 Nfu87cTQcOFIwFVxSj7L1yulo6zrttoZEHutt6XNNkiwoHPjg7MW9F+H4NOdkN5vYTnV
 HI/Q==
X-Gm-Message-State: ANhLgQ3afdNSVBvJG8v0T3NyHZcZLdAiw7Tr/hVdtfwhhxP7jdWLOsWr
 +8S6WXPdGG1zVitZzlnWfNZLnowiSWCmIkXMRFtYrAG6gWDAqHv1i7o5R72hn1Hd4EoSO2GssLf
 4ZLqzK+alExU3cDo=
X-Received: by 2002:ac8:1196:: with SMTP id d22mr18487552qtj.344.1583832063674; 
 Tue, 10 Mar 2020 02:21:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtIT2Ed9zeE9dTPLxOVsSajeFV+VeX8T80YMQqepekoU9kbufSccUkN9RLr/tVSZ6CKsLlQDA==
X-Received: by 2002:ac8:1196:: with SMTP id d22mr18487533qtj.344.1583832063445; 
 Tue, 10 Mar 2020 02:21:03 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id k50sm24256328qtc.90.2020.03.10.02.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:21:02 -0700 (PDT)
Date: Tue, 10 Mar 2020 05:20:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310051738-mutt-send-email-mst@kernel.org>
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

Can names be prefixed with VMPort pls? VMX has specific unrelated meaning.

Same everywhere.

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


