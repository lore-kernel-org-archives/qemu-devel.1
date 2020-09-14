Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B427C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E79217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9aOLdP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E79217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHj8l-0006Vr-JT
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kHj88-0005mq-AI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kHj86-00055w-NT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600069344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/ve+X+wl4KH7BnrqeQeAzUFQxL2hnOTat/2iip9Xyg=;
 b=B9aOLdP0sruf2/OL+g11KfstZDN4aiXhx6nChLBUP12zp69Boc+NlxQA4GojWyAMIIByJU
 gwvTU77scxOa5UnAm7aic+rcISqPGqZ0ipycP2AQJ2kVnK8y+HrQY3Yzwe9E5G/9gpp9RQ
 dCcEAfMnMYoB6sCeIdws5cRct+ftkDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-3JpwoGVnO3-51m5-UFjziQ-1; Mon, 14 Sep 2020 03:42:23 -0400
X-MC-Unique: 3JpwoGVnO3-51m5-UFjziQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28CA51005E77;
 Mon, 14 Sep 2020 07:42:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C84915E1DC;
 Mon, 14 Sep 2020 07:42:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9630531E63; Mon, 14 Sep 2020 09:42:20 +0200 (CEST)
Date: Mon, 14 Sep 2020 09:42:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: Does. there exists race condition in virtio-gpu device
Message-ID: <20200914074220.tiaridgcha3j2okz@sirius.home.kraxel.org>
References: <CAKXe6SJWAt8U-UmCqgtMwt-moL6MAtV5BpBiaM=BN92mQN0Z2g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJWAt8U-UmCqgtMwt-moL6MAtV5BpBiaM=BN92mQN0Z2g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 08:49:25PM +0800, Li Qiang wrote:
> Hello Gerd and Paolo,
> 
> I think there is a race condition in virtio-gpu device.
> In 'virtio_gpu_reset' and 'virtio_gpu_process_cmdq' they both operate
> on 'g->cmdq'.
> 
> However the 'virtio_gpu_reset' is in vcpu thread and the
> 'virtio_gpu_process_cmdq' is
> in main thread through BH.
> 
> So I think there is a race condition. But I don't find a pattern for
> this kind of bug(BH and vcpu thread). I missed anything?

There is a global lock for that (vcpu threads grab it before calling io
handlers), so devices typically don't have to worry about that kind of
race patterns.

HTH,
  Gerd


