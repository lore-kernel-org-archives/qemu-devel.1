Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08EAC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 10:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9B920BED
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 10:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJuvVgQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9B920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT0LS-0002Ds-JM
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT0KR-0001Ky-9U
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 06:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT0KO-0006nA-Tz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 06:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602757061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S9UQ4vRf26w4ZCSfE8N3sbkve8u9lCyT9thRP/mqOTA=;
 b=BJuvVgQ8FmI+o5nNTnh4HRjpyHDpc5MxjJzabvxHnBlaEBlyVRJGIgNee6K3fxscHI5vYc
 wJ3J9UGBAYkA6aAqnGXVO0YWW+9Of6QKYA6LSkEKT5xWVnmkKLTHJu8P1GWDwKSr+D08Ja
 3fuDfS5YRAXdBIG5oThUj3NyWrlMcVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-nE7nLbwOO02FmmSr594H_w-1; Thu, 15 Oct 2020 06:17:38 -0400
X-MC-Unique: nE7nLbwOO02FmmSr594H_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44C7D18A550B;
 Thu, 15 Oct 2020 10:17:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B02085D9D5;
 Thu, 15 Oct 2020 10:17:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8372E16E0A; Thu, 15 Oct 2020 12:17:34 +0200 (CEST)
Date: Thu, 15 Oct 2020 12:17:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paul Zimmerman <pauldzim@gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-dwc2: fix divide-by-zero in
 dwc2_handle_packet()
Message-ID: <20201015101734.2ga5uedh3woefpzx@sirius.home.kraxel.org>
References: <20201012150356.79670-1-mcascell@redhat.com>
 <CADBGO7-w7txnd6MHAY0ge3k3LRcn0FfGDU9znQU7qxQddJQT0A@mail.gmail.com>
 <20201013070423.ahsq7dvpwcsl6ouj@sirius.home.kraxel.org>
 <CADBGO7-BuSh04JctYpQkHoG02cANfet6Zy2fAHVx0gq0cL96jQ@mail.gmail.com>
 <20201013084123.6eihr74ckoburszw@sirius.home.kraxel.org>
 <CAA8xKjX_o5QmXbvjbYkBP8gmO4EOMbESSzWpeAwz9-e1eKmYEg@mail.gmail.com>
 <CADBGO782sqBuszLDcA2PWDR4HujVA76BKDXfWWX_GYXHy2YwqA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADBGO782sqBuszLDcA2PWDR4HujVA76BKDXfWWX_GYXHy2YwqA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
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
Cc: gaoning.pgn@antgroup.com, Mauro Matteo Cascella <mcascell@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, linyi.lxw@antfin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> So I think the patch works fine, and I don't think we need to do
> anything fancier.

Cool, thanks for checking.

take care,
  Gerd


