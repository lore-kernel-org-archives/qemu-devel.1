Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B2C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ED920722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3fVXdtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ED920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CSk-0005zJ-Kf
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j5CRz-0005Uv-4I
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j5CRx-0006zE-NT
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:50:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48691
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j5CRx-0006yq-Hf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582307452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C2lkRJuvRvWmT6hf3o3RHC8s5DCaeNzpBG1rUQPK4Y=;
 b=I3fVXdtlvvTtA/ZkJwviCuKSchQEdE6iBTE46lLONxtbHbJcn1wP7nOaIPNrg2QVWZzFZ7
 +TTblgUsGZlvbtzYotunc6CjNVrWjNse1x1m3WFRiArWBaj9/8LaQFT7dAudhx1+EEI0L+
 Lx0bRWj34BqalDcq8m+x7xkcPN2P3FE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-I5ePkQlYNESx9r-7hapxvg-1; Fri, 21 Feb 2020 12:50:48 -0500
X-MC-Unique: I5ePkQlYNESx9r-7hapxvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4441F8017CC;
 Fri, 21 Feb 2020 17:50:47 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 171F960499;
 Fri, 21 Feb 2020 17:50:44 +0000 (UTC)
Date: Fri, 21 Feb 2020 17:50:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v1] block/nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200221175042.GJ2931@work-vm>
References: <20200218224811.30050-1-andrzej.jakowski@linux.intel.com>
 <20200221134555.GK1484511@stefanha-x1.localdomain>
 <e8aa39fd-b5eb-8ed2-445b-02cce3301748@linux.intel.com>
 <CAJSP0QWXsZXBr_iVJp11FHYYj2Zb1NU62vA6kaR36mOH9B8abA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWXsZXBr_iVJp11FHYYj2Zb1NU62vA6kaR36mOH9B8abA@mail.gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Zhang Yi <yi.z.zhang@linux.intel.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Junyan He <junyan.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Fri, Feb 21, 2020 at 3:36 PM Andrzej Jakowski
> <andrzej.jakowski@linux.intel.com> wrote:
> > On 2/21/20 6:45 AM, Stefan Hajnoczi wrote:
> > > Why is msync(2) done on memory loads instead of stores?
> >
> > This is my interpretation of NVMe spec wording with regards to PMRWBM f=
ield
> > which says:
> >
> > "The completion of a memory read from any Persistent
> > Memory Region address ensures that all prior writes to the
> > Persistent Memory Region have completed and are
> > persistent."
>=20
> Thanks, I haven't read the PMR section of the spec :).
>=20
> A synchronous operation is bad for virtualization performance.  While
> the sync may be a cheap operation in hardware, it can be arbitrarily
> expensive with msync(2).  The vCPU will be stuck until msync(2)
> completes on the host.
>=20
> It's also a strange design choice since performance will suffer when
> an unrelated read has to wait for writes to complete.  This is
> especially problematic for multi-threaded applications or multi-core
> systems where I guess this case is hit frequently.  Maybe it's so
> cheap in hardware that it doesn't matter?  But then why didn't NVDIMM
> use this mechanism?
>=20
> If anyone knows the answer I'd be interested in learning.  But this
> isn't a criticism of the patch - of course it needs to implement the
> hardware spec and we can't change it.

Is this coming from the underlying PCIe spec ?
In PCIe Base 4.0 Rev 0.3 Feb19-2014, section 2.4.1 Transaction ordering,
there's a Table 2-39 and entry B2a in that table is:


  'A Read Request must not pass a Posted Request unless B2b applies.'

and a posted request is defined as a 'Memory Write Request or a Message
Request'.

???

Dave

> Stefan
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


