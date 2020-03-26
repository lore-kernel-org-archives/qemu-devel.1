Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE77C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6786A20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTYuZu8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6786A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMq4-0004nu-Ke
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHMpR-0004Eh-H9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHMpP-0006a3-ET
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:21:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHMpP-0006Zb-AJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585207283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eST+TwOPCy/uw3BDo6fMjzERPTTwo+a6tBhI87ptxQ=;
 b=NTYuZu8mqKpBJSTDll6h530Ba60qJ3exHb7WPvExqEngHQASn8PfGzZSONp4Md6r9VgThb
 J8PkRDXl7lLakBo4/I3wMa3GG31ovLWObUK9g1GDltrEICmVazVZ9rKZBJN74KV/wYIK5w
 DeOK744TsN+ehaleefbtVlvOXf3OdBY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-mv393q-9NWWA8KZh8X5zgw-1; Thu, 26 Mar 2020 03:20:39 -0400
X-MC-Unique: mv393q-9NWWA8KZh8X5zgw-1
Received: by mail-wr1-f72.google.com with SMTP id o9so2589875wrw.14
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 00:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4XWknPyKkYAfbqizFNt1Gd0mfkxXVUcGvQWw0e8F7fs=;
 b=kZm9dbXLQjaBvuEC+SYNuRq/eZiarr8/kgHwl3D5vrSbfEGbV1T6sTkIZQmc8I4blS
 CBqhTaVEHp2b8iqIQLqOpaXk7oQtdplAohkN+mKtdp61FKSQ7AwipbgtQunVqJ3By4Id
 Ez72Vc1TcMc6k9Tc1oX2B4h4vhzlyG4LpBdExDQGZJtIE8VAMzh0Jzkp4VGr0iX7h5K4
 WE07nBcnuW/NqRa/DQxxWzf0CAosLKKq16xLqnXAghYwl5IQLaBsuOEEyWKIi1osylPO
 zlTI45VuD6QMz0yuAMcISxtxw8Ufz+kDN8GbsdxMpyftQzm//x5dyXHr9vFzmTMkWkGt
 ebWQ==
X-Gm-Message-State: ANhLgQ3y2KCeJszOcEuK4tp50LXurFzEpcikajDVSJBVlMCFFb13ddBt
 OX+jPdfiHvbtd6CLRDJPgsSl4POI1WSqZsZNev7tb4NcIMh4cfEegt91N6ENrN0LsfRjB5HV5bB
 RJTlyHAIRZn/OsLc=
X-Received: by 2002:adf:a348:: with SMTP id d8mr7659497wrb.83.1585207238151;
 Thu, 26 Mar 2020 00:20:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vulLKViL6lz98C0rMEOGStoYAVS4PIbCmp8QYl/VaQLfO8diHChBT/rYUPUuQ2COQGUsrv+DA==
X-Received: by 2002:adf:a348:: with SMTP id d8mr7659463wrb.83.1585207237880;
 Thu, 26 Mar 2020 00:20:37 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
 by smtp.gmail.com with ESMTPSA id r3sm2300372wrm.35.2020.03.26.00.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 00:20:37 -0700 (PDT)
Date: Thu, 26 Mar 2020 03:20:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200326031817-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
 <20200312043859-mutt-send-email-mst@kernel.org>
 <45756694-560d-0276-d39e-cc2fd1c4e3a7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <45756694-560d-0276-d39e-cc2fd1c4e3a7@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote:
> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> > On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >> 2. You are essentially stealing THPs in the guest. So the fastest
> >> mapping (THP in guest and host) is gone. The guest won't be able to ma=
ke
> >> use of THP where it previously was able to. I can imagine this implies=
 a
> >> performance degradation for some workloads. This needs a proper
> >> performance evaluation.
> >=20
> > I think the problem is more with the alloc_pages API.
> > That gives you exactly the given order, and if there's
> > a larger chunk available, it will split it up.
> >=20
> > But for balloon - I suspect lots of other users,
> > we do not want to stress the system but if a large
> > chunk is available anyway, then we could handle
> > that more optimally by getting it all in one go.
> >=20
> >=20
> > So if we want to address this, IMHO this calls for a new API.
> > Along the lines of
> >=20
> > =09struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> > =09=09=09=09=09unsigned int max_order, unsigned int *order)
> >=20
> > the idea would then be to return at a number of pages in the given
> > range.
> >=20
> > What do you think? Want to try implementing that?
>=20
> You can just start with the highest order and decrement the order until
> your allocation succeeds using alloc_pages(), which would be enough for
> a first version. At least I don't see the immediate need for a new
> kernel API.

OK I remember now.  The problem is with reclaim. Unless reclaim is
completely disabled, any of these calls can sleep. After it wakes up,
we would like to get the larger order that has become available
meanwhile.


> --=20
> Thanks,
>=20
> David / dhildenb


