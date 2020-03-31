Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A7B20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHXka+jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A7B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36449 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFIi-0000lK-5v
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJFHE-0005nl-0b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJFHC-00028W-U9
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:41:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJFHC-00027t-Qf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585654910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvwZLJ3US04UxmmWRmWTVnpY8k7b4HfazsLUeNkImHs=;
 b=OHXka+jzKFxMqfAcMmIPLA6sJDsQ8jsOCbRa2W80IbeMhZoDvKWV9Zbd6yJFPm523+8PTK
 9d6MYYRrr9UHR4dAXHTIAHZ/mXjr6+04jXo5r2nvD4sWeG6oN6AZeyRDOFpIu4OcQatvkh
 0I6ul9TBKzc6eIib1xdtX3nwRJxeq10=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-VH70x_yNOSGhfWBF9PARjA-1; Tue, 31 Mar 2020 07:41:48 -0400
X-MC-Unique: VH70x_yNOSGhfWBF9PARjA-1
Received: by mail-wr1-f71.google.com with SMTP id j12so12796013wrr.18
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 04:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AZ64sFb0qcxHlZqy2cG15w4RKWrXYh8Gd6lAq0C4yQ8=;
 b=RI1uqZj1mNCvUYOD9b6EltETh8AWqiQ1I+/HY+jPsjzD/QJZGpnNs7n19mPXgWQOu5
 7SKWgKjZSfwMhzLY1FZwJiQSVcjoWWjM9beMmjGO1fvj8dqGPtYv6oNfNTHGDc7ysQ5q
 DMo2IJLmpuGeAnY/ER870t2nEGz2ztO6GMVtQd7JKS2fLGKsTjzFN8Cv2Uei1I88eQYz
 sIutJX5a85xp3j/vasIvOzGTrpkH6oeTooKJyUjCflkloxnocgWR6EnKE6Twvapq0ZMw
 P+5v+KwssTOQvj9rV3vWosgsIFWy2jeLBiQ92gTj+AF5yBnDuemhZPPBWC0KpUeW5NKz
 c3ng==
X-Gm-Message-State: ANhLgQ2qXMydVvjHc6AKAT+FylEorC94GNf6kTN6zXKLGLftt3llIqJT
 vlYYSNf4aNxroiBzyn5KcQtkBbh6cDXOHNjcs5O5FdWlm1sBY9TxscWMMXXJdzw9D+ACCMyDXwN
 3lzVfTNzdAxY7dx4=
X-Received: by 2002:a1c:a982:: with SMTP id s124mr3197933wme.105.1585654907359; 
 Tue, 31 Mar 2020 04:41:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtrUbxZkn9lybYPcpYKPiRTp6kNAJ4F3nj0vYcajBinFkAfgk0sidKss5bbcl5lNLZ4DYryhw==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr3197927wme.105.1585654907203; 
 Tue, 31 Mar 2020 04:41:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id v129sm3549381wmg.1.2020.03.31.04.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 04:41:46 -0700 (PDT)
Date: Tue, 31 Mar 2020 07:41:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] fix vhost_user_blk_watch crash
Message-ID: <20200331074133-mutt-send-email-mst@kernel.org>
References: <20200323052924.29286-1-fengli@smartx.com>
 <20200329084911-mutt-send-email-mst@kernel.org>
 <20200325222930.GA14456@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200325222930.GA14456@localhost.localdomain>
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 06:30:08PM -0400, Raphael Norwitz wrote:
> On Sun, Mar 29, 2020 at 09:30:24AM -0400, Michael S. Tsirkin wrote:
> >=20
> > On Mon, Mar 23, 2020 at 01:29:24PM +0800, Li Feng wrote:
> > > the G_IO_HUP is watched in tcp_chr_connect, and the callback
> > > vhost_user_blk_watch is not needed, because tcp_chr_hup is registered=
 as
> > > callback. And it will close the tcp link.
> > >=20
> > > Signed-off-by: Li Feng <fengli@smartx.com>
> >=20
> > Raphael would you like to review this?
>=20
> Sure - I'll review it now.
>=20
> > Also, I think at this point
> > nutanix is the biggest contributor to vhost user blk.
> > So if you want to be added to MAINTAINERS on this
> > one so people Cc you on patcches, that'd be great.
> >=20
>=20
> Yes, please add me to MAINTAINERS.

Great, pls send a patch.

> =20


