Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 10:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2816720BED
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 10:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/7QpIb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2816720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT0NN-0003ic-5Z
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 06:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT0MT-00039d-2I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 06:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT0MR-00071e-CG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 06:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602757190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRUANYY/ZuAVMASf6Ie99AK/DB8ViqWA775ifCoqBJw=;
 b=S/7QpIb4s+khue9rIY0A53uXrvOGR/VdjaEDUR553XD31OiGggEK8f3ddyUaTBVZdD5dYn
 S/ScWehBeCnSFS7u1Jkdd2ySN4WG/9cCR4c5SeXMxbSd3bUbialIZRfCe9CEWAIAoHsTB7
 XH4QYG4HIdIla/DFxSC9VcAZwbGMoeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-HyLKvf_gMuCxdAlhcCugIg-1; Thu, 15 Oct 2020 06:19:48 -0400
X-MC-Unique: HyLKvf_gMuCxdAlhcCugIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA55802B61;
 Thu, 15 Oct 2020 10:19:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC658610F3;
 Thu, 15 Oct 2020 10:19:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1710A16E0A; Thu, 15 Oct 2020 12:19:45 +0200 (CEST)
Date: Thu, 15 Oct 2020 12:19:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [PATCH v2] hw/usb/hcd-dwc2: fix divide-by-zero in
 dwc2_handle_packet()
Message-ID: <20201015101945.xm7lwbinfaljnwuv@sirius.home.kraxel.org>
References: <20201015075957.268823-1-mcascell@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201015075957.268823-1-mcascell@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: gaoning.pgn@antgroup.com, linyi.lxw@antfin.com, qemu-devel@nongnu.org,
 pauldzim@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 09:59:57AM +0200, Mauro Matteo Cascella wrote:
> Check the value of mps to avoid potential divide-by-zero later in the function.
> Since HCCHAR_MPS is guest controllable, this prevents a malicious/buggy guest
> from crashing the QEMU process on the host.
> 
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>
> Reported-by: Gaoning Pan <gaoning.pgn@antgroup.com>
> Reported-by: Xingwei Lin <linyi.lxw@antfin.com>
> ---
> Moved check earlier in the function and added "Reviewed-by" line.

Added to usb queue.

thanks,
  Gerd


