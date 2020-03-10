Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CAFC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859872465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArQqrBSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859872465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbJx-0001eg-Nl
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBbFf-0006Xg-7l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBbFe-0002MC-53
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:32:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBbFd-0002JK-VH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583832757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBJ5AVUe7YrB6rHStKYGtyk64xSpf5ZQZVt4J1yOxhg=;
 b=ArQqrBSILkJcz1399/3OZdhn+c9d2CGzGlAPezCZLEDLlxYMZ8DfDR6l1sBF1iy2kXnFm7
 fLhFSYf+dsxBENscoWjuPOqUW+1587XUBw596WDVYF11+JaSMqgeysri7H6A8/N8vpW5ke
 JDwItaSPZN6PL366/YcB+Ue3pH51B88=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-lhGOWLqMOX-V7khh5vP5xA-1; Tue, 10 Mar 2020 05:32:36 -0400
X-MC-Unique: lhGOWLqMOX-V7khh5vP5xA-1
Received: by mail-qk1-f200.google.com with SMTP id e10so2742869qkg.8
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JL2jntm7hRsQUQNWo+yF+hoPc2sLkuvBe0FiMBzXr5A=;
 b=AulTtn2Pax+fmfDEItXY55HZHN4UAql9FF9YwjQmz1y1budXOEr+kDiQYGFWXlyAFQ
 Cq0EXW6EaSop40zY2U4Ogi/hcnixiUhhHObYo79bZHpPDvi8LTsYbBnivXOAEKiZvVZq
 L46MCf5rsIUMvwQ7CMnEQe5UP47tB64dylDHJxSOQOWUBbHqcy5vikfsdnQjsEENmuG0
 klfMId7PeDuOXPAwI8p8TEjddRMYZKytcyU6z3h7gjQee+BkO45k9L0ihZdCBaArNIC4
 iVQjM9ZTybhgy7O6xsKOogfNgiI73RniBwew7uR5q+QPHYt3QBdzW/iWY6pSYAGTQFOf
 J4zQ==
X-Gm-Message-State: ANhLgQ1+kYLthT5PbI0kCrfIo/KT49XxS92aIwd0R1urmyl25oV8jpqq
 YxD5aDxrUT2bY9FlIF3P3iKl9PAUNivtBEOhhDLFNpwel6UYaCe4/bi/jPJxTYTuyuQLERoRSVp
 RIS+8pM0KSdwKa4o=
X-Received: by 2002:a37:4b4b:: with SMTP id y72mr18428763qka.175.1583832755489; 
 Tue, 10 Mar 2020 02:32:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt0sPH1iqQNg5t01Ng8v9aZWzrWbvolkOy/bRoIt5uOT/ROqwzC9r1ImUPE8kAzPsRKNzhP7Q==
X-Received: by 2002:a37:4b4b:: with SMTP id y72mr18428746qka.175.1583832755209; 
 Tue, 10 Mar 2020 02:32:35 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id i11sm9857173qka.92.2020.03.10.02.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:32:34 -0700 (PDT)
Date: Tue, 10 Mar 2020 05:32:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 04/14] hw/i386/vmport: Introduce vmx-version property
Message-ID: <20200310053210-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-5-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200309235411.76587-5-liran.alon@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 01:54:01AM +0200, Liran Alon wrote:
> Instead of hard-coding the VMX version, make it a VMPORT object property.
> This would allow user to control it's value via "-global vmport.vmx-versi=
on=3DX".
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>

More detail on why this is useful?

> ---
>  hw/i386/vmport.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index 7c21e56081b0..a2c8ff4b59cf 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -44,6 +44,8 @@ typedef struct VMPortState {
>      MemoryRegion io;
>      VMPortReadFunc *func[VMPORT_ENTRIES];
>      void *opaque[VMPORT_ENTRIES];
> +
> +    uint32_t vmx_version;
>  } VMPortState;
> =20
>  static VMPortState *port_state;
> @@ -112,7 +114,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, =
uint32_t addr)
>      X86CPU *cpu =3D X86_CPU(current_cpu);
> =20
>      cpu->env.regs[R_EBX] =3D VMPORT_MAGIC;
> -    return 6;
> +    return port_state->vmx_version;
>  }
> =20
>  static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
> @@ -169,6 +171,8 @@ static void vmport_realizefn(DeviceState *dev, Error =
**errp)
>  }
> =20
>  static Property vmport_properties[] =3D {
> +    /* Default value taken from open-vm-tools code VERSION_MAGIC definit=
ion */
> +    DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> --=20
> 2.20.1


