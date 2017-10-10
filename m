Received: from eggs.gnu.org ([2001:4830:134:3::10]:38400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1kSz-0003SS-QO
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1kSy-0003VU-Pp
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e1kSy-0003Sd-HL
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Oct 2017 23:40:00 -0300
Message-Id: <20171010024001.4526-8-ehabkost@redhat.com>
In-Reply-To: <20171010024001.4526-1-ehabkost@redhat.com>
References: <20171010024001.4526-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 7/8] vl: exit if maxcpus is negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>

From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

---Steps to Reproduce---

When passed a negative number to 'maxcpus' parameter, Qemu aborts
with a core dump.

Run the following command with maxcpus argument as negative number

ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D200g -device virtio-blk-pci,
drive=3Drootdisk -drive file=3D/home/images/pegas-1.0-ppc64le.qcow2,
if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3Dqcow2 -monitor telnet
:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net
user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=3D1,
threads=3D1,maxcpus=3D-12

(process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
 18446744073709550568 bytes

Trace/breakpoint trap

Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Message-Id: <1504511031-26834-1-git-send-email-s1seetee@linux.vnet.ibm.co=
m>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/sysemu/sysemu.h | 2 +-
 vl.c                    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index b21369672a..c083869fcf 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -113,7 +113,7 @@ extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
 extern int smp_cpus;
-extern int max_cpus;
+extern unsigned int max_cpus;
 extern int cursor_hide;
 extern int graphic_rotate;
 extern int no_quit;
diff --git a/vl.c b/vl.c
index ebea42e0ea..d7c349233f 100644
--- a/vl.c
+++ b/vl.c
@@ -161,7 +161,7 @@ Chardev *sclp_hds[MAX_SCLP_CONSOLES];
 int win2k_install_hack =3D 0;
 int singlestep =3D 0;
 int smp_cpus =3D 1;
-int max_cpus =3D 1;
+unsigned int max_cpus =3D 1;
 int smp_cores =3D 1;
 int smp_threads =3D 1;
 int acpi_enabled =3D 1;
@@ -4331,8 +4331,8 @@ int main(int argc, char **argv, char **envp)
=20
     machine_class->max_cpus =3D machine_class->max_cpus ?: 1; /* Default=
 to UP */
     if (max_cpus > machine_class->max_cpus) {
-        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs=
 "
-                     "supported by machine '%s' (%d)", max_cpus,
+        error_report("Invalid SMP CPUs %d. The max CPUs "
+                     "supported by machine '%s' is %d", max_cpus,
                      machine_class->name, machine_class->max_cpus);
         exit(1);
     }
--=20
2.13.6
