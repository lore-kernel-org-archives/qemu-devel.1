Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77980C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 425F820719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2mAgY+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425F820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMfm-0000QJ-DG
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHMeh-0008O3-VS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHMeg-0006rb-QJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:10:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHMeg-0006qr-ML
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585206617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5RUarPJKbZshZ1deDsvQsw3/emm1strsu5WgGNqgLc=;
 b=Y2mAgY+TkVhSsDUrlBjdp3X1Y03hvJI2g4WF2h7J6ZMpMzndu647K9FDDOghHETPC7vDRr
 LLrTQqbmVXfhAUb3QMio2M/F6J7J8+soxLp6JaTWtWXlV/5rf0L8r6j8oNsNIDiNiwTpzs
 vNPipNuHdoc9tTwY6AT8qyVRO4rMyKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-MIPoCa13Pg625A1e0Rzngg-1; Thu, 26 Mar 2020 03:10:15 -0400
X-MC-Unique: MIPoCa13Pg625A1e0Rzngg-1
Received: by mail-wr1-f71.google.com with SMTP id f15so2593449wrt.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 00:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H8Cw3DLh+iXs54zjqQfuZxMBQva4d9GTteg9CmCE+Ho=;
 b=fOfo/5BrRrnKB0SzsClhsrjZvIn5uWs9/gsxZMf+bUE5qIpl3SigxibTaRWoy1zG3u
 PGrF4FYcHAS5XP09LtSQJkBTDiqU2VIFf4xhhtbImrMgulcYb9qfJdVPiPohC3eU+VMy
 6de40SWe0KzObm/ExTCrWmuOymEyFCk2N+DmoomR+prqcAQygUmL0eheWiSJmOzuy0BQ
 DLviotMo7HC/BCbzUVejeXmc8kUJhGo6iqAamb5q8z2DjpF+5fs7fcfknlKRqIQiARA7
 maRNO/WGFnG8bOkDE1jqGv2AouPOZhP01I3AE2Rt7dyBuDMjQ/3NkGdn2ETJZxbI6B8q
 ZH6w==
X-Gm-Message-State: ANhLgQ1TlQABEOsTG5zMZqleoIOx7rE+uY3kEVCBGLNAQm/QfYtpLQ9k
 It6rFvedmADg+EB1TXHXGwlYWxc2oPpmIrBYY+ADZkEJFV1jx/Whj/oby1dMMm5x9EJSpXohHpN
 cjcm9wf9V1O2wnmg=
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr7455135wrt.408.1585206614577; 
 Thu, 26 Mar 2020 00:10:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv1gHKjELwCfzDpvvpY8bDWo2p7o6gD/1dLi9S0i1LgXWtQ35bOWK+dgA1kgl5Qn2fUPD9HnQ==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr7455094wrt.408.1585206614278; 
 Thu, 26 Mar 2020 00:10:14 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
 by smtp.gmail.com with ESMTPSA id y16sm2272355wrp.78.2020.03.26.00.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 00:10:13 -0700 (PDT)
Date: Thu, 26 Mar 2020 03:10:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200326030833-mutt-send-email-mst@kernel.org>
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

Well there's still a chance of splitting a big page if one
becomes available meanwhile. But OK.

> --=20
> Thanks,
>=20
> David / dhildenb


