Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6CC20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBSANB5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6CC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii08H-0003bf-JA
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ii03g-00065D-Vc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ii03f-0000dG-1P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:57:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ii03e-0000Y4-PU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576778273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgoAJPsyBWGNUC0qdNBP37n+f8fXPIZIj+IKfmqzm1g=;
 b=GBSANB5ksrEh6jKz5CUcCVySYFLVzDUCqCqWQaiZvwUnTfRGxraOMG5qFdngCp4G5U/Cwx
 mH9COQLmIU74YN5IoL8a6mJSfU22gLiNLd9yDbsMXUP/RUDv7M99uZqe38PS+VdM8ZBB7d
 K14SWsrQaZ/8gYD9ohSKG5+7BZ5JB9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-OuNnLlQAMuKqHMASxHVo6w-1; Thu, 19 Dec 2019 12:57:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58A481856A8A;
 Thu, 19 Dec 2019 17:57:43 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE2707EB64;
 Thu, 19 Dec 2019 17:57:42 +0000 (UTC)
Date: Thu, 19 Dec 2019 14:57:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/2] numa: properly check if numa is supported
Message-ID: <20191219175741.GT498046@habkost.net>
References: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
 <1576154936-178362-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576154936-178362-3-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: OuNnLlQAMuKqHMASxHVo6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Tao Xu <tao3.xu@intel.com>,
 qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@linaro.org>,
 qemu-stable@nongnu.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 01:48:56PM +0100, Igor Mammedov wrote:
> Commit aa57020774b, by mistake used MachineClass::numa_mem_supported
> to check if NUMA is supported by machine and also as unrelated change
> set it to true for sbsa-ref board.
>=20
> Luckily change didn't break machines that support NUMA, as the field
> is set to true for them.
>=20
> But the field is not intended for checking if NUMA is supported and
> will be flipped to false within this release for new machine types.
>=20
> Fix it:
>  - by using previously used condition
>       !mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id
>    the first time and then use MachineState::numa_state down the road
>    to check if NUMA is supported
>  - dropping stray sbsa-ref chunk
>=20
> Fixes: aa57020774b690a22be72453b8e91c9b5a68c516
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I'm queueing this and plan to submit a pull request soon.

--=20
Eduardo


