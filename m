Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAC220734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBTgk5tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAC220734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisUF-0003ya-La
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLG-0000oa-FU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLF-0008Ka-06
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdv4ziay2Sv+upSlMJ3KLdxkcpgWNHmqMtF1sz11Yck=;
 b=hBTgk5tR4G1SZ8aXJsf45O3BoZTzBKqN8TvNvea/6OXwL+mKYXKfNbcvfF6hffgQCgvMyP
 VHdK3fLN8jm+FvRl8XUsFYt9lTzM2SLXmSZBiFwS0VuKLkIL26QBOCyC+LtjzBYJwWclsv
 FBq18ZiNJux3TdYkgkMCJL7HB8+TW0A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-XTaPwa-mPPGgBtnMnjOyMw-1; Wed, 10 Jun 2020 00:27:52 -0400
X-MC-Unique: XTaPwa-mPPGgBtnMnjOyMw-1
Received: by mail-wr1-f69.google.com with SMTP id n6so512394wrv.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gdv4ziay2Sv+upSlMJ3KLdxkcpgWNHmqMtF1sz11Yck=;
 b=IaPfXKXUuOtmhRgxXgVD452dDSGIj/ZwzC9aq9lkxA/1pa7NzzXvQCCMWg/AOROGdk
 KcXixSm4RrosobehTzzMyuUqIJzYvdc284gZW4CRO9e56JdMwiwrmPt38szOeZ5HspJA
 6Xx4y5nwNCJIlXjDUuGP1SnUYSkUKA3+sQZ+1gCYlh41xDAYMz6IHyswNEJbBsmvz07Z
 rOLjX6U+BV8uEb4ufmw9mdHD0sNA2Iq3aP2atq24k6/+iuSQRHnL0PMnZmHh43kx5WQD
 rQJHoL6N7e/WPiKGaTHQ2ROfxEmcLPU78or4iaSg+HW30EoiCFsu/1/4y9L3A3x/Sqra
 n+uQ==
X-Gm-Message-State: AOAM532xQ1WCPVy1dDbKB7fUE9v35g936gvKLxYoQNz0i3uP83ghsmAi
 D9dHRiDfm+1geFlu86TkO1pESbKe1SJ3+4fOhwBvLwlH3F5ShUuo7zsH2cXI37YQwlc1oN6awYB
 M13v07Yw+6+32gjQ=
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr1181310wmd.138.1591763270803; 
 Tue, 09 Jun 2020 21:27:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyShvsCdz3lYegUvuAHwD/LKF4mnLt1VkCGV64RCKvtS8yWnkdtwxzu6XDPsbsCMqnZ5+Ei9A==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr1181300wmd.138.1591763270569; 
 Tue, 09 Jun 2020 21:27:50 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id p16sm6559256wru.27.2020.06.09.21.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:50 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/56] char-socket: return -1 in case of disconnect during
 tcp_chr_write
Message-ID: <20200610042613.1459309-35-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>, Dima Stepanov <dimastep@yandex-team.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

During testing of the vhost-user-blk reconnect functionality the qemu
SIGSEGV was triggered:
 start qemu as:
 x86_64-softmmu/qemu-system-x86_64 -m 1024M -M q35 \
   -object memory-backend-file,id=ram-node0,size=1024M,mem-path=/dev/shm/qemu,share=on \
   -numa node,cpus=0,memdev=ram-node0 \
   -chardev socket,id=chardev0,path=./vhost.sock,noserver,reconnect=1 \
   -device vhost-user-blk-pci,chardev=chardev0,num-queues=4 --enable-kvm
 start vhost-user-blk daemon:
 ./vhost-user-blk -s ./vhost.sock -b test-img.raw

If vhost-user-blk will be killed during the vhost initialization
process, for instance after getting VHOST_SET_VRING_CALL command, then
QEMU will fail with the following backtrace:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x00005555559272bb in vhost_user_read (dev=0x7fffef2d53e0, msg=0x7fffffffd5b0)
    at ./hw/virtio/vhost-user.c:260
260         CharBackend *chr = u->user->chr;

 #0  0x00005555559272bb in vhost_user_read (dev=0x7fffef2d53e0, msg=0x7fffffffd5b0)
    at ./hw/virtio/vhost-user.c:260
 #1  0x000055555592acb8 in vhost_user_get_config (dev=0x7fffef2d53e0, config=0x7fffef2d5394 "", config_len=60)
    at ./hw/virtio/vhost-user.c:1645
 #2  0x0000555555925525 in vhost_dev_get_config (hdev=0x7fffef2d53e0, config=0x7fffef2d5394 "", config_len=60)
    at ./hw/virtio/vhost.c:1490
 #3  0x00005555558cc46b in vhost_user_blk_device_realize (dev=0x7fffef2d51a0, errp=0x7fffffffd8f0)
    at ./hw/block/vhost-user-blk.c:429
 #4  0x0000555555920090 in virtio_device_realize (dev=0x7fffef2d51a0, errp=0x7fffffffd948)
    at ./hw/virtio/virtio.c:3615
 #5  0x0000555555a9779c in device_set_realized (obj=0x7fffef2d51a0, value=true, errp=0x7fffffffdb88)
    at ./hw/core/qdev.c:891
 ...

The problem is that vhost_user_write doesn't get an error after
disconnect and try to call vhost_user_read(). The tcp_chr_write()
routine should return -1 in case of disconnect. Indicate the EIO error
if this routine is called in the disconnected state.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <aeb7806bfc945faadf09f64dcfa30f59de3ac053.1590396396.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 chardev/char-socket.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index db253d4024..18e762643b 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -175,15 +175,16 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
         if (ret < 0 && errno != EAGAIN) {
             if (tcp_chr_read_poll(chr) <= 0) {
+                /* Perform disconnect and return error. */
                 tcp_chr_disconnect_locked(chr);
-                return len;
             } /* else let the read handler finish it properly */
         }
 
         return ret;
     } else {
-        /* XXX: indicate an error ? */
-        return len;
+        /* Indicate an error. */
+        errno = EIO;
+        return -1;
     }
 }
 
-- 
MST


