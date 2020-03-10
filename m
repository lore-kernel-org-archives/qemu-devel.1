Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43D1C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C82A20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZMijCC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C82A20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBe79-0008S3-O8
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBe6Q-0007ZZ-4I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBe6O-0007en-HE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:35:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBe6O-0007cK-CC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583843715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXCLIQQwvEX75uEGQN48ktHBaMOObwrPmyZ5f8H/EEg=;
 b=PZMijCC0ClLcwP3hZiSiRsPuknKPchE+T9z36kjS2qexaw54JPlOs2o+LHbclp7P82+YAr
 oVKdlwN+PYVs/v+dJrgOZLAZxIsd4OCwinsTyXarKSQQ1oIabF1SInvd2J8BB3L1iTlRMS
 GbRotAfIGqdjJLzDU4+LrF6QlbXEqYY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-xUDx_CyvMqqwqCJMSTVzmA-1; Tue, 10 Mar 2020 08:35:13 -0400
X-MC-Unique: xUDx_CyvMqqwqCJMSTVzmA-1
Received: by mail-qk1-f197.google.com with SMTP id 22so9581190qkc.7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=y3G/twGGOn8u2ykneuxfw2vijhDIJKZj3ymbHF/Pruo=;
 b=d4IhWPork8bW6dpgDude+FCb7JK2YVbJk9TaK6DoZ/QktpQD7irr/HXCThJFKHTeaS
 fJDmx4EeE6t69/in/SpJjOSNPKB0IC7xUa63ainnE+5Uz+kWHCrUJPMizXOQQMBCRtPO
 tWJTAP+a8rNjG4r3awQ8HyQRGP/+5mhw2b5Flsxn8DqRjT29IlW40EAQbv48CSLXRCi9
 IfRVzRBN+oKwsVfvJYeHOqIT1rqvzpmfigRoc+4qxEjIzljm/vBDOQZLM/l0MDhRYyXL
 4fsBCzPJDNVT9WNtNm2yPkBOVfpV3wGXJRLM1apPn0iXCK8i3aJ7FA+XbMycRxEsJZg4
 0A7w==
X-Gm-Message-State: ANhLgQ3KZqX9M09C2EPOjtujNmY6+gCUMF+e68u1r5XcQ+CeT8XMP0IW
 uN2Fdc1EXHAZUATuHq6r8yRSmPBYRXpTeDzyyT4VeuEUHykcSTiGh7cyMfwkA817t5acnW7X8bd
 95Bj719H3esBjRRw=
X-Received: by 2002:ae9:e810:: with SMTP id a16mr5879446qkg.208.1583843713138; 
 Tue, 10 Mar 2020 05:35:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt06E8bilFYo+AfJal9N5emXr3Y4gyuIqnQPfzawBkPW20NP+Gasa6Vk7eYgQQ6NLXZ1PM51g==
X-Received: by 2002:ae9:e810:: with SMTP id a16mr5879423qkg.208.1583843712861; 
 Tue, 10 Mar 2020 05:35:12 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id v80sm23640333qka.15.2020.03.10.05.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 05:35:11 -0700 (PDT)
Date: Tue, 10 Mar 2020 08:35:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310082730-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
MIME-Version: 1.0
In-Reply-To: <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
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

On Tue, Mar 10, 2020 at 02:25:28PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 14:14, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
> > > As can be seen from VmCheck_GetVersion() in open-vm-tools code,
> > > CMD_GETVERSION should return VMX type in ECX register.
> > >=20
> > > Default is to fake host as VMware ESX server. But user can control
> > > this value by "-global vmport.vmx-type=3DX".
> > >=20
> > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > ---
> > >   hw/i386/vmport.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > >=20
> > > diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> > > index a2c8ff4b59cf..c03f57f2f636 100644
> > > --- a/hw/i386/vmport.c
> > > +++ b/hw/i386/vmport.c
> > > @@ -36,6 +36,15 @@
> > >   #define VMPORT_ENTRIES 0x2c
> > >   #define VMPORT_MAGIC   0x564D5868
> > > +typedef enum {
> > > +   VMX_TYPE_UNSET =3D 0,
> > > +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Express *=
/
> > > +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
> > > +   VMX_TYPE_WGS,        /* Deprecated type used for VMware Server */
> > > +   VMX_TYPE_WORKSTATION,
> > > +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for ACE 1=
.x */
> > > +} VMX_Type;
> > > +
> > Is this really VMX type? And do users care what it is?
> This enum is copied from open-vm-tools source code
> (lib/include/vm_version.h). This is how it's called in VMware Tools
> terminology... Don't blame me :)

I don't even want to go look at it to check license compatibility, but
IMHO that's just another reason to avoid copying it.
Copying bad code isn't a good idea unless needed for
compatibility.


> > Also, how about friendlier string values so people don't need to
> > figure out code numbers?
>=20
> I could have defined a new PropertyInfo struct in hw/core/qdev-properties=
.c
> for this enum and then define a proper macro in qdev-properties.h.
> But it seems like an overkill for a value that is suppose to rarely be
> changed. So I thought this should suffice for now for user-experience
> perspective.
> If you think otherwise, I can do what I just suggested above.
>=20
> -Liran

I think that's better, and this allows you to use official
product names that people can relate to.

Alternatively just drop this enum completely.  As far as you are
concerned it's just a number VM executable gives together with the
version, right?  We don't even need the enum, just set it to 2 and add a
code comment saying it's esx server.


> >=20
> > >   #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
> > >   typedef struct VMPortState {
> > > @@ -46,6 +55,7 @@ typedef struct VMPortState {
> > >       void *opaque[VMPORT_ENTRIES];
> > >       uint32_t vmx_version;
> > > +    uint8_t vmx_type;
> > >   } VMPortState;
> > >   static VMPortState *port_state;
> > > @@ -114,6 +124,7 @@ static uint32_t vmport_cmd_get_version(void *opaq=
ue, uint32_t addr)
> > >       X86CPU *cpu =3D X86_CPU(current_cpu);
> > >       cpu->env.regs[R_EBX] =3D VMPORT_MAGIC;
> > > +    cpu->env.regs[R_ECX] =3D port_state->vmx_type;
> > >       return port_state->vmx_version;
> > >   }
> > > @@ -173,6 +184,8 @@ static void vmport_realizefn(DeviceState *dev, Er=
ror **errp)
> > >   static Property vmport_properties[] =3D {
> > >       /* Default value taken from open-vm-tools code VERSION_MAGIC de=
finition */
> > >       DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
> > > +    DEFINE_PROP_UINT8("vmx-type", VMPortState, vmx_type,
> > > +                      VMX_TYPE_SCALABLE_SERVER),
> > >       DEFINE_PROP_END_OF_LIST(),
> > >   };
> > > --=20
> > > 2.20.1


