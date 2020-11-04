Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB003C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310BF223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/Yekjwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310BF223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6yG-0005NP-4B
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nB-0006Mr-PT
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6n7-0004px-27
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOf6X564u68YDgrr4+ImRp2w40G6MZqV8eYk6Yyrpk4=;
 b=N/Yekjwiaezdrdy5bqOTDtGC4elhD4JCEhkuzF8G4AvMXWSfSp+AAAStrpuCyfy5kZb5Nf
 yuqI+hf7QCxd1RuK4syzrEzCT4t7Qc/j4WlJhmnPZdMrng4xMNUDIrBGfIdWp4vI9XMXdn
 ZwWNysTCYVEQgApJ47ktmq7r+zIP5I0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-EWfNmpFSPhSy29UJKR7V6w-1; Tue, 03 Nov 2020 19:36:40 -0500
X-MC-Unique: EWfNmpFSPhSy29UJKR7V6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDE071054FA5
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:33 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C847747C6;
 Wed,  4 Nov 2020 00:36:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/72] scripts/qemu-ga-client: apply (most) flake8 rules
Date: Tue,  3 Nov 2020 19:35:08 -0500
Message-Id: <20201104003602.1293560-19-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Line length should be < 80
- You shouldn't perform unscoped imports except at the top of the module

Notably, the sys.path hack creates problems with the import rule. This
will be fixed later.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qemu-ga-client | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index ae71b30dfa43..a12e0e9b2a6e 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -12,7 +12,8 @@
 # Start QEMU with:
 #
 # # qemu [...] -chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
-#   -device virtio-serial -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
+#   -device virtio-serial \
+#   -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
 #
 # Run the script:
 #
@@ -37,6 +38,7 @@
 #
 
 import base64
+import optparse
 import os
 import random
 import sys
@@ -94,9 +96,11 @@ class QemuGuestAgentClient:
         msgs = []
         msgs.append('version: ' + info['version'])
         msgs.append('supported_commands:')
-        enabled = [c['name'] for c in info['supported_commands'] if c['enabled']]
+        enabled = [c['name'] for c in info['supported_commands']
+                   if c['enabled']]
         msgs.append('\tenabled: ' + ', '.join(enabled))
-        disabled = [c['name'] for c in info['supported_commands'] if not c['enabled']]
+        disabled = [c['name'] for c in info['supported_commands']
+                    if not c['enabled']]
         msgs.append('\tdisabled: ' + ', '.join(disabled))
 
         return '\n'.join(msgs)
@@ -119,11 +123,11 @@ class QemuGuestAgentClient:
                     if ipaddr['ip-address-type'] == 'ipv4':
                         addr = ipaddr['ip-address']
                         mask = self.__gen_ipv4_netmask(int(ipaddr['prefix']))
-                        msgs.append("\tinet %s  netmask %s" % (addr, mask))
+                        msgs.append(f"\tinet {addr}  netmask {mask}")
                     elif ipaddr['ip-address-type'] == 'ipv6':
                         addr = ipaddr['ip-address']
                         prefix = ipaddr['prefix']
-                        msgs.append("\tinet6 %s  prefixlen %s" % (addr, prefix))
+                        msgs.append(f"\tinet6 {addr}  prefixlen {prefix}")
             if nif['hardware-address'] != '00:00:00:00:00:00':
                 msgs.append("\tether " + nif['hardware-address'])
 
@@ -237,6 +241,8 @@ def _cmd_suspend(client, args):
 
 def _cmd_shutdown(client, args):
     client.shutdown()
+
+
 _cmd_powerdown = _cmd_shutdown
 
 
@@ -280,17 +286,15 @@ def main(address, cmd, args):
 
 
 if __name__ == '__main__':
-    import optparse
-    import os
-    import sys
+    address = os.environ.get('QGA_CLIENT_ADDRESS')
 
-    address = os.environ['QGA_CLIENT_ADDRESS'] if 'QGA_CLIENT_ADDRESS' in os.environ else None
-
-    usage = "%prog [--address=<unix_path>|<ipv4_address>] <command> [args...]\n"
+    usage = ("%prog [--address=<unix_path>|<ipv4_address>]"
+             " <command> [args...]\n")
     usage += '<command>: ' + ', '.join(commands)
     parser = optparse.OptionParser(usage=usage)
     parser.add_option('--address', action='store', type='string',
-                      default=address, help='Specify a ip:port pair or a unix socket path')
+                      default=address,
+                      help='Specify a ip:port pair or a unix socket path')
     options, args = parser.parse_args()
 
     address = options.address
-- 
2.26.2


