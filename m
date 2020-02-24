Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA65C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D6020726
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrvSYYvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D6020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6BVv-0003mx-Ni
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j6BUv-00038j-9H
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j6BUt-0004pI-TY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:02:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j6BUt-0004p8-OR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582542118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTYFg9yM9vtRO0Wzq7zBBKKPniaOmR4IZBIP9m9b2rw=;
 b=XrvSYYvVX5bJSBAmwHdkpEBxwsKaDYq54l4j0JMCBihBNffNOK3bpBpUerlemRH4fINKtv
 DM04lehSYvvdrpyJBBC1RSusNSMaRPInZNSN8DA5k5CNxDAoYQauwZ/HDyP2D/IIjAjEKw
 EXwsvZmht5qrE94B3lSFpmYl+RYh0DM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-uGjKIxJbMD2dtF4qLwfH3w-1; Mon, 24 Feb 2020 06:01:54 -0500
X-MC-Unique: uGjKIxJbMD2dtF4qLwfH3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F9E3A0CBF;
 Mon, 24 Feb 2020 11:01:53 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-177.brq.redhat.com [10.40.204.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4D551001B34;
 Mon, 24 Feb 2020 11:01:48 +0000 (UTC)
Date: Mon, 24 Feb 2020 12:01:45 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 0/3] Tighten qemu-img rules on missing backing format
Message-ID: <20200224110145.GB3296@andariel.pipo.sk>
References: <20200222112341.4170045-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200222112341.4170045-1-eblake@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 22, 2020 at 05:23:38 -0600, Eric Blake wrote:
> In the past, we have had CVEs caused by qemu probing one image type
> when an image started out as another but the guest was able to modify
> content.  The solution to those CVEs was to encode backing format
> information into qcow2, to ensure that once we make a decision, we
> don't have to probe any further.  However, we failed to enforce this
> at the time.  And now that libvirt is switching to -blockdev, it has
> come back to bite us: with -block, libvirt had no easy way (other than

s/-block/-drive/ ?

> json:{} pseudoprotocol) to force a backing file, but with -blockdev,

"json:{}" is basically -blockdev with extra steps. Old -drive usage
didn't have any way to do that apart from rewriting the image. Which is
basically the same since json:{} also needs to be recorded in the image
to take effect.

> libvirt HAS to use blockdev-open on the backing chain and supply a
> backing format there, and thus has to probe images.  If libvirt ever
> probes differently than qemu, we are back to the potential
> guest-visible data corruption or potential host CVEs.

As I've elaborated in [1] I disagree with the host CVE part. The
insecure part is not probing the format itself, but probing format AND
using the backing file of the image if we probed format.

I agree that mis-probing format leads to data corruption though.

> It's time to deprecate images without backing formats.  This patch
> series does two things: 1. record an implicit backing format where one
> is learned (although sadly, not all qemu-img commands are able to
> learn a format), 2. warn to the user any time a probe had ambiguous
> results or a backing format is omitted from an image.  All previous
> images without a backing format are still usable, but hopefully the
> warnings (along with libvirt's complaints about images without a
> backing format) help us pinpoint remaining applications that are

It is not a warning in libvirt though. We just refuse it now because we
don't do probing. Previously we allowed qemu to probe the format and the
only thing that prevented host CVEs was if the host used selinux or any
other security approach which would prevent opening the backing file.

> creating images on their own without recording a backing format.


