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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42461C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8F020715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW+0MSlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8F020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B3k-00085f-0F
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wuchenye1995@gmail.com>) id 1j10rO-0004I5-CK
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wuchenye1995@gmail.com>) id 1j10rM-0006dS-ER
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:39:50 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:46279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <wuchenye1995@gmail.com>)
 id 1j10rM-0006Zi-6d
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:39:48 -0500
Received: by mail-pl1-x62b.google.com with SMTP id y8so2288287pll.13
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 20:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:mime-version:content-transfer-encoding:date
 :message-id; bh=TdKc+yJzWxZKEEjl1+bly/sL8BnupcTGP7QrM+JSsrg=;
 b=QW+0MSlw3jz3PE9ecO3cf8fVgqqmk5sI53Simb8ZfcDQ2Ma6yGm4y96wbGG2FClGwG
 RhhE+9wQeEghdy+mgpRqljZ93knEmx2oL7DE0kGM35V1L8G1piSq0q4wx1msuR+0Gekq
 Mz2vWH2f+WBUCY8/GB/X1EPohvBO+vUstHKkSHYuCiRGkQCOANQyLbQCKDC/GUiAV8aH
 0mJhUljYZjg60/LjrCtGydkvYcD9rsh8E1Wrd0rZaUh1UeJYjN7v/5DlD5xA1686khKc
 dxJQV9yMl/sDWgpAXVbX0vGm2r1jVls/wwdkyWO3scrn3nnpNaRTc17oaTBMB/o34u1V
 jSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:mime-version
 :content-transfer-encoding:date:message-id;
 bh=TdKc+yJzWxZKEEjl1+bly/sL8BnupcTGP7QrM+JSsrg=;
 b=lmuSNi592Yr8rHRCpiPNhZAFnymVKfASSZJv3Pzd+OhSJtjpxQckVhQ+9X4R404IZt
 f0XLeJ2St1/6HNUCmQ2kwAcADr3eGao4v3ZlDyNc7SIy/JYrSEaL8SUKTpqt4yy/FVdF
 9u6jMJYz/CEySgYSgSt1tg2ZuK5C71m4x143fD0mSyKql6F9jlFFs6NiQceUrpU4AmzR
 kN7y/PIK7EB3RX6blTAxbWTa7dDTRoiCzb0EwpP1ZWwmFVbrfFylh74VIjqPDm+Q/mBh
 vjEM3SZlPbVaouSWN1ioEm14isbIAA3O3eWugry3u4lLb0bY6s4DHOEzL9lYbrJ9Of8e
 ZmjQ==
X-Gm-Message-State: APjAAAUC+wutK0hnRtpQOD+sX+TYtUl5rdlbXB8odBUxVpBKGBjrGapx
 uewzi3qTj+OOIUS7Dj4cmZ0=
X-Google-Smtp-Source: APXvYqwbiumFm6310rd9ILzmA83GPF5+RBYBtG4ONdrr/NOFKgoyme61Bj80WQJWWdK5RoyKXJ656A==
X-Received: by 2002:a17:902:103:: with SMTP id 3mr11100682plb.34.1581309585798; 
 Sun, 09 Feb 2020 20:39:45 -0800 (PST)
Received: from iPhone (smtpbg511.qq.com. [203.205.250.109])
 by smtp.gmail.com with ESMTPSA id c19sm10689682pgh.8.2020.02.09.20.39.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Feb 2020 20:39:45 -0800 (PST)
X-GUID: E7FD201D-9E96-5556-7472-E01727A775B8
From: "=?utf-8?B?d3VjaGVueWUxOTk1?="<wuchenye1995@gmail.com>
To: "=?utf-8?B?ZGV2ZWxAZWRrMi5ncm91cHMuaW8=?="<devel@edk2.groups.io>
Subject: A problem with live migration of UEFI virtual machines
Mime-Version: 1.0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 10 Feb 2020 12:39:42 +0800
Message-ID: <tencent_F1295F826E46EDFF3D77812B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62b
X-Mailman-Approved-At: Mon, 10 Feb 2020 10:31:31 -0500
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
 =?utf-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PGRpdiBzdHlsZT0ibWluLWhlaWdodDoyMnB4O21hcmdpbi1ib3R0b206OHB4OyI+PGRpdiBj
bGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJ3aWR0aDogYXV0byAhaW1wb3J0YW50OyBoZWlnaHQ6
IGF1dG8gIWltcG9ydGFudDsiPkhpIGFsbCw8L2Rpdj48ZGl2IGNsYXNzPSIgc2VsZmRpdiIg
c3R5bGU9IndpZHRoOiBhdXRvICFpbXBvcnRhbnQ7IGhlaWdodDogYXV0byAhaW1wb3J0YW50
OyI+Jm5ic3A7ICZuYnNwO1dlIGZvdW5kIGEgcHJvYmxlbSB3aXRoIGxpdmUgbWlncmF0aW9u
IG9mIFVFRkkgdmlydHVhbCBtYWNoaW5lcyBkdWUgdG8gc2l6ZSBvZiBPVk1GLmZkIGNoYW5n
ZXMuPC9kaXY+PGRpdiBjbGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJ3aWR0aDogYXV0byAhaW1w
b3J0YW50OyBoZWlnaHQ6IGF1dG8gIWltcG9ydGFudDsiPiZuYnNwOyAmbmJzcDtTcGVjaWZp
Y2FsbHksIHRoZSBzaXplIG9mIE9WTUYuZmQgaW4gZWRrIHdpdGggbG93IHZlcnNpb24gc3Vj
aCBhcyBlZGstMi4wLTI1IGlzJm5ic3A7PGI+Mk1CPC9iPiZuYnNwO3doaWxlIHRoZSBzaXpl
IG9mIGl0IGluIGhpZ2hlciB2ZXJzaW9uIHN1Y2ggYXMgZWRrLTIuMC0zMCBpcyZuYnNwOzxi
PjRNQjwvYj4uPC9kaXY+PGRpdiBjbGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJ3aWR0aDogYXV0
byAhaW1wb3J0YW50OyBoZWlnaHQ6IGF1dG8gIWltcG9ydGFudDsiPiZuYnNwOyAmbmJzcDtX
aGVuIHdlIG1pZ3JhdGUgYSBVRUZJIHZpcnR1YWwgbWFjaGluZSBmcm9tIHRoZSBob3N0IHdp
dGggbG93IHZlcnNpb24gb2YgZWRrMiB0byB0aGUgaG9zdCB3aXRoIGhpZ2hlciBvbmUsIHFl
bXUgY29tcG9uZW50IHdpbGwgcmVwb3J0IGFuIGVycm9yIGluIGZ1bmN0aW9uJm5ic3A7PGI+
cWVtdV9yYW1fcmVzaXplPC9iPiZuYnNwO3doaWxlPC9kaXY+PGRpdiBjbGFzcz0iIHNlbGZk
aXYiIHN0eWxlPSJ3aWR0aDogYXV0byAhaW1wb3J0YW50OyBoZWlnaHQ6IGF1dG8gIWltcG9y
dGFudDsiPmNoZWNraW5nIHNpemUgb2Ygb3ZtZl9wY2Jpb3M6Jm5ic3A7PGI+TGVuZ3RoIG1p
c21hdGNoOiBwYy5iaW9zOiAweDIwMDAwMCBpbiAhPSAweDQwMDAwMDogSW52YWxpZCBhcmd1
bWVudC48L2I+PC9kaXY+PGRpdiBjbGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJ3aWR0aDogYXV0
byAhaW1wb3J0YW50OyBoZWlnaHQ6IGF1dG8gIWltcG9ydGFudDsiPjxiPiZuYnNwOyAmbmJz
cDs8L2I+V2Ugd2FudCB0byBrbm93IGhvdyB0byBzb2x2ZSB0aGlzIHByb2JsZW0gYWZ0ZXIg
dXBkYXRpbmcgdGhlIHZlcnNpb24gb2YgZWRrMi48L2Rpdj48ZGl2IGNsYXNzPSIgc2VsZmRp
diIgc3R5bGU9IndpZHRoOiBhdXRvICFpbXBvcnRhbnQ7IGhlaWdodDogYXV0byAhaW1wb3J0
YW50OyI+Jm5ic3A7ICZuYnNwO1RoYW5rIHlvdS48L2Rpdj48ZGl2IGNsYXNzPSIgc2VsZmRp
diIgc3R5bGU9IndpZHRoOiBhdXRvICFpbXBvcnRhbnQ7IGhlaWdodDogYXV0byAhaW1wb3J0
YW50OyI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9IiBzZWxmZGl2IiBzdHlsZT0id2lkdGg6IGF1
dG8gIWltcG9ydGFudDsgaGVpZ2h0OiBhdXRvICFpbXBvcnRhbnQ7Ij48YnI+PC9kaXY+PGRp
diBjbGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJ3aWR0aDogYXV0byAhaW1wb3J0YW50OyBoZWln
aHQ6IGF1dG8gIWltcG9ydGFudDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
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
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgQ2hlbnllIFd1PC9kaXY+PGRpdiBj
bGFzcz0iIHNlbGZkaXYiIHN0eWxlPSJ3aWR0aDogYXV0byAhaW1wb3J0YW50OyBoZWlnaHQ6
IGF1dG8gIWltcG9ydGFudDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
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
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOzIwMjAuMi4xMDwv
ZGl2PjwvZGl2PjxkaXYgaWQ9Im9yaWdpbmFsLWNvbnRlbnQiPjwvZGl2Pg==


