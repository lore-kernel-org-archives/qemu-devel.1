Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617A6C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A1822284
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRP+o8Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A1822284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMLN-0004Ql-IV
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXMJ6-0002mz-9s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXMJ4-0004qM-Ex
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603794861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDMXLsU2pYUn/y+TlmrEZHPd7PcODN16khUC8oRt8wI=;
 b=VRP+o8GwybtZcd6KJo8ClrnJsP7aI3tZthReMyvC8QwfVHcrnjvtV4qhRSfHRFBESnM+zQ
 S1cWQkLpMlDIt+A5Itd0XXJJzxe3j5w51l2fS/7NrIVQDH3NuVzQqjILVoJl4rZFmEgRcJ
 o+dr7BJwWXSmkWveKqzte0B28XnETwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-yIba5a3VPXOm9SpR2TUXTQ-1; Tue, 27 Oct 2020 06:34:19 -0400
X-MC-Unique: yIba5a3VPXOm9SpR2TUXTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4A491016CE2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 10:34:18 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FC205B4B1;
 Tue, 27 Oct 2020 10:34:08 +0000 (UTC)
Date: Tue, 27 Oct 2020 11:34:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH 1/3] coroutine: let CoQueue wake up outside a coroutine
Message-ID: <20201027103407.GA4628@merkur.fritz.box>
References: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
 <20201010204106.1368710-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201010204106.1368710-2-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.10.2020 um 22:41 hat marcandre.lureau@redhat.com geschrieben:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The assert() was added in commit b681a1c73e15 ("block: Repair the
> throttling code."), when the qemu_co_queue_do_restart() function
> required to be running in a coroutine. It was later made unnecessary in
> commit a9d9235567e7 ("coroutine-lock: reschedule coroutine on the
> AioContext it was running on").
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


