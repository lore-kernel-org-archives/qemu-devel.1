Received: from eggs.gnu.org ([2001:4830:134:3::10]:35411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85TM-0008CP-No
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85TL-0008Db-CN
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d85TL-0008DF-38
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03AF4C027390
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 13:46:38 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  9 May 2017 14:46:20 +0100
Message-Id: <20170509134623.13120-2-berrange@redhat.com>
In-Reply-To: <20170509134623.13120-1-berrange@redhat.com>
References: <20170509134623.13120-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/4] Default to GSSAPI (Kerberos) instead of
 DIGEST-MD5 for SASL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

RFC 6331 documents a number of serious security weaknesses in
the SASL DIGEST-MD5 mechanism. As such, QEMU should not be
using or recommending it as a default mechanism for VNC auth
with SASL.

GSSAPI (Kerberos) is the only other viable SASL mechanism that
can provide secure session encryption so enable that by defalt
as the replacement. If users have TLS enabled for VNC, they can
optionally decide to use SCRAM-SHA-1 instead of GSSAPI, allowing
plain username and password auth.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-doc.texi | 50 +++++++++++++++++++++++++++++---------------------
 qemu.sasl     | 54 +++++++++++++++++++++++++++++++-----------------------
 2 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 794ab4a..a4be714 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1732,37 +1732,45 @@ SASL service config /etc/sasl2/qemu.conf. If running QEMU as an
 unprivileged user, an environment variable SASL_CONF_PATH can be used
 to make it search alternate locations for the service config.
 
-The default configuration might contain
+If the TLS option is enabled for VNC, then it will provide session encryption,
+otherwise the SASL mechanism will have to provide encryption. In the latter
+case the list of possible plugins that can be used is drastically reduced. In
+fact only the GSSAPI SASL mechanism provides an acceptable level of security
+by modern standards. Previous versions of QEMU referred to the DIGEST-MD5
+mechanism, however, it has multiple serious flaws described in detail in
+RFC 6331 and thus should never be used any more. The SCRAM-SHA-1 mechanism
+provides a simple username/password auth facility similar to DIGEST-MD5, but
+does not support session encryption, so can only be used in combination with
+TLS.
+
+When not using TLS the recommended configuration is
 
 @example
-mech_list: digest-md5
-sasldb_path: /etc/qemu/passwd.db
+mech_list: gssapi
+keytab: /etc/qemu/krb5.tab
 @end example
 
-This says to use the 'Digest MD5' mechanism, which is similar to the HTTP
-Digest-MD5 mechanism. The list of valid usernames & passwords is maintained
-in the /etc/qemu/passwd.db file, and can be updated using the saslpasswd2
-command. While this mechanism is easy to configure and use, it is not
-considered secure by modern standards, so only suitable for developers /
-ad-hoc testing.
+This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol, with
+the server principal stored in /etc/qemu/krb5.tab. For this to work the
+administrator of your KDC must generate a Kerberos principal for the server,
+with a name of 'qemu/somehost.example.com@@EXAMPLE.COM' replacing
+'somehost.example.com' with the fully qualified host name of the machine
+running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
 
-A more serious deployment might use Kerberos, which is done with the 'gssapi'
-mechanism
+When using TLS, if username+password authentication is desired, then a
+reasonable configuration is
 
 @example
-mech_list: gssapi
-keytab: /etc/qemu/krb5.tab
+mech_list: scram-sha-1
+sasldb_path: /etc/qemu/passwd.db
 @end example
 
-For this to work the administrator of your KDC must generate a Kerberos
-principal for the server, with a name of  'qemu/somehost.example.com@@EXAMPLE.COM'
-replacing 'somehost.example.com' with the fully qualified host name of the
-machine running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
+The saslpasswd2 program can be used to populate the passwd.db file with
+accounts.
 
-Other configurations will be left as an exercise for the reader. It should
-be noted that only Digest-MD5 and GSSAPI provides a SSF layer for data
-encryption. For all other mechanisms, VNC should always be configured to
-use TLS and x509 certificates to protect security credentials from snooping.
+Other SASL configurations will be left as an exercise for the reader. Note that
+all mechanisms except GSSAPI, should be combined with use of TLS to ensure a
+secure data channel.
 
 @node gdb_usage
 @section GDB usage
diff --git a/qemu.sasl b/qemu.sasl
index 64fdef3..fb8a92b 100644
--- a/qemu.sasl
+++ b/qemu.sasl
@@ -1,36 +1,44 @@
-# If you want to use the non-TLS socket, then you *must* include
-# the GSSAPI or DIGEST-MD5 mechanisms, because they are the only
-# ones that can offer session encryption as well as authentication.
+# If you want to use VNC remotely without TLS, then you *must*
+# pick a mechanism which provides session encryption as well
+# as authentication.
 #
-# If you're only using TLS, then you can turn on any mechanisms
+# If you are only using TLS, then you can turn on any mechanisms
 # you like for authentication, because TLS provides the encryption
 #
-# Default to a simple username+password mechanism
-# NB digest-md5 is no longer considered secure by current standards
-mech_list: digest-md5
+# If you are only using UNIX sockets then encryption is not
+# required at all.
+#
+# NB, previously DIGEST-MD5 was set as the default mechanism for
+# QEMU VNC. Per RFC 6331 this is vulnerable to many serious security
+# flaws as should no longer be used. Thus GSSAPI is now the default.
+#
+# To use GSSAPI requires that a QEMU service principal is
+# added to the Kerberos server for each host running QEMU.
+# This principal needs to be exported to the keytab file listed below
+mech_list: gssapi
 
-# Before you can use GSSAPI, you need a service principle on the
-# KDC server for libvirt, and that to be exported to the keytab
-# file listed below
-#mech_list: gssapi
+# If using TLS with VNC, or a UNIX socket only, it is possible to
+# enable plugins which don't provide session encryption. The
+# 'scram-sha-1' plugin allows plain username/password authentication
+# to be performed
 #
-# You can also list many mechanisms at once, then the user can choose
-# by adding  '?auth=sasl.gssapi' to their libvirt URI, eg
-#   qemu+tcp://hostname/system?auth=sasl.gssapi
-#mech_list: digest-md5 gssapi
+#mech_list: scram-sha-1
+
+# You can also list many mechanisms at once, and the VNC server will
+# negotiate which to use by considering the list enabled on the VNC
+# client.
+#mech_list: scram-sha-1 gssapi
 
 # Some older builds of MIT kerberos on Linux ignore this option &
 # instead need KRB5_KTNAME env var.
 # For modern Linux, and other OS, this should be sufficient
 #
-# There is no default value here, uncomment if you need this
-#keytab: /etc/qemu/krb5.tab
+# This file needs to be populated with the service principal that
+# was created on the Kerberos v5 server. If switching to a non-gssapi
+# mechanism this can be commented out.
+keytab: /etc/qemu/krb5.tab
 
-# If using digest-md5 for username/passwds, then this is the file
+# If using scram-sha-1 for username/passwds, then this is the file
 # containing the passwds. Use 'saslpasswd2 -a qemu [username]'
 # to add entries, and 'sasldblistusers2 -f [sasldb_path]' to browse it
-sasldb_path: /etc/qemu/passwd.db
-
-
-auxprop_plugin: sasldb
-
+#sasldb_path: /etc/qemu/passwd.db
-- 
2.9.3
