Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DAC43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE1820874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrCPKGC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE1820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGf9-0003Kv-L2
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKGdm-0002fe-Rf
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKGdl-0005Jb-5i
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600674816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7pvsr0p+GdI1eIJor1CVUSzcNqIaExaURsxYxBq86i0=;
 b=NrCPKGC6VuasiFLTTNQJk1VocbJNUtaImZ/YC3Wm+v2ON3wrOIYIw5eDYUqg9ECrWfrlna
 hBEH4OuzCVy4aVZre1pDAQJIDvFHJtcAkqe7dVz7Xb9MBu5c3VYvg6ShFOto3jqowVFeJM
 qHTO8nqGAC3B3h4Ga9+bwrT6/r8cpr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-2jYNslnMMWaEqPjitt_-MA-1; Mon, 21 Sep 2020 03:53:32 -0400
X-MC-Unique: 2jYNslnMMWaEqPjitt_-MA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E659E8015FA;
 Mon, 21 Sep 2020 07:53:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4269A60C11;
 Mon, 21 Sep 2020 07:53:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 23C0816E0A; Mon, 21 Sep 2020 09:53:28 +0200 (CEST)
Date: Mon, 21 Sep 2020 09:53:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] hw: usb: hcd-ohci: fix oob access and loop issues
Message-ID: <20200921075328.zumquffvf3ojnjes@sirius.home.kraxel.org>
References: <20200915182259.68522-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200915182259.68522-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Yi Ren <yunye.ry@alibaba-inc.com>,
 Yongkang Jia <j_kangel@163.com>, Gaoning Pan <pgn@zju.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 11:52:57PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Hello,
> 
> * While servicing transfer descriptors(TD) in ohci_service[_iso]_td
>   routines, it may lead to out-of-bounds access and/or infinite loop
>   issues, as the OHCI controller driver may supply malicious values
>   to derive frame_number, start_addr, end_addr etc. variables.
> 
> * This series breaks earlier single patch into two.
>   One for an out-of-bounds access issue and another to fix infinite
>   loop case.
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg05145.html

Added to usb patch queue.

thanks,
  Gerd


