Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C98C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0825E2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFOgDPnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0825E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQt2-0004lQ-7L
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCQro-0007FF-3d
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCQrm-0005r9-Vl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:39:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38496
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCQrm-0005r2-SA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584031166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/yD8fal8CCL/bE6LGP4x8ytyK0/Cd7U2jJO5ljBrUI=;
 b=CFOgDPnOGIdOfNSO6AQv7cpmurSlaLlhiiM0GdrT3l1QXShO1bFW8ZYAlz2Ejz6meJHkMW
 4irLU+jRKVxAnVXSXenO56mFkKMdewgCwByuO2Cljf8AZnckJglOVyj8GnhA8SHa99fpH+
 9Nm6BHZa1XZynpmyTNn94VA32bNhb+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-AvVZl5O6O9WRz5t4IgEX5w-1; Thu, 12 Mar 2020 12:39:24 -0400
X-MC-Unique: AvVZl5O6O9WRz5t4IgEX5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 658FC800EBC;
 Thu, 12 Mar 2020 16:39:23 +0000 (UTC)
Received: from work-vm (ovpn-116-106.ams2.redhat.com [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1BF48F37D;
 Thu, 12 Mar 2020 16:39:21 +0000 (UTC)
Date: Thu, 12 Mar 2020 16:39:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: The issues about architecture of the COLO checkpoint
Message-ID: <20200312163919.GJ3211@work-vm>
References: <20200213103752.GE2960@work-vm>
 <CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com>
 <e820e35d-5b8a-18c8-736b-6c38cff9798e@intel.com>
 <CA+XQNE49wq2nRKJ0CA4uHDZ4OUEbFGPKBfAWB4+UwPYgiZkrCw@mail.gmail.com>
 <5d030380-76d6-67c6-39a1-82c197e320b4@intel.com>
 <CA+XQNE6riKARXtP9oZaQjK9Gqgfh-+Ae8qX+WsWhGfMB0hf8tg@mail.gmail.com>
 <0c69b913bf1047c4b7d5edac50f3988b@intel.com>
 <CA+XQNE6tZv0uhGoqqnS2ki=ZjP_YFaE53ZZntKPAbCxGnO1V8A@mail.gmail.com>
 <343daa37127e424c94fa0a3edde30f0c@intel.com>
 <20200306162201.3a1cd3ae@luklap>
MIME-Version: 1.0
In-Reply-To: <20200306162201.3a1cd3ae@luklap>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Daniel Cho <danielcho@qnap.com>, "Zhang, Chen" <chen.zhang@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> On Wed, 4 Mar 2020 07:44:11 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Daniel Cho <danielcho@qnap.com>
> > > Sent: Monday, February 24, 2020 3:15 PM
> > > To: Zhang, Chen <chen.zhang@intel.com>
> > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>; Zhanghailiang
> > > <zhang.zhanghailiang@huawei.com>; qemu-devel@nongnu.org; Jason
> > > Wang <jasowang@redhat.com>
> > > Subject: Re: The issues about architecture of the COLO checkpoint
> > >
> > > Hi Zhang,
> > >
> > > Thanks for your help.
> > > However, did you occur the error which the function qemu_hexdump in
> > > colo-compare.c will crash the qemu process while doing operation with
> > > network?
> > >
> >
> > No, qemu_hexdump looks no relationship with network...
> > Do you means it will crashed in qemu_hexdump sometimes?
>=20
> Jeah, I hit that bug too, but it was fixed with
> 1e907a32b77e5d418538453df5945242e43224fa "COLO-compare: Fix incorrect `if=
` logic"
> in qemu 4.2.

Is anyone running any CI stuff for COLO?  I'm not, but bugs like that
make it clear we probably should be;  it's not trivial to setup, but it
should be doable in a nest setup these days.

Dave

> Regards,
> Lukas Straub
>=20
> > > We are working on VM fault tolerance study and COLO function evalutat=
ion
> > > first. Currently we did not have a confirmed plan on it.
> >
> > OK, keep connection.
> >
> > Thanks
> > Zhang Chen
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


