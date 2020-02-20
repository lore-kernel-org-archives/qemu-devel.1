Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFD1C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19719206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFYSq2Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19719206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lYl-0007OR-8m
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lWn-00049Q-8s
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lWm-0004js-4a
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lWl-0004ii-Hi
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAmYFDb/7MmwCRG3sYs3ce3Q6pXzhe5z0UwykWSueMI=;
 b=NFYSq2XmFEBftztS7K9h4zMRMP0HIyrdtcDs+U/5DugU1sCBRCNzA4OdTUPHO/bwwYp9Et
 Bb7TjP3F9Hv+K/hWZZc5TAlyiHDbg9dXrsNzTvqQL3LLucr7E+ksmsRUVZ3mnm9Q+S+/dC
 JoAzCeIH7x6xK9ZWpW6+EjNaefPCZ9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-TaKAPs3YMTCaXzg6MOeUTA-1; Thu, 20 Feb 2020 08:05:59 -0500
Received: by mail-wm1-f72.google.com with SMTP id p2so579353wma.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4cFZx3MMvL5YTnq3TreW86G7x/AmeK47tUPtRXUhNQM=;
 b=ZMc4N/Z7/9unndrYG4e9WUdb6haWxEic1NvN/Q9IUtWDQsSldOoaQIyizVcWd9STJe
 U52zGMIECoCKKsjnJl/3xswZI7XpREuXF9CYiY0wwwo+VhygMqCeDEmipXOdNRfEZmka
 uhWVjNE2tyG0mBp4oR0pUuZU/muqcMft3phfF80SlDYNjxEqNB1CBa5byolLx6kv44Df
 3lc92Y37sgLKWNLFTLbU99Sp80UantZeV+zthOm7bh1O+MsT73Zp1/lBNWWpkDieOn1D
 o8TuxRsbZx9DhpKXCnY71hEHUcsEsN0WwVSCdS90ej9VyuDETJp7r2unyYFJkL4u/gus
 8WVg==
X-Gm-Message-State: APjAAAUOU4p83pPak5oPpTZkLTots8HCZ3kgS4I0H+Gva3LdnqtM1TvS
 YeXo6N065ouPa40OAoxQAiIDBMYOttDdTse5mvkGKd4lCTLcwX05dfqJTmLypRo4uWDdjnNi8y8
 zNaUJiDDQywqPl+M=
X-Received: by 2002:a05:600c:3d1:: with SMTP id
 z17mr4707527wmd.90.1582203957911; 
 Thu, 20 Feb 2020 05:05:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5jcBfwQCBB55iS//J5oZ4nyff+vZw9LvNNuT8fCe2PE+cfM3f9N7yqnDLu5ddD34rthBOSw==
X-Received: by 2002:a05:600c:3d1:: with SMTP id
 z17mr4707497wmd.90.1582203957647; 
 Thu, 20 Feb 2020 05:05:57 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:05:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 01/20] scripts/git.orderfile: Display Cocci scripts before
 code modifications
Date: Thu, 20 Feb 2020 14:05:29 +0100
Message-Id: <20200220130548.29974-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: TaKAPs3YMTCaXzg6MOeUTA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we use a Coccinelle semantic script to do automatic
code modifications, it makes sense to look at the semantic
patch first.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/git.orderfile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 1f747b583a..7cf22e0bf5 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -22,6 +22,9 @@ Makefile*
 qapi/*.json
 qga/*.json
=20
+# semantic patches
+*.cocci
+
 # headers
 *.h
=20
--=20
2.21.1


