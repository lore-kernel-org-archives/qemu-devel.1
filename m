Received: from eggs.gnu.org ([2001:4830:134:3::10]:56064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhxz-0004G6-Oy
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhxy-0006zA-PL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:39 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:41923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhxy-0006yW-I9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:38 -0500
Received: by mail-wr0-x232.google.com with SMTP id p69so14070847wrb.8
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:38 -0800 (PST)
Received: from 640k.lan (dynamic-adsl-78-12-251-125.clienti.tiscali.it.
	[78.12.251.125]) by smtp.gmail.com with ESMTPSA id
	f125sm2751101wme.45.2017.12.20.09.15.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 20 Dec 2017 09:15:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:16 +0100
Message-Id: <1513790098-9815-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/46] contrib: add systemd unit files
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
Message-Id: <20171124164422.3960-1-pbonzini@redhat.com>
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
index 0000000..51cd7b3
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
index 0000000..a1d27b0
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
index 0000000..9d7c3e5
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
1.8.3.1
