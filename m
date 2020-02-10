Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,FROM_MISSP_FREEMAIL,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D2C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D0220715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBIlYxy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D0220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B49-0000qb-TD
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wuchenye1995@gmail.com>) id 1j14oq-0002eU-Sj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wuchenye1995@gmail.com>) id 1j14op-00083w-PO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:53:28 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <wuchenye1995@gmail.com>)
 id 1j14op-00083G-K3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:53:27 -0500
Received: by mail-pf1-x42f.google.com with SMTP id k29so3359949pfp.13
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:mime-version:content-transfer-encoding:date
 :message-id; bh=aVMo1/fH/+J5Dd6h+JEmd8cOpt300SuK8YxZxwJ1Cew=;
 b=FBIlYxy8LkKzMldUeHdqxaD6SAInLrKqUwPPvZo8mMSGYEoim6k1wby5ukDpEd1Gye
 rMNe/9ldjDM1RiYjorDGtz3KTb3Cwsxmg89d/K/eFxolEjPo9VGeGjlOtCR5kvDI23xv
 ET7UK7lD815q0T0aBKsirROYuoOXUoENDcVEDR1RF/esRU4EYkCp33+cB5vInfiU359q
 cNMnJITB2TbXof7Ys8o4bzN5dFABggxr0Jskc2eXkvaj6b5nPJwMIRKQsdpsLgCnruAY
 BfxTHOwvNfLqVKvVlAlzG6g04LpK3t95SzLv79BUakzJ2MOcU/WygCK3lkA0ljPgJz42
 +jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:mime-version
 :content-transfer-encoding:date:message-id;
 bh=aVMo1/fH/+J5Dd6h+JEmd8cOpt300SuK8YxZxwJ1Cew=;
 b=bPiibP+pnTRB42y0yTzTpSZZlD2QSN2IJeWW4GPdMM5tehIqE9+lo7kjtukvQrBj4K
 Zehi1l/1povc6k1M7QNkL8boaEnt5kAsnClPMjHpSTyx0dsxSZBtSl26hpEmDkD1O5Xb
 KHQojG6QRPXXjQRZcetpra4ELrEkXJNIxmtORNBy6LT1hFAp1BaDsb+UR+3WLhvBZthg
 0p9NYzBs5SGyoIBx3rjPeogLjZPx5+S2Hritw06QpkesNChLZniYSd6DTsATqLUnjEOh
 EHEglc3pxgNurLOo4qEiqvXPmYCB6kFyA9ltxKNvgJ+ICrNhyYsgijSAaF7caTzTnqhv
 bjaw==
X-Gm-Message-State: APjAAAUZskoU4uCdOo8CHOpuGxyJjcHpr0vlYmORTaJdVDgfNGWN1e1m
 Kk1mq+qVrwKr0W7uMlhcO0M=
X-Google-Smtp-Source: APXvYqx8d3YEPommdJ5usOd9s2vNf2dUbNNSODQfRE/zscQcBjf5fzvA+uuqAu9ryzmoRQZ7iJpDBA==
X-Received: by 2002:a63:ac46:: with SMTP id z6mr480981pgn.301.1581324806613;
 Mon, 10 Feb 2020 00:53:26 -0800 (PST)
Received: from iPhone ([203.205.219.194])
 by smtp.gmail.com with ESMTPSA id j125sm11824296pfg.160.2020.02.10.00.53.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Feb 2020 00:53:26 -0800 (PST)
X-GUID: 0A97B8BE-A1E3-226B-A4F7-682B94A81571
From: "=?utf-8?B?d3VjaGVueWUxOTk1?="<wuchenye1995@gmail.com>
To: "=?utf-8?B?ZGV2ZWxAZWRrMi5ncm91cHMuaW8=?="<devel@edk2.groups.io>
Subject: A problem with live migration of UEFI virtual machines
Mime-Version: 1.0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 10 Feb 2020 16:53:23 +0800
Message-ID: <tencent_3CD8845EC159F0161725898B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
X-Mailman-Approved-At: Mon, 10 Feb 2020 10:31:32 -0500
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
Cc: =?utf-8?B?emhvdWppYW5qYXk=?= <zhoujianjay@gmail.com>,
 =?utf-8?B?ZWRrMi1kZXZlbA==?= <edk2-devel@lists.01.org>,
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
bGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJoZWlnaHQ6IDEwNi4yNXB4OyB3aWR0aDogYXV0byAh
aW1wb3J0YW50OyI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
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
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBDaGVueWUgV3UmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
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
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsyMDIwLjIuMTA8L2Rpdj48L2Rpdj48ZGl2IGlkPSJvcmlnaW5hbC1jb250ZW50Ij48L2Rp
dj4=


