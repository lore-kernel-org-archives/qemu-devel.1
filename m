Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0528DC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49592464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW041N1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49592464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdcv-0000JA-0r
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBda3-0005TV-HV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBda2-0001tB-Aa
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:01:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBda1-0001pp-IV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tC+6wLHi524LbvtxXg/FsHiqGTc5BwuWVvX+ALGysHU=;
 b=bW041N1pXBO43OYE24xCwf2k+/3oLxOoiThGkS3kPXp7mxNaUnZB3iCPjtxwM/KGB/cWwR
 bztTgPTC5AeY/0fQnWuIasDCYjaYSLRrXOfQtjIOFpbG7UJJFO5SnPiiDcxRzCR4zsrkjm
 58RjCFGs+1a0YdV3ETo3k4tIcVgSe/A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-L5awXbzaNNGEtwXPJYeyIA-1; Tue, 10 Mar 2020 08:01:46 -0400
X-MC-Unique: L5awXbzaNNGEtwXPJYeyIA-1
Received: by mail-qt1-f197.google.com with SMTP id o10so8896622qtk.22
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K+vW3tNAJr8+qNBSoFRZU7UIZ3SdxxURW7qpS3VG+n8=;
 b=eWVyhVzkK1c0sjeJCqHn8Xf1bACHG1uMncL/9VaYjDmPTVHh78/G1Deu6zcLX64n76
 uT9sYEWybmINoaXGFXP5XwT8pMeV8SmLpg/MPLOIot1VdbGrSbzz89Nvpsagyc1EukmV
 uIva9vHh5W5WacPjvSJC0Z6bxyiIzXxD032VhDIVVxh8Av91kpiKmPkfdNauSYtuIMvT
 bKmpaYzZ+7f2tHC8oQVeaO3mnJxbKVBnmEmfzvYiByP4Cs5f3YkH2coN8kg1A9V3J0po
 6GQvhvF11/AVfWSERvSksi0fD2fvTeIMUMDTG/tIkgTCGCOolmyGANinwF/f5zx3m0QL
 6lOQ==
X-Gm-Message-State: ANhLgQ29Mm0urmNjx/QPSFb99oMBk7ooZzdlEdWkhIIE2A5DqO5VmxbY
 U6WAZJuEfCiEWZ7wMU9sqJv1PPoxD8ZJaLq46WNJfOtRQ1Q/KVTv8BTVB/I2b27njOcuxnqlMQ7
 PcxMOd7PtSfW5R/I=
X-Received: by 2002:a37:5b81:: with SMTP id
 p123mr17412036qkb.284.1583841706197; 
 Tue, 10 Mar 2020 05:01:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsLQvvcwtvEzlXdQOt7kcsYA7AA5UAZ+CZmUeoqvWksHYawsdIvknXzc/VTC8Xmhe6y84doBg==
X-Received: by 2002:a37:5b81:: with SMTP id
 p123mr17412013qkb.284.1583841705958; 
 Tue, 10 Mar 2020 05:01:45 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id h34sm24531905qtc.62.2020.03.10.05.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 05:01:44 -0700 (PDT)
Date: Tue, 10 Mar 2020 08:01:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Message-ID: <20200310074821-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
 <20200310052226-mutt-send-email-mst@kernel.org>
 <c9374d4c-4d63-9302-0896-958950029ec5@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c9374d4c-4d63-9302-0896-958950029ec5@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Tue, Mar 10, 2020 at 04:44:54AM -0700, Liran Alon wrote:
>=20
> On 10/03/2020 11:22, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:54:04AM +0200, Liran Alon wrote:
> > > This is VMware documented functionallity that some guests rely on.
> > > Returns the BIOS UUID of the current virtual machine.
> > >=20
> > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > ---
> > >   hw/i386/vmport.c     | 14 ++++++++++++++
> > >   include/hw/i386/pc.h |  1 +
> > >   2 files changed, 15 insertions(+)
> > >=20
> > > diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> > > index 2ae5afc42b50..7687f3368a55 100644
> > > --- a/hw/i386/vmport.c
> > > +++ b/hw/i386/vmport.c
> > > @@ -26,6 +26,7 @@
> > >   #include "hw/i386/pc.h"
> > >   #include "hw/input/i8042.h"
> > >   #include "hw/qdev-properties.h"
> > > +#include "sysemu/sysemu.h"
> > >   #include "sysemu/hw_accel.h"
> > >   #include "qemu/log.h"
> > >   #include "trace.h"
> > > @@ -121,6 +122,18 @@ static uint32_t vmport_cmd_get_version(void *opa=
que, uint32_t addr)
> > >       return port_state->vmx_version;
> > >   }
> > > +static uint32_t vmport_cmd_get_bios_uuid(void *opaque, uint32_t addr=
)
> > > +{
> > > +    X86CPU *cpu =3D X86_CPU(current_cpu);
> > > +    uint32_t *uuid_parts =3D (uint32_t*)(qemu_uuid.data);

BTW missing space before * here.

> > > +
> > > +    cpu->env.regs[R_EAX] =3D uuid_parts[0];
> > > +    cpu->env.regs[R_EBX] =3D uuid_parts[1];
> > > +    cpu->env.regs[R_ECX] =3D uuid_parts[2];
> > > +    cpu->env.regs[R_EDX] =3D uuid_parts[3];
> > > +    return cpu->env.regs[R_EAX];
> > > +}
> > > +
> > Should be LE here?
>=20
> No. This is how the UUID is expected to be returned to guest.
>=20
> -Liran
>=20

Um *how* is it expected to be returned? IIUC this takes network order
byte data and handles it as host endian. Assuming it's right on an LE
host it isn't on a BE host.  So I am guessing you want le32_to_cpu here.

--=20
MST


