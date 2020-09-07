Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09402C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A27E2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3lKlNVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A27E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5nI-0000IM-Eq
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF5l8-0005D3-Q8
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:15:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50142
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF5l6-0003HO-AT
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599441345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qIS5RL+Gs74fRPFtUy5AxKUGZXvhlPxPbHtxGys/y1I=;
 b=X3lKlNVCIa0ClLg5ehkHZAsPYWJVhaQ2AmIufX69g9GFqb711pvGyruTypFcJEGKbBdkEU
 44vSgfkEVNZGvu3RMZ1yNCJNxEpc3UtT6TNcA2tWwk1Uh+qmSp71d/9FTY5mx2D7kLtob9
 fThQvjSfXd2FKUA7S748+2qfTh3HMYk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-TbcGWhjtMLKMG9fWjfNnlw-1; Sun, 06 Sep 2020 21:15:42 -0400
X-MC-Unique: TbcGWhjtMLKMG9fWjfNnlw-1
Received: by mail-wr1-f69.google.com with SMTP id k13so3518529wrw.16
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 18:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qIS5RL+Gs74fRPFtUy5AxKUGZXvhlPxPbHtxGys/y1I=;
 b=JyoXB0vc/4wKuzQ++xZapicuKH+uVRMf84hPZqIbtNs2Oob+01TrZHco9JdkQt54Le
 0BqBcmNKgHz12UG9jEjYknv8Z6KNC6SCc93ggJZ+uCM7XKClAilWtefyQNJ0OFvw84P4
 W2k+JAdWrBMqXSDYI81dga8MIZha4JkgLFGuS/rZPJ9bHrmD/dn8Ui+hM0q7A1cTzq/q
 XjaDsqLWi4N87MKQEfoT9vrcfBxj400r5AQ6DTxgtkTibJSk95Wo1RfXmlGLL4LHx2Rf
 GCW0MeMOGWy3XfukbHXt+cO8AXodkl+GBbKQ+VdUhi0dahq/bzOJS70KdDcEts8gyUeg
 UdqQ==
X-Gm-Message-State: AOAM531pd9nROVQ06jWiJYXiCYqv+cxhw8fAcGVaP2JoUfSgDQ3QbDcn
 yvyfq2oY59reBXC9EX8ywj3V+JbHYotxNUX1/3IysWkOYJ0RQeC5dwN+tjzkG0EH0fbckOgq3yS
 PObUX8drsZINp3/o=
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr7940599wrq.297.1599441340943; 
 Sun, 06 Sep 2020 18:15:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8UDacsew+zfAGWdeWP9PQWws6wwIvAC1nkTH8H79fBd+viulBuu83KP8wt4W6ykgcBohMAA==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr7940583wrq.297.1599441340767; 
 Sun, 06 Sep 2020 18:15:40 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k22sm25872093wrd.29.2020.09.06.18.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:15:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] hw/char: Remove TYPE_SERIAL_IO
Date: Mon,  7 Sep 2020 03:15:36 +0200
Message-Id: <20200907011538.818996-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 21:15:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the TYPE_SERIAL_IO which is simply a superset of
TYPE_SERIAL_MM, as suggested by Paolo and Peter here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg721806.html

Since v1:
- Reword migration comment (Marc-André)

Philippe Mathieu-Daudé (2):
  hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
  hw/char/serial: Remove TYPE_SERIAL_IO (superset of TYPE_SERIAL_MM)

 include/hw/char/serial.h |  9 ---------
 hw/char/serial.c         | 41 ----------------------------------------
 hw/mips/mipssim.c        |  5 +++--
 3 files changed, 3 insertions(+), 52 deletions(-)

-- 
2.26.2


