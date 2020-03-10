Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD59C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157262253D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsQdGtiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157262253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBd18-0002Yk-9D
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBczH-0000OI-Lu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBczE-00035p-Hr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:23:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40215
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBczE-00034T-DE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583839428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARFud9ehVNccCKVjkmVkg+yKKC3/af23ze0VhFw18J4=;
 b=GsQdGtiqJl56y4kH2/yPKIssfsYpQPi8G/HkDqA/qmYNQUDtHpa4+kmpPVsUvkbrAkgxNh
 y/TMVSA5Fn6XQ/zjLGQoqowelB38GCZ/ajuf2HutK9oIUdwA0EyMAE51bIyLygSz8TKeq8
 oq7xuqUCF9C+9+NE00eArEbxx1+Sc4I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-7u1dw8OPM9SQbpnHg_cUew-1; Tue, 10 Mar 2020 07:23:46 -0400
X-MC-Unique: 7u1dw8OPM9SQbpnHg_cUew-1
Received: by mail-qt1-f199.google.com with SMTP id g6so8889865qtp.20
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zB1QbI5LBseUQJHWNyB0+Af4WYPuqVnyJuauYa3nbkc=;
 b=XVCBM2ffdet6gyM+LHLPumwzbagngGZ5WJ1yEnj2hNiUyEblltcHjCDyImvm2DALRU
 Kik4xyJUCNC/LLxLr2HJFnAEfDPa0W+r1p3qOz6UyfXFvRXSoj9SXY3JFYrqj4MZo+9j
 f3cB6apYG5/EhLQXrj/RISEWzX1EO9CqtnIH3zaH4JGV3ENoaWLnpbEjkMKWyxzLWiq6
 aFQBToz7stURNbC7/DfG1BMLqn6lxEElfoLDB7NlQAA87TRK3S2vVGE61dHRgXZkLEAx
 AN4mP/i4FQsIHkI/Tj6l2opUm27ydx/O+RQTt16ldGnYEy+O2GggqWBT736eL6GETKpJ
 b8kg==
X-Gm-Message-State: ANhLgQ1nredtZJidS3omh+XCquBtFAWuqtjistrZjVi9MRZaSflrTRL9
 ZsCED+YS9cSkdGmkX1eUc0SZWzl6Gh277XWR5y3xYRDzjBNNaqz3mhQYpiHk5VQikmJseEnAnFo
 mE9qHDtyXCp43j/U=
X-Received: by 2002:ac8:4914:: with SMTP id e20mr18102813qtq.199.1583839425823; 
 Tue, 10 Mar 2020 04:23:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs7Ds/8/DxL002RqiZdQmsYzF303SpxprvckkqvfchvNmYYdodD0anQ5B8YOWDXdFBy0jkISg==
X-Received: by 2002:ac8:4914:: with SMTP id e20mr18102798qtq.199.1583839425553; 
 Tue, 10 Mar 2020 04:23:45 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id c190sm2155300qkb.80.2020.03.10.04.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:23:44 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:23:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310072324-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310051738-mutt-send-email-mst@kernel.org>
 <742df43c-d188-5aa3-f9a3-89ba540283a9@oracle.com>
MIME-Version: 1.0
In-Reply-To: <742df43c-d188-5aa3-f9a3-89ba540283a9@oracle.com>
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

On Tue, Mar 10, 2020 at 01:18:44PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 11:20, Michael S. Tsirkin wrote:
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
> > Can names be prefixed with VMPort pls? VMX has specific unrelated meani=
ng.
> >=20
> > Same everywhere.
> I didn't thought it matters much given that this enum is only defined
> locally in vmport.c.
> But sure I can rename it in v2.
>=20
> -Liran

Property names matter more.


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


