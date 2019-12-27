Return-Path: <SRS0=GTQb=2R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3EC2D0C6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 13:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CE220882
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 13:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BF6owoGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CE220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikptK-0007wG-MO
	for qemu-devel@archiver.kernel.org; Fri, 27 Dec 2019 08:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ikprb-0006Hh-7n
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 08:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ikprZ-0002yh-Fi
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 08:41:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ikprZ-0002yT-CO
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 08:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577454068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsnPAQSkWvtcYpvI7N8qYJnicQPbC05o8HCtvE27HQw=;
 b=BF6owoGXdc8YBo1HWkJ0LiOMMF5KHX8u68s+CE2cARbdnZd8PFzv9a46AQXP3QZRiNtDtw
 SEjeOd2WpYhz7oGDiFDMZpIkbu4g6AiK26VtDqcNynRZYpzsv72WkvBqPAIgFgki+a6hee
 gEmOVxTpKOd5Z/pS06cw5FJ1MIullGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-71KYVSqFPGW6o9-_KXWFpQ-1; Fri, 27 Dec 2019 08:41:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A48E6801E7A
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2019 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-24.gru2.redhat.com
 [10.97.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4962781765;
 Fri, 27 Dec 2019 13:41:04 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] python/qemu: qmp: Replace socket.error with OSError
Date: Fri, 27 Dec 2019 10:40:57 -0300
Message-Id: <20191227134101.244496-2-wainersm@redhat.com>
In-Reply-To: <20191227134101.244496-1-wainersm@redhat.com>
References: <20191227134101.244496-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 71KYVSqFPGW6o9-_KXWFpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The socket.error is deprecated from Python 3.3, instead it is
made a link to OSError. This change replaces the occurences
of socket.error with OSError.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 python/qemu/qmp.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 5c8cf6a056..8c6c9847d0 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -47,7 +47,7 @@ class QEMUMonitorProtocol(object):
                         or a tuple in the form ( address, port ) for a TCP
                         connection
         @param server: server mode listens on the socket (bool)
-        @raise socket.error on socket connection errors
+        @raise OSError on socket connection errors
         @note No connection is established, this is done by the connect() =
or
               accept() methods
         """
@@ -107,8 +107,8 @@ class QEMUMonitorProtocol(object):
         self.__sock.setblocking(0)
         try:
             self.__json_read()
-        except socket.error as err:
-            if err[0] =3D=3D errno.EAGAIN:
+        except OSError as err:
+            if err.errno =3D=3D errno.EAGAIN:
                 # No data available
                 pass
         self.__sock.setblocking(1)
@@ -133,7 +133,7 @@ class QEMUMonitorProtocol(object):
         Connect to the QMP Monitor and perform capabilities negotiation.
=20
         @return QMP greeting dict
-        @raise socket.error on socket connection errors
+        @raise OSError on socket connection errors
         @raise QMPConnectError if the greeting is not received
         @raise QMPCapabilitiesError if fails to negotiate capabilities
         """
@@ -147,7 +147,7 @@ class QEMUMonitorProtocol(object):
         Await connection from QMP Monitor and perform capabilities negotia=
tion.
=20
         @return QMP greeting dict
-        @raise socket.error on socket connection errors
+        @raise OSError on socket connection errors
         @raise QMPConnectError if the greeting is not received
         @raise QMPCapabilitiesError if fails to negotiate capabilities
         """
@@ -167,10 +167,10 @@ class QEMUMonitorProtocol(object):
         self.logger.debug(">>> %s", qmp_cmd)
         try:
             self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
-        except socket.error as err:
-            if err[0] =3D=3D errno.EPIPE:
+        except OSError as err:
+            if err.errno =3D=3D errno.EPIPE:
                 return
-            raise socket.error(err)
+            raise err
         resp =3D self.__json_read()
         self.logger.debug("<<< %s", resp)
         return resp
--=20
2.23.0


