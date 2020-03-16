Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90998C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29DC20724
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA7/aw/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29DC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDo4z-0004Fx-CB
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1jDnUf-000873-4I
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1jDnUT-0000gH-27
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:01:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1jDnUP-0000CZ-GJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584356450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dg6Z/zM68y6egVxjTIxJNihvnmhssR0VTz+eymxL59Y=;
 b=bA7/aw/lp5fWg19tNMkChvsyNSGBffRekC3daLAe5be0XTT32aEtZ6FILSsV6bahRLNRMH
 arXbS+00sP1DYMcdvhufigDnjYoVxrukf4njZy2j1P8yFZNxDHkePotfbGCQ0hZ5oIYwBb
 p+sGtOYxtIhA012MxeyoSfNJeI8D/kM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-BFVJiV76NR-2JZ9X_6LFDQ-1; Mon, 16 Mar 2020 07:00:48 -0400
X-MC-Unique: BFVJiV76NR-2JZ9X_6LFDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11EF6105253F;
 Mon, 16 Mar 2020 11:00:47 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.119.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 140248B756;
 Mon, 16 Mar 2020 11:00:46 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 9FDF23E048A; Mon, 16 Mar 2020 12:00:43 +0100 (CET)
Date: Mon, 16 Mar 2020 12:00:43 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] softmmu/vl.c: Handle '-cpu help' and '-device help'
 before 'no default machine'
Message-ID: <20200316110043.GN22884@paraplu>
References: <20200313172447.15471-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200313172447.15471-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Cc: Markus; he'd be pleasantly surprised with this, if he already
hadn't noticed this, as he was also mildly annoyed about this the other
day.]

On Fri, Mar 13, 2020 at 05:24:47PM +0000, Peter Maydell wrote:
> Currently if you try to ask for the list of CPUs for a target
> architecture which does not specify a default machine type
> you just get an error:
>=20
>   $ qemu-system-arm -cpu help
>   qemu-system-arm: No machine specified, and there is no default
>   Use -machine help to list supported machines

I just applied the patch and built on QEMU.

With `qemu-system-arm`:

    $> ./arm-softmmu/qemu-system-arm -cpu help | head -5
    Available CPUs:
      arm1026
      arm1136
      arm1136-r2
      arm1176

    $> ./arm-softmmu/qemu-system-arm -device help | head -5
    Controller/Bridge/Hub devices:
    name "i82801b11-bridge", bus PCI
    name "ioh3420", bus PCI, desc "Intel IOH device id 3420 PCIE Root Port"
    name "pci-bridge", bus PCI, desc "Standard PCI Bridge"
    name "pci-bridge-seat", bus PCI, desc "Standard PCI Bridge (multiseat)"

With `qemu-system-aarch64`:

    $> ./aarch64-softmmu/qemu-system-aarch64 -cpu help | head -5
    Available CPUs:
      arm1026
      arm1136
      arm1136-r2
      arm1176

    $> ./aarch64-softmmu/qemu-system-aarch64 -device help | head -5
    Controller/Bridge/Hub devices:
    name "i82801b11-bridge", bus PCI
    name "ioh3420", bus PCI, desc "Intel IOH device id 3420 PCIE Root Port"
    name "pci-bridge", bus PCI, desc "Standard PCI Bridge"
    name "pci-bridge-seat", bus PCI, desc "Standard PCI Bridge (multiseat)"

> Since the list of CPUs doesn't depend on the machine, this is
> unnecessarily unhelpful. "-device help" has a similar problem.
>=20
> Move the checks for "did the user ask for -cpu help or -device help"
> up so they precede the select_machine() call which checks that the
> user specified a valid machine type.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

> ---
> This has been on-and-off irritating me for years, and it's
> embarrassing how simple the fix turns out to be...
> ---
>  softmmu/vl.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

[...]=20

Thanks. :)

--=20
/kashyap


