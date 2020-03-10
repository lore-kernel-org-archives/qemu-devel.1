Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4DBC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA1D208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ameir1er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA1D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdNN-0000hj-BZ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBdMC-0007V8-DN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBdMB-0003y2-4h
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:47:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22126
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBdMA-0003vX-VW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oY1mzk/EYBr6J62+WuQ4/jstRSd8m6EHTpJgYFacdpo=;
 b=Ameir1erGyrVweF9ROoDtoqD/S18od76e8fFS+BLg16qJfKZfevQeS3ZcFxG8w6vFD4UJU
 f8V+r7XbhxNMqshbjwt0O/HaVqOM1sge/uOo3dkIOhTZCEJONAwdZ8U6vkZrP3VFF35k/6
 M6G45rsy/42yJERpF0Gw9pXwHKTIngo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-q9xwfOLaNK215OQVHb7Pzw-1; Tue, 10 Mar 2020 07:47:26 -0400
X-MC-Unique: q9xwfOLaNK215OQVHb7Pzw-1
Received: by mail-qt1-f199.google.com with SMTP id f25so8902434qtp.12
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=01kcaO/83ZRzIyn7MFA2w/DKpbOjEgsN0yIw4DbewCc=;
 b=NHGFWhmDU5vr+1bJUlIkN8N+X0D9bI0ZPmnTr6OcLhScip8WAEMjJt9IFmU4d9lgOC
 9wsM6nAV/QlYf3CIoKb7gt6CIBwPai1BLde3uwr8JIswBtYtJAXLdwEzt3RSiaZkTbqd
 bFfg8g5X1Uc2EOUbg0BOJqOCTWH2lfbD798VSVLBIFVxAwMMaT/wFYCmWslLM9xLi05j
 nX/CKstO2spZs/dIi+aZpo4USOv6KQIrWOrVpW+YwTjn3oBVAUWdDCP6bm4wgZrbU63t
 Ry7qBdtPEDCBByiaciy72upd76VL5RlB/aKysjgaXOjL9gMQIElqC3qFBo2nl5cqKEhq
 kOkw==
X-Gm-Message-State: ANhLgQ2zvxXCN6WZePD5kl/YWkKuMHnEPQXhmGWRLNu5k7+01jP7HzxK
 q5xUf0oBpmMc3LOEL5u7VdESk3hTVC3YBmybupk0HJR6mofYxrSldHuTwvafjGqc3X54w0D/nQ6
 0SxNuwda6V3jUX08=
X-Received: by 2002:ac8:776c:: with SMTP id h12mr9515628qtu.38.1583840846195; 
 Tue, 10 Mar 2020 04:47:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuKJtVYvp3F3qsjHAdOGuw0gHlbWjpkM2DWgZ4VbzqJMrJb2jjffhlnm9/IIKzXJaWreLMaZw==
X-Received: by 2002:ac8:776c:: with SMTP id h12mr9515612qtu.38.1583840845938; 
 Tue, 10 Mar 2020 04:47:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id p2sm23027551qkm.64.2020.03.10.04.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:47:25 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:47:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310074624-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310051738-mutt-send-email-mst@kernel.org>
 <742df43c-d188-5aa3-f9a3-89ba540283a9@oracle.com>
 <20200310072324-mutt-send-email-mst@kernel.org>
 <0077a145-258f-1575-baed-4b3ae99f1934@oracle.com>
MIME-Version: 1.0
In-Reply-To: <0077a145-258f-1575-baed-4b3ae99f1934@oracle.com>
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

On Tue, Mar 10, 2020 at 01:40:24PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 13:23, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:18:44PM +0200, Liran Alon wrote:
> > > On 10/03/2020 11:20, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
> > > > > As can be seen from VmCheck_GetVersion() in open-vm-tools code,
> > > > > CMD_GETVERSION should return VMX type in ECX register.
> > > > >=20
> > > > > Default is to fake host as VMware ESX server. But user can contro=
l
> > > > > this value by "-global vmport.vmx-type=3DX".
> > > > >=20
> > > > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > > ---
> > > > >    hw/i386/vmport.c | 13 +++++++++++++
> > > > >    1 file changed, 13 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> > > > > index a2c8ff4b59cf..c03f57f2f636 100644
> > > > > --- a/hw/i386/vmport.c
> > > > > +++ b/hw/i386/vmport.c
> > > > > @@ -36,6 +36,15 @@
> > > > >    #define VMPORT_ENTRIES 0x2c
> > > > >    #define VMPORT_MAGIC   0x564D5868
> > > > > +typedef enum {
> > > > > +   VMX_TYPE_UNSET =3D 0,
> > > > > +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Expre=
ss */
> > > > > +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
> > > > > +   VMX_TYPE_WGS,        /* Deprecated type used for VMware Serve=
r */
> > > > > +   VMX_TYPE_WORKSTATION,
> > > > > +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for A=
CE 1.x */
> > > > > +} VMX_Type;
> > > > > +
> > > > Can names be prefixed with VMPort pls? VMX has specific unrelated m=
eaning.
> > > >=20
> > > > Same everywhere.
> > > I didn't thought it matters much given that this enum is only defined
> > > locally in vmport.c.
> > > But sure I can rename it in v2.
> > >=20
> > > -Liran
> > Property names matter more.
> You mean to rename "vmx-version" and "vmx-type" to "vmport-vmx-version" a=
nd
> "vmport-vmx-type"?
> They are properties of vmport object so it seems redundant no? Also doesn=
't
> seem consistent which how properties of other objects in QEMU are named.
> (E.g. PVSCSI have "use_msg" property. Not "pvscsi_use_msg").
> But will do as you will suggest. Just asking for guidance of what you are
> looking for.
>=20
> -Liran

Sorry - no I'm looking for an alternative to "vmx" everywhere but especiall=
y
in property names which need to be maintained. Maybe vm-exec or vmexec
as I suggested separately.

> >=20
> >=20
> > > > >    #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPO=
RT)
> > > > >    typedef struct VMPortState {
> > > > > @@ -46,6 +55,7 @@ typedef struct VMPortState {
> > > > >        void *opaque[VMPORT_ENTRIES];
> > > > >        uint32_t vmx_version;
> > > > > +    uint8_t vmx_type;
> > > > >    } VMPortState;
> > > > >    static VMPortState *port_state;
> > > > > @@ -114,6 +124,7 @@ static uint32_t vmport_cmd_get_version(void *=
opaque, uint32_t addr)
> > > > >        X86CPU *cpu =3D X86_CPU(current_cpu);
> > > > >        cpu->env.regs[R_EBX] =3D VMPORT_MAGIC;
> > > > > +    cpu->env.regs[R_ECX] =3D port_state->vmx_type;
> > > > >        return port_state->vmx_version;
> > > > >    }
> > > > > @@ -173,6 +184,8 @@ static void vmport_realizefn(DeviceState *dev=
, Error **errp)
> > > > >    static Property vmport_properties[] =3D {
> > > > >        /* Default value taken from open-vm-tools code VERSION_MAG=
IC definition */
> > > > >        DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version=
, 6),
> > > > > +    DEFINE_PROP_UINT8("vmx-type", VMPortState, vmx_type,
> > > > > +                      VMX_TYPE_SCALABLE_SERVER),
> > > > >        DEFINE_PROP_END_OF_LIST(),
> > > > >    };
> > > > > --=20
> > > > > 2.20.1


