Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6316FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 20:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC5D20719
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wcyn246g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC5D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb8UF-0001Ja-9s
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 15:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kb8Su-0000p6-I3
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 15:36:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kb8Ss-0003y3-CI
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 15:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604694964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTZGvFgMinVN6ECVKNldPNC1WHdpZNXG6Rq4h+n4HGc=;
 b=Wcyn246gGT5FPECPORpffsZHdOJ7KA69yCTFPwpYsA7h/gDyV/NdIUnY+9uLu6HrmAOSdw
 IZlud3uOZQKv72bDOv5R4PdEt0QVY5pAN2asG3C5xTXifdCruyUL8QxfLeiRShmGZDPNAt
 sqqw2Rwq+9EYtED1x0XbYOXMuqtxFCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-m19i8tQ2M4Oc6lah8JSaAQ-1; Fri, 06 Nov 2020 15:36:00 -0500
X-MC-Unique: m19i8tQ2M4Oc6lah8JSaAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C2F805EFC;
 Fri,  6 Nov 2020 20:35:59 +0000 (UTC)
Received: from [10.3.114.103] (ovpn-114-103.phx2.redhat.com [10.3.114.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72D695D9CA;
 Fri,  6 Nov 2020 20:35:59 +0000 (UTC)
Subject: Re: nbd: bitmap_to_extents() calls nbd_extent_array_add() without
 checking return value: coverity false positive?
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <CAFEAcA8keTZEW3MLky3_HKh5cu2HR1O0iBax2c0hs0qSosNYSw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9ff386a7-c334-30ed-da79-341d75ed39b2@redhat.com>
Date: Fri, 6 Nov 2020 14:35:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8keTZEW3MLky3_HKh5cu2HR1O0iBax2c0hs0qSosNYSw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 11:22 AM, Peter Maydell wrote:
> Hi; Coverity's "you usually check the return value of this function
> but you didn't do that here" heuristic has fired on the code in
> nbd/server.c:bitmap_to_extents() -- the function nbd_extent_array_add()
> is called five times in server.c, and the return value is checked
> in four of those, but not in the final call at the end of
> bitmap_to_extents(). (CID 1436125.)
> 
> Is this a false positive, or should the caller be handling an
> error here ?

False positive, but I don't mind tweaking the code to silence Coverity.
This should do it; let me know if I should turn it into a formal patch.

diff --git i/nbd/server.c w/nbd/server.c
index d145e1a69083..377698a2ce85 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -2128,9 +2128,8 @@ static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
         }
     }

-    if (!full) {
-        /* last non dirty extent */
-        nbd_extent_array_add(es, end - start, 0);
+    if (!full && nbd_extent_array_add(es, end - start, 0) < 0) {
+        /* last non dirty extent, not a problem if array is now full */
     }

     bdrv_dirty_bitmap_unlock(bitmap);


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


