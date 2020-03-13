Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D40C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6535220724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqJO5xBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6535220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmXV-0000I7-J7
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCmWn-00086d-FJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCmWl-0008RX-V0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:47:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCmWl-0008OM-PF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584114431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3iczKH5UgBs4JGW85loRd/P8nBI5UWmYFJ6xjMom0g=;
 b=JqJO5xBkgn+tmTX+wFQzERUliyqwQekieOnIMuVzAdlqL7Qx+VcU5QY9zT27dhVkx+21OZ
 TmKrcBmc6u5jQRGsz5ReL8EKAvMH8pQ7+EBMsOnabeb7dHIohP+vho23Mv7v0alncQcVPG
 eMbEbFI1JzJnQZXxxQme28S/EuhNZMk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-H0pFPYxcNHyxFi1UWOdhbQ-1; Fri, 13 Mar 2020 11:47:09 -0400
X-MC-Unique: H0pFPYxcNHyxFi1UWOdhbQ-1
Received: by mail-qk1-f197.google.com with SMTP id w124so8426782qkd.19
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 08:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gg2hxwMuiXkS0g9skmdeh9isX5iDpKeL9VdmXudmFHo=;
 b=k+a/AxtuLhJ3HODIsIf0qSynC4Ylxf6bo0sxNNlwOSakCTGoEB7Ietn/zZYItiDIzK
 bb2ynulmfXY20QiLz0Vqn99uzTV//cRMKPzMrDWL08EH4svK4i33vJLP80w/M0GY7I+b
 M2nqa1Dj+9Pr0uk9kW6Up0X8soBwbxXzF+li1/f8XnUo0RnUo1chCTdmSGQQxyeL7P7g
 pwQw2azeESUGrrEWOwbmG9dXcgDKj20DxSPiFw8PkOuhI4l8e8Q90k1nsyW13NX/Lec+
 asij5Z/kFwqZ8vqM8J3p4M3zG/L9PiLFTyBo2r5L+3UpTkeQiUIb+3QojAL2rp3lJ8bG
 Hg+w==
X-Gm-Message-State: ANhLgQ0+SejsPFK07lEfgxUBPYp4Wnu+SMjY/jj8pnzRtNJScPFg5Xv/
 P88Co1b2naqAZKcBC53QToNW+nJW5omDxRpH2G9/rikvK6Sr7JWjU1GSIslmmFghQ/EcZpK6xsC
 TRyEEHqOahh8ri6s=
X-Received: by 2002:ac8:7446:: with SMTP id h6mr13330580qtr.274.1584114429246; 
 Fri, 13 Mar 2020 08:47:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtBPQX9+Eh46XkeAsJ4mZ/NZ9iOOtAYQ168GvaBH/jgYh9OPVQ6hZ3a9shulqFZ6v2QAdi3pA==
X-Received: by 2002:ac8:7446:: with SMTP id h6mr13330549qtr.274.1584114428892; 
 Fri, 13 Mar 2020 08:47:08 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id q24sm5681246qtk.45.2020.03.13.08.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 08:47:08 -0700 (PDT)
Date: Fri, 13 Mar 2020 11:47:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
Message-ID: <20200313113049-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
MIME-Version: 1.0
In-Reply-To: <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
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

On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
> > > @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void *opaque=
, uint32_t addr)
> > >       return ram_size;
> > >   }
> > > +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
> > > +{
> > > +    X86CPU *cpu =3D X86_CPU(current_cpu);
> > > +    qemu_timeval tv;
> > > +
> > > +    if (qemu_gettimeofday(&tv) < 0) {
> > > +        return UINT32_MAX;
> > > +    }
> > > +
> > > +    cpu->env.regs[R_EBX] =3D (uint32_t)tv.tv_usec;
> > > +    cpu->env.regs[R_ECX] =3D port_state->max_time_lag_us;
> > > +    return (uint32_t)tv.tv_sec;
> > > +}
> > > +
> > >   /* vmmouse helpers */
> > >   void vmmouse_get_data(uint32_t *data)
> > >   {
> > That's a very weird thing to return to the guest.
> > For example it's not monotonic across migrations.
> That's the VMware PV interface... I didn't design it. :P
> Regarding how it handles the fact time is not monotonic across migrations=
,
> see big comment at the start of services/plugins/timeSync/timeSync.c in
> open-vm-tools regarding the time-sync algorithm used by VMware Tools.
> Specifically:
> """
> During normal operation this plugin only steps the time forward and only =
if
> the error is greater than one second.

Looks like guest assumes this time only moves forward.
So something needs to be done to avoid it moving
backward across migrations.



> """
> > And what does max_time_lag_us refer to, anyway?
> According to the comment in open-vm-tools TimeSyncReadHost():
> """
> maximum time lag allowed (config option), which is a threshold that keeps
> the tools from being over eager about resetting the time when it is only =
a
> little bit off.
> """
>=20
> Looking at open-vm-tools timeSync.c code, it defines the threshold of how
> far guest time can be from host time before deciding to do a "step
> correction".
> A "step correction" is defined as explicitly setting the time in the gues=
t
> to the time in the host.
> >=20
> >=20
> > So please add documentation about what this does.
> You are right. I agree.
> I think it would be best to just point to open-vm-tools
> services/plugins/timeSync/timeSync.c.
> Do you agree or should I copy some paragraphs from there?

Neither. Their documentation will be from guest point of view.  Please
look at that code and write documentation from host point of view.
Your documentation for the lag parameter is I think a good
example of how to do it.

> > If there's no document to refer to then pls write
> > code comments or a document under docs/ - this does not
> > belong in commit log.
> >=20
> >=20
> >=20
> > > @@ -214,6 +229,7 @@ static void vmport_realizefn(DeviceState *dev, Er=
ror **errp)
> > >       vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NUL=
L);
> > >       if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
> > >           vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios=
_uuid, NULL);
> > > +        vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
> > >       }
> > >   }
> > > @@ -249,6 +265,11 @@ static Property vmport_properties[] =3D {
> > >        * 5 - ACE 1.x (Deprecated)
> > >        */
> > >       DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_ty=
pe, 2),
> > > +    /*
> > > +     * Max amount of time lag that can go uncorrected.
> > What does uncorrected mean?
> You are right this is a bad phrasing taken from open-vm-tools.
> It should mean "How far we allow guest time to go from host time before
> guest VMware Tools will sync it to host time".
> How you prefer to phrase this?

Sounds like a good explanation. Maybe we allow -> can
since "we" is hypervisor and it's actually under guest control.


> >=20
> > > +     * Value taken from VMware Workstation 5.5.
> >=20
> > How do we know this makes sense for KVM? That has significantly
> > different runtime characteristics.
> This is just a threshold as you can understand from the above reply of mi=
ne
> (I should rephrase the comments to make this clearer).
> So we just chose a threshold that makes sense for common workloads.
> One of the reasons to put this as a property, is to still allow user to
> override it.

Well close to 100% of users will have no idea what to set it to.


> >=20
> >=20
> > Also, the version returns ESX server, why does it make
> > sense to take some values from workstation?
> I believe (don't remember) that ESXi was observed to return similar value=
.
> Most of our workloads that runs with this came from ESXi and we never
> examined an issue regarding this in our production environment.
> Which makes sense as this is just a thresthold that specifies when guest
> time should be synced to host time.
> You prefer I would just remove this comment?

Maybe add " TODO: should this depend on vmare-vmx-type? ".

>=20
> Thanks,
> -Liran
>=20
> >=20
> > > +     **/
> > > +    DEFINE_PROP_UINT32("max-time-lag", VMPortState, max_time_lag_us,=
 1000000),
> > >       DEFINE_PROP_END_OF_LIST(),
> > >   };
> > > diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
> > > index 7f33512ca6f0..50416c8c8f3e 100644
> > > --- a/include/hw/i386/vmport.h
> > > +++ b/include/hw/i386/vmport.h
> > > @@ -8,6 +8,7 @@ typedef enum {
> > >       VMPORT_CMD_GETVERSION       =3D 10,
> > >       VMPORT_CMD_GETBIOSUUID      =3D 19,
> > >       VMPORT_CMD_GETRAMSIZE       =3D 20,
> > > +    VMPORT_CMD_GETTIME          =3D 23,
> > >       VMPORT_CMD_VMMOUSE_DATA     =3D 39,
> > >       VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
> > >       VMPORT_CMD_VMMOUSE_COMMAND  =3D 41,
> > > --=20
> > > 2.20.1


