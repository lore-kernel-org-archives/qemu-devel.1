Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08FFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B7020786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STVKbYfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B7020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIr4-00054G-JE
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIot-0002Li-MJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIor-0002tw-2X
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:28:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIoq-0002tP-Mp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585668527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgEAaNiN99kgGwxTOLnUsdZ99w6D7FBMccPhHQIOkoc=;
 b=STVKbYfAYudyxIgiWxgZnR3rqsgxCStG3L0yzdH289A6k121EedxBelpZMokgdTZ47nCTm
 nrSiRHaFs6T1M15aHgRJFIICsk22xxRDmspo9PMe2HOUQQzWAA09vLANcSO2wl/GIOZMmZ
 IY7nFuXIW94IbXkKIGaPJqPQTigwb1E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-d-HlF942M42Ec8k73u2_6w-1; Tue, 31 Mar 2020 11:28:46 -0400
X-MC-Unique: d-HlF942M42Ec8k73u2_6w-1
Received: by mail-wr1-f69.google.com with SMTP id i18so13051198wrx.17
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wbjZ/8kYKp7eRMJMyV+34cf5N5B3hMsmVB1uhWILGRg=;
 b=LaSzCEUvzXZpBRrCcNSxapAWmOGXdwGtWnJwWwW9snw4uZCWw57L12ByCci7ZJclg4
 A9deMxuDUOOxUsz89Ft9GAw9z00NYZ1HK3ZItzs1qLDjmYpTvceAgDV66w44pt8Rw5KN
 AbsEqUTMdoc1g1hK457kr3Vcs4sCnaOrJgOk91gsZEdwTLeHkFfOrEtUnllK1wdY/ErU
 0xQozX9nAmeuhCcz/W5Ix6oyOSgPtY4ysK06CDUEgY0ZIjmw4XdJ8zaT2wXeQk2/V/yK
 S8epac8fHwcIMYZmA3qw0xdKVBt4qMYPilfFDi4jjZ3AE8sEvIY0K9DKGdECFdIDurzG
 7bfQ==
X-Gm-Message-State: ANhLgQ1V8gq4YXHzcwuFxtKOEI/StCoKMM0QppRC8zxsMkvND5sxtk48
 EdxJeKLHx4Iipggybfp5ypXpXkdAw6P/U2BpIpSMgatV3iH5Lv9zXeDfpMlS/pewGreUSgW8xWs
 bC19PVTsCzZNqc1I=
X-Received: by 2002:a1c:c246:: with SMTP id s67mr4069856wmf.160.1585668525085; 
 Tue, 31 Mar 2020 08:28:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuMBsfYL4fBH/dyfa7LMsqKN06EtOubW3BDQDDF16qT0lG1gYEHk80ZPDmqIeS9K1EOzGhzsw==
X-Received: by 2002:a1c:c246:: with SMTP id s67mr4069822wmf.160.1585668524863; 
 Tue, 31 Mar 2020 08:28:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id w7sm26825926wrr.60.2020.03.31.08.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 08:28:44 -0700 (PDT)
Date: Tue, 31 Mar 2020 11:28:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200331112730-mutt-send-email-mst@kernel.org>
References: <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
 <20200331101117-mutt-send-email-mst@kernel.org>
 <118bc13b-76b2-f5a1-6aca-65bd10a22f6c@redhat.com>
 <00dc8bad-05e5-6085-525c-ce9fded672cc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <00dc8bad-05e5-6085-525c-ce9fded672cc@redhat.com>
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
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 04:34:48PM +0200, David Hildenbrand wrote:
> On 31.03.20 16:29, David Hildenbrand wrote:
> > On 31.03.20 16:18, Michael S. Tsirkin wrote:
> >> On Tue, Mar 31, 2020 at 04:09:59PM +0200, David Hildenbrand wrote:
> >>
> >> ...
> >>
> >>>>>>>>>>>>>> So if we want to address this, IMHO this calls for a new A=
PI.
> >>>>>>>>>>>>>> Along the lines of
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int m=
in_order,
> >>>>>>>>>>>>>>                    unsigned int max_order, unsigned int *o=
rder)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> the idea would then be to return at a number of pages in t=
he given
> >>>>>>>>>>>>>> range.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> What do you think? Want to try implementing that?
> >>
> >> ..
> >>
> >>> I expect the whole "steal huge pages from your guest" to be problemat=
ic,
> >>> as I already mentioned to Alex. This needs a performance evaluation.
> >>>
> >>> This all smells like a lot of workload dependent fine-tuning. :)
> >>
> >>
> >> So that's why I proposed the API above.
> >>
> >> The idea is that *if we are allocating a huge page anyway*,
> >> rather than break it up let's send it whole to the device.
> >> If we have smaller pages, return smaller pages.
> >>
> >=20
> > Sorry, I still fail to see why you cannot do that with my version of
> > balloon_pages_alloc(). But maybe I haven't understood the magic you
> > expect to happen in alloc_page_range() :)
> >=20
> > It's just going via a different inflate queue once we have that page, a=
s
> > I stated in front of my draft patch "but with an
> > optimized reporting interface".
> >=20
> >> That seems like it would always be an improvement, whatever the
> >> workload.
> >>
> >=20
> > Don't think so. Assume there are plenty of 4k pages lying around. It
> > might actually be *bad* for guest performance if you take a huge page
> > instead of all the leftover 4k pages that cannot be merged. Only at the
> > point where you would want to break a bigger page up and report it in
> > pieces, where it would definitely make no difference.
>=20
> I just understood what you mean :) and now it makes sense - it avoids
> exactly that. Basically
>=20
> 1. Try to allocate order-0. No split necessary? return the page
> 2. Try to allocate order-1. No split necessary? return the page
> ...
>=20
> up to MAX_ORDER - 1.
>=20
> Yeah, I guess this will need a new kernel API.

Exactly what I meant. And whever we fail and block for reclaim, we
restart this.

>=20
> --=20
> Thanks,
>=20
> David / dhildenb


