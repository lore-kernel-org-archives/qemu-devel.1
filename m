Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C48CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10D92072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enO0byOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10D92072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7dA9-00014x-3J
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 07:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7d9I-0000V5-Nd
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7d9H-0006RI-0b
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597663074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=du+532pabThjmir/2ufWgC+odfEQv9//dZODgMc4L98=;
 b=enO0byOnZGWMUvN9uzSey+xZreZ+X/IW+jSLt4/5HL6GoYEM2ySZtyNX4nwmZ7o5XXp/Uq
 qgzzm8SmVxTqFUznyDz92s0wDhTOfW+EJQdqQZCpNr7YVCIzb7g1rut+ZMKkPLXiDA+PnG
 5QWBpuOAKIihVwUyiEIF3sfdSuBoa7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-OyszKqJoP4ey1pxAlvqH6w-1; Mon, 17 Aug 2020 07:17:50 -0400
X-MC-Unique: OyszKqJoP4ey1pxAlvqH6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EFFE1DDE6;
 Mon, 17 Aug 2020 11:17:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B3E91992D;
 Mon, 17 Aug 2020 11:17:47 +0000 (UTC)
Date: Mon, 17 Aug 2020 13:17:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 3/7] hw/ide/core: Replace magic '512' value by
 BDRV_SECTOR_SIZE
Message-ID: <20200817111745.GG11402@linux.fritz.box>
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-4-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200814082841.27000-4-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.08.2020 um 10:28 hat Philippe Mathieu-Daudé geschrieben:
> Use self-explicit definitions instead of magic '512' value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

BDRV_SECTOR_SIZE is the arbitrary unit in which some block layer
functions and variables work (such as bs->total_sectors). It happens to
be 512.

IDE disks have a sector size, too. Actually, two of them, a physical and
a logical one. The more important one is the logical one. We happen to
emulate only IDE devices for which the logical block size is 512 bytes
(ide_dev_initfn() errors out otherwise).

But just because two constants both happen to be 512 in practice, they
are not the same thing.

So if we want to replace all magic 512 values, we should probably
introduce a new IDE_SECTOR_SIZE and then decide case by case whether
IDE_SECTOR_SIZE or BDRV_SECTOR_SIZE is meant. I think most (if not all)
of the places you converted in this patch need to be IDE_SECTOR_SIZE.

Kevin


