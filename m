Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C10C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571972083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="h7jF2T0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571972083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqlc-0003Mq-4X
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGU-0000Cg-HA
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGM-0001cE-L0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:46:05 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:37004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hgqGM-0001Zt-63
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:45:58 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 3A9D596F58;
 Fri, 28 Jun 2019 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1561725941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIhpl/DttkLLK7DJX0z6TNYXgE+dPetO02X9ZhbQxV8=;
 b=h7jF2T0fsXdKZL4y5iwn88gt8VIk8dkDRJC8l0isl2aiiP28gS5sdgv2n6IaX/dU2pdGu3
 agWnqfH3Mo/uQ48nCzhLfkopfFFDqndUk+TgyqyhsRGm3r5YZ/c4oh2THlpX66ZSTdVTJv
 2TPN0JquvAtbKhsB6Sl8Q+NTOmeJ3Jc=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 14:45:34 +0200
Message-Id: <20190628124534.10679-6-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628124534.10679-1-damien.hedde@greensocs.com>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1561725941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIhpl/DttkLLK7DJX0z6TNYXgE+dPetO02X9ZhbQxV8=;
 b=mS6j+2pPCfSd1JvGpPHYEbGTeAkmLCZejEUuI/oqKEwg6n1kU2uKsEXXmesZ2yyWfE1+GI
 A6tx4aVqYpxmjPDYU1boYt6lOZq7jTVQyaYeCJd3mtSPaneZf768Fqr8fGMT8qTIj5zCWr
 jcDJvgy081q+5IV0gALPfIcZOBy/E8I=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1561725941; a=rsa-sha256; cv=none;
 b=6QG9edmInuNkDFiiOSf7gN6KYVCUcyZuP8hzanDh5uEZAFC7vBLO8sOpZtMPvmKZ28sT8y
 ValY/+l2xllUv9/amCRrHAHFgXse2rceDd+6NncqhQc/MD10NdKxgV69z2VZFyk4MvMeYt
 lIpvHaDKd8t1lO+ecClpfmb/RHz+SPk=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH 5/5] docs: add fault injection framework
 documentation
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, ehabkost@redhat.com,
 mark.burton@greensocs.com, armbru@redhat.com, sakisp@xilinx.com,
 edgari@xilinx.com, crosa@redhat.com, pbonzini@redhat.com,
 luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds some hints about how to use the fault injection framework.

This is based on Frederic Konrad's work.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 docs/fault_injection.txt | 149 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 docs/fault_injection.txt

diff --git a/docs/fault_injection.txt b/docs/fault_injection.txt
new file mode 100644
index 0000000000..3cb1c1fd1a
--- /dev/null
+++ b/docs/fault_injection.txt
@@ -0,0 +1,149 @@
+                           Fault Injection Framework
+                           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+------------
+
+The fault injection framework allows users to write python scripts to in=
ject
+faults through the QMP (QEMU Machine Protocol) during execution.
+
+Basically it's composed of a Python API which makes some QMP commands ea=
sy to
+send to the machine:
+  * read/write a virtual/memory memory location.
+  * set a GPIO line.
+  * get/set a QOM property.
+
+In addition it allows the Python script to be notified back by QEMU so i=
t can
+do any of the previous commands at a given virtual clock time.
+
+Today the available function in the API are the following:
+  * notify(time_ns, cb, do_halt)
+  * write_mem(address, value, size, cpu)
+  * read_mem(address, size, cpu)
+  * write_pmem(address, value, size)
+  * read_pmem(address, size)
+  * get_qom_property(path, property)
+  * set_qom_property(path, property, value)
+  * set_gpio(path, gpio, num, value)
+
+Empty Example
+-------------
+
+This is an empty example to begin:
+
+import fault_injection
+import sys
+
+framework =3D None
+
+def main():
+    # The injection framework will parse the command line automatically
+    # (eg: the qmp socket/port.. etc)
+    sys.stdout.write('Fault Injection Example\n')
+    global framework
+    framework =3D fault_injection.FaultInjectionFramework(sys.argv[1])
+
+    framework.run()
+    sys.exit(1)
+
+if __name__ =3D=3D '__main__':
+    main()
+
+To run the example just save the example in `script/qmp/example_scenario=
`
+Run qemu with the additional arguments: `-S -qmp unix:/path/to/qmp-sock,=
server`
+in order to wait for a qmp connection and stop the QEMU machine.
+Run the example with: `./example_scenario /path/to/qmp-sock`
+
+It will start the simulation inside QEMU and do nothing else.
+
+Adding a callback at a given time
+---------------------------------
+
+As described above a callback can be added in the python scenario.
+For example we can create the following callback which write 0xDEADBEEF =
@0 with
+a size of 4 from cpu 0 and then reads it back:
+
+def write_mem_callback():
+    print 'write_mem_callback()'
+    framework.write_mem(0x0, 0xDEADBEEF, 4, 0)
+    val =3D framework.read_mem(0x0, 4, 0)
+    print 'value read: 0x%8.8X' %val
+
+Then we can notify it in the main function before framework.run():
+`framework.notify(1000000000, write_mem_callback)`
+
+The script works as expected:
+
+write_mem_callback()
+value read: 0xDEADBEEF
+
+Using the python interpreter
+----------------------------
+
+The Python interpreter can be used to send the command above:
+For example to set the vinithi bit to 1 for the /rpu_cpu@0 the following
+commands can be done in the script/qmp directory:
+
+$ python
+>>> import fault_injection
+>>> inj=3Dfault_injection.FaultInjectionFramework("../../qmp-sock", 0)
+Connected to QEMU 2.2.50
+
+>>> inj.help()
+
+Fault Injection Framework Commands
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+cont()
+ * Resume the simulation when the Virtual Machine is stopped.
+
+notify(time_ns, cb, do_pause)
+ * Notify the callback cb in guest time time_ns. Simulation is stopped o=
nly if
+   do_pause is set to True.
+
+run_once()
+ * Start the simulation and handle a callback set by notify. Return afte=
r
+   first callback is handled
+
+run()
+ * Start the simulation and handle the callbacks set by notify. Do not r=
eturn
+   until the end of the simulation.
+
+write_mem(address, value, size, cpu)
+ * Write @value of size @size at virtual @address from @cpu.
+ * @cpu is the cpu id.
+
+write_pmem(address, value, size)
+ * Like write_mem, but on a physical @address.
+
+read_mem(address, size, cpu)
+ * Read a value of size @size at virtual @address from @cpu.
+ * @cpu is the cpu id.
+ * Returns the value.
+
+read_pmem(address, size)
+ * Like read_mem, but on a physical @address.
+
+get_qom_property(path, property)
+ * Get a qom property.
+ * Returns the qom property named @property in @path.
+
+set_qom_property(path, property, value)
+ * Set the property named @property in @path with @value.
+
+set_gpio(path, gpio, num, value)
+ * Set the gpio named @gpio number @num in @path with the @val.
+ * @val is a boolean.
+
+>>> inj.set_gpio('/rpu_cpu@0', 'vinithi', 0, 1)
+
+Notes
+-----
+
+The user can turn debug information on by passing a level to the framewo=
rk
+constructor eg:
+"framework =3D fault_injection.FaultInjectionFramework(1)" will print ti=
med traces
+such as write or read.
+"framework =3D fault_injection.FaultInjectionFramework(2)" will print th=
e QMP
+commands as well.
+
--=20
2.22.0


