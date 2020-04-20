Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040DC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04F12080C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdGIm2WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04F12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbHS-0000Fp-2k
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jQbGR-0008Be-Iy
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:35:27 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jQbGP-0000Sb-Kn
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:35:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1jQbGP-0000Ol-60
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587407723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4hf7Kq9UsvBGLZr0nrQMZDe0o+wls0D/tv+L0W7oDQ=;
 b=FdGIm2WRM/0zwIQ6lFJGC67W3esVD0wuVqC90geo2JEgeXETSgp2fHYscxt3mpoQVbo9Rp
 ArZ0jKVMVKpTf6eenW+cqzA2yHFPfj3pBMXgHfG5/g5MtnaPcIb3In761Jpc8mRRyX499O
 /Nc/ahVuU2cOjTJ0GET3/t8MVsUf4Lw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-TBfwIdBONbO8bIdx3l_2aQ-1; Mon, 20 Apr 2020 14:35:17 -0400
X-MC-Unique: TBfwIdBONbO8bIdx3l_2aQ-1
Received: by mail-lf1-f70.google.com with SMTP id v6so4555512lfi.6
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 11:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l4hf7Kq9UsvBGLZr0nrQMZDe0o+wls0D/tv+L0W7oDQ=;
 b=IT/SKCk7sBdIXoOghWqhQnZetcHQhVynxM1pRMlNDS+Ah58sZ2TCxRqVvE54E+1nvk
 0yFN2WSTBoPenJ8WO+fouo1UX5fajZTh2JjLqgUNvVkywLE1POOygplmLm2ZLARgGman
 +Cz347879N2w6rt+XQFcxVExoGCGyxVTtqaochxR8eA6Fdnb7yQh693invcbeB9yTyS4
 NjM+vcFMiFXHsAqTS0WNYVYhiZoZRDLJM1RoL5KOQ47BLnPJQbfmyIHohQLr1nnuJcVF
 0ovPggGS4xVLhZhhAvX/FBxlH28baTrsiR9N644CZtQHmqGqaha3KhRZ1CkNl1Zh5NxP
 2iDg==
X-Gm-Message-State: AGi0PubfR+ref3qB4uTXTO937tkXYG6V5J5gXT9hFlcWNAMNBbIgJCi8
 OTDaedKJzkG2czyYPVQEl6z5uFMSCopldNOSZiSBwowQmV3vHefksj/Hv1kqwfaZYEwNQ2Wb41e
 u56/9HEwArYZanz0d4R8mdSPy5Y2CAb4=
X-Received: by 2002:a05:6512:10c5:: with SMTP id
 k5mr11740689lfg.0.1587407715529; 
 Mon, 20 Apr 2020 11:35:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypIaiwKwIRoNXigLlxcF3Vms0MA0xaP61Z8cGeUOFubr6MeJCDc8SOkYeMAAhh8mlIqLMPdMZADN8uOtqZzbx5s=
X-Received: by 2002:a05:6512:10c5:: with SMTP id
 k5mr11740668lfg.0.1587407715264; 
 Mon, 20 Apr 2020 11:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
 <0e15c8e7-7b32-985e-c182-2868273a1bd7@redhat.com>
 <AFEDBC1F-8536-4354-9C5E-9829C258B6E3@nutanix.com>
 <67ca69f6-8d6b-8be0-72f2-b30a67edf200@gmail.com>
 <24B1F6CD-14DD-4F28-9406-453D19CCAFCF@nutanix.com>
 <315246A9-D4F1-4C92-A822-90809A171FAD@nutanix.com>
In-Reply-To: <315246A9-D4F1-4C92-A822-90809A171FAD@nutanix.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Mon, 20 Apr 2020 20:35:04 +0200
Message-ID: <CAMDeoFXA=knXuwx4_mt7Hn9zymCrhk_fvoUhfH1=hp5sLXx+Gg@mail.gmail.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
To: Ani Sinha <ani.sinha@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 5:38 PM Ani Sinha <ani.sinha@nutanix.com> wrote:
>
>
>
> > On Apr 20, 2020, at 8:34 PM, Ani Sinha <ani.sinha@nutanix.com> wrote:
> >
> >
> >
> >> On Apr 18, 2020, at 6:18 PM, Marcel Apfelbaum <marcel.apfelbaum@gmail.=
com> wrote:
> >>
> >> A PCIe Root Port or a PCI slot can or cannot support hot-plugging. Any=
thing in the middle can't be done at PCIe/PCI level (as far as I know).
> >
> > Is it possible to dynamically set PCI_EXP_SLTCAP_HPC for a slot at runt=
ime?
>
> What I mean is, when a slot capability is set an initialization, is it se=
t in stone or can the capabilities be revoked post initialization? I can =
=E2=80=99t find anything related to this in PCIE spec.

This bit is hardware initialized. This means that once initialized,
it's fixed and can't be changed. It could be re-initialized after
reset though.

Best regards, Julia Suvorova.


