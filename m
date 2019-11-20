Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C859BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3E72071C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDHwkLSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3E72071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUxZ-00021p-LV
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iXUwV-0001NK-C0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iXUwS-00059m-WD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:43:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28054
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iXUwS-00059Z-JS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574275383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=798g9wLEGX/NCbaZwe+VMddNLoz0xnNYBxMUseP6R0c=;
 b=IDHwkLSHY53OU/dIg981jKDwkFIbpog/X/sk+X7+LEM4FFQ1TfuZ1WUM7UXtPFp5BOS8i/
 ZDUIihvTcNdWsmv4QzHFcslGJqur0ZILWBL8VDI9cDt4D4GIFn1NGAAfUmeBgfW6Tl0EOU
 aOD+1qAuX2/Il+LROAKNSEOFv/GiaoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-nNLTuyfzMBOBivDG8GUV-Q-1; Wed, 20 Nov 2019 13:43:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC8E5107ACC9;
 Wed, 20 Nov 2019 18:43:00 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E98F1042B7D;
 Wed, 20 Nov 2019 18:42:59 +0000 (UTC)
Date: Wed, 20 Nov 2019 15:42:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-4.2 1/2] i386: Add new versions of
 Skylake/Cascadelake/Icelake without TSX
Message-ID: <20191120184258.GS3812@habkost.net>
References: <20191120164912.32384-1-ehabkost@redhat.com>
 <20191120164912.32384-2-ehabkost@redhat.com>
 <b1d8c3ef-646a-85c7-176b-c4429f36d384@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b1d8c3ef-646a-85c7-176b-c4429f36d384@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nNLTuyfzMBOBivDG8GUV-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Jiri Denemark <jdenemar@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 06:40:06PM +0100, Paolo Bonzini wrote:
> On 20/11/19 17:49, Eduardo Habkost wrote:
> > One of the mitigation methods for TAA[1] is to disable TSX
> > support on the host system.  Linux added a mechanism to disable
> > TSX globally through the kernel command line, and many Linux
> > distributions now default to tsx=3Doff.  This makes existing CPU
> > models that have HLE and RTM enabled not usable anymore.
> >=20
> > Add new versions of all CPU models that have the HLE and RTM
> > features enabled, that can be used when TSX is disabled in the
> > host system.
>=20
> What is the effect of this when using "-cpu CascadeLake-Server" and
> upgrading QEMU?  Would it automatically switch to the new version?  If
> so, would it be better to include a duplicate of the models (and if so,
> that would conflict with my VMX features patch, which is also for 4.2).

It won't, because PCMachineClass::default_cpu_version=3D=3D1 for all
versioned PC machine-types, currently.

The plan is to set default_cpu_version=3DCPU_VERSION_LATEST on
pc-*-5.0 (or, more likely, 5.1).  But this will happen only after
libvirt starts resolving CPU model versions.  See the
"Runnability guarantee of CPU models" section at
qemu-deprecated.texi.

--=20
Eduardo


