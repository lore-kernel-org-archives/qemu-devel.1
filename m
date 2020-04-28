Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB35C8300B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C783208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BS+STKBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C783208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTUOs-0007FJ-7F
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTUKb-0008E4-O8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTUKa-0001Cg-H4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:47:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTUKZ-0000kk-Ru
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588096052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n7MGgWkbStttGkK4Of8lZsOyv3s886QYbVpHquwkFjw=;
 b=BS+STKBLGIdM3eYI/Y2RHR/VvT4TCnSiP6ayJrVkQoPskfXcW1t5iAOVThzno2ErPQFPlj
 ZQ48lAnOWVToqLkfL0MKeGWQeTXq5X8UumBbPK6BG3K8lDHRVIgpphgd6UYo2QdtM9ZQ24
 3ZabjVDv21swWX+3Pyr7BCM4tkdk2UE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-LWLfT0o9PZiEswAKD3I8sA-1; Tue, 28 Apr 2020 13:47:30 -0400
X-MC-Unique: LWLfT0o9PZiEswAKD3I8sA-1
Received: by mail-wm1-f70.google.com with SMTP id 72so1462386wmb.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 10:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lg9yHrGkGpcXD03lDudWZju5giekXRjY8U3zy8wdgTk=;
 b=aTHC4BsLtr8QeHHEnB1UAXeeO6QPaNqmiwRog/ji7M+jy1Xd+f7cBFLswl4kCs8O20
 iAsggIeinfYlmSiTlO37hSYeE5S8E82Yu7zZ6rIdet/4kzo+G3bi8b93T38Ru1ZSfgMy
 njzU7Qw0r5L0BqHtZ4iHe2R9thzYcjZudFIoJq6/44uNDsszWenQPByeDITYjhGgxBeY
 E13LZAEtlCc57LQ+4luS/qxIvr5XIZ4F82SzmywItyKk2s8IxJznL6d7RFEUwlNkHZAt
 ieT2ef8R5xMtUvqhKFG+HcrlxkfHP+ja8zUljqW1Hr7mNCV3ARK+mF7wnoK6lhugY/Oc
 jJsQ==
X-Gm-Message-State: AGi0Puak/tEWS7SXBa38DteSRcNRIcfDzgqW5IwvAI19b7CvyfWqtp/i
 yIX7j2V37iNST0BXz6W5qnBx/W3k5R/RnKW7+x/CWwF7VeNvOhp9dUTviKI1CDItk4nEDhOdfPF
 A2oC0WMgJEPDIVeI=
X-Received: by 2002:adf:f4cb:: with SMTP id h11mr31372276wrp.191.1588096049474; 
 Tue, 28 Apr 2020 10:47:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypKmvuTXADWGgD3SH5QEwygEylrxfjfEtGUOUXfhn+AV7M/MJi32+si96thGmY7dXr8eGYZ29A==
X-Received: by 2002:adf:f4cb:: with SMTP id h11mr31372235wrp.191.1588096049178; 
 Tue, 28 Apr 2020 10:47:29 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 p6sm26215895wrt.3.2020.04.28.10.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:47:28 -0700 (PDT)
Date: Tue, 28 Apr 2020 13:47:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Message-ID: <20200428134350-mutt-send-email-mst@kernel.org>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200428172920.GA111124@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200428172920.GA111124@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 06:29:20PM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 22, 2020 at 09:13:35PM -0700, elena.ufimtseva@oracle.com wrot=
e:
> > We will post separate patchsets for the following improvements for
> > the experimental Qemu multi-process:
> >  - Live migration;
> >  - Asynchronous communication channel;
> >  - Libvirt support;
> >=20
> > We welcome all your ideas, concerns, and questions for this patchset.
>=20
> This patch series does two things:
> 1. It introduces the remote device infrastructure.
> 2. It creates the remote device program and the associated build changes
>    (makefiles, stubs, etc).
>=20
> There are many patches and it's likely that a bunch more revisions will
> be necessary before this can be merged.
>=20
> I want to share an idea to reduce the scope and get patches merged more
> quickly.  It looks like the series can be reduced to 21 patches using
> this approach.
>=20
> I suggest dropping the remote device program from this patch series (and
> maybe never bringing it back).  Instead, use the softmmu target for the
> remote device.
>=20
> Why?  Because the remote device program is just a QEMU that uses the
> remote machine type and has no vCPUs:
>=20
>   $ qemu-system-x86_64 -chardev id=3Dchar0,... \
>                        -M remote,chardev=3Dchar0 \
> =09=09       -device lsi53c810 \
> =09=09       -drive if=3Dnone,id=3Ddrive0,file=3Dvm.img,format=3Draw \
> =09=09       -device scsi-hd,drive=3Ddrive0
>=20
> This will use the remote machine type, interrupt controller, and PCI bus
> that you have created.
>=20
> The remote machine type should default to no vCPUs and no memory
> creation (the memory comes via the mpqemu link communications channel).
>=20
> At this point qemu-system-x86_64 contains a lot of code that you don't
> want in the final remote device program.  Let's ignore that for a
> second.
>=20
> Now you can submit a 21-patch series containing just the remote device
> infrastructure.  This will be easier to merge.
>=20
> Returning to code size, the next step is to reduce the binary.  QEMU has
> a Kconfig-style system for optional features and dependencies.  It's a
> better approach than creating a separate make target because it
> eliminates the duplication and mess in the makefiles.
>=20
> For example, you can disable TCG and KVM so that your binary has no
> ability to execute guest code.  Currently ./configure disallows this but
> I've tried it and it works.
>=20
> You can add a new default-configs/ file that disables CONFIG_ISAPC,
> CONFIG_I440FX, etc.  When you compile QEMU most of hw/ will not be built
> anymore.  At this point you have a smaller binary that is still a
> softmmu target so the makefiles are shared with the regular
> qemu-system-x86_64.
>=20
> There will be some code for which there is no Kconfig option yet.
> Further improvements can be made by adding Kconfig options for any code
> that you wish to eliminate.  Instead of writing makefile changes like
> you did in this patch series you would be adding Kconfig options.  The
> nice thing is that this work isn't specific to the remote device program
> - anyone can use the new Kconfig options to reduce the size of their
> QEMU.  So not only is it less messy than duplicating the makefiles,
> but it also benefits everyone.
>=20
> The downside to doing this is that it will take a while to eliminate all
> code that you don't want via Kconfig.  However, your initial patch
> series can be merged sooner and I think this direction is also cleaner.
>=20
> I hope I've explained the idea properly :).  We can continue reviewing
> the current series if you prefer, but I think it would be quicker to
> drop the remote device program.
>=20
> Stefan

Building QEMU twices just to get the remote is however not very
attractive. So how about making remote a special target?
Either remote-softmmu/ or if impossible x86_64-remote-softmmu/

--=20
MST


