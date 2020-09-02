Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC4BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B1E20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="e+/Epz8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B1E20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVIn-0002ts-NH
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDVEE-0004s5-Ku
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:03:18 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:58877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDVEC-0007j7-DV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=gBzu7Ef20E1BMkzEu3EfXEZHuP63wUmDy7+bNtkfYG8=; b=e+/Epz8HW0QgkutN0MVDZNMyq9
 VM+GSzoJCPrlpmBOv6yEkWEUprTXA8IlTdRfLXhU7NOAlWmLDWJBp6EX3+Qt8XX3fmGGyqXL66X3Q
 N4PHr3TCAwhOfwddjKFg+rwNRV8/Wgd7LcJbIPxkKI8aR4Ud5NEW2xnRvuyzYrBWmN9iY3kRfd5p+
 Zin5SnPLU9ImPd6Kh0n8VvFTSra0iWGQlf3FxtX4XK3RTCQBEaAMDgvfF7rD+wpRawbRdVeGRpfvq
 +qZsHLFyDLF+DbR91WQPAI79JGq2CXA8XRwRs0B1z/sfC0ZnbmvNQqBm7wZeTZyh92yn9ZAi1ZSSl
 OGeYlI6Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Date: Wed, 02 Sep 2020 18:03:12 +0200
Message-ID: <2877776.MzA8b4DPAS@silver>
In-Reply-To: <20200902141035.GK403297@redhat.com>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com>
 <2812056.Ea3xXQFrjv@silver> <20200902141035.GK403297@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 07:41:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 2. September 2020 16:10:35 CEST Daniel P. Berrang=E9 wrote:
> > Yeah, I know, but the problem is I don't see how I would squeeze the
> > relevant information into only one log message; and even "what's a good
> > starting point" is already questionable.
> >=20
> > For that reason my plan was:
> > 	- logging this warning
> > =09
> > 	- describing the 'msize' issue in detail on the QEMU wiki (what's the
> > =09
> > 	  point, how would you benchmark it)
> >=20
> > So my idea was: user sees the message, "what is 'msize?'" -> Google "ms=
ize
> > qemu" -> click 'QEMU wiki' -> read all the details.
> >=20
> > But how about this: I put a QEMU wiki link directly into the log messag=
e?
>=20
> Rather than that, how about putting it in the QEMU man page, and then
> just add  "See 'man 1 qemu' for further guidance".

Well, I can do that of course. But somehow I fear users get lost by just=20
pointing them to "man 1 qemu" in the log message. It already starts that e.=
g.=20
on Debian there is no "man qemu", it is "man qemu-system" there instead. Ne=
xt=20
issue is that qemu man page is currently not structured in a way that would=
=20
allow me to directly point them to the relevant man heading like:

	man --pager=3D'less -p ^9P-msize' qemu

So they would need to scroll their way through the entire man page by=20
themselfes and find confusing sections like "-fsdev -device virtio-9p-pci" =
vs.
"-virtfs", etc. I can imagine some people will struggle with that.

With a link like "https://wiki.qemu.org/Documentation/9psetup#msize" the th=
ing=20
would be crystal clear within seconds.

Just my opinion. Greg?

Best regards,
Christian Schoenebeck



