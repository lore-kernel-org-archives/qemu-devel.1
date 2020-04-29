Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D726C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B6720575
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh1phvW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B6720575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTk20-0008Va-Gh
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTjz6-0005TR-6a
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTjz4-0005Ia-QC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:30:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTjz4-0005EC-BW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588156228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7z1ACmdQSGg28OLD1qkSCn+BJtp9J+HyqHparbleSNE=;
 b=Sh1phvW0dMDqhCw2jILUXNuC5oZLqVxTHgPaFM5YirkIBHv82ajajA+qqBriAcUaaKcDMI
 8TCsXpgorBwdt5wKHBjFxEvocbO+ovmH3am1UCTWJQmjf0EzwNOhOnGnCsn2eNYV1B7Df8
 AqT9rHk3IjiQ4/+ytHWVLOAQJSlCL2E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-DBQTaLodPaSK8LZ-PzjIWw-1; Wed, 29 Apr 2020 06:30:24 -0400
X-MC-Unique: DBQTaLodPaSK8LZ-PzjIWw-1
Received: by mail-wr1-f72.google.com with SMTP id m5so1490195wru.15
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 03:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8ZJKZsSWFVEez5/W0jXjw9vCWKyJ7u0zDJzUT/lzswk=;
 b=TJgMIO7HrKxkHiDxVlzdjxUA153TcCqrzXcbiU0a/A+e0+0o6OwUK1beGjYsNIc2u9
 VY08hVJOVxe0JGYCDHMAs2rpUlkE+JwBbXdJU1JshUhBcAX1in5O6pQYduqP7HDfErEu
 /8Eg+CaaHDm1VSi5vraLiKrCnd0h76hXAzhizyvdJMKDxw5fFcTfiHexHVyANsdSWLzs
 bN1Z/k6LuYsr8xgSl7PMvJsz/tuklzleRMRLH3Ou/ENZwuQUatQgxY/mLvKhogL5RBkg
 ayuR99shyqdTgaHD6UwNTSohSk1ua9R/H/MkwQ0VY/RPuVjtDBOUlTTlxihz5y3u1bbJ
 WjCA==
X-Gm-Message-State: AGi0Pubr4MiT/iCPUjyYX7UikPUlvGj+BcsUo2zNN5hc4WiaOeOpeoeJ
 C7rblAb7HVO8HwvqovkMbDbs3xqzo+1LqbgMq6bAQSWTH4tSkNqsXh3BCpphNbWoujwlQ/hkCoe
 XMVdYVTpq2Y9Yx5s=
X-Received: by 2002:a5d:6985:: with SMTP id g5mr39512540wru.398.1588156223117; 
 Wed, 29 Apr 2020 03:30:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypIVrcsg4aI/9/EpkDUqVaE1UEHfDGlcGw2rvlXtzLewCk/VI5ppgmZpKvia6rB1LMSnLKFyEA==
X-Received: by 2002:a5d:6985:: with SMTP id g5mr39512515wru.398.1588156222810; 
 Wed, 29 Apr 2020 03:30:22 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 c190sm7416454wme.4.2020.04.29.03.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 03:30:22 -0700 (PDT)
Date: Wed, 29 Apr 2020 06:30:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200429062136-mutt-send-email-mst@kernel.org>
References: <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
 <20200429035457-mutt-send-email-mst@kernel.org>
 <2F2DCEBC-C0B5-4653-B741-245A9FF38BDE@nutanix.com>
 <20200429045427-mutt-send-email-mst@kernel.org>
 <CEF52CB4-73FE-4D45-ACF7-440F7EC9AA1F@nutanix.com>
 <20200429060230-mutt-send-email-mst@kernel.org>
 <7F9D8AE0-FC4B-4CF3-A206-FCAEB0DD4CE6@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <7F9D8AE0-FC4B-4CF3-A206-FCAEB0DD4CE6@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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

On Wed, Apr 29, 2020 at 10:20:31AM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 29, 2020, at 3:45 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > On Wed, Apr 29, 2020 at 09:14:26AM +0000, Ani Sinha wrote:
> >>=20
> >>=20
> >>> On Apr 29, 2020, at 2:26 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >>>=20
> >>> Even if it seems to work for guests now, if we don't stick to emulati=
ng
> >>> capabilities that hardware interfaces provide we can never be sure it
> >>> will keep working.
> >>=20
> >> OS es use ACPI for PCI bridges: https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__github.com_qemu_qemu_blob_master_docs_pcie.txt&d=3DDwIFaQ&=
c=3Ds883GpUCOChKOHiocYtGcg&r=3DIIUxIyRwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&=
m=3D9AnuR62iRsUnmV9ggkS_lqen67etHeCjATFLwCJWxQs&s=3DAs__N9BXf0DTSZkD4cxaQsT=
eg0exh5GSPqkFSh7fxRk&e=3D=20
> >> They use =E2=80=9C_EJ0=E2=80=9D to detect jot unplug capability: https=
://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__uefi.org_sites_default_fi=
les_resources_ACPI-5F3.pdf&d=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DIIUxIy=
RwG4RGy57y2nvMNYcDkqW-NHozZ2R38VYcg5U&m=3D9AnuR62iRsUnmV9ggkS_lqen67etHeCjA=
TFLwCJWxQs&s=3DSDgOhKGpnlzfbvAOFl2m9a-tdPZEUcCwKWsgkVDafyM&e=3D=20
> >>=20
> >> 6.3.3 _EJx (Eject) These control methods are optional and are supplied=
 for devices that support a software-controlled VCRstyle ejection mechanism=
 or that require an action be performed such as isolation of power/data lin=
es before the device can be removed from the system. To support warm (syste=
m is in a sleep state) and hot (system is in S0) removal, an _EJx control m=
ethod is listed for each sleep state from which the device supports removal=
, where x is the sleeping state supported. For example, _EJ0 indicates the =
device supports hot removal; _EJ1=E2=80=93EJ4 indicate the device supports =
warm removal.
> >=20
> > Yes. So if there's no _EJx then it's reasonable to assume you can't
> > isolate the slot, and so no hot-plug will happen either.
>=20
> Where are you getting that?

It's well known. For example, the pci hot-plug specification, version
1.1, states:

1.6 Asssumptions

...

1.6.2 Orderly Removal and Insertion

...

Furthermore, PCI add-in cards are not generally designed to be connected to=
 a slot that
has power applied. Therefore, the operating-system vendor and Platform vend=
or define a
sequence of user actions and system behavior that guarantees that power is =
always
removed from a slot before a card is inserted.

Inserting or removing an add-in card without following the proper sequence =
leads to
unpredictable results, including data corruption, abnormal termination of t=
he operating
system, or damage to card or Platform hardware. Unless otherwise stated, it=
 is assumed
throughout the remainder of this specification that the user always follows=
 the proper
removal and insertion sequence.

...


2.1 System Components

...

The physical
insertion or removal must not occur until the system software has:
=E2=80=A2 Quiesced any operating system services or drivers using the add-i=
n card
=E2=80=A2 Isolated and powered down the slot
=E2=80=A2 Indicated to the user that it is ready
If an add-in card is inserted or removed without following the proper seque=
nce, this is
considered an improper operation and error conditions and other unexpected =
events are
possible, including data corruption and hardware damage.

and so on.


> This isn=E2=80=99t true. =E2=80=9C_SUN=E2=80=9D is used to detect the slo=
t unique number.

That's just enumeration.

> Windows does allow hot plugging on the bridge on which EJ0 has been turne=
d off.

Given no real or virtual hardware that does that, there's no guarantee
that I can see that it will keep supporting that in future versions.


> >=20
> >>=20
> >> Note that =E2=80=9Cthese control methods are optional=E2=80=9D line. I=
f the OS adheres to the spec, it should not expect them to exist all the ti=
me.
> >>=20
> >=20
> >=20
> >=20
> > --=20
> > MST
> >=20
>=20


