Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC9DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C7420650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaFqQoBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C7420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJW1-0000i0-7s
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCJUz-0000GK-Aj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCJUy-0003FZ-4p
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:47:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59857
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCJUx-0003FJ-Vh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584002843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXPfPIIIQAut8UkWcjgt+9CNPzKPDBbyxrORjLogus4=;
 b=NaFqQoBhQZX1krMfajf1qBOhq/cANC7luMCgXACqIB3li73mHLNBcjYfYT9pa+xS16QEIH
 X49pRid2wgHwOtfkeAxPsnqXbQAIeSsrHW3jYZqJpVAqmsdTHXTI/NwWGpnAwZymz8G2om
 M3kOnggCVWvhSdVwyQd7LGMs7cOmkhs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-YlbIafYGOPCu1NLphVzuzg-1; Thu, 12 Mar 2020 04:47:19 -0400
X-MC-Unique: YlbIafYGOPCu1NLphVzuzg-1
Received: by mail-qt1-f197.google.com with SMTP id d6so3027125qtn.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 01:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CMGY5NDRnQ6tpPW4NbzkE3whOpE1haBikjv6YCfDFio=;
 b=XwxcD90HgX7vHv48pchgSnC2qCNXbK9ztqRg9X70rHK+uF9Eg6AE5jmpiOX7K4K7U7
 PRk7zZ6g+x7pYTaxqfIV0dnFgPIJanQt1ZLXnwkwGgLG3ScTA3XNpIV2i4YZzlPSDAWL
 rNJtTwhwWN12of6XxN/3z8A8IM7tBJN4urYaSCq0x4OaE2F0wFCjj8kv1Tnc7nO0WU38
 /oMg5yDMeJ5gROwF9loboWVqYyxT2TP9ZAChQfhx1tTX84N0fAyy/Ezc3TQWxjukY7DP
 S9dBm7MmYwcaNYo+eTH3HuePBranYhxTljhcPBocomMZDyUnUrvzWpL0L6Le7GBb0Tnu
 A1ug==
X-Gm-Message-State: ANhLgQ3LwItFgVFc+chHUFeQTxEw6bVhGFPmDQkiTmyE+YROdLMn8QMh
 WXSi0I4fsS5HmKRUf+mSuITf2wesjYCQO8SBmGNS8dxgQSKFlEDXmqENyKhQRx6f8+e5A/TNrYu
 MMw9FwTEASn3tjuQ=
X-Received: by 2002:ac8:70d4:: with SMTP id g20mr6375494qtp.146.1584002838848; 
 Thu, 12 Mar 2020 01:47:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsV2vB8jgT9lPTI6/rXChnARxotlD8arZEu0o0XGFcCreqdYk31/Dsq3r3lSxfUv0vOD7Pnvw==
X-Received: by 2002:ac8:70d4:: with SMTP id g20mr6375478qtp.146.1584002838612; 
 Thu, 12 Mar 2020 01:47:18 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id c190sm5213470qkb.80.2020.03.12.01.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 01:47:17 -0700 (PDT)
Date: Thu, 12 Mar 2020 04:47:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200312043859-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> 2. You are essentially stealing THPs in the guest. So the fastest
> mapping (THP in guest and host) is gone. The guest won't be able to make
> use of THP where it previously was able to. I can imagine this implies a
> performance degradation for some workloads. This needs a proper
> performance evaluation.

I think the problem is more with the alloc_pages API.
That gives you exactly the given order, and if there's
a larger chunk available, it will split it up.

But for balloon - I suspect lots of other users,
we do not want to stress the system but if a large
chunk is available anyway, then we could handle
that more optimally by getting it all in one go.


So if we want to address this, IMHO this calls for a new API.
Along the lines of

=09struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
=09=09=09=09=09unsigned int max_order, unsigned int *order)

the idea would then be to return at a number of pages in the given
range.

What do you think? Want to try implementing that?

--=20
MST


