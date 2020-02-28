Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A795EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733172467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiqP7gF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733172467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iJ5-0000EW-KI
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7iIF-0007SB-S9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7iIE-0006KJ-3a
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31502
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7iIE-0006Jm-0C
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582906513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C9640rUAjpviNshx6LDTNOAy3oPg+kOruFP1DZrwdO8=;
 b=CiqP7gF3akI6bkG8anclhwJJ/HuuGqskfTQwZseeEl0I4t9utA2XaKvTjratFdmWsqwu+j
 eZbAPCNRnWe5/op1XkNDiY8LUt/T6cHdYhA03UtZdhe1A6LY2tIMgvg0Fh5icU2ozQUKlR
 f0Dy7Y9pO9ZyMai2QsMoz8aHq9e/CYM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-4VuFM64PMkOgusez3yPg7g-1; Fri, 28 Feb 2020 11:15:07 -0500
X-MC-Unique: 4VuFM64PMkOgusez3yPg7g-1
Received: by mail-qk1-f198.google.com with SMTP id 205so3318203qkg.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s94Ca9pAMmAvav2blTufA3RgnkjJ4014cp9prKvCvyA=;
 b=qPuYtBKncLd1filobjYCvjEOFwu6AZUNfPgaMxwD8t8h+/9QYMwEWJbYYDtKT/qfTr
 s/LDdX9AjqEfgkwnsn58HXk7YI4ALJ2CkOMOo4iPQMlzbeHXclQ2OeKlDfoG3tAAxYdf
 Uvq+jAGp9Rl2EBBdyM1cqN2DnmLbGblEzItdy/UM37AunNZAi7dXzHL90iO++j72RXP+
 YrN1ykZdSqpvVlPTCNr8VrNcJy58eHxHMOAUmD2Iyi17y69QxR5Qy2CZ6mEkB+a02hlh
 BIRvgHUwef8Pjqduml7sj6v5skuufol8+hB/s7wx+fxD9PEEoP/VbBfSLmkAwc0MMTRj
 Xy0w==
X-Gm-Message-State: APjAAAXKfWxtis8GahaeCNo0u8C7O+v5OgmzO9xoqpxwASVUssCSliFI
 1VDCrzwfKGGksm0WLkcDxfwhi468hSqzOYRg7dbGw8tl0F1qdbZTjHDZPSDTqZvhaz0d9w5bq38
 w/wC0WapBg6Q3LQw=
X-Received: by 2002:ac8:664f:: with SMTP id j15mr4899916qtp.267.1582906506191; 
 Fri, 28 Feb 2020 08:15:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3sulcWd1UDn+oQxtpaQQvatquWcR+iq8zu/vj1R9IMPK5/36MqeeB3XxmCRejDI1ArwcmuA==
X-Received: by 2002:ac8:664f:: with SMTP id j15mr4899870qtp.267.1582906505737; 
 Fri, 28 Feb 2020 08:15:05 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id x44sm3769833qtc.88.2020.02.28.08.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:15:04 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
Date: Fri, 28 Feb 2020 11:14:58 -0500
Message-Id: <20200228161503.382656-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
- pick tags
- don't register resamplefd with KVM kernel when the userspace
  resamplefd path is enabled (should enable fast path on new kernels)
- fix resamplefd mem leak
- fix commit message of patch 4 [Eric]
- let kvm_resample_fd_notify() return a boolean, skip ioapic check if
  returned true
- more comments here and there in the code to state the fact that
  userspace ioapic irr & remote-irr are bypassed [Paolo]

VFIO INTx is not working with split irqchip.  On new kernels KVM_IRQFD
will directly fail with resamplefd attached so QEMU will automatically
fallback to the INTx slow path.  However on old kernels it's still
broken.

Only until recently I noticed that this could also break PXE boot for
assigned NICs [1].  My wild guess is that the PXE ROM will be mostly
using INTx as well, which means we can't bypass that even if we
enables MSI for the guest kernel.

This series tries to first fix this issue function-wise, then speed up
for the INTx again with resamplefd (mostly following the ideas
proposed by Paolo one year ago [2]).  My TCP_RR test shows that:

  - Before this series: this is broken, no number to show

  - After patch 1 (enable slow path): get 63% perf comparing to full
    kernel irqchip

  - After whole series (enable fast path partly, irq injection will be
    the same as fast path, however userspace needs to intercept for
    EOI broadcast to resamplefd, though should still be faster than
    the MMIO trick for intx eoi): get 93% perf comparing to full
    kernel irqchip, which is a 46% performance boost

I think we can consider to apply patch 1 even sooner than the rest of
the series to unbreak intx+split first.

The whole test matrix for reference:

  |----------+---------+-------------------+--------------+----------------=
----|
  | IRQ type | irqchip | TCP_STREAM (Gbps) | TCP_RR (pps) | note           =
    |
  |----------+---------+-------------------+--------------+----------------=
----|
  | msi      | on      |              9.39 |        17567 |                =
    |
  | nomsi    | on      |              9.29 |        14056 |                =
    |
  | msi      | split   |              9.36 |        17330 |                =
    |
  | nomsi    | split   |                 / |            / | currently broke=
n   |
  | nomsi    | split   |              8.98 |         8977 | after patch 1  =
    |
  | nomsi    | split   |              9.21 |        13142 | after whole ser=
ies |
  |----------+---------+-------------------+--------------+----------------=
----|

Any review comment is welcomed.  Thanks,

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1786404
[2] https://patchwork.kernel.org/patch/10738541/#22609933

Peter Xu (5):
  vfio/pci: Disable INTx fast path if using split irqchip
  vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for irqfds
  KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
  KVM: Kick resamplefd for split kernel irqchip
  Revert "vfio/pci: Disable INTx fast path if using split irqchip"

 accel/kvm/kvm-all.c    | 101 +++++++++++++++++++++++++++++++++++++----
 accel/kvm/trace-events |   1 +
 hw/intc/ioapic.c       |  23 +++++++++-
 hw/vfio/pci.c          |  37 ++++++---------
 include/sysemu/kvm.h   |   7 +++
 5 files changed, 137 insertions(+), 32 deletions(-)

--=20
2.24.1


