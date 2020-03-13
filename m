Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0DEC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E042D206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1ctCp12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E042D206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpEJ-000503-Ur
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBH-0007qr-Qz
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBG-0002Sx-RE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36390
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBG-0002Rp-N0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzUdM1ZagK75BIGV+iiLIHXu9NBWzrOD4R++sxCHDoI=;
 b=a1ctCp124O9hJqJJ8pgJgQiCBuXhNXYkVltnflY4kyudFl5yOgQ7sk711H2R0IpKWzkza/
 MsZhzz/Vt1T7yrl1/ikKJ9jHW46Uv1ituvYlTgpNcLYOWaoMOEXHld1a9RasmUegaD76is
 F55uCaUKvqO7ryW4JLskDQ9KWLzFLzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-ZxnLby-VO2qVP1Z5T_oLnA-1; Fri, 13 Mar 2020 14:37:07 -0400
X-MC-Unique: ZxnLby-VO2qVP1Z5T_oLnA-1
Received: by mail-wm1-f69.google.com with SMTP id g26so3289630wmk.6
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=intvWc0QjhhlSzR1IDRa0EVk0LsfQ2/cVL2atlURA2k=;
 b=DwBE9hwkFblBjhws8Oi1Xcpd4SDZerCCuQOMT+afxdbV46eYp7358RtXcni2fvXXm+
 XsqK0FFr3bDJtG3q7BrI+LjSRiJi2tHbE/muGBKoqXD2N/YdYlpJf0ceZx+jaq2ZKQPR
 XLY1CVMk+zgw0UWn4CWbtzTH4Hx5egM2RXnoqVO1WUXjnG9PgkcEJ7+dyD0IUjOU+zKa
 TrRqh2gwwW0ghcpUrSWwoLBLmKTySRX3WCnCqFawD03Dyg26rFOZlE9awfr+375/HV1I
 tMAs6AaP8ixnEfW4e/6OLD84JMR5n1P8firBTEaJ7asRvRa/CAH4BZ3rk91QzmG03pCb
 YkpA==
X-Gm-Message-State: ANhLgQ0RWMp6oAGvgFAurZ9eCd4jbhGBPROsd16ITF5cKac5qym2ykja
 gS0yQcsBq/o/rrM4rAm+4MOTueZjDIFI3Ao16BRv1hY4cZWbaU+4GM8FTPrF4UOnpL+DtNe2ipl
 FXX7kexsEohyM+vk=
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr7730339wmh.65.1584124626711;
 Fri, 13 Mar 2020 11:37:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs6LWJfbWP4kFQvfej2dGXUhXsnUPkGfYqWd+58D4W2bm/r9A5Xs2YTAiB5KtkiaaAcwYQ9sw==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr7730297wmh.65.1584124626502;
 Fri, 13 Mar 2020 11:37:06 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id 62sm27365177wri.30.2020.03.13.11.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/14] configure: Avoid building TCG when not needed
Date: Fri, 13 Mar 2020 19:36:40 +0100
Message-Id: <20200313183652.10258-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid building TCG when building only tools:

  ./configure --enable-tools --disable-system --disable-user

This saves us from running the soft-float tests enabled since
commit 76170102508.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index eb49bb6680..c2ffcb0431 100755
--- a/configure
+++ b/configure
@@ -1650,6 +1650,10 @@ if [ "$ARCH" =3D "unknown" ]; then
   linux_user=3D"no"
 fi
=20
+if [ "$bsd_user" =3D "no" -a "$linux_user" =3D "no" -a "$softmmu" =3D "no"=
 ] ; then
+  tcg=3D"no"
+fi
+
 default_target_list=3D""
=20
 mak_wilds=3D""
--=20
2.21.1


