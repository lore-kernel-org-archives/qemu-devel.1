Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C86C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5DA2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imnHIhkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5DA2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j308f-0004X3-AW
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j307O-0002pI-8C
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j307N-00064g-Ag
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j306u-0005Yk-L8
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581783364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rGxu2WAKHmWrsK5i7B1ITlPmz0WbEXAEhhFZo5Btr6I=;
 b=imnHIhkEBmxstuvf2FC4RX7tMMCM4GwVUv8BWGkFdCYLcCw7tbEMo9bqJj3Y+VtlkRODP3
 6z/fwspKM4G1uyEAGpaAoFqlpqF+jTeQZ9ObYP/nlUgnWAH1DgutCBUb7WL36822ySN+YS
 O3jodJ9l1WgcLwfEMBFmXmwq2ZV4pfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-PQQ3-PLnOeCCELL5u3yZ4w-1; Sat, 15 Feb 2020 11:16:01 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so5896887wru.7
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 08:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I8Qt4eqntsRD4P75qFlC97N/QHEJ2WA+14+XeTDgAcQ=;
 b=GwxAM9z7Gzrpd2CPpAcxTfMcg82qOLH/rLgx3Ak60IjiXL/0HeqWXFOVhDnNPS7yGh
 V9Wl/O0D/lmTyUaTdGKZUo4PbXKIrcKz8MxYpp8vBZMhh7U5rfixEF4PBHvZJITjQsln
 F1loYGEhhUJt1WvMC3SOOTraKm0H+RBJvWV93f8PEylf/HLu7f0UIvNKiLqaBjstZocm
 c8zleJz0y3jSSphlfEmN70YX328dgAcMFBrfnV7f8swAPMDX+l1R852/n0H7rrtgKxsI
 t1dqOf1j6F7qr+A+Id/8lcuxVWh0x/sdqzpRwWXvvQCLyV3ggdvAXYWi3brjuIymYwUg
 LHWQ==
X-Gm-Message-State: APjAAAW3WXmdD2KhHH8w/+MM7wqbku5HeefSCDXgdjFmpms/A9p6KQfE
 7hUCdqiRKuJJXO4/Jh2bdvS/lWa2qAzQXoq1mKkRB6XXo4b6+wc+dm3JNA4vh6PCa6Jw9LKOmzE
 GuCm6thB1JXVD7Hc=
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr11241106wmj.96.1581783360550; 
 Sat, 15 Feb 2020 08:16:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwR7Jcu6Rjjh6mJ2IoDSuorj+uiRsbXaSzmeAatmVqX2SdSszjnTOrDW8nSYrMCF94WHKpAfw==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr11241086wmj.96.1581783360302; 
 Sat, 15 Feb 2020 08:16:00 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w26sm11855872wmi.8.2020.02.15.08.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:15:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw: Remove unneeded variable assignment
Date: Sat, 15 Feb 2020 17:15:54 +0100
Message-Id: <20200215161557.4077-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: PQQ3-PLnOeCCELL5u3yZ4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix few warnings reported by Clang static code analyzer.

Philippe Mathieu-Daud=C3=A9 (3):
  block/qcow2-bitmap: Remove unneeded variable assignment
  hw/display/qxl: Remove unneeded variable assignment
  hw/block/pflash_cfi02: Remove unneeded variable assignment

 block/qcow2-bitmap.c    | 1 -
 hw/block/pflash_cfi02.c | 1 -
 hw/display/qxl.c        | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

--=20
2.21.1


