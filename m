Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91114C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1F6208CC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCgU60vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1F6208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43963 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1LF-0007f0-F6
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iX1Jz-0006or-DM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iX1Jy-0005Xf-8e
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:05:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iX1Jy-0005XH-4d
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574161521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jF61xnViGL23Eb+Id7KyzfYMx3Ayid8wCkfadXcBI/4=;
 b=cCgU60vn4aU25A7NdeMFR51rv3ODemIZQOJUm8+sAme3cD+QWfO4MipV9LIysoM8jXukIg
 C9Zuf3RGkMFIBE5w4B06R75/FfU5peoVe88oprquCmIHB2k0n3106XVbAuDaL9pb7azg6N
 1o1P9NNlTh+SZaj9BUd1pkIrMX8VGos=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-4JcX_BvQO7-o-BTGLHt6gg-1; Tue, 19 Nov 2019 06:05:18 -0500
Received: by mail-qt1-f200.google.com with SMTP id o13so14423289qtr.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 03:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hi1GDSpU8sEfJ8C10wXwgWCrxY2Og6V/G6pirfRJec4=;
 b=Ur/0XDxHk3e1kbk95Gv7ss3IkcB+xG6rmUXXbZ/EvAVwlFQX9giMnOPG4yh7xr+dXx
 gsCWtLIvm+38hY/4iD4VukmiOhKpSPjQnWMgIR0oW1dRptPnkR9t5vIZ1/MOkM778CSn
 aKyYVVq6rL7IgYemxr5YyjgjqtJPGGP+4ZapqZdfWcXO6/aOQT1HVkZm7AgyQpQ/bKhv
 6p/IAg06Cu9qKqpXim14D6mdtchObwvf6A30ezto0Syha76yXCw/qsHYAk5/plYnNn8u
 KCQsQduFzM7FQGs63mMr0wR9DAofFKPmX+rHhffTtXkEgIMJdXlSkurPVu9yIfsRTQz5
 zA9A==
X-Gm-Message-State: APjAAAWZC+zfvIUBSblljVd5XiH3cFQgGD9oWXs3HfI0Kxb3sfR4PuoL
 aeuhDllHfGtzbV2RJBHYSskspRLDwlKLhPbOdiaOpWKOIF6fVAhjKT6Vu8x0P3+gkqppPQmRYgo
 Pvm4qdqykmrQ+N6A=
X-Received: by 2002:ae9:c119:: with SMTP id z25mr28143870qki.417.1574161517992; 
 Tue, 19 Nov 2019 03:05:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPACvjM0GvsFusndHnk8gYc4xURL2HxeMadQqQBKvM0RI9qQG5bRIsFuHHa4/JE3DycniSQQ==
X-Received: by 2002:ae9:c119:: with SMTP id z25mr28143845qki.417.1574161517664; 
 Tue, 19 Nov 2019 03:05:17 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id 40sm12003083qtc.95.2019.11.19.03.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 03:05:16 -0800 (PST)
Date: Tue, 19 Nov 2019 06:05:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qi1.zhang@intel.com
Subject: Re: [PATCH v2 0/2] TM field check failed
Message-ID: <20191119060259-mutt-send-email-mst@kernel.org>
References: <cover.1570503331.git.qi1.zhang@intel.com>
MIME-Version: 1.0
In-Reply-To: <cover.1570503331.git.qi1.zhang@intel.com>
X-MC-Unique: 4JcX_BvQO7-o-BTGLHt6gg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 pbonzini@redhat.com, yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 08:28:12PM +0800, qi1.zhang@intel.com wrote:
> From: "Zhang, Qi" <qi1.zhang@intel.com>
>=20
> spilt the reserved fields arrays and remove TM field from reserved=20
>  bits

Looks good to me.
Also Cc Peter Xu.
Also I wonder - do we need to version this change
with the machine type? Peter what's your take?
Also, Peter, how about we create a MAINTAINERS entry for IOMMUs
and add everyone involved, this way people will
remember to CC you?

> Changelog V1:
>  add descriptons
> Changelog V2:
>  refine
>=20
> Zhang, Qi (2):
>   intel_iommu: split the resevred fields arrays into two ones
>   intel_iommu: TM field should not be in reserved bits
>=20
>  hw/i386/intel_iommu.c          | 35 ++++++++++++++++++++--------------
>  hw/i386/intel_iommu_internal.h | 17 +++++++++++++----
>  2 files changed, 34 insertions(+), 18 deletions(-)
>=20
> --=20
> 2.20.1


