Received: from eggs.gnu.org ([2001:4830:134:3::10]:34371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eC089-0003Xd-KY
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eC082-0005FD-FA
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:25:13 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:62448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eC082-0005ET-2e
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:25:06 -0500
References: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c97adeea-32ee-269c-2a88-b011e8a294fa@vivier.eu>
Date: Tue, 7 Nov 2017 10:24:52 +0100
MIME-Version: 1.0
In-Reply-To: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support explicit targets for
 PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Sierra <asierra@xes-inc.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

Le 07/11/2017 à 03:50, Aaron Sierra a écrit :
> Enable building PowerPC targets supporting a specific CPU, without 
> having to set QEMU_CPU via the environment. For example these build 
> targets (and many more) become available:
> 
> qemu-ppc.e500mc qemu-ppc.e500v2 qemu-ppc.e5500 qemu-ppc.e600 
> qemu-ppc.e6500
> 
> These (statically compiled) binaries have proven useful for
> emulating PowerPC CPUs within Docker containers, where it's hard to
> reliably define environment variables that are available for every
> process.
> 

An other idea would be to extract the default cpu from argv[0].

We don't change the default CPU at compile time, but we check the binary
name:
- if it's qemu-ppc, let's use the default cpu for qemu-ppc
- if it's not qemu-ppc, but something like qemu-ppc.XXX, let's set the
CPU to XXX. For instance "qemu-ppc.e600" will be a shortcut for
"qemu-ppc -cpu e600". [1]

I think it's easy to implement and don't change the default behavior of
qemu. And you can use hardlink to define several binaries with different
defaults (like busybox)

Thanks,
Laurent

[1] something like:

-- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4165,6 +4165,7 @@ static void usage(int exitcode)
 static int parse_args(int argc, char **argv)
 {
     const char *r;
+    const char *cpuname;
     int optind;
     const struct qemu_argument *arginfo;

@@ -4179,6 +4180,11 @@ static int parse_args(int argc, char **argv)
         }
     }

+    cpuname = strrchr(argv[0], '.');
+    if (cpuname && cpuname[1] != 0) {
+        cpu_model = strdup(cpuname + 1);
+    }
+
     optind = 1;
     for (;;) {
         if (optind >= argc) {
