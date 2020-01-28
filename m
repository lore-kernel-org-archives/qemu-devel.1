Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D6BC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEAA24688
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T17n9ask"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEAA24688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwObR-0005ng-LU
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwOaM-0004du-AV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwOaL-0000ix-26
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwOaK-0000iC-VA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580209148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ByumgrNzlLWFSkD7chJPVnd5nK+x9Y51/TodVPgmg4=;
 b=T17n9askNSUqhT9I7VEMvZObaG6REU0zCOII7ylaF2RLXQkB+so40Gew3CpONZMmYWGDyk
 YONuZkEVo0ZQDh/FMIc7JjnUaz113cLerJfun4R3jjMagLqBBa6XCcPT/86x9Zi8I9kDJJ
 pIqEJuNZzaJkx61emEVoiWzhwPakeAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-LutRDJZgNrSK4YF9RvZSMQ-1; Tue, 28 Jan 2020 05:59:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EDBB100550E;
 Tue, 28 Jan 2020 10:59:05 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6787E87022;
 Tue, 28 Jan 2020 10:59:01 +0000 (UTC)
Date: Tue, 28 Jan 2020 10:58:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [question] hw/arm/virt: about the default gic-version in
 accelerated mode
Message-ID: <20200128105858.GG3215@work-vm>
References: <df1d6ae5-b734-ef64-4ef9-c661e8f797e8@redhat.com>
 <CAFEAcA8hib-3YWuS-MajjvokOFCGKUHeuz+XQTBYf8LBz+PuFQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8hib-3YWuS-MajjvokOFCGKUHeuz+XQTBYf8LBz+PuFQ@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: LutRDJZgNrSK4YF9RvZSMQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Auger Eric <eric.auger@redhat.com>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, qemu list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Tue, 28 Jan 2020 at 10:47, Auger Eric <eric.auger@redhat.com> wrote:
> > When arm virt machine is run in accelerated mode with "-cpu host
> > -machine virt", the default gic version is 2.
> >
> > I understand the rationale with TCG where we don't have MSI ITS
> > emulation along with GICv3 so we need to choose GICv2 to get GICv2M
> > functionality.
> >
> > However in KVM mode, I would have expected to see the host GIC probed t=
o
> > set the same version on guest. Indeed most of our HW now have GICv3
> > without GICv2 compat mode so our default values lead to weird traces:
> >
> > "
> > qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
> > qemu-system-aarch64: failed to set irq for PMU
> > "
> >
> > I would like to propose a patch to improve those errors and also sugges=
t
> > a hint. But I also wanted to know whether you would accept to change th=
e
> > default value with KVM and choose the host version instead of 2. For TC=
G
> > we would keep v2.
>=20
> As with the -cpu option, the default is there for command
> line backward compatibility primarily. Even if we had
> better support for MSI ITS emulation we'd still leave
> the default at GICv2.

I'm curious why; 'virt' is a versioned machine type, the whole point of
versioned machine types is you're allowed to change the behaviour of
them between versions of qemu.   If people want their command lines
to stay stable they can specify a version, i.e. -M virt-4.2 and
know that it won't change.

> If you want "do the best you can, regardless of accelerator"
> that is "-cpu max -machine gic-version=3Dmax".

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


