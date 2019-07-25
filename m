Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F929C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FF6229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FF6229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfiz-0003qg-1O
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48945)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfiR-0002Tu-3T
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfiP-0001pD-UR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:34 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:44810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfiP-0001p4-QW
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:33 -0400
Received: by mail-qk1-f176.google.com with SMTP id d79so36693001qke.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=B3UY5a3GSETbHrcSK3vVNYdNg0sS9rUjkdxwFi9HF2M=;
 b=Nb38ls/V1eushyxO6ylrLLrITozt4S8qg1cQkK6pmJmexVVv2Prb/jXgrkz+YgY94T
 +amXEWzhejsTwioVx9lhT2TDH+ofPO3GZAAP/0w8WVHGAKUKmKLIbzFUxpW1Cfa4hhUE
 NF9QVmDyET50cyBGx395sAF43HO73nEZQy2b8Jb8SAiQjHbc2ZVW5mxu+A6SRITzKdRS
 5BCfwPD7im6XmhWcPGAGdS/Uw9K0u7jJvBvotq/PymVwAgbthQwZb0rkFyvUswYeL2ui
 QuVY/F5LP9vncSifrslLhJYdsshJtuCF8bM1tZIXlsxNqlH4GuF0qp/K9eGyCYTE/ijP
 Tozg==
X-Gm-Message-State: APjAAAV+ko8YUbxLOiLSy0gGR+KHHipv9HWiOp6ZwXB6mlnoT6Zkw8L9
 WQGeRbFh/98hItf+08CANdvmIHDQKzeA6A==
X-Google-Smtp-Source: APXvYqwkB00o503MheE21nrKomd323zNnDCeyU9yooF7IAw9QEQjuDMkIj2hz8i/FP2g5Di4xQqV8w==
X-Received: by 2002:a37:7ec7:: with SMTP id
 z190mr59403606qkc.347.1564068692947; 
 Thu, 25 Jul 2019 08:31:32 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 c5sm23318181qkb.41.2019.07.25.08.31.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:31:32 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:31:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190624091304.666-1-stefanha@redhat.com>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.176
Subject: [Qemu-devel] [PULL 01/12] docs: clarify multiqueue vs multiple
 virtqueues
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725153128.ZS35uro8mbDsHoaQvKgrW5vv1sFCsId6jyapjXIW6AQ@z>

From: Stefan Hajnoczi <stefanha@redhat.com>

The vhost-user specification does not explain when
VHOST_USER_PROTOCOL_F_MQ must be implemented.  This may lead
implementors of vhost-user masters to believe that this protocol feature
is required for any device that has multiple virtqueues.  That would be
a mistake since existing vhost-user slaves offer multiple virtqueues but
do not advertise VHOST_USER_PROTOCOL_F_MQ.

For example, a vhost-net device with one rx/tx queue pair is not
multiqueue.  The slave does not need to advertise
VHOST_USER_PROTOCOL_F_MQ.  Therefore the master must assume it has these
virtqueues and cannot rely on askingt the slave how many virtqueues
exist.

Extend the specification to explain the different between true
multiqueue and regular devices with a fixed virtqueue layout.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190624091304.666-1-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/interop/vhost-user.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5750668aba..7827b710aa 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -324,6 +324,15 @@ must support changing some configuration aspects on the fly.
 Multiple queue support
 ----------------------
 
+Many devices have a fixed number of virtqueues.  In this case the master
+already knows the number of available virtqueues without communicating with the
+slave.
+
+Some devices do not have a fixed number of virtqueues.  Instead the maximum
+number of virtqueues is chosen by the slave.  The number can depend on host
+resource availability or slave implementation details.  Such devices are called
+multiple queue devices.
+
 Multiple queue support allows the slave to advertise the maximum number of
 queues.  This is treated as a protocol extension, hence the slave has to
 implement protocol features first. The multiple queues feature is supported
@@ -339,6 +348,14 @@ queue in the sent message to identify a specified queue.
 The master enables queues by sending message ``VHOST_USER_SET_VRING_ENABLE``.
 vhost-user-net has historically automatically enabled the first queue pair.
 
+Slaves should always implement the ``VHOST_USER_PROTOCOL_F_MQ`` protocol
+feature, even for devices with a fixed number of virtqueues, since it is simple
+to implement and offers a degree of introspection.
+
+Masters must not rely on the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature for
+devices with a fixed number of virtqueues.  Only true multiqueue devices
+require this protocol feature.
+
 Migration
 ---------
 
-- 
MST


