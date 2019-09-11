Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6982C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED0B2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPqwVH/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED0B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82hL-0004Vx-TB
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i82fw-0003Io-Qo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i82fw-00025E-08
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:48 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i82fv-00024k-Oe
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:47 -0400
Received: by mail-ed1-x542.google.com with SMTP id u6so20628080edq.6
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=CznsfNqRFkEaozvL8QNATJ8LsCtwZTAqu3w3onXT/ZQ=;
 b=WPqwVH/w7vCF5mwqscvMPPQbLncaFb/s1Fhtj310aqCOj6epZKIYZbvCqS7WyN6J6S
 VR94rbVjT6U+4PSqsilo09bhWaGpiZiS3VrbE6aQ/Qpn2GTGanNlMo7oV/IRii30MuNK
 8i8UxfpzREhAFcig9IJ92E3vYYjLxYex5UfLJAPkkqnSDuH0i165FYKe45OVuWSoOXGL
 71fkh/ZzGzU1Be8v9wxQfWg9NrCmolm9hBfEnjWb3rdxAxordZga+Mo92ymhfl0DfmUt
 EDsywi1hxAeoaoKGhSfUMOR/QfKT+ufU/76xo4h2qFrJbmb0YdvjKus6DMWJISKPww6i
 68Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CznsfNqRFkEaozvL8QNATJ8LsCtwZTAqu3w3onXT/ZQ=;
 b=dGlHJQLyKIJVibY2Q0U14Wz2zoZj+9FJVyseOXcpgqQhu9VYXMOYiusPD/dFXoNl6V
 QGmSZEnfbIrjVRI30niP0gXhbBHY1puLSnSqidIpLVrbRsr5rg17h9kP+TCwonqf2uAW
 QdvN6AJASv8sFFXswiGQe5PtMVUrVcC51QYKloXDMFRRkQWXUDDgGvAoF3Dgu9IWOlaE
 lJoOxFLSUOaubZVLDhTatLvrCx9KnJroWFdD1vqTBqoAxYuLlDA7KiOcUAWFfPuZ/1rr
 KuKsx7MoEmysO4PVgn3XK9wQHyM7exp202i9jmxk9+fzUieImSg2QPA0/IXOcgqFKPP+
 hZdQ==
X-Gm-Message-State: APjAAAXH1gEXvPSvY/3qFRRIA5KvH5ZjGmbgTYTK9yQqy6Hj1t4R3hEl
 pO57mSqNw3xDzNia+KI1pZQWtkKE
X-Google-Smtp-Source: APXvYqx/ruV7vQqif64tv6wCsIB5cKqQRb88+Pa+5emAGE/E2eiqLbhVxpOjZcClRsSo5HWf0v1otw==
X-Received: by 2002:a17:906:19d6:: with SMTP id
 h22mr29931473ejd.61.1568208526447; 
 Wed, 11 Sep 2019 06:28:46 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id f57sm2471923edd.4.2019.09.11.06.28.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Sep 2019 06:28:45 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 13:28:37 +0000
Message-Id: <20190911132839.23336-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: [Qemu-devel] [PATCH V2 0/2] migration/qemu-file: cleanup and refine
 qemu-file
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
Cc: Wei Yang <richard.weiyang@gmail.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two cleanup:

Patch #1 make code consistent on calling add_to_iovec
Patch #2 refine the code to handle the case when buf already flushed

v2:
  * wrap common steps into add_buf_to_iovec()

Wei Yang (2):
  migration/qemu-file: remove check on writev_buffer in
    qemu_put_compression_data
  migration/qemu-file: fix potential buf waste for extra buf_index
    adjustment

 migration/qemu-file.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

-- 
2.15.1


