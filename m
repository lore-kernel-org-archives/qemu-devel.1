Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B28C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A89F217D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoewsvAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A89F217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjma-0002wL-6k
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTjlW-000261-U3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTjl3-0001OZ-1Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:16:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTjl2-0001O1-Gv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588155358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUeV+gMmGZSwu0n91DRDSTV6bAwP4jaEC1OcQgaRfR0=;
 b=UoewsvAiFFP9BYXy8Ja/Vktgi/+cOtEdBGUmuFbQvXFxh3znwr4k0L1+NkV3Qha08erFwU
 XsIVgChur2Bg2lHzLOaIBGd+jo5UfooiFYZEQTYMDt5mrbnvztZyoUz2MKs9u6HPl8JlGP
 TOy0n6wMYSI3TS3R3cpDyOt2+8T9Pzs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-RkFNwJcKMmevMXf4BIDxPQ-1; Wed, 29 Apr 2020 06:15:46 -0400
X-MC-Unique: RkFNwJcKMmevMXf4BIDxPQ-1
Received: by mail-wm1-f69.google.com with SMTP id 71so802759wmb.8
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 03:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5CFfxJVt5oaAUwMD0QQ4Urm3IUuxh7TQdQE0BS1n7dM=;
 b=KWuS7eFgsy3IXzLof5AivOpMby/XkYJBsyEu/czn2GTRdYaiJ3Wjg3jZxxpP/lbe7b
 oMnZzqSAM/XoNUUTFa5204GSAp83SMMcjANuluIbtcdZBsf2vb8UoCNiQOMUePNfRJM5
 17ju0iq64fUN5LE7w6j1XFuL0kZ7M9QsPmaZRRnT0kdpH8vujEGj/Ozd+KZ4Cf6zqfxF
 A4BjkwBZcVMBHv6zWBPn0uChFMxv+0oXeJ/ujYrx/fPdixkro7LZET0HwOszZhsOEzJJ
 7HKfPkuVhGQ39Zyp4AG5t71CsTt25Ebp33+bD1fv33leDtdvHc23mxlp+3o3YQCmgkmf
 Pgvw==
X-Gm-Message-State: AGi0PuaGiLxs0wmm6fhuV+yPjJHjGcDFBpn1b5XscGHi3kwqu5GvNJ0+
 lKgBb9/5/vwsk0fgqfuXOUaERMXR34dlCRDd9MsfOIyuglDKsw86ct2gZnsjCXFmp+eIu1vb5mh
 BP1+8Hs3pMMTxF6Y=
X-Received: by 2002:a1c:9891:: with SMTP id a139mr2595786wme.129.1588155345719; 
 Wed, 29 Apr 2020 03:15:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypJpI6Rn4MOCEyWv+sxu+Wi0Q3q2ibjraeX9b68y//EUzVcL1dXtFYdZHhMiJ10X7IjqFs9Hlw==
X-Received: by 2002:a1c:9891:: with SMTP id a139mr2595756wme.129.1588155345525; 
 Wed, 29 Apr 2020 03:15:45 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 t16sm7000024wmi.27.2020.04.29.03.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 03:15:44 -0700 (PDT)
Date: Wed, 29 Apr 2020 06:15:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200429060230-mutt-send-email-mst@kernel.org>
References: <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
 <20200429035457-mutt-send-email-mst@kernel.org>
 <2F2DCEBC-C0B5-4653-B741-245A9FF38BDE@nutanix.com>
 <20200429045427-mutt-send-email-mst@kernel.org>
 <CEF52CB4-73FE-4D45-ACF7-440F7EC9AA1F@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <CEF52CB4-73FE-4D45-ACF7-440F7EC9AA1F@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

On Wed, Apr 29, 2020 at 09:14:26AM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 29, 2020, at 2:26 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > Even if it seems to work for guests now, if we don't stick to emulating
> > capabilities that hardware interfaces provide we can never be sure it
> > will keep working.
>=20
> OS es use ACPI for PCI bridges: https://github.com/qemu/qemu/blob/master/=
docs/pcie.txt
> They use =E2=80=9C_EJ0=E2=80=9D to detect jot unplug capability: https://=
uefi.org/sites/default/files/resources/ACPI_3.pdf
>=20
> 6.3.3 _EJx (Eject) These control methods are optional and are supplied fo=
r devices that support a software-controlled VCRstyle ejection mechanism or=
 that require an action be performed such as isolation of power/data lines =
before the device can be removed from the system. To support warm (system i=
s in a sleep state) and hot (system is in S0) removal, an _EJx control meth=
od is listed for each sleep state from which the device supports removal, w=
here x is the sleeping state supported. For example, _EJ0 indicates the dev=
ice supports hot removal; _EJ1=E2=80=93EJ4 indicate the device supports war=
m removal.

Yes. So if there's no _EJx then it's reasonable to assume you can't
isolate the slot, and so no hot-plug will happen either.

>=20
> Note that =E2=80=9Cthese control methods are optional=E2=80=9D line. If t=
he OS adheres to the spec, it should not expect them to exist all the time.
>=20



--=20
MST


