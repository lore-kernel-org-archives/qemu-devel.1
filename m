Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D01C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E25121D1A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aje+J4/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E25121D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFY8P-0007eY-Gz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4h-0001Br-EW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4f-0003lM-LH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o87llB+9PMIU+7P1+hFN0vkatsEBd5s8c241sBT1/2s=;
 b=aje+J4/UN1AqOeywADP9HCuznaA1jtzDw+3wnJ5Qe32XL3mOOuzllpf/O0oRF3rax5aoqh
 vVr6HboL5CLKQ+1wcbnqDyHrlTNkbuwyMf8aHZnB8/KRtmPgymDdzGkoz0aINb87Fx/MwL
 F9XqEfLC4sMa1TrxAuiNNnMQhRJGgMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Cwk02GAzN_6RGVIAfR0ZRg-1; Tue, 08 Sep 2020 03:29:51 -0400
X-MC-Unique: Cwk02GAzN_6RGVIAfR0ZRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A2C91091069
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:29:50 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 276B67E30C;
 Tue,  8 Sep 2020 07:29:48 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 04/10] tests: acpi: tolerate "virt/SSDT.memhp" mismatch
 temporarily
Date: Tue,  8 Sep 2020 09:29:33 +0200
Message-Id: <20200908072939.30178-5-lersek@redhat.com>
In-Reply-To: <20200908072939.30178-1-lersek@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Li4uIHRvIGxldCAiY2hlY2stcXRlc3QtYWFyY2g2NCIgcGFzcyB1bnRpbCB3ZSByZWZyZXNoIHRo
ZSBBTUwgYWZ0ZXIKYWR2YW5jaW5nIHRoZSBlZGsyIHN1Ym1vZHVsZSB0byB0YWcgZWRrMi1zdGFi
bGUyMDIwMDguCgpDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgpDYzog
SWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4KQ2M6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KUmVmOiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5l
dC9xZW11LytidWcvMTg1MjE5NgpTaWduZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0By
ZWRoYXQuY29tPgotLS0KIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZm
LmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggYi90ZXN0cy9xdGVzdC9i
aW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oCmluZGV4IGRmYjg1MjNjOGJmNC4uZTU2OTA5
OGFiZGRjIDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQt
ZGlmZi5oCisrKyBiL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmgK
QEAgLTEgKzEsMiBAQAogLyogTGlzdCBvZiBjb21tYS1zZXBhcmF0ZWQgY2hhbmdlZCBBTUwgZmls
ZXMgdG8gaWdub3JlICovCisidGVzdHMvZGF0YS9hY3BpL3ZpcnQvU1NEVC5tZW1ocCIsCi0tIAoy
LjE5LjEuMy5nMzAyNDdhYTVkMjAxCgoK


