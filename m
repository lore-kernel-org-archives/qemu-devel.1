Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C38C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FA02073D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoDA4oog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FA02073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4u7-0006sP-7R
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1if4sO-0005hV-O8
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1if4sL-0001Jd-J4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:30:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1if4sL-0001IR-EF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576081808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZwjoRyY7AB0rlcqpTra+Dt6kC2EW0+7cpDvCVpBMxI=;
 b=MoDA4oogsimnQv61DfCTKFiv75Epm9T4VB/YIMoOFcFa62HMOnVjRUcH75Gei/7iacDBh1
 1MCGMWK0ETnI4BgGQg9LcxeVA2p7bFTck1RcQ34Sq8QayPdYLjmYqRe5sHf/Y4GiPpkRe8
 oJ5vdFs06tZKxY6EHOUNOSgbZRrPp7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-nBCwO_nBPSu0KOyYY5ga4A-1; Wed, 11 Dec 2019 11:30:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1507190714C;
 Wed, 11 Dec 2019 16:30:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A2F75C1B5;
 Wed, 11 Dec 2019 16:30:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BFCE11386A7; Wed, 11 Dec 2019 17:30:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: Insufficiently documented deprecated command arguments
References: <87tv67wa9y.fsf@dusky.pond.sub.org>
 <20191211093317.GB2441258@angien.pipo.sk>
 <20191211101439.GA6505@linux.fritz.box>
 <20191211105147.GC2441258@angien.pipo.sk>
 <20191211122417.GB6505@linux.fritz.box>
 <20191211123210.GH955178@redhat.com>
 <20191211125548.GE2441258@angien.pipo.sk>
Date: Wed, 11 Dec 2019 17:30:04 +0100
In-Reply-To: <20191211125548.GE2441258@angien.pipo.sk> (Peter Krempa's message
 of "Wed, 11 Dec 2019 13:55:48 +0100")
Message-ID: <87d0cuu8oj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nBCwO_nBPSu0KOyYY5ga4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> On Wed, Dec 11, 2019 at 12:32:10 +0000, Daniel Berrange wrote:
>> On Wed, Dec 11, 2019 at 01:24:17PM +0100, Kevin Wolf wrote:
>> > Am 11.12.2019 um 11:51 hat Peter Krempa geschrieben:
>> > > On Wed, Dec 11, 2019 at 11:14:39 +0100, Kevin Wolf wrote:
>
> [...]
>
>> > > Well, in some specific cases we could detect the node names
>> > > auto-assigned by qemu and use them instead of paths, but in my opini=
on
>> > > it's not worth the effort and extra code.
>> >=20
>> > Well, the question is what to do on the QEMU side then. Deprecation
>> > should mean that we have a plan for removing the feature. If we're
>> > planning to keep the feature indefinitely because libvirt needs it, we
>> > might want to consider removing the deprecation notice.
>>=20
>> Ideally libvirt would stop using -drive entirely, as I hate the idea of
>> having to keep this around indefinitely in libvirt too. This needs QEMU
>> to close the last gaps wrt SD cards
>
> Yes and also give us guidance how to convert it. Looking at the code
> didn't help. There's a plethora of controllers and options to configure
> without clear indication what is default behaviour expected.

Similar situation as for if=3Dpflash.  That one we addressed just for
"tier 1" machine types: i386 pc-*, arm virt-*.

Would addressing if=3Dsd just for these machines suffice?

Addressing if=3Dpflash and if=3Dsd for all machines looks is beyond my
capacity.

For a more detailed analysis, see my "Review of onboard block device
configuration with -drive", Message-ID:
<87fti1i0oi.fsf@dusky.pond.sub.org>.  Relevant parts:

    The interface types are:
    [...]
    * if=3Dpflash

      Many machines have onboard pflash devices.  They recognize
      bus=3D0,unit=3DU where 0 <=3D U < number of such onboard devices.  AR=
M
      machine sbsa-ref, virt, i386 machines pc*, isapc, xenfv, Risc-V
      machine virt provide machine properties for connecting backends to
      their onboard pflash devices.  For the other machines, -drive is stil=
l
      the only way to connect backends.

      PPC machines pseries* create spapr-nvram devices instead.  It can be
      created with -device instead.

      SPARC machine niagara creates a memory region instead *boggle*.
      -drive is the only way to configure that.

      Other machines create the onboard pflash device only when the
      corresponing drive is present.  Since pflash devices are not
      pluggable, -drive is the only way to create them.
    [...]
    * if=3Dsd

      Many machines have onboard sd-card devices.  They recognize
      bus=3D0,unit=3DU where 0 <=3D U < number of such onboard devices.  -d=
rive is
      the only way to connect backends.
    [...]

    Summary
    [...]
    * if=3Dpflash, if=3Dmtd and if=3Dsd are blocked by the "no way to conne=
ct
      backends to onboard devices" issue, and the "no way to create the
      device" issue.  We solved them for if=3Dpflash with some boards.  Man=
y
      more remain.

> Trying to convert it blindly would end up worse than just ditching
> support for sdcards altogehter.

Tempting, isn't it?


