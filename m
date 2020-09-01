Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E27C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B956206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH4lXg39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B956206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7J0-00078o-ME
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kD6zX-000618-2F
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kD6zV-0003zF-6L
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598969427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFd7OZfcsuvuGEyiKcB4OxeO7oTue9CfechDZ/tUmUY=;
 b=IH4lXg39p58qL7ccVHt9fdgDBBc6CaQ3jDHctwECeiJlOiLAxnSO88WRls8fsSRDNU6nA2
 63K9YsGuGFdig2uK64AasAlFHW5MU9bcGBAGXTST7A3aPn9iC7J+q//xZqKc/VcL0i0Low
 Ua46tuPbI5ieTAc8Oj90oEnUTd6gk/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-iouppgFXPCOsaN3PTCspOw-1; Tue, 01 Sep 2020 10:10:25 -0400
X-MC-Unique: iouppgFXPCOsaN3PTCspOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D07980EF9C;
 Tue,  1 Sep 2020 14:10:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E6B45C1A3;
 Tue,  1 Sep 2020 14:10:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F25D217447; Tue,  1 Sep 2020 16:10:22 +0200 (CEST)
Date: Tue, 1 Sep 2020 16:10:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] cirrus: handle wraparound in cirrus_invalidate_region
Message-ID: <20200901141022.eum6rpcferl3enrm@sirius.home.kraxel.org>
References: <20200821082622.7169-1-kraxel@redhat.com>
 <CAKXe6SKZuuCnzAF2uwHO=sh=o2XdAU1+dG6OO-eLYnubX9KikA@mail.gmail.com>
 <20200831112322.rkzv6acsw7iza6w7@sirius.home.kraxel.org>
 <CAKXe6SJLxQacG_TmSBZPCkDyz24FADqNc4R+hs4z1PxzsSjexQ@mail.gmail.com>
 <20200901051530.hjdugb7c5r22n3ui@sirius.home.kraxel.org>
 <CAKXe6SLOP9WPYoPP-Rf+RvwVk26J9siNod=CgkBj8dW0rMD25Q@mail.gmail.com>
 <20200901071628.kp6xgkl7725ghyh3@sirius.home.kraxel.org>
 <CAKXe6SJgfTcFD=9AaYUoTc0_GN_L-49zUbFsQ8UNQQ8wP7D3Eg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJgfTcFD=9AaYUoTc0_GN_L-49zUbFsQ8UNQQ8wP7D3Eg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 03:37:17PM +0800, Li Qiang wrote:
> Gerd Hoffmann <kraxel@redhat.com> 于2020年9月1日周二 下午3:16写道：
> >
> >   Hi,
> >
> > > +            /* wraparound */
> > > +            memory_region_set_dirty(&s->vga.vram, off_cur,
> > > s->cirrus_addr_mask - off_cur);
> >
> > > So the len is 's->cirrus_addr_mask->off_cur+1'.
> >
> > Correct.
> 
> So do you agree me the first set size should be 's->cirrus_addr_mask -
> off_cur+1'?

Yes.

> > The +1 balances the -1 done before ...
> 
> Then the second set size is ok.

Ok, good.  v2 sent now.

thanks,
  Gerd


