Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF61C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4ABE2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDK9H/Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ABE2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdSaa-0000ND-37
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 01:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdSZc-0007ws-1j
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:56:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60504
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdSZX-000686-TO
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590472578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKQ1AhTKOyEeSLNsfNo1edWWeduY23gX4OZwXMzCCUc=;
 b=fDK9H/HprDfNOYeCJQOwYnAH0Q0y71kzA6oQePXWw9Bf34sxjq9qghoSBPDyAqL96Tijfj
 Eto+v2Q3fD/8lBBRYVAZpV6WAuHNq0Gl/zqSXVFteW1bHl6eQXAZcQd/kAdGZaJk8T3rfE
 ZJgGEXSo5Ii2mtUINhBOdS/7ZCc9MYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-I0pfnrkqNKKKfIYJuegnPA-1; Tue, 26 May 2020 01:56:13 -0400
X-MC-Unique: I0pfnrkqNKKKfIYJuegnPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9EEB1800D42;
 Tue, 26 May 2020 05:56:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1F419D7C;
 Tue, 26 May 2020 05:56:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 52A381753B; Tue, 26 May 2020 07:56:11 +0200 (CEST)
Date: Tue, 26 May 2020 07:56:11 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] audio: fix wavcapture segfault
Message-ID: <20200526055611.bqazfxqjxusrmwca@sirius.home.kraxel.org>
References: <20200521172931.121903-1-brogers@suse.com>
MIME-Version: 1.0
In-Reply-To: <20200521172931.121903-1-brogers@suse.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 11:29:31AM -0600, Bruce Rogers wrote:
> Commit 571a8c522e caused the HMP wavcapture command to segfault when
> processing audio data in audio_pcm_sw_write(), where a NULL
> sw->hw->pcm_ops is dereferenced. This fix checks that the pointer is
> valid before dereferincing it. A similar fix is also made in the
> parallel function audio_pcm_sw_read().
> 
> Fixes: 571a8c522e (audio: split ctl_* functions into enable_* and
> volume_*)
> Signed-off-by: Bruce Rogers <brogers@suse.com>

Added to audio queue.

thanks,
  Gerd


