Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1E9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85207206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mi27yDYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85207206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0P5Z-0005ZZ-Rf
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0P4z-00054J-3j
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:51:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55949
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0P4x-0004A1-OX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595940694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=LLy05MHLIurSbzZW9bSO/N6LsH8oa+pSSN8DmSnwbe0=;
 b=Mi27yDYIUB6lNCyIw0jWEXTdQyPCSuqSzyZYQfSt4eBWs7k13zLHdKRuCD+aBUK6krma2k
 JX4IIcdntcu6i0Kw40ySbHgITUn+2Rub3M0zmNeR282qjdvUTaYaze6Hn0MD/hGlf4wImt
 V+E0x0ajNVVqUGHWiZRxGT+9S+HzkiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-C2ENYEeANeOC_UPuork4fA-1; Tue, 28 Jul 2020 08:51:30 -0400
X-MC-Unique: C2ENYEeANeOC_UPuork4fA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70AD3800468;
 Tue, 28 Jul 2020 12:51:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-161.ams2.redhat.com [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32A5990E77;
 Tue, 28 Jul 2020 12:51:27 +0000 (UTC)
Subject: Re: [PATCH] iotests/197: Fix for non-qcow2 formats
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200728122125.273230-1-mreitz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ed774b32-8c99-2815-a54d-00b1db6c5d80@redhat.com>
Date: Tue, 28 Jul 2020 14:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200728122125.273230-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/2020 14.21, Max Reitz wrote:
> While 197 is very much a qcow2 test, and it looks like the partial
> cluster case at the end (introduced in b0ddcbbb36a66a6) is specifically
> a qcow2 case, the whole test scripts actually marks itself to work with
> generic formats (and generic protocols, even).
> 
> Said partial cluster case happened to work with non-qcow2 formats as
> well (mostly by accident), but 1855536256 broke that, because it sets
> the compat option, which does not work for non-qcow2 formats.
> 
> So go the whole way and force IMGFMT=qcow2 and IMGPROTO=file, as done in
> other places in this test.
> 
> Fixes: 1855536256eb0a5708b04b85f744de69559ea323
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/197     | 8 +++++---
>  tests/qemu-iotests/197.out | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)

Thanks, that fixes the issue for me, indeed!

Tested-by: Thomas Huth <thuth@redhat.com>


