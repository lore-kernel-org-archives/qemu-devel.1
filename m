Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C250C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEFE2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FO5FkkOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEFE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvOP-0001Cp-8M
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kAvNl-0000K6-QJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:22:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kAvNk-0004d4-6o
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598448146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezmDcJT0Zw6dwqvG4RGoksUm+mitxTD2HAjHCpPoihs=;
 b=FO5FkkOv/JbQISvboHI1HRNHdfvJXGHgRw9VvRFXSsTK5PFiyqY8rrXbAm3Tbn7m5T/d78
 4seFrxwTbQv5yqY5HT45u3Ij5eX98pB0i9MSTqcTbIGdGak+gJeh5NqirWWEUlFkXr9CGL
 WQQgZpGr0RpOqAKnSfMxWnFupJyy0EE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-TFMc_7BvP3C_FShf7mVWjg-1; Wed, 26 Aug 2020 09:22:22 -0400
X-MC-Unique: TFMc_7BvP3C_FShf7mVWjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02E2210ABDBC;
 Wed, 26 Aug 2020 13:22:22 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-67.ams2.redhat.com [10.36.114.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02CAF5D9EF;
 Wed, 26 Aug 2020 13:22:20 +0000 (UTC)
Date: Wed, 26 Aug 2020 15:22:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH v3] block: Raise an error when backing file parameter is
 an empty string
Message-ID: <20200826132219.GD7485@linux.fritz.box>
References: <20200813134722.802180-1-ckuehl@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200813134722.802180-1-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.08.2020 um 15:47 hat Connor Kuehl geschrieben:
> Providing an empty string for the backing file parameter like so:
> 
> 	qemu-img create -f qcow2 -b '' /tmp/foo
> 
> allows the flow of control to reach and subsequently fail an assert
> statement because passing an empty string to
> 
> 	bdrv_get_full_backing_filename_from_filename()
> 
> simply results in NULL being returned without an error being raised.
> 
> To fix this, let's check for an empty string when getting the value from
> the opts list.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Fixes: https://bugzilla.redhat.com/1809553
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>

Thanks, applied to the block branch.

Kevin


