Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98208C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 05:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648292072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 05:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVpY/plr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648292072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8dH7-00083e-Kr
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 01:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8dGb-0007eY-3p
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 01:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8dGZ-0001LJ-0S
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 01:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597901853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kw/rgdGOX+BlJlch/OP1b4ri5M8HI8eOWZoBY36bkyo=;
 b=eVpY/plr40gw/WBhA/D5HxheBpyc9zARiBaX9wJuwgHC/mcYP8UFk8yKX36zgBonCporzI
 SPTQQ9syxLM1sr5Zo86egCAXZu2K4mLYU88l35Bf7ansXnTGsn17U5ZYSrlERU2+9LcA4w
 Y8eyVMR2h0HxEPW6lAzXlngpyYVESe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-ECRkWCLENqex8YgM16y9dA-1; Thu, 20 Aug 2020 01:37:31 -0400
X-MC-Unique: ECRkWCLENqex8YgM16y9dA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DA5581CAF8;
 Thu, 20 Aug 2020 05:37:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF9B439A55;
 Thu, 20 Aug 2020 05:37:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C5EF9490E; Thu, 20 Aug 2020 07:37:28 +0200 (CEST)
Date: Thu, 20 Aug 2020 07:37:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v5 1/1] audio/jack: fix use after free segfault
Message-ID: <20200820053728.kv7pngxqzp32uky3@sirius.home.kraxel.org>
References: <20200819062940.52774-1-geoff@hostfission.com>
 <20200819062940.52774-2-geoff@hostfission.com>
 <5029913.bOW1W81TKx@silver>
MIME-Version: 1.0
In-Reply-To: <5029913.bOW1W81TKx@silver>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 01:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: Geoffrey McRae <geoff@hostfission.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > +    qemu_bh_cancel(c->shutdown_bh);
> 
> Looks like a potential race. Quote from the API doc of qemu_bh_cancel():
> 
> 	"While cancellation itself is also wait-free and thread-safe, it can of 	
> 	course race with the loop that executes bottom halves unless you are 
> 	holding the iothread mutex.  This makes it mostly useless if you are not 
> 	holding the mutex."

Should not be a problem, all auto backend code should only be called
while qemu holds the iothread mutex.  With the exception of the shutdown
handler which jack might call from signal context (which is why we need
the BH in the first place).

take care,
  Gerd


