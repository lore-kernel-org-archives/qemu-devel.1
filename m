Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A96C2D0D2
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58872082E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5w/H4yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58872082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTDi-00077c-MI
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAI-0002Pf-N2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAH-0006K6-6h
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAG-0006Dc-Vb
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id u2so10932184wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4rxzMXDh2umxV3T+Q0o883/DwawMbdM0BPJwurk6og0=;
 b=u5w/H4yNTIpmqedqVeh8zzVq9AIZgSCgYOdeO74nmXzZzfhO35exjqx5Zrs5UC2EJh
 g6GxqC4PycOqNERbeo1SaetDjUofGI2KSLheaqpogd6amS7JNDaKq0RDUxTIGJZGZOQK
 t2U707Q0IwvjnQmP1X2TD1ZEMAfXWD8FMUuRmDMHAFl2OlVNsw0Kg1BWzzYWerU6pruT
 BJRo90kKv9b5p5ZL2y20fxnH/2MOS/prLhiCET/NcTufAW7ryHypcwKdaYRBq0lfO91Y
 ISLa7f82SI36twCHwanVPY8R4r1xS3J6L+5V1RXzaYwtu5tlOQoCmOn6gzWy5mVt8MSU
 gZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4rxzMXDh2umxV3T+Q0o883/DwawMbdM0BPJwurk6og0=;
 b=cvEOZYy7KWOSqwoBhbcd8vZBx3tHw2BEwtZkfbgbsdThW4FO7pbvLek6ScYQHfxgMq
 98BdykqXF2jUeVlWWfaUUaAkYy4MbpXwMjemQ4N14U/BdZJgePmKvHa8AzvwB04JEJX9
 /7oPE8CNkwM1XEXsxovbrHCuR9WFCDSwbKeOaMx1MhdLLN/ilTeTbiNAqAeI9O0YvgGn
 KACLuJwqsQK+F0qScw521n8hIItGJgQN+GCyIzf028SUodRP3lV2RHUuFVcflz/OO3D2
 XzzsyW/meD1R9JXYv1kk4Rka6Tjclm3OGjeF4V0ZcH/sG62fQbAlUXuawP3wBANdzTgP
 h/aQ==
X-Gm-Message-State: APjAAAV+e4OCtObEDyq+LUlevNrxOMlG9TgCJpFn1pBG0DeI4/ifm5O1
 GfsKdNsei2To8ecqDD1s4rUyqM1y
X-Google-Smtp-Source: APXvYqxQo4d9lO5PRCeIelFFDN2EKmdNUI5IgEP0xiv3M4qDieWApXAwu1dKuphktEzCBtQQXiF89Q==
X-Received: by 2002:a1c:bbc3:: with SMTP id
 l186mr19264112wmf.101.1576890159171; 
 Fri, 20 Dec 2019 17:02:39 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t125sm8449596wmf.17.2019.12.20.17.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 17:02:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 0/8] hw/avr: Introduce the Arduino boards
Date: Sat, 21 Dec 2019 02:02:18 +0100
Message-Id: <20191221010226.9230-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 Phillip Stevens <phillip.stevens@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series add the arduino boards, aiming at removing the
'sample' board that doesn't follow any specification.

Since v1:
- Addressed Igor comments
- Addressed Aleksandar comments
- Fixed UART issue (was due to IRQ shifted by 2 in CPU)

TODO after merge is:
- Extract Timer8 common parts from Timer16
- Add GPIOs
- Connect LED to GPIO on Arduino
- Plug to Scratch (See http://s4a.cat/).
  (I plan to purpose that as a GSoC idea).

Thank you for having insisted with this port during so long!

Regards,

Phil.

Based-on: <20191218210329.1960-1-mrolnik@gmail.com>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg666384.html
Cc: Stefan Hajnoczi <stefanha@redhat.com> (for GSoC idea)
Cc: Phillip Stevens <phillip.stevens@gmail.com> (for FreeRTOS example)

Philippe Mathieu-Daudé (8):
  hw/char/avr: Reduce USART I/O size
  hw/timer/avr_timer16: Rename memory region debugging name
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add some Arduino boards
  tests/boot-serial-test: Test some Arduino boards (AVR based)
  tests/acceptance: Do not set the machine type manually
  tests/acceptance: Keep multilines comment consistent with other tests
  tests/acceptance: Test the Arduino MEGA2560 board

 hw/avr/atmega.h                  |  48 ++++
 hw/avr/arduino.c                 | 177 ++++++++++++
 hw/avr/atmega.c                  | 460 +++++++++++++++++++++++++++++++
 hw/char/avr_usart.c              |   2 +-
 hw/timer/avr_timer16.c           |   6 +-
 tests/boot-serial-test.c         |   2 +
 hw/avr/Makefile.objs             |   2 +
 tests/acceptance/machine_avr6.py |  11 +-
 8 files changed, 697 insertions(+), 11 deletions(-)
 create mode 100644 hw/avr/atmega.h
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmega.c

-- 
2.21.0


