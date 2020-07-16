Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A3C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47B220657
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdfpbhU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47B220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvylV-00033p-TD
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 03:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvykx-0002dA-Of
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:56:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvykv-00041L-3G
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594886195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Wndyb4rAXtgFSUyEb7PB+YMnuDnnCGvoISxiSPDteNY=;
 b=VdfpbhU2KUs/AfgzVo8XH5trXTBDttfW3V9z6p9+Id/QVMwxrd9D5mMTPuWuC7EXoaSQ9k
 lukc+jA6Wp8QMr/D+dSBmwHQTs9ElNpmlj5M9CSlapzdWh38iueXUQu3ZigBnZXaHucDgc
 Ct/MyFY0YIugN4uL2PLBZnAX2fU4BHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-N-4Zd0IxNryrv3GC_UhV_g-1; Thu, 16 Jul 2020 03:56:33 -0400
X-MC-Unique: N-4Zd0IxNryrv3GC_UhV_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 793CE107ACCA;
 Thu, 16 Jul 2020 07:56:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A07CE6E9F3;
 Thu, 16 Jul 2020 07:56:27 +0000 (UTC)
Subject: Re: [PATCH v2] tests: qmp-cmd-test: fix memory leak
To: Li Qiang <liq3ea@163.com>, armbru@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, eric.auger@redhat.com
References: <20200715154117.15456-1-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <71d35a8d-e767-902d-58b2-bb4ce5407988@redhat.com>
Date: Thu, 16 Jul 2020 09:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200715154117.15456-1-liq3ea@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/2020 17.41, Li Qiang wrote:
> Properly free each test response to avoid memory leak and separate
> qtest_qmp() calls with spare lines, in a consistent manner.
> 
> Fixes: 5b88849e7b9("tests/qmp-cmd-test: Add
> qmp/object-add-failure-modes"
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Change sincve v1: add detailed commit message
>  
> tests/qtest/qmp-cmd-test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Thanks, queued to https://gitlab.com/huth/qemu/-/commits/qtest-next/

 Thomas


