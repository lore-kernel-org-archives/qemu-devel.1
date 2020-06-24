Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F6D20823
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmMpeaAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F6D20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1yB-0002iG-V9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 05:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jo1w2-0001eh-HS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:43:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jo1w0-0001iq-3M
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592991790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oPKbC1YA93Av+yiE5U+CayMGhagkk3KG4JGWnQE6Qg=;
 b=SmMpeaAUzoFXOH4YXNOI7dqEdHA9k8FEXxaUKUMH3XcLdFMehY/wbcdUwPqEnqRSZG78e9
 UoLqE5Z7BdPYFuVNKh+Bsg2DizyqeMyjsVC/YfLyCvuqbqKRBVnE5L7MYLANs4nIXaYwC6
 q8SjFYmJFFIR+E65M1FZGRWTzr7LJyU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-FQdaVuVjNcCMzwd301cHOA-1; Wed, 24 Jun 2020 05:43:09 -0400
X-MC-Unique: FQdaVuVjNcCMzwd301cHOA-1
Received: by mail-pj1-f72.google.com with SMTP id l62so1083002pje.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 02:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4oPKbC1YA93Av+yiE5U+CayMGhagkk3KG4JGWnQE6Qg=;
 b=nyQW5Sm+92f/3ycj4gfsc7JGQViIypMUnNpyjP8UOIWzTVq1WOrAdpCnRZ4KSYoAN9
 jXNw7eXcK0VV3n17xzdsO7TvKkHKkmUD/k41sVrJnd6GQPGskpmzwZ0uePNvvvxsdqag
 kZXsSK6I9w+oFCSqxtpjBEO8CSA11qFbZtfwwpfW/4TA0tUVX/lUhkHl7C6Mg0UCbcC8
 Yz5Gf9W2dFpEF076nNhqFH4NfdIKDLhGf/MpMLW+WKVSntuFkURvCM0G2qiEA5JOLqRB
 c3YArodelRPVUEuu1LLPymevyrZqIZJqHTd0FXcVOhlXPhJEbfr7Kcyyg/qDpOkX010w
 GFYg==
X-Gm-Message-State: AOAM531LqlWo+CEOMRErCT9+XGSzecWqLvBcZw7BlJtM8pRpEqVY2SK3
 ZwAzRVc6xbm8buUz2amUCw8Z9HNCW6R6HAmpDYQjSRrGf5W9hif+E6PjYY2DKYIdR1w61hcUlO1
 2Wbu9RKSwQ2Bovr2m2/yyOd0pQIJiJAQ=
X-Received: by 2002:a62:5c02:: with SMTP id q2mr73886pfb.232.1592991788049;
 Wed, 24 Jun 2020 02:43:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcOl//OR/q5vt00qNKNv+CdAqEa3M1lrA/no5ZNebJST37uxXKAuuWykqGnNwaI5LlxaXBzRPK0PtjS+MAgDU=
X-Received: by 2002:a62:5c02:: with SMTP id q2mr73853pfb.232.1592991787728;
 Wed, 24 Jun 2020 02:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <877dvy45vr.fsf@dusky.pond.sub.org>
 <CACLfguWUoV7Ngt0U3Rdenvyp1s0PcWk2xsJirYGvHR3KSmZoeA@mail.gmail.com>
 <c8929663-27f2-93d6-e7b5-a3dc269fa7d2@redhat.com>
In-Reply-To: <c8929663-27f2-93d6-e7b5-a3dc269fa7d2@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jun 2020 17:42:56 +0800
Message-ID: <CACLfguW04Lz8jbe+HOPMk7V46A91USc7eo+XdP+3BX+OeOFzDA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] vDPA support in qemu
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, hanand@xilinx.com,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 5:43 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/23 =E4=B8=8B=E5=8D=885:16, Cindy Lu wrote:
> > On Tue, Jun 23, 2020 at 3:07 PM Markus Armbruster <armbru@redhat.com> w=
rote:
> >> Cindy Lu <lulu@redhat.com> writes:
> >>
> >>> vDPA device is a device that uses a datapath which complies with the
> >>> virtio specifications with vendor specific control path. vDPA devices
> >>> can be both physically located on the hardware or emulated by softwar=
e.
> >>> This RFC introduce the vDPA support in qemu
> >>> TODO
> >>> 1) vIOMMU support
> >>> 2) live migration support
> >> This gives me the foggiest of ideas on what vDPA is.  Could we use
> >> docs/interop/vhost-vdpa.rst?
> >>
> > Sure will add this
> >
> >
>
> Not sure it's the best place since vhost-vdpa is kernel specific.
>
> Maybe kernel docs (TBD) is a better place and we can refer it this file
> in the future.
>
> But it doesn't harm if you said something more here and refer the kernel
> commit here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D4c8cf31885f69e86be0b5b9e6677a26797365e1d
>
> Thanks
>
>
Hi Markus,
I think I agree with Jason's opinion, kernel docs is a better place.
Maybe we can keep what it is now, and do this job in the future.

Thanks
Cindy


