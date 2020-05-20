Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ADDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ABA2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoUpncMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ABA2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKXH-0008A2-Un
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKWc-0006bz-2q
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:56:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKWa-000167-NC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m+yQ8DFlzcs8/vJZk7FsEa32wJsi4ogkn6zv0QlGG9U=;
 b=IoUpncMvxWZPj5j/JHqPq00MtHRdHhfeSUSjo5x70VYvA/UsQHC8Mljpvl9xypVp8NcdkI
 VGYvetz/3e7F62CAyesi+EaduwQVwXSxbtUkgvnlO/HG38T/4apRpcw3vsXTa9PLXJM0ub
 72JMT5sEI1CX57RB2EvXJAvuCxcGjlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-HV80_dChPtOUHmDsyPpvYA-1; Wed, 20 May 2020 04:56:23 -0400
X-MC-Unique: HV80_dChPtOUHmDsyPpvYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6809319200C0;
 Wed, 20 May 2020 08:56:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27FD81057051;
 Wed, 20 May 2020 08:56:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 58D1E17444; Wed, 20 May 2020 10:56:21 +0200 (CEST)
Date: Wed, 20 May 2020 10:56:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] es1370: check total frame count against current frame
Message-ID: <20200520085621.ok2qmf3sbwlmjk7i@sirius.home.kraxel.org>
References: <20200514200608.1744203-1-ppandit@redhat.com>
 <nycvar.YSQ.7.77.849.2005200005050.62159@xnncv>
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.77.849.2005200005050.62159@xnncv>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
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
Cc: Ren Ding <rding@gatech.edu>, QEMU Developers <qemu-devel@nongnu.org>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 12:05:48AM +0530, P J P wrote:
> +-- On Fri, 15 May 2020, P J P wrote --+
> | From: Prasad J Pandit <pjp@fedoraproject.org>
> | 
> | A guest user may set channel frame count via es1370_write()
> | such that, in es1370_transfer_audio(), total frame count
> | 'size' is lesser than the number of frames that are processed
> | 'cnt'.
> | 
> |     int cnt = d->frame_cnt >> 16;
> |     int size = d->frame_cnt & 0xffff;
> | 
> | if (size < cnt), it results in incorrect calculations leading
> | to OOB access issue(s). Add check to avoid it.
> | 
> 
> Ping...!

Added to audio patch queue.

(there isn't much activity in audio, thats why the mail was sitting in
my mailbox waiting for me process it ...)

thanks,
  Gerd


