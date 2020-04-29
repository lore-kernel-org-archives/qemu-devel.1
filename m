Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D3C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF2720787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pr72Y+YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF2720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThou-00026X-OH
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:11:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jThnd-0000gq-VV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jThmv-00066V-L8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:10:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54944
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jThmv-00065y-7f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588147788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAlpxp3wFgbwKjQXIb8b+UREOKmD4rY9QHj3vRcyrv0=;
 b=Pr72Y+YEC5BLSxGDc/wVRbhXTqcLpyn5xcOxuWeqIu7+2fbGVJP6pPus/mWIDjLpIzDNrj
 k/ul/kTpTyH6z3my6UCWqpmVW+7eJNzC8Fxno+3JwDqxwwGsOggYu0OkrLdCU9cnCS0fcb
 RpFyFu47oM3ZtSLV4gajibG6Yttalcg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-vUt-op3MPnCBYnejbXpQJw-1; Wed, 29 Apr 2020 04:09:46 -0400
X-MC-Unique: vUt-op3MPnCBYnejbXpQJw-1
Received: by mail-wr1-f71.google.com with SMTP id f15so1353497wrj.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bvOIAyJUYXXNCIUVO1BnjxcUFZ+iNKfP38pL5ifX8d0=;
 b=Rl9FLn88ztPYoc49QJBAMlCo+Du9WsoHAX2hRcgbUQvBNZOgamBhnNdLLJLhFdKkTR
 MX/fRdChw2QEKfBUMEl/+rYJMVdkBHaYN+R7BWuP+q5CMclUJ3DKPVB0P9dnhl1jGyx0
 gJ5QgvCFdRfvDewyIx4pDP9aq7RXj8xLvT3W1o5SN5BoQpqDTuiHqaSPy1Ul4AT0x7ZP
 giL5qQxAKEtv7yC6VaBskMPxGKXovl0hkQruTj7pjqAT7jVFus9MIXQQek+epOGnRLoX
 S6b0MXBDPNz1RST61zOO3wI7HXsifJEvrNI2wAX0IWfWuAMrK/ptvQbqtazDOqMZgeS6
 H2rw==
X-Gm-Message-State: AGi0PuY3bNbPKoecEtLUdp5KOqwB5unum9nNGEw41QgPrkmEGIMejoVU
 2gBi6RvikSv7oZHtFr3WBvYnclIE/tY6XAyEZ0mQQTddrze579HWP1ewQ3fq0A00RzV2ZybonVP
 kP56bvgkBAfpY7HM=
X-Received: by 2002:a7b:c959:: with SMTP id i25mr1813843wml.20.1588147784008; 
 Wed, 29 Apr 2020 01:09:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypLQ7Fg0RTSagoo04RJlglX83rQp4NT/rcLQOAT4/zIKHjd8S+7abF9eJZ70gAajHld6k9jx2g==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr1813807wml.20.1588147783713; 
 Wed, 29 Apr 2020 01:09:43 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 v10sm29562616wrq.45.2020.04.29.01.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 01:09:43 -0700 (PDT)
Date: Wed, 29 Apr 2020 04:09:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200429035457-mutt-send-email-mst@kernel.org>
References: <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

On Wed, Apr 29, 2020 at 07:43:04AM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 29, 2020, at 1:08 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > On Wed, Apr 29, 2020 at 07:02:56AM +0000, Ani Sinha wrote:
> >>=20
> >>=20
> >>> On Apr 29, 2020, at 12:27 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >>>=20
> >>> On Wed, Apr 29, 2020 at 06:54:52AM +0000, Ani Sinha wrote:
> >>>>=20
> >>>>=20
> >>>>> On Apr 29, 2020, at 12:22 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> >>>>>=20
> >>>>> On Wed, Apr 29, 2020 at 06:11:20AM +0000, Ani Sinha wrote:
> >>>>>>=20
> >>>>>>=20
> >>>>>>> On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> >>>>>>>=20
> >>>>>>> o if there's a need to disable
> >>>>>>> just one of these, commit log needs to do a better job documentin=
g the
> >>>>>>> usecase.
> >>>>>>=20
> >>>>>> The use case is simple. With this feature admins will be able to d=
o what they were forced to do from Windows driver level but now at the bus =
level. Hence,=20
> >>>>>> (a) They need not have access to the guest VM to change or update =
windows driver registry settings. They can enable the same setting from adm=
in management console without any access to VM.
> >>>>>> (b) It is more robust. No need to mess with driver settings. Incor=
rect settings can brick guest OS. Also no guest specific knowhow required.
> >>>>>> (c) It is more scalable since a single cluster wide setting can be=
 used for all VM power ons and the management plane can take care of the re=
st automatically. No need to access individual VMs to enforce this.
> >>>>>> (d) I am told that the driver level solution does not persist acro=
ss a reboot.=20
> >>>>>>=20
> >>>>>> Ani
> >>>>>=20
> >>>>> Looks like disabling both plug and unplug would also address these =
needs.
> >>>>=20
> >>>> No the driver level solution does not prevent hot plugging of device=
s but blocks just hot unplugging. The solution I am proposing tries to do t=
he same but from the bus/hypervisor level.
> >>>=20
> >>> Why does the driver level solution need to prevent just hot unpluggin=
g?
> >>=20
> >> Because it not fair to prevent end users from hot plugging new devices=
 when it is the (accidental?) hot unplugging of existing devices which caus=
es issues.
> >=20
> > Accidental? So maybe what you need is actually something else then -
> > avoid *removing* the device when it's powered down.
>=20
> You don=E2=80=99t get it. It is not hypervisor admins who are unplugging =
it. It is the end users. Even RedHat customers want this feature. See follo=
wing resources:=20
> https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1802592
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1790899

That doesn't seem to require that hotplug keeps working.

> My approach is much more fine grained than just disable everything approa=
ch that we have for q35. For i440fx we can do better than that.
>=20
>=20
> >=20
> >>>=20
> >>>=20
> >>>>=20
> >>>>> --=20
> >>>>> MST
>=20


