Received: from eggs.gnu.org ([2001:4830:134:3::10]:50456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVOwj-0005el-8d
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVOwf-0005og-Uh
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dVOwf-0005m1-LW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58A817CE0E
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 21:13:16 +0000 (UTC)
Date: Wed, 12 Jul 2017 23:13:05 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170712211305.ajtizorj4yq6jble@localhost.localdomain>
References: <20170712094149.23069-1-jfreimann@redhat.com>
	<20170712180550-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20170712180550-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH RFC 0/3] tests/pxe-testt: add testcase
 using vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com

On Wed, Jul 12, 2017 at 06:10:05PM +0300, Michael S. Tsirkin wrote:
>On Wed, Jul 12, 2017 at 11:41:46AM +0200, Jens Freimann wrote:
>> This implements a testcase for pxe-test using the vhost-user interface. Spawn a
>> vhost-user-bridge process and connect it to the qemu process.
>>
>> It is send as an RFC because:
>>  - Patch 3/3: there must be cleaner way to do this.
>>  - Does Patch 1/3 make sense or should I just redirect all output to /dev/null?
>>  - don't hardcode port numbers in qemu cmdline, create socket and pass
>>     fd to -netdev (need to figure out how to do this)
>
>Doesn't this work?
>
>-netdev socket,id=str[,fd=h]

It should. But I get this:

        dded sock 5 for watching. max_sock: 5
        Sock 3 removed from dispatcher watch.
        qemu: error: specified mcastaddr "127.0.0.1" (0x7f000001) does not contain a multicast address
        qemu-system-x86_64: -netdev socket,id=n1,fd=3: Device 'socket' could not be initialized
        Broken pipe
 
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 5a0d182..a14c1d9 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -29,7 +29,7 @@
 #define QEMU_CMD_NETDEV " -device virtio-net-pci,netdev=net0 "\
                         " -netdev vhost-user,id=net0,chardev=%s,vhostforce "\
                         " -netdev user,id=n0,tftp=./,bootfile=%s "\
-                        " -netdev socket,id=n1,udp=localhost:%d,localaddr=localhost:%d"
+                        " -netdev socket,id=n1,fd=%d"
 #define QEMU_CMD_NET    " -device virtio-net-pci,netdev=n0 "\
                         " -device virtio-net-pci,netdev=n1 "
 
@@ -72,16 +72,42 @@ static const char *init_hugepagefs(const char *path)
     return path;
 }
 
+static int vubr_create_socket(struct sockaddr_in *si_remote, int rport)
+{
+    int sock =  -1;
+
+    if (inet_aton("127.0.0.1", (struct in_addr *) &si_remote->sin_addr.s_addr) == 0) {
+        g_test_message("inet_aton failed\n");
+        return -1;
+    }
+
+    sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+    if (sock == -1) {
+        g_test_message("socket creation failed\n");
+    }
+    if (connect(sock, (struct sockaddr *) si_remote, sizeof(*si_remote))) {
+        printf("connect, %d", errno);
+        return -1;
+    }
+
+    return sock;
+}
+
 static void test_pxe_vhost_user(void)
 {
     char template[] = "/tmp/vhost-user-bridge-XXXXXX";
     char template2[] = "/tmp/hugepages-XXXXXX";
     gchar *vubr_args[] = {NULL, NULL, NULL, NULL};
+    struct sockaddr_in si_remote = {
+        .sin_family = AF_INET,
+        .sin_port = htons(RPORT),
+    };
     const char *hugefs;
     GError *error = NULL;
     char *vubr_binary;
     char *qemu_args;
     GPid vubr_pid;
+    int sock = -1;
 
     tmpfs = mkdtemp(template);
     if (!tmpfs) {
 
     tmpfs = mkdtemp(template);
     if (!tmpfs) {
@@ -109,9 +135,10 @@ static void test_pxe_vhost_user(void)
         root = tmpfs2;
     }
 
+    sock = vubr_create_socket(&si_remote, RPORT);
+
     qemu_args = g_strdup_printf(QEMU_CMD, MEMSZ, MEMSZ, (root),
-                                "char0", vubr_args[2], "char0", disk,
-                                RPORT, LPORT);
+            "char0", vubr_args[2], "char0", disk, sock);



regards,
Jens 
