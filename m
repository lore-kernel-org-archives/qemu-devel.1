Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6089CC83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BD32076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9hO30M4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BD32076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTidF-0003mR-4k
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTia4-0008Pu-KY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTiWV-0004Ci-GU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:00:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTiWV-000487-1r
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588150614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pulz+KnawAn2bBcefZQzgGt8FYq6KYVhU84dCjo7DKs=;
 b=H9hO30M4b6lHdc+RKBOdDQVo0iFw9/OckbIoBHiOkwuZoJoEyNENb2swkbPWGwgN8eZ/c8
 FOGrpol5JCXxmYslC4V0FX6Bi4XFlEYWW/V8BuOStqVYHcsfRkAHu4lSSczioHcrHYE8Jo
 9GkcbFlyusxpmcIjx8q2b5BxLPbQNR0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-ezpbuRbePDqSPBttuME9Lw-1; Wed, 29 Apr 2020 04:56:52 -0400
X-MC-Unique: ezpbuRbePDqSPBttuME9Lw-1
Received: by mail-wm1-f70.google.com with SMTP id 72so2307917wmb.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VsQW8+kzj3UdgWSX3tV7dinnShvnPg8H1WOwfpramrQ=;
 b=YcwdQS5HqJd2Y/KRjLM6irGMnUbGCVwPJtQiDnYk6PzPRh7pYTciSGc0+pw2FzvEyv
 CLZbj7a3vgw6lzr/7QM2Ovca4HBf5V1AkpCqZ+BcuazsIOZb8Cun3b8Gqa397NCVWeXH
 ke75c7p/NcJJZZTTW3Szqym8M0Vy4KmZguUnzc0HiqyQs6/clxJ7wE+amhSkKcVPPXYi
 J4StE1CZ7JmApUNq0UU+k4MPtb9eF/b0gABuK8NxDSWM91ELZf26h7oCB4y5E7dGa5Qg
 /n7HsluCABYw0/JvD5zEnKLY25LEAJB9nKAF5H8HnureFbxJ9PvjVfyTl9k3IhkOZBV4
 ZRJA==
X-Gm-Message-State: AGi0PubBuVGeOZLrFZMWk0JDp3VNb2SXYbaJjPF+vXsr4ypCqsB42c7n
 +QttQDo8DKS9/9ZV3bK6gRsENWwIMJUU+eKoY0r6n9q28pWd6o3Gb2bHHAwoYMahHhtFA1br5MG
 yJvE2Z5U+DXO0cPA=
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr31051743wro.361.1588150610339; 
 Wed, 29 Apr 2020 01:56:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ6Z3cP+tsUv1qr+qtu6Qa9HpWCTD1VyFuqLBEpxHI3MvXZmmBkUcoN1uK5DEmd1FHWtGcG/g==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr31051719wro.361.1588150610094; 
 Wed, 29 Apr 2020 01:56:50 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 r18sm26265195wrj.70.2020.04.29.01.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 01:56:49 -0700 (PDT)
Date: Wed, 29 Apr 2020 04:56:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200429045427-mutt-send-email-mst@kernel.org>
References: <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
 <20200429035457-mutt-send-email-mst@kernel.org>
 <2F2DCEBC-C0B5-4653-B741-245A9FF38BDE@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <2F2DCEBC-C0B5-4653-B741-245A9FF38BDE@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 08:14:01AM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 29, 2020, at 1:39 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > On Wed, Apr 29, 2020 at 07:43:04AM +0000, Ani Sinha wrote:
> >>=20
> >>=20
> >>> On Apr 29, 2020, at 1:08 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >>>=20
> >>> On Wed, Apr 29, 2020 at 07:02:56AM +0000, Ani Sinha wrote:
> >>>>=20
> >>>>=20
> >>>>> On Apr 29, 2020, at 12:27 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> >>>>>=20
> >>>>> On Wed, Apr 29, 2020 at 06:54:52AM +0000, Ani Sinha wrote:
> >>>>>>=20
> >>>>>>=20
> >>>>>>> On Apr 29, 2020, at 12:22 PM, Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> >>>>>>>=20
> >>>>>>> On Wed, Apr 29, 2020 at 06:11:20AM +0000, Ani Sinha wrote:
> >>>>>>>>=20
> >>>>>>>>=20
> >>>>>>>>> On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >>>>>>>>>=20
> >>>>>>>>> o if there's a need to disable
> >>>>>>>>> just one of these, commit log needs to do a better job document=
ing the
> >>>>>>>>> usecase.
> >>>>>>>>=20
> >>>>>>>> The use case is simple. With this feature admins will be able to=
 do what they were forced to do from Windows driver level but now at the bu=
s level. Hence,=20
> >>>>>>>> (a) They need not have access to the guest VM to change or updat=
e windows driver registry settings. They can enable the same setting from a=
dmin management console without any access to VM.
> >>>>>>>> (b) It is more robust. No need to mess with driver settings. Inc=
orrect settings can brick guest OS. Also no guest specific knowhow required=
.
> >>>>>>>> (c) It is more scalable since a single cluster wide setting can =
be used for all VM power ons and the management plane can take care of the =
rest automatically. No need to access individual VMs to enforce this.
> >>>>>>>> (d) I am told that the driver level solution does not persist ac=
ross a reboot.=20
> >>>>>>>>=20
> >>>>>>>> Ani
> >>>>>>>=20
> >>>>>>> Looks like disabling both plug and unplug would also address thes=
e needs.
> >>>>>>=20
> >>>>>> No the driver level solution does not prevent hot plugging of devi=
ces but blocks just hot unplugging. The solution I am proposing tries to do=
 the same but from the bus/hypervisor level.
> >>>>>=20
> >>>>> Why does the driver level solution need to prevent just hot unplugg=
ing?
> >>>>=20
> >>>> Because it not fair to prevent end users from hot plugging new devic=
es when it is the (accidental?) hot unplugging of existing devices which ca=
uses issues.
> >>>=20
> >>> Accidental? So maybe what you need is actually something else then -
> >>> avoid *removing* the device when it's powered down.
> >>=20
> >> You don=E2=80=99t get it. It is not hypervisor admins who are unpluggi=
ng it. It is the end users. Even RedHat customers want this feature. See fo=
llowing resources:=20
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.redhat.com_=
archives_libvir-2Dlist_2020-2DFebruary_msg00110.html&d=3DDwIFaQ&c=3Ds883GpU=
COChKOHiocYtGcg&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DMf70_yU=
9LUbRFZOy4rYM5N43B_MDbO7SxEMSSJKVaJY&s=3DKgR1-KlzL-bGr51uY1vupOIgTpTjNAecbu=
OUIpcuMUs&e=3D=20
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.redhat=
.com_show-5Fbug.cgi-3Fid-3D1802592&d=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=
=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DMf70_yU9LUbRFZOy4rYM5N43=
B_MDbO7SxEMSSJKVaJY&s=3DKVis9gzVeA7nnGauZpXWm_sEnl_UpsIzSlggwb60Fg8&e=3D=20
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.redhat=
.com_show-5Fbug.cgi-3Fid-3D1790899&d=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=
=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3DMf70_yU9LUbRFZOy4rYM5N43=
B_MDbO7SxEMSSJKVaJY&s=3DY0K8tiyqpmKeXU245pnhTTAr2e3YSuxxw4BkiDxGwB8&e=3D=20
> >=20
> > That doesn't seem to require that hotplug keeps working.
>=20
> Like I said, that is because PCIE limits this at this moment. We can
> do better than this solution on i440fx. We can be narrower in limiting
> just hot unplug leaving hot plugging as is. Why should we always go
> with the least common denominator for all the features? Why do we have
> to be limited when we can do better?

Even if it seems to work for guests now, if we don't stick to emulating
capabilities that hardware interfaces provide we can never be sure it
will keep working.

>=20
> >=20
> >> My approach is much more fine grained than just disable everything app=
roach that we have for q35. For i440fx we can do better than that.
> >>=20
> >>=20
> >>>=20
> >>>>>=20
> >>>>>=20
> >>>>>>=20
> >>>>>>> --=20
> >>>>>>> MST
>=20


