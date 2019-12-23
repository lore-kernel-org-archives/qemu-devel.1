Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF06C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C1A20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrc1rgpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C1A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijR85-0005pm-Qn
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 12:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQnJ-0005QX-1t
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQnH-0005lO-V1
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQnH-0005lF-R1
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=piqn6mX5WQ96VESO5T0tIJ0XhrZt2DhdjHLkZukt+8U=;
 b=Vrc1rgpI/0Gv+AfPrbc4ene6a7ELJKf6DjO8284KMT2bT8vKhSXYXUBiS3/4oRK6vIsfN4
 jPZDPHmY96X/pbw9a1fRDyP9U9m9GqSstql1p6K8yAQfGw8SaiW1CKkstlW0d9Wi+1Ze/P
 RjqiByKe+5x680W/y+rGLd9I+4cHNw4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-k93MnnzFOnavMOVjZmhRmg-1; Mon, 23 Dec 2019 11:42:53 -0500
Received: by mail-qk1-f200.google.com with SMTP id f124so11510600qkb.22
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:42:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tN9j8nC8UNjEIUbDqAKywg3EszM5OfgJu5L0vZrOdtE=;
 b=IoGQYrWDcuvzNrsx8qUoawWTHbq2epMi+gXpYRAKe2xSeWWkTb/Wwc2TJl1pWeC/AO
 koGohUoY+FAa2hMpfz6d1OLVMiJYpzf3+mKTzqSSLwXcdYwBCeqLy4ljYkibaiF5gZnI
 ZJi32Nw/0kYDE5cHQxWWiDM1+DOOGT4izAZKcBt4t0xqPoxILTJgJXJhus2zbDHXZxn5
 aTt1gjuOY22Jc/14WctJD4AGfV44AyMtAedgJ7kIeTf+mKptbugFsQOuuTSERj/eN1Hm
 EqthZ0DOnagV5ozefpB2OyIc7etRt2UhRM34DbozfwX9jzCW3CkJSCpoPAfMB5bl5dov
 ugHg==
X-Gm-Message-State: APjAAAWRZCWsVfY37bWExz0xNYdni717bH1axS8tXGs/912XiTCJEBIA
 BNW5ExZXiNdD3mw2a99FKIBvU/wTYb9c2lykzeqMD8JaGNA17Y3u++ePEHvGgRE4a0X5hyCV/GM
 QEpWxtUfQy4n3BPc=
X-Received: by 2002:a05:6214:3e7:: with SMTP id
 cf7mr24858589qvb.129.1577119372331; 
 Mon, 23 Dec 2019 08:42:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqygk0Ihdq8AsX7QCWS+wqEk3rBOBjSr/Cra2T6bVbo0LHxlDBbDtXlAhqUr148uzprEvRVxag==
X-Received: by 2002:a05:6214:3e7:: with SMTP id
 cf7mr24858578qvb.129.1577119372150; 
 Mon, 23 Dec 2019 08:42:52 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 t2sm5870881qkc.31.2019.12.23.08.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:42:51 -0800 (PST)
Date: Mon, 23 Dec 2019 11:42:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 25/27] hw: fix using 4.2 compat in 5.0 machine types for
 i440fx/q35
Message-ID: <20191223141536.72682-26-mst@redhat.com>
References: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191223141536.72682-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: k93MnnzFOnavMOVjZmhRmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

5.0 machine type uses 4.2 compats. This seems to be incorrect, since
the latests machine type by now is 5.0 and it should use its own
compat or shouldn't use any relying on the defaults.
Seems, like this appeared because of some problems on merge/rebase.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 1 -
 hw/i386/pc_q35.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 721c7aa64e..fa12203079 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -425,7 +425,6 @@ static void pc_i440fx_5_0_machine_options(MachineClass =
*m)
     m->alias =3D "pc";
     m->is_default =3D 1;
     pcmc->default_cpu_version =3D 1;
-    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
 DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 52f45735e4..84cf925cf4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -354,7 +354,6 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     pc_q35_machine_options(m);
     m->alias =3D "q35";
     pcmc->default_cpu_version =3D 1;
-    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
--=20
MST


