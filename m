Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF3BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFA620691
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYnDduhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFA620691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii7e-00063V-L1
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihf2-00057h-3h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihf1-0007eI-6N
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcbWQH7pJHVpoNeJquNw2ZsCFOjczssRU3nlPknFYGU=;
 b=bYnDduhzY6+ONWZn20HMc4e7Y+jNTTeac6Wlv29x1mCCr9qKjFTF4r1IK5gP3raIHHCO2H
 33cYhmC5o7yQKn3k6jiRNzXCwFGKKYRaTWsoVBsgwLA9q1sS54ueeGz0TDn3YZ/7J+2HoD
 H728/wLlHqjLljVeoqeyGegULisezXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-bxu390EONniWOfF15S7FgQ-1; Tue, 09 Jun 2020 13:03:36 -0400
X-MC-Unique: bxu390EONniWOfF15S7FgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744B1461;
 Tue,  9 Jun 2020 17:03:35 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFA27768AE;
 Tue,  9 Jun 2020 17:03:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] vhost-user-blk: add VIRTIO_F_RING_PACKED feature bit
Date: Tue,  9 Jun 2020 18:02:16 +0100
Message-Id: <20200609170218.246468-6-stefanha@redhat.com>
In-Reply-To: <20200609170218.246468-1-stefanha@redhat.com>
References: <20200609170218.246468-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com, cohuck@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vmhvc3QgZGV2aWNlcyBoYXZlIGEgbGlzdCBvZiBmZWF0dXJlIGJpdHMgdGhhdCB0aGUgZGV2aWNl
IGJhY2tlbmQgaXMKYWxsb3dlZCB0byBjb250cm9sLiBUaGUgVklSVElPX0ZfUklOR19QQUNLRUQg
ZmVhdHVyZSBpcyBhIGZlYXR1cmUgdGhhdAptdXN0IGJlIG5lZ290aWF0ZWQgdGhyb3VnaCBhbGwg
dGhlIHdheSB0byB0aGUgZGV2aWNlIGJhY2tlbmQuIEFkZCBpdCBzbwp0aGUgZGV2aWNlIGJhY2tl
bmQgY2FuIGRlY2xhcmUgd2hldGhlciBvciBub3QgaXQgc3VwcG9ydHMgdGhlIHBhY2tlZApyaW5n
IGxheW91dC4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KUmV2aWV3ZWQtYnk6IFJhcGhhZWwgTm9yd2l0eiA8cmFwaGFlbC5ub3J3aXR6QG51dGFu
aXguY29tPgotLS0KIGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgfCAxICsKIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxr
LmMgYi9ody9ibG9jay92aG9zdC11c2VyLWJsay5jCmluZGV4IDlkOGMwYjM5MDkuLjEwZTExNGEx
OWEgMTAwNjQ0Ci0tLSBhL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMKKysrIGIvaHcvYmxvY2sv
dmhvc3QtdXNlci1ibGsuYwpAQCAtNDQsNiArNDQsNyBAQCBzdGF0aWMgY29uc3QgaW50IHVzZXJf
ZmVhdHVyZV9iaXRzW10gPSB7CiAgICAgVklSVElPX0JMS19GX0RJU0NBUkQsCiAgICAgVklSVElP
X0JMS19GX1dSSVRFX1pFUk9FUywKICAgICBWSVJUSU9fRl9WRVJTSU9OXzEsCisgICAgVklSVElP
X0ZfUklOR19QQUNLRUQsCiAgICAgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVNDLAogICAgIFZJ
UlRJT19SSU5HX0ZfRVZFTlRfSURYLAogICAgIFZJUlRJT19GX05PVElGWV9PTl9FTVBUWSwKLS0g
CjIuMjYuMgoK


