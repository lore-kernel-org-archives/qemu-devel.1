Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FD7C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2347020714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tk5cWy8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2347020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1olG-0001O6-A1
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1okH-0000J6-UK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1okF-0001wf-Sl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:55:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1okF-0001w0-GA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581501346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=onN83qc6/Vo06Lz9lSCrSNUC92FVEvKQZ8OGiWJo0xY=;
 b=Tk5cWy8OoqaXvO93IqyWLjHjzxsMQ+XznVEjLYeAsujix2XEFY69ZgfYsVxwo4EO/kQZRw
 N86x6GL5kziuJDBbyisLIVwHihMJvLv4d4eRjKUTA8YBfM0hLgldB6DCwOqCdsR86akR3+
 BACs6smKW4AkgBwHOLWS839jZrKcyxk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-8XMyXpizNdCE1PuNpOOa3A-1; Wed, 12 Feb 2020 04:55:44 -0500
Received: by mail-qt1-f197.google.com with SMTP id k20so899602qtm.11
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 01:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bFNhckmD80QJf6jRDOHI6PRM4MMiU94KSnf7/vGNBgo=;
 b=tXpSwzEmo8tsNoQmz1sLlXhE8+1RB65PtDaAC58QqgpQ48jr4W8TG5Ucis0ErjyoES
 PSM/4EYCaqNsM9A4Rx2Q40ZYb64/MDXQxRQDkb2cSqtSVt8LSG+OnhAbwx26qy52TBBx
 7tUg6zqshDtx9PGZ1/M8JChj4NGym9A3TBGlv/Gfldi+i2j2JdWWlg484E+TkLvrNbyw
 Rlak+6DTQqO992H3qDjcy8WrX7uS250COInvqX35qhyBtgWh5xQIJPg+hHXGdICxbAnx
 hqO9bmISfX9/NPbHI5I+3FmDYChI6B5RasDj3ZUopEBEGw7SOUqqQT8exoEArRLm9R7e
 q7Ug==
X-Gm-Message-State: APjAAAXK8NU5iGWcPg4UQ2F7uz5mj0qjsXDD5o0G5DaL0sW9oZn5oYC3
 s1I4fhgEq7OinxZ4XalSt6JKlpNG5OoxqEcR+99deYrW7hKUXvExIbhzPAlnOnzt3o+KXyBsWff
 Zg4C4uF7PUv9L3To=
X-Received: by 2002:a37:c20c:: with SMTP id i12mr6835438qkm.369.1581501343958; 
 Wed, 12 Feb 2020 01:55:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCGfkRPm08o/LHssSKBU88oQZ98wfqpUmh8XnUJ6AgE1yA5tbBHLFkuTpDWg4gHursBy+Haw==
X-Received: by 2002:a37:c20c:: with SMTP id i12mr6835426qkm.369.1581501343730; 
 Wed, 12 Feb 2020 01:55:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id d206sm3549894qke.66.2020.02.12.01.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 01:55:42 -0800 (PST)
Date: Wed, 12 Feb 2020 04:55:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Message-ID: <20200212045245-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
 <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
 <20200212024158-mutt-send-email-mst@kernel.org>
 <d4eb9cde-5d06-3df9-df28-15378a9c6929@redhat.com>
 <82d99b35-0c64-2eb2-9c23-7af2597b880b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <82d99b35-0c64-2eb2-9c23-7af2597b880b@redhat.com>
X-MC-Unique: 8XMyXpizNdCE1PuNpOOa3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 05:33:06PM +0800, Jason Wang wrote:
>=20
> On 2020/2/12 =E4=B8=8B=E5=8D=884:53, Jason Wang wrote:
> >=20
> > On 2020/2/12 =E4=B8=8B=E5=8D=884:18, Michael S. Tsirkin wrote:
> > > On Wed, Feb 12, 2020 at 11:39:54AM +0800, Jason Wang wrote:
> > > > On 2020/2/11 =E4=B8=8B=E5=8D=887:33, Michael S. Tsirkin wrote:
> > > > > On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
> > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > >=20
> > > > > > The standard virtio-mmio devices use notification register to s=
ignal
> > > > > > backend. This will cause vmexits and slow down the
> > > > > > performance when we
> > > > > > passthrough the virtio-mmio devices to guest virtual machines.
> > > > > > We proposed to update virtio over MMIO spec to add the per-queu=
e
> > > > > > notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the =
VMM to
> > > > > > configure notify location for each queue.
> > > > > >=20
> > > > > > [1]https://lkml.org/lkml/2020/1/21/31
> > > > > >=20
> > > > > > Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
> > > > > > Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
> > > > > > Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
> > > > > > Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> > > > > > Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > > > > Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > > > Hmm. Any way to make this static so we don't need
> > > > > base and multiplier?
> > > > E.g page per vq?
> > > >=20
> > > > Thanks
> > > Problem is, is page size well defined enough?
> > > Are there cases where guest and host page sizes differ?
> > > I suspect there might be.
> >=20
> >=20
> > Right, so it looks better to keep base and multiplier, e.g for vDPA.
> >=20
> >=20
> > >=20
> > > But I also think this whole patch is unproven. Is someone actually
> > > working on QEMU code to support pass-trough of virtio-pci
> > > as virtio-mmio for nested guests? What's the performance
> > > gain like?
> >=20
> >=20
> > I don't know.
> >=20
> > Thanks
>=20
>=20
> Btw, I think there's no need for a nested environment to test. Current
> eventfd hook to MSIX should still work for MMIO.
>=20
> Thanks


Oh yes it's the wildcard thingy but how much extra performance does one get
from it with MMIO? A couple % might not be worth the trouble for MMIO.

--=20
MST


