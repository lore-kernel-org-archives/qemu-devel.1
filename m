Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33FFECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C6C20673
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Dyotwbk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C6C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVlY-0001r0-8P
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexandr.iarygin@cloud.ionos.com>)
 id 1iHVNt-0003di-Tv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexandr.iarygin@cloud.ionos.com>)
 id 1iHVNs-0002o5-Dg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:57:17 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexandr.iarygin@cloud.ionos.com>)
 id 1iHVNs-0002nH-3K
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:57:16 -0400
Received: by mail-ed1-x543.google.com with SMTP id c4so12977334edl.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sS8cYiQp7T5fn3LJDhD/jbl4mofkKJSWjJqSZbjUzjI=;
 b=Dyotwbk0okwSHMtPILag5I0Dt/4M6P+5vuiNFfmL6Vhl1FCml5GQMM7tzeG/XC4U3n
 1+KZ14xkWqV4CCrN4D33KnNaAGdxqvjXZDYLIyqdZoVybt16AZYLC9Obq5CSdUk2G6eL
 JVMvskpQOS8/qA6mdrRNcCugWtSO51LiGaPQxAL/kfyZ+fqNWNktqpFRWwXFBfId0YVQ
 pocdV3KxibV1FNE9Je69qmiVIc3kYZK+N0ROfjatqzXw6Jd6KXDZKE3ENm+tyN5qtnKh
 ydIu4AqFhZds9dUhfF8tUhFjqU1wyXCrBoOE7FKUTb8HHtMHHQgMIzKUIdkKOhvP8rx/
 BjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=sS8cYiQp7T5fn3LJDhD/jbl4mofkKJSWjJqSZbjUzjI=;
 b=dNYwJFNXYjNMZwKRLetSAasIORA8MoQ8Fe7BOou8c2INK6ONVKf1AqaQGGXRFrHKPC
 MvazUtseMlLSNZW9+RHGtvLUeGgPu0CEXQSUKOO2P8tWdV1Dy3bQZVLcyCA/mHxqpK9/
 Lj+GtqScLkBEO2dKsWGH/hgbFlTed9yi5pMLwXCj1O+VIzn9CYz3m0BmhgL/DQJByUSa
 Cb9TSBliwh9wHkLA/oPsVAf1d5TTww9ZLZBvPfi5Q0fyPjPAdcGDghCFUvDWalR71Ih5
 O0NYFYfKgjGTaL19UZYVyXjY9U8Hfc6NDe0wiBN7QdZTtzW3fcjZQ2c8MgX2bS6ui/XI
 3YKQ==
X-Gm-Message-State: APjAAAUGi+O2mfKCeb2uPvuuWvdYZ1NIXrskIwMAR5y8k17fj/ctSFV9
 XdD1lBvEChwwAUchddsmbNNTvA==
X-Google-Smtp-Source: APXvYqyWkSYRhmhhfgO/KSGFe/uD7aob3d8GHKA6kJBziD6T0Mz9b6DKdvlS/U/uybSbKMZoFcHSPA==
X-Received: by 2002:a17:906:944b:: with SMTP id
 z11mr640256ejx.46.1570463834312; 
 Mon, 07 Oct 2019 08:57:14 -0700 (PDT)
Received: from aiarygin-laptop ([2001:1438:4010:2558:180d:888f:abd7:58ee])
 by smtp.gmail.com with ESMTPSA id 36sm3541803edz.92.2019.10.07.08.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:57:13 -0700 (PDT)
From: Alexandr Iarygin <alexandr.iarygin@cloud.ionos.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/97] Patch Round-up for stable 4.0.1,
 freeze on 2019-10-10
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
Date: Mon, 07 Oct 2019 17:57:12 +0200
Message-ID: <87d0f8k0pz.fsf@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
X-Mailman-Approved-At: Mon, 07 Oct 2019 12:14:24 -0400
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> Hi everyone,=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>
> The following new patches are queued for QEMU stable v4.0.1:
>
>   https://github.com/mdroth/qemu/commits/stable-4.0-staging
>
> The release is planned for 2019-10-17:
>
>   https://wiki.qemu.org/Planning/4.0

Hi,

How about

commit fd392cfa8e6fb0dc34bd0327fc356dfbf6edf1fd
Author: Yury Kotov <yury-kotov@yandex-team.ru>
Date:   Mon Apr 8 14:33:43 2019 +0300

    migration: Fix use-after-free during process exit


commit ebb6ff25cd888a52a64a9adc3692541c6d1d9a42
Author: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Date:   Fri Aug 16 19:15:03 2019 +0200

    virtio-blk: Cancel the pending BH when the dataplane is reset


and https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg04618.html
?

