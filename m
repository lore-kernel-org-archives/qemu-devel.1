Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD95EC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D9F20872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fq+WuE4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D9F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhLM-0004r3-QC
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBhKm-0004MA-5z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:34:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBhKk-0007gZ-OW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598632474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LwqQf5i9NAGma/r66kRgb124ymggdGh0guXHDBuwZS0=;
 b=fq+WuE4BCUyxKWza6bMmWHeQ8uQSnS4KWO6RQjYziceesdpog9JdN1aMe0+eRbT8NLAAl0
 rksY7CywKwElskYVCAndVbYNlMc065fZ0BbTm6yxhDipMmmCooj1r8tLB5pl11iYSTdJOs
 DhRr6mt8YNwyutkSVoIC+r5Pe493pw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-qSaGucYlNO2UVrx83XgwUA-1; Fri, 28 Aug 2020 12:34:30 -0400
X-MC-Unique: qSaGucYlNO2UVrx83XgwUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45A56189E62F;
 Fri, 28 Aug 2020 16:34:28 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-79.ams2.redhat.com [10.36.112.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC4219C66;
 Fri, 28 Aug 2020 16:34:23 +0000 (UTC)
To: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
From: Thomas Huth <thuth@redhat.com>
Subject: QEMU build error with --disable-qcow1
Message-ID: <5e1817af-afde-2839-98b2-c7a50678756a@redhat.com>
Date: Fri, 28 Aug 2020 18:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 12:34:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


 Hi,

if I run "configure" with --disable-qcow1, I currently get a build error:

Linking target qemu-nbd
libblock.fa(block_qcow2-threads.c.o): In function `qcow2_zlib_compress':
/tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:101:
undefined reference to `deflateInit2_'
/tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:116:
undefined reference to `deflate'
/tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:123:
undefined reference to `deflateEnd'
libblock.fa(block_qcow2-threads.c.o): In function `qcow2_zlib_decompress':
/tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:152:
undefined reference to `inflateInit2_'
/tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:157:
undefined reference to `inflate'
/tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:169:
undefined reference to `inflateEnd'
etc.

Not sure whether this is due to the recent conversion to meson, or a
recent change to that file ... anybody got a clue what's going on here?

 Thomas


