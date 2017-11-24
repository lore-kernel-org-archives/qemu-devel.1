Received: from eggs.gnu.org ([2001:4830:134:3::10]:45834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIH5Z-0001eX-FY
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 11:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIH5W-000794-7o
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 11:44:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eIH5V-0006qS-SW
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 11:44:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E17EFB652
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 16:44:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Nov 2017 17:44:22 +0100
Message-Id: <20171124164422.3960-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.11] contrib: add systemd unit files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This lets distros standardize on how QEMU should install systemd
services for qemu-ga and qemu-pr-helper.

The qemu-ga unit file comes from Fedora, but I checked that
Debian is using the same path for the virtio-serisal port.

I would like to include this in 2.11, so that the qemu-pr-helper
socket can be standardized across distros.  Note however that
the files are not installed.  We can add a configure option
in 2.12 perhaps, but it's too late now; documenting the files
in the release notes should do.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/systemd/qemu-guest-agent.service | 11 +++++++++++
 contrib/systemd/qemu-pr-helper.service   | 15 +++++++++++++++
 contrib/systemd/qemu-pr-helper.socket    |  9 +++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 contrib/systemd/qemu-guest-agent.service
 create mode 100644 contrib/systemd/qemu-pr-helper.service
 create mode 100644 contrib/systemd/qemu-pr-helper.socket

diff --git a/contrib/systemd/qemu-guest-agent.service b/contrib/systemd/qemu-guest-agent.service
new file mode 100644
index 0000000000..51cd7b37ff
--- /dev/null
+++ b/contrib/systemd/qemu-guest-agent.service
@@ -0,0 +1,11 @@
+[Unit]
+Description=QEMU Guest Agent
+BindTo=dev-virtio\x2dports-org.qemu.guest_agent.0.device
+After=dev-virtio\x2dports-org.qemu.guest_agent.0.device
+
+[Service]
+ExecStart=-/usr/bin/qemu-ga
+Restart=always
+RestartSec=0
+
+[Install]
diff --git a/contrib/systemd/qemu-pr-helper.service b/contrib/systemd/qemu-pr-helper.service
new file mode 100644
index 0000000000..a1d27b0221
--- /dev/null
+++ b/contrib/systemd/qemu-pr-helper.service
@@ -0,0 +1,15 @@
+[Unit]
+Description=Persistent Reservation Daemon for QEMU
+
+[Service]
+WorkingDirectory=/tmp
+Type=simple
+ExecStart=/usr/bin/qemu-pr-helper
+PrivateTmp=yes
+ProtectSystem=strict
+ReadWritePaths=/var/run
+RestrictAddressFamilies=AF_UNIX
+Restart=always
+RestartSec=0
+
+[Install]
diff --git a/contrib/systemd/qemu-pr-helper.socket b/contrib/systemd/qemu-pr-helper.socket
new file mode 100644
index 0000000000..9d7c3e5e2c
--- /dev/null
+++ b/contrib/systemd/qemu-pr-helper.socket
@@ -0,0 +1,9 @@
+[Unit]
+Description=Persistent Reservation Daemon for QEMU
+
+[Socket]
+ListenStream=/run/qemu-pr-helper.sock
+SocketMode=0600
+
+[Install]
+WantedBy=multi-user.target
-- 
2.14.3
