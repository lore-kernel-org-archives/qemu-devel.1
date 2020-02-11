Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,FROM_MISSP_FREEMAIL,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815D7C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB4520578
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugqWSjUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB4520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Z0n-0001vp-Fr
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wuchenye1995@gmail.com>) id 1j1YzH-0000Pn-1f
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wuchenye1995@gmail.com>) id 1j1YzF-0005P1-V3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:06:14 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:37035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <wuchenye1995@gmail.com>)
 id 1j1YzF-0005Ks-P2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:06:13 -0500
Received: by mail-pf1-x42b.google.com with SMTP id p14so5780139pfn.4
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:mime-version:content-transfer-encoding:date
 :message-id; bh=Kq0lBiunf/sTqWevmIvfgOTUJUcaF2h+JBcdJ8a+WEk=;
 b=ugqWSjUyYejqfVV+zc/EOBL4fjvmJtlsjA7UBPPib7aXsC1y31l5OriujZ8RPdWia0
 6zdHvB9GfUcg65+7G5YK4PJSvph9AtLopE7GOwTrIfUxEVj9RGN2xE1LtRKak5nw8fhC
 bkF2qbcfap0kc6TdVM4pqglSge84oPmboebT8vQAdisoIZzPCeorPO1ONZP3lyvXpGL2
 E17/6Q1JsO0eakNQWG9PaFw87hJwP9+bH2xhFJdYWSM/CBep4aWmGTqvc+PwTlQa18Li
 O0EhNuEt4cZwP2yjCkr+YtG+h2D5EbvWWlkXuqe7k7SPuNm7bM8FHipKWoVshz8TiXpU
 YAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:mime-version
 :content-transfer-encoding:date:message-id;
 bh=Kq0lBiunf/sTqWevmIvfgOTUJUcaF2h+JBcdJ8a+WEk=;
 b=ApNlECDm+nh1OKhDrC4kH2hXppM3rGI/cyE+3fprWh1JwXtMcnST3nHMKO+JGU1qIH
 6Ockga2y5/dCOxfSM+ZFCRwvbmgH76znfuLvQ5PpCViLYlu7PsfDxxnf3esioxfX83jZ
 O7rsnHMmUv4xHA4aLRjguw5rXRCyUCKHATi+88ksO8p1zdglLW9MQNw1nCm1ksBvlYot
 kDqNy+e85Yz29Z5E+GxH4bKS53ai2qpZl765Cj1FVqiay+yA2uMAck1lSEeYZGcG8ug9
 5wUY0ZI8TIbTRpglvsJ7VEMQQM4cVV/P0FGknUSS2cNjmJCq6cdz+AQk4QXkAxZUnmkH
 jEzg==
X-Gm-Message-State: APjAAAVvSldiD/X5hOI75jbtnYp1j+xOQH10STRe78eq7OJGREfngg5v
 Jui+d4GPxriao65qQz4uY3A=
X-Google-Smtp-Source: APXvYqxyJ+rNJDwjbK7OWsLQb8xrKMY1mMeDNX7jqGiEhPEnpy85yfXZ+QA/m5vmQlR8NBhTyvKKmg==
X-Received: by 2002:a63:4e63:: with SMTP id o35mr7492651pgl.279.1581440771429; 
 Tue, 11 Feb 2020 09:06:11 -0800 (PST)
Received: from iPhone ([203.205.219.185])
 by smtp.gmail.com with ESMTPSA id y10sm5279009pfq.110.2020.02.11.09.06.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Feb 2020 09:06:10 -0800 (PST)
X-GUID: 789F6374-6ED1-6F20-39A3-046DECD5D6AA
From: "=?utf-8?B?d3VjaGVueWUxOTk1?="<wuchenye1995@gmail.com>
To: "=?utf-8?B?ZGlzY3Vzcw==?="<discuss@edk2.groups.io>
Subject: A problem with live migration of UEFI virtual machines
Mime-Version: 1.0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 12 Feb 2020 01:06:07 +0800
Message-ID: <tencent_BC7FD00363690990994E90F8@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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
Cc: =?utf-8?B?ZGV2ZWxAZWRrMi5ncm91cHMuaW8=?= <devel@edk2.groups.io>,
 =?utf-8?B?d3VjaGVueWUxOTk1?= <wuchenye1995@gmail.com>,
 =?utf-8?B?emhvdWppYW5qYXk=?= <zhoujianjay@gmail.com>,
 =?utf-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PGRpdiBzdHlsZT0ibWluLWhlaWdodDoyMnB4O21hcmdpbi1ib3R0b206OHB4OyI+PGRpdiBj
bGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJoZWlnaHQ6IDI2LjU2MjVweDsgd2lkdGg6IGF1dG8g
IWltcG9ydGFudDsiPkhpIGFsbCw8L2Rpdj48ZGl2IGNsYXNzPSIgc2VsZmRpdiIgc3R5bGU9
ImhlaWdodDogNTMuMTI1cHg7IHdpZHRoOiBhdXRvICFpbXBvcnRhbnQ7Ij4mbmJzcDsgJm5i
c3A7V2UgZm91bmQgYSBwcm9ibGVtIHdpdGggbGl2ZSBtaWdyYXRpb24gb2YgVUVGSSB2aXJ0
dWFsIG1hY2hpbmVzIGR1ZSB0byBzaXplIG9mIE9WTUYuZmQgY2hhbmdlcy48L2Rpdj48ZGl2
IGNsYXNzPSIgc2VsZmRpdiIgc3R5bGU9ImhlaWdodDogNzkuNjg3NXB4OyB3aWR0aDogYXV0
byAhaW1wb3J0YW50OyI+Jm5ic3A7ICZuYnNwO1NwZWNpZmljYWxseSwgdGhlIHNpemUgb2Yg
T1ZNRi5mZCBpbiBlZGsgd2l0aCBsb3cgdmVyc2lvbiBzdWNoIGFzIGVkay0yLjAtMjUgaXMm
bmJzcDs8Yj4yTUI8L2I+Jm5ic3A7d2hpbGUgdGhlIHNpemUgb2YgaXQgaW4gaGlnaGVyIHZl
cnNpb24gc3VjaCBhcyBlZGstMi4wLTMwIGlzJm5ic3A7PGI+NE1CPC9iPi48L2Rpdj48ZGl2
IGNsYXNzPSIgc2VsZmRpdiIgc3R5bGU9ImhlaWdodDogMTA2LjI1cHg7IHdpZHRoOiBhdXRv
ICFpbXBvcnRhbnQ7Ij4mbmJzcDsgJm5ic3A7V2hlbiB3ZSBtaWdyYXRlIGEgVUVGSSB2aXJ0
dWFsIG1hY2hpbmUgZnJvbSB0aGUgaG9zdCB3aXRoIGxvdyB2ZXJzaW9uIG9mIGVkazIgdG8g
dGhlIGhvc3Qgd2l0aCBoaWdoZXIgb25lLCBxZW11IGNvbXBvbmVudCB3aWxsIHJlcG9ydCBh
biBlcnJvciBpbiBmdW5jdGlvbiZuYnNwOzxiPnFlbXVfcmFtX3Jlc2l6ZTwvYj4mbmJzcDt3
aGlsZTwvZGl2PjxkaXYgY2xhc3M9IiBzZWxmZGl2IiBzdHlsZT0iaGVpZ2h0OiA3OS42ODc1
cHg7IHdpZHRoOiBhdXRvICFpbXBvcnRhbnQ7Ij5jaGVja2luZyBzaXplIG9mIG92bWZfcGNi
aW9zOiZuYnNwOzxiPkxlbmd0aCBtaXNtYXRjaDogcGMuYmlvczogMHgyMDAwMDAgaW4gIT0g
MHg0MDAwMDA6IEludmFsaWQgYXJndW1lbnQuPC9iPjwvZGl2PjxkaXYgY2xhc3M9IiBzZWxm
ZGl2IiBzdHlsZT0iaGVpZ2h0OiA1My4xMjVweDsgd2lkdGg6IGF1dG8gIWltcG9ydGFudDsi
PjxiPiZuYnNwOyAmbmJzcDs8L2I+V2Ugd2FudCB0byBrbm93IGhvdyB0byBzb2x2ZSB0aGlz
IHByb2JsZW0gYWZ0ZXIgdXBkYXRpbmcgdGhlIHZlcnNpb24gb2YgZWRrMi48L2Rpdj48ZGl2
IGNsYXNzPSIgc2VsZmRpdiIgc3R5bGU9ImhlaWdodDogMjYuNTYyNXB4OyB3aWR0aDogYXV0
byAhaW1wb3J0YW50OyI+Jm5ic3A7ICZuYnNwO1RoYW5rIHlvdS48L2Rpdj48ZGl2IGNsYXNz
PSIgc2VsZmRpdiIgc3R5bGU9ImhlaWdodDogMjYuNTYyNXB4OyB3aWR0aDogYXV0byAhaW1w
b3J0YW50OyI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9IiBzZWxmZGl2IiBzdHlsZT0iaGVpZ2h0
OiAyNi41NjI1cHg7IHdpZHRoOiBhdXRvICFpbXBvcnRhbnQ7Ij48YnI+PC9kaXY+PGRpdiBj
bGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJoZWlnaHQ6IDE4NS45Mzc1cHg7IHdpZHRoOiBhdXRv
ICFpbXBvcnRhbnQ7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IENoZW55ZSBXdSZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOzIwMjAuMi4xMjwvZGl2PjwvZGl2PjxkaXYgaWQ9Im9yaWdpbmFsLWNvbnRlbnQiPjwv
ZGl2Pg==


