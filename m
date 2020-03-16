Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E81C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789FF20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnJJrFU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789FF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv7M-0008Uo-JQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuoi-0006v0-Fh
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuoh-0005uQ-Eo
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuoh-0005p7-91
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geXUfxMTgfWENukAzjlYJ+d5da/XKDwLqigN/96zKgk=;
 b=MnJJrFU7pQspdxvaBYulKtie3OasaO73uYYZY4OQKnqef735HUaQRSiWEkhQYya/HPYtWv
 o7QqukLODjsBo78OnMXjB32g9+Sf/wNfbLg8u2zbtFj6W0UyRq3vMeUSHs7yI/yJHEWWOh
 XEH3mMFqiv842xuIx38VIJFbKX25scM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-B3V4_B-ROp-rAvvvEZNBIQ-1; Mon, 16 Mar 2020 14:50:20 -0400
X-MC-Unique: B3V4_B-ROp-rAvvvEZNBIQ-1
Received: by mail-wr1-f70.google.com with SMTP id 94so4786023wrr.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c99EwYDmEg45/8wGuL3rbDlH0homjHih1JIeWwXpyVw=;
 b=s1jQIZvzrYFlbFzCaji+jkOsxy7oG+HOREIb46yw1uVrDwfeVSBrvuy4eRgy77e+uW
 An/qiEBXA8hefYczIhbqpb0l+fX6yH/Ij/Q+Z3lfq8MdDte3M2y7MNaO0T6++HckW711
 KSC8TcimLps88qoGZwDMhqZguM2eKsuEaUKIUtP8BcmXoO9o2d0v5uK6oszk5LmqYv80
 xqxbcvkytr1gbIbu1D98AD6aXo2ntiwVmrmD36akjozZrRGZoYKMtus0qTT+N9K0ttWq
 neaMGMEZh/kzgCxtkxspnpLTI9wtedaH/7dGxeAPARdoZvoaMlT2vNL5eg8gMYXDNjqn
 aPvQ==
X-Gm-Message-State: ANhLgQ0BmiPwA2LYcNrkXSJ1YVGeTr680dGVUk42hWrSnho1nWJzM+/C
 eq58j++fWTf9oYQHEC4gsAPppSaeRHQ3/wQeckaWg72U/suSfD9eroZBh80z0n02C6qQ2acOEyg
 rMk2m6B2z6b/anE4=
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr859460wrl.38.1584384619223;
 Mon, 16 Mar 2020 11:50:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsY7FkLjuRCRhi7A/6S071MUAhXUay6JJw0H0pT5iS2EtUJy1H4rCdjVpv8QDVXrBfp9uTYfA==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr859443wrl.38.1584384619020;
 Mon, 16 Mar 2020 11:50:19 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id k18sm916145wru.94.2020.03.16.11.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 02/25] memory: Simplify memory_region_init_rom_nomigrate()
 to ease review
Date: Mon, 16 Mar 2020 19:49:43 +0100
Message-Id: <20200316185006.576-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_init_rom_nomigrate() has the same content than
memory_region_init_ram_shared_nomigrate(), with setting the
readonly mode. The code is easier to review as creating a
readonly ram/shared/nomigrate region.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 memory.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/memory.c b/memory.c
index 3ea0afada9..0ee43c60bd 100644
--- a/memory.c
+++ b/memory.c
@@ -1671,19 +1671,8 @@ void memory_region_init_rom_nomigrate(MemoryRegion *=
mr,
                                       uint64_t size,
                                       Error **errp)
 {
-    Error *err =3D NULL;
-    memory_region_init(mr, owner, name, size);
-    mr->ram =3D true;
+    memory_region_init_ram_shared_nomigrate(mr, owner, name, size, false, =
errp);
     mr->readonly =3D true;
-    mr->terminates =3D true;
-    mr->destructor =3D memory_region_destructor_ram;
-    mr->ram_block =3D qemu_ram_alloc(size, false, mr, &err);
-    mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
-    if (err) {
-        mr->size =3D int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-    }
 }
=20
 void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
--=20
2.21.1


