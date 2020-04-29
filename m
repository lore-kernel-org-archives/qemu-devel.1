Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61039C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8E32073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpsG/Cp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8E32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThfc-0003sL-85
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jThJE-0003Jx-SO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jThIS-0003t4-O3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:39:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46830
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jThIS-0003nt-7L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588145899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+eYhJiXO1Uw+QM6xXWdLaxW5Wfl1IHnN586DWPqybsE=;
 b=MpsG/Cp4d/ZFyxIVbMLKbiTvl92N+en5Gb1yWnDQ+zt54DA8o/L+iTBjdBYTripaJrP3J/
 dFF586OJnh33tsfVOTkwlTFrHnKQZJn2ABoaCFVnMhuKqjHo52nlo0Bfwe29vW7JMDjyN9
 37ipxVSJwJ3Aqs7hFIp2q7RHf+YKD/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-GTnmhMvOPJy7SEbYr_WKFg-1; Wed, 29 Apr 2020 03:38:17 -0400
X-MC-Unique: GTnmhMvOPJy7SEbYr_WKFg-1
Received: by mail-wm1-f70.google.com with SMTP id h22so853044wml.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 00:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A9WBZG+WcWFWtcJ5nYZQXh6zP8peCmAbg0zAbNtGJaQ=;
 b=UTGCFgBcdJ9xqPCOPio2WcoHXKOWZ1ERSxTEeMmuGiI5QqVPWmUxeAE225RGIFwymH
 bYKmqhjxQQKiZEREpbef26dn5TpRTTchhI60nZSoD/rlycMs2vIEn6M29gg3H3uyplfz
 ng783B1BThdAZPDKJCJA+I7flEPcHTWN29oxpz1Z5xz6wrnyhup3Ku3R8e8jN0ANUlzE
 z8WGKfOfJAw/L1Pk7PIHZQ9y1420RK54b3FiwKjCxrE2/czUiAeWo2gylH5MHkHNZ3Qp
 fl/VbH4G10Jr6pFrmvtQDltBscRhFdBMbvsrmZxJKgHHnmWgKvZDDIWiz38hLj+1CVNY
 tATA==
X-Gm-Message-State: AGi0PuacGQLX5Cz4OB1nlecqQdLbc/55Uc7cTq2SSAOP1lauURuXuN83
 SrQRQbciBINIIsGpccFtMhExqkZjeMB8/t+Ouh/jX4+7f6ibg6Ah7P6vLnyPtFJlR1jpKTZ0Kkj
 QyZcCAEchdQ+ZijQ=
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr1720715wmj.86.1588145896728;
 Wed, 29 Apr 2020 00:38:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2J07c1aXmt+4cOfJiTBVl3sIUKxe31zerHqdYr30/gzhXtPoe+JyyGLxIVTMfE3a98VZzoQ==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr1720688wmj.86.1588145896500;
 Wed, 29 Apr 2020 00:38:16 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 n6sm30959889wrs.81.2020.04.29.00.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 00:38:15 -0700 (PDT)
Date: Wed, 29 Apr 2020 03:38:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200429033657-mutt-send-email-mst@kernel.org>
References: <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

On Wed, Apr 29, 2020 at 07:02:56AM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 29, 2020, at 12:27 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >=20
> > On Wed, Apr 29, 2020 at 06:54:52AM +0000, Ani Sinha wrote:
> >>=20
> >>=20
> >>> On Apr 29, 2020, at 12:22 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >>>=20
> >>> On Wed, Apr 29, 2020 at 06:11:20AM +0000, Ani Sinha wrote:
> >>>>=20
> >>>>=20
> >>>>> On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> >>>>>=20
> >>>>> o if there's a need to disable
> >>>>> just one of these, commit log needs to do a better job documenting =
the
> >>>>> usecase.
> >>>>=20
> >>>> The use case is simple. With this feature admins will be able to do =
what they were forced to do from Windows driver level but now at the bus le=
vel. Hence,=20
> >>>> (a) They need not have access to the guest VM to change or update wi=
ndows driver registry settings. They can enable the same setting from admin=
 management console without any access to VM.
> >>>> (b) It is more robust. No need to mess with driver settings. Incorre=
ct settings can brick guest OS. Also no guest specific knowhow required.
> >>>> (c) It is more scalable since a single cluster wide setting can be u=
sed for all VM power ons and the management plane can take care of the rest=
 automatically. No need to access individual VMs to enforce this.
> >>>> (d) I am told that the driver level solution does not persist across=
 a reboot.=20
> >>>>=20
> >>>> Ani
> >>>=20
> >>> Looks like disabling both plug and unplug would also address these ne=
eds.
> >>=20
> >> No the driver level solution does not prevent hot plugging of devices =
but blocks just hot unplugging. The solution I am proposing tries to do the=
 same but from the bus/hypervisor level.
> >=20
> > Why does the driver level solution need to prevent just hot unplugging?
>=20
> Because it not fair to prevent end users from hot plugging new devices wh=
en it is the (accidental?) hot unplugging of existing devices which causes =
issues.

Accidental? So maybe what you need is actually something else then -
avoid *removing* the device when it's powered down.

> >=20
> >=20
> >>=20
> >>> --=20
> >>> MST


