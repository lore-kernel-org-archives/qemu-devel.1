Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D5D204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R/d0dGkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D5D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GCs-000181-Ru
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Faf-0008QM-JB
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fab-00010o-Rw
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5Fab-00010E-GM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdaR1067287;
 Tue, 3 Sep 2019 20:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2019-08-05; bh=hxeKK/qh9ZE+ORb7l8efNgDV+/6JxPDwkO6gyQ0/c4M=;
 b=R/d0dGkcmia69JtABjjUBj7TVlg2AvkW3p4dfAeB5KZikCi2NcYJ0GMeutSOFZGB8nCS
 HXXDKSSxbWt96y1rUn4zzxXm8Appr56O+hndtQunWwEv5mQhqjGxPLNEdAr0BhJhitNz
 Pk/2N6JumPcejLNx0ipTD+2PxI7nkuIwOYOQq82jpe20cisxQFdELCsqy10LNEOlEQ7o
 foRJqNNKrxH3WoeThYmIAHqX87geDranz7aZIhkxce/vRRJT2P5FNpuJ/YeyHLYyp3Ci
 6YV7xPTDdsElL8k25zXSSTqEWw3yJedUrSVI3Q3GDtkWH/xfekObhqWaeMSTEMw8pSYt Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2usy66r2jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcAlB025388;
 Tue, 3 Sep 2019 20:39:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2us5pha10m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KdYIN029143;
 Tue, 3 Sep 2019 20:39:34 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:33 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:10 -0400
Message-Id: <59cb496983f03b05f6da87af73bc2a2ac0bb7f81.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030207
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 x83KdaR1067287
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 44/45] multi-process: add the concept
 description to docs/devel/qemu-multiprocess
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John G Johnson <john.g.johnson@oracle.com>

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 v2 -> v3:
   - Updated with latest design of this project

 docs/devel/qemu-multiprocess.txt | 627 +++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 627 insertions(+)
 create mode 100644 docs/devel/qemu-multiprocess.txt

diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-multiproc=
ess.txt
new file mode 100644
index 0000000..5b94c8d
--- /dev/null
+++ b/docs/devel/qemu-multiprocess.txt
@@ -0,0 +1,627 @@
+Disaggregating QEMU
+
+This document describes implementation details of multi-process
+qemu.
+
+QEMU can be broadly described as providing three main services. One is a
+VM control point, where VMs can be created, migrated, re-configured, and
+destroyed. A second is to emulate the CPU instructions within the VM,
+often accelerated by HW virtualization features such as Intel=E2=80=99s =
VT
+extensions. Finally, it provides IO services to the VM by emulating HW
+IO devices, such as disk and network devices.
+
+A disaggregated QEMU
+
+A disaggregated QEMU involves separating QEMU services into separate
+host processes. Each of these processes can be given only the privileges
+it needs to provide its service, e.g., a disk service could be given
+access only the the disk images it provides, and not be allowed to
+access other files, or any network devices. An attacker who compromised
+this service would not be able to use this exploit to access files or
+devices beyond what the disk service was given access to.
+
+A QEMU control process would remain, but in disaggregated mode, it would
+be a control point that executes the processes needed to support the VM
+being created, but have no direct interfaces to the VM. During VM
+execution, it would still provide the user interface to hot-plug devices
+or live migrate the VM.
+
+A first step in creating a disaggregated QEMU is to separate IO services
+from the main QEMU program, which would continue to provide CPU
+emulation. i.e., the control process would also be the CPU emulation
+process. In a later phase, CPU emulation could be separated from the
+control process.
+
+
+Disaggregating IO services
+
+Disaggregating IO services is a good place to begin QEMU disaggregating
+for a couple of reasons. One is the sheer number of IO devices QEMU can
+emulate provides a large surface of interfaces which could potentially
+be exploited, and, indeed, have been a source of exploits in the past.
+Another is the modular nature of QEMU device emulation code provides
+interface points where the QEMU functions that perform device emulation
+can be separated from the QEMU functions that manage the emulation of
+guest CPU instructions.
+
+QEMU device emulation
+
+QEMU uses a object oriented SW architecture for device emulation code.
+Configured objects are all compiled into the QEMU binary, then objects
+are instantiated by name when used by the guest VM. For example, the
+code to emulate a device named =E2=80=9Cfoo=E2=80=9D is always present i=
n QEMU, but its
+instantiation code is only run when the device is included in the target
+VM. (e.g., via the QEMU command line as _-device foo_)
+
+The object model is hierarchical, so device emulation code names its
+parent object (such as =E2=80=9Cpci-device=E2=80=9D for a PCI device) an=
d QEMU will
+instantiate a parent object before calling the device=E2=80=99s instanti=
ation
+code.
+
+Current separation models
+
+In order to separate the device emulation code from the CPU emulation
+code, the device object code must run in a different process. There are
+a couple of existing QEMU features that can run emulation code
+separately from the main QEMU process. These are examined below.
+
+vhost user model
+
+Virtio guest device drivers can be connected to vhost user applications
+in order to perform their IO operations. This model uses special virtio
+device drivers in the guest and vhost user device objects in QEMU, but
+once the QEMU vhost user code has configured the vhost user application,
+mission-mode IO is performed by the application. The vhost user
+application is a daemon process that can be contacted via a known UNIX
+domain socket.
+
+vhost socket
+
+As mentioned above, one of the tasks of the vhost device object within
+QEMU is to contact the vhost application and send it configuration
+information about this device instance. As part of the configuration
+process, the application can also be sent other file descriptors over
+the socket, which then can be used by the vhost user application in
+various ways, some of which are described below.
+
+vhost MMIO store acceleration
+
+VMs are often run using HW virtualization features via the KVM kernel
+driver. This driver allows QEMU to accelerate the emulation of guest CPU
+instructions by running the guest in a virtual HW mode. When the guest
+executes instructions that cannot be executed by virtual HW mode,
+execution returns to the KVM driver so it can inform QEMU to emulate the
+instructions in SW.
+
+One of the events that can cause a return to QEMU is when a guest device
+driver accesses an IO location. QEMU then dispatches the memory
+operation to the corresponding QEMU device object. In the case of a
+vhost user device, the memory operation would need to be sent over a
+socket to the vhost application. This path is accelerated by the QEMU
+virtio code by setting up an eventfd file descriptor that the vhost
+application can directly receive MMIO store notifications from the KVM
+driver, instead of needing them to be sent to the QEMU process first.
+
+vhost interrupt acceleration
+
+Another optimization used by the vhost application is the ability to
+directly inject interrupts into the VM via the KVM driver, again,
+bypassing the need to send the interrupt back to the QEMU process first.
+The QEMU virtio setup code configures the KVM driver with an eventfd
+that triggers the device interrupt in the guest when the eventfd is
+written. This irqfd file descriptor is then passed to the vhost user
+application program.
+
+vhost access to guest memory
+
+The vhost application is also allowed to directly access guest memory,
+instead of needing to send the data as messages to QEMU. This is also
+done with file descriptors sent to the vhost user application by QEMU.
+These descriptors can be passed to mmap() by the vhost application to
+map the guest address space into the vhost application.
+
+IOMMUs introduce another level of complexity, since the address given to
+the guest virtio device to DMA to or from is not a guest physical
+address. This case is handled by having vhost code within QEMU register
+as a listener for IOMMU mapping changes. The vhost application maintains
+a cache of IOMMMU translations: sending translation requests back to
+QEMU on cache misses, and in turn receiving flush requests from QEMU
+when mappings are purged.
+
+applicability to device separation
+
+Much of the vhost model can be re-used by separated device emulation. In
+particular, the ideas of using a socket between QEMU and the device
+emulation application, using a file descriptor to inject interrupts into
+the VM via KVM, and allowing the application to mmap() the guest should
+be re used.
+
+There are, however, some notable differences between how a vhost
+application works and the needs of separated device emulation. The most
+basic is that vhost uses custom virtio device drivers which always
+trigger IO with MMIO stores. A separated device emulation model must
+work with existing IO device models and guest device drivers. MMIO loads
+break vhost store acceleration since they are synchronous - guest
+progress cannot continue until the load has been emulated. By contrast,
+stores are asynchronous, the guest can continue after the store event
+has been sent to the vhost application.
+
+Another difference is that in the vhost user model, a single daemon can
+support multiple QEMU instances. This is contrary to the security regime
+desired, in which the emulation application should only be allowed to
+access the files or devices the VM it=E2=80=99s running on behalf of can=
 access.
+
+
+New separation model based on proxy objects
+
+A different model based on proxy objects in the QEMU program
+communicating with remote emulation programs could provide separation
+while minimizing the changes needed to the device emulation code. The
+rest of this section is a discussion of how a proxy object model would
+work.
+
+
+Remote emulation processes
+
+The remote emulation process will run the QEMU object hierarchy without
+modification. The device emulation objects will be also be based on the
+QEMU code, because for anything but the simplest device, it would not be
+a tractable to re-implement both the object model and the many device
+backends that QEMU has.
+
+The processes will communicate with the QEMU process over UNIX domain
+sockets. The processes can be executed either as standalone processes,
+or be executed by QEMU. In both cases, the host backends the emulation
+processes will provide are specified on its command line, as they would
+be for QEMU. For example:
+
+    disk-proc -blockdev driver=3Dfile,node-name=3Dfile0,filename=3Ddisk-=
file0  \
+    -blockdev driver=3Dqcow2,node-name=3Ddrive0,file=3Dfile0
+
+would indicate process _disk-proc_ uses a qcow2 emulated disk named
+_file0_ as its backend.
+
+Emulation processes may emulate more than one guest controller. A common
+configuration might be to put all controllers of the same device class
+(e.g., disk, network, etc.) in a single process, so that all backends of
+the same type can be managed by a single QMP monitor.
+
+communication with QEMU
+
+Remote emulation processes will recognize a _-socket_ argument that
+specifies the path of a UNIX domain socket used to communicate with the
+QEMU process. If no _-socket_ argument is present, the process will use
+file descriptor 0 to communicate with QEMU. For example,
+
+    disk-proc -socket /tmp/disk0-sock <backend list>
+
+will communicate with QEMU using the socket path _/tmp/disk0-sock_.
+
+remote process QMP monitor
+
+Remote emulation processes can be monitored via QMP, similar to QEMU
+itself. The QMP monitor socket is specified the same as for a QEMU
+process:
+
+    disk-proc -qmp unix:/tmp/disk-mon,server
+
+can be monitored over the UNIX socket path _/tmp/disk-mon_.
+
+QEMU command line
+
+The QEMU command line options will need to be modified to indicate which
+items are emulated by a separate program, and which remain emulated by
+QEMU itself.
+
+identifying remote emulation processes
+
+Remote emulation processes will be identified to QEMU using a _-remote_
+command line option. This option can either specify a command that QEMU
+will execute, or can specify a UNIX domain socket that QEMU can use to
+connect to an existing process. Both forms require a =E2=80=9Cid=E2=80=9D=
 option that
+identifies the process to later _-device_ options. The process version
+is:
+
+    -remote id=3Ddisk-proc,command=3D"disk-proc <backend list>"
+
+And the socket version is:
+
+    -remote id=3Ddisk-proc,socket=3D"/tmp/disk0-sock"
+
+In the latter case, the remote process must be given the same socket on
+its command line when it is executed:
+
+    disk-proc -socket /tmp/disk0-sock <backend list>
+
+identifying devices emulated remotely
+
+Devices that are to be emulated in a separate process will be identify
+the remote process with a =E2=80=9Cremote=E2=80=9D option on their _-dev=
ice_ command
+line specification. e.g., an LSI SCSI controller and disk can be
+specified as:
+
+    -device lsi53c895a,id=3Dscsi0
+    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0
+
+If these devices are emulated by remote process =E2=80=9Cdisk-proc,=E2=80=
=9D as
+described in the previous section, the QEMU command line would be:
+
+    -device lsi53c895a,id=3Dscsi0,remote=3Ddisk-proc
+    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0,remote=3Ddi=
sk-proc
+
+Some devices are implicitly created by the machine object. e.g., the q35
+machine object will create its PCI bus, and attach an ich9-ahci IDE
+controller to it. In this case, options will need to be added to the
+_-machine_ command line. e.g.,
+
+    -machine pc-q35,ide-remote=3Ddisk-proc
+
+will use the remote process with an =E2=80=9Cid=E2=80=9D of =E2=80=9Cdis=
k-proc=E2=80=9D to emulate the
+IDE controller and its disks.
+
+The disks themselves still need to be specified with _-remote_ option,
+as in the example above. e.g.,
+
+    -device ide-hd,drive=3Ddrive0,bus=3Dide.0,unit=3D0,remote=3Ddisk-pro=
c
+
+
+QEMU management of remote processes
+
+Each _-remote_ instance on the QEMU command line will create a remote
+process proxy instance in QEMU. They will be held on a _QList_ that can
+be searched for by its =E2=80=9Cid=E2=80=9D property. The remote process=
 proxy will also
+establish a communication channel between QEMU and the remote process.
+This can be done in one of two methods: direction execution of the
+process by QEMU with fork() and exec() system calls, or by connecting to
+an existing process.
+
+direct execution
+
+When the remote process is directly executed, the remote process proxy
+will setup a communication channel between itself and the emulation
+process. This channel will be created using socketpair() and the remote
+process side of the pair will be given to the process as file descriptor
+0.
+
+connecting to an existing process
+
+Some environments wish to deny QEMU the ability to execute fork() and
+exec() In these case, emulation processes will be started before QEMU,
+and a UNIX domain socket will be given to each emulation process to
+communicate with QEMU over. After communication is established, the
+socket will be unlinked from the file system space by the QEMU process.
+
+communication with emulation process
+
+primary socket
+
+Whether the process was executed by QEMU or externally, there will be a
+primary socket for communication between QEMU and the remote process.
+This channel will handle configuration commands from QEMU to the
+process, either from the QEMU command line, or from QMP commands that
+affect the devices being emulated by the process. This channel will only
+allow one message to be pending at a time; if additional messages
+arrive, they must wait for previous ones to be acknowledged from the
+remote side.
+
+secondary sockets
+
+The primary socket can pass the file descriptors of secondary sockets
+for operations that occur in parallel with commands on the primary
+channel. These include MMIO operations generated by the guest, interrupt
+notifications generated by the devices being emulated, or _vmstate_ for
+live migration. These secondary sockets will be created at the behest of
+the device proxies that require them. A disk device proxy wouldn=E2=80=99=
t need
+any secondary sockets, but a disk controller device proxy may need both
+an MMIO socket and an interrupt socket.
+
+emulation process attached via QMP command
+
+There will be a new =E2=80=9Cattach-process=E2=80=9D QMP command to faci=
litate device
+hot-plug. This command=E2=80=99s arguments will be the same as the _-rem=
ote_
+command line when it=E2=80=99s used to attach to a remote process. i.e.,=
 it will
+need an =E2=80=9Cid=E2=80=9D argument so that hot-plugged devices can la=
ter find it, and
+a =E2=80=9Csocket=E2=80=9D argument to identify the UNIX domain socket t=
hat will be used
+to communicate with QEMU.
+
+
+QEMU device proxy objects
+
+QEMU has an object model based on sub-classes inherited from the
+=E2=80=9Cobject=E2=80=9D super-class. The sub-classes that are of intere=
st here are the
+=E2=80=9Cdevice=E2=80=9D and =E2=80=9Cbus=E2=80=9D sub-classes whose chi=
ld sub-classes make up the
+device tree of a QEMU emulated system.
+
+The proxy object model will use device proxy objects to replace the
+device emulation code within the QEMU process. These objects will live
+in the same place in the object and bus hierarchies as the objects they
+replace. i.e., the proxy object for an LSI SCSI controller will be a
+sub-class of the =E2=80=9Cpci-device=E2=80=9D class, and will have the s=
ame PCI bus
+parent and the same SCSI bus child objects as the LSI controller object
+it replaces.
+
+After the QEMU command line has been parsed, the remote devices will be
+instantiated in the same manner as local devices are. (i.e.,
+qdev_device_add()). In order to distinguish them from regular _-device_
+device objects, their class name will be the name of the class it
+replaces, with =E2=80=9C-proxy=E2=80=9D appended. e.g., the =E2=80=9Clsi=
53c895a=E2=80=9D proxy class
+will be =E2=80=9Clsi53c895a-proxy.=E2=80=9D
+
+device JSON description
+
+The remote process needs a JSON representation of the command line
+options used to create the object. This JSON representation is used to
+create the corresponding object in the emulation process. e.g., for an
+LSI SCSI controller invoked as:
+
+     -device lsi53c895a,id=3Dscsi0,remote=3Dlsi-scsi
+
+the proxy object would create a
+
+    { "driver" : "lsi53c895a", "id" : "scsi0" }
+
+JSON description. The =E2=80=9Cdriver=E2=80=9D option is assigned to the=
 device name
+when the command line is parsed, so the =E2=80=9C-proxy=E2=80=9D appende=
d by the command
+line parsing code is removed. The =E2=80=9Cremote=E2=80=9D option isn=E2=
=80=99t needed in the
+JSON description since it only applies to the proxy object in the QEMU
+process.
+
+device object whitelist
+
+Some device objects may not need a proxy. These are devices with no
+direct guest interfaces. (e.g., no MMIO, PIO, or interrupts). There will
+be a whitelist of such devices, and any devices on this list will not be
+instantiated in QEMU. Their JSON representation will still be sent to
+the remote process, so the object can be created there.
+
+object initialization
+
+QEMU object initialization occurs in two phases. The first
+initialization happens once per object class. (i.e., there can be many
+SCSI disks in an emulated system, but the =E2=80=9Cscsi-hd=E2=80=9D clas=
s has its
+class_init() function called only once) The second phase happens when
+each object=E2=80=99s instance_init() function is called to initialize e=
ach
+instance of the object.
+
+All device objects are sub-classes of the =E2=80=9Cdevice=E2=80=9D class=
, so they also
+have a realize() function that is called after instance_init() is called
+and after the object=E2=80=99s static properties have been initialized. =
Many
+device objects don=E2=80=99t even provide an instance_init() function, a=
nd do
+all their per-instance work in realize().
+
+class_init
+
+The class_init() method of a proxy object will, in general behave
+similarly to the object it replaces, including setting any static
+properties and methods needed by the proxy.
+
+instance_init / realize
+
+The instance_init() and realize() functions would only need to perform
+tasks related to being a proxy, such are registering its own MMIO
+handlers, or creating a child bus that other proxy devices can be
+attached to later.
+
+Other tasks will are device-specific. For example, PCI device objects
+will initialize the PCI config space in order to make a valid PCI device
+tree within the QEMU process.
+
+address space registration
+
+Most devices are driven by guest device driver accesses to IO addresses
+or ports. The QEMU device emulation code uses QEMU=E2=80=99s memory regi=
on
+function calls (such as memory_region_init_io()) to add callback
+functions that QEMU will invoke when the guest accesses the device=E2=80=
=99s
+areas of the IO address space. When a guest driver does access the
+device, the VM will exit HW virtualization mode and return to QEMU,
+which will then lookup and execute the corresponding callback function.
+
+A proxy object would need to mirror the memory region calls the actual
+device emulator would perform in its initialization code, but with its
+own callbacks. When invoked by QEMU as a result of a guest IO operation,
+they will forward the operation to the device emulation process.
+
+PCI config space
+
+PCI devices also have a configuration space that can be accessed by the
+guest driver. Guest accesses to this space is not handled by the device
+emulation object, but by its PCI parent object. Much of this space is
+read-only, but certain registers (especially BAR and MSI-related ones)
+need to be propagated to the emulation process.
+
+PCI parent proxy
+
+One way to propagate guest PCI config accesses is to create a
+=E2=80=9Cpci-device-proxy=E2=80=9D class that can serve as the parent of=
 a PCI device
+proxy object. This class=E2=80=99s parent would be =E2=80=9Cpci-device=E2=
=80=9D and it would
+override the PCI parent=E2=80=99s config_read() and config_write() metho=
ds with
+ones that forward these operations to the emulation program.
+
+interrupt receipt
+
+A proxy for a device that generates interrupts will need to create a
+socket to receive interrupt indications from the emulation process. An
+incoming interrupt indication would then be sent up to its bus parent to
+be injected into the guest. For example, a PCI device object may use
+pci_set_irq().
+
+live migration
+
+The proxy will register to save and restore any _vmstate_ it needs over
+a live migration event. The device proxy does not need to manage the
+remote device=E2=80=99s _vmstate_; that will be handled by the remote pr=
ocess
+proxy (see below).
+
+
+QEMU remote device operation
+
+Generic device operations, such as DMA, will be performs by the remote
+process proxy by sending messages to the remote process.
+
+DMA operations
+
+DMA operations would be handled much like vhost applications do. One of
+the initial messages sent to the emulation process is a guest memory
+table. Each entry in this table consists of a file descriptor and size
+that the emulation process can mmap() to directly access guest memory,
+similar to vhost_user_set_mem_table(). Note guest memory must be backed
+by file descriptors, such as when QEMU is given the _-mem-path_ command
+line option.
+
+IOMMU operations
+
+When the emulated system includes an IOMMU, the remote process proxy in
+QEMU will need to create a socket for IOMMU requests from the emulation
+process. It will handle those requests with an
+address_space_get_iotlb_entry() call. In order to handle IOMMU unmaps,
+the remote process proxy will also register as a listener on the
+device=E2=80=99s DMA address space. When an IOMMU memory region is creat=
ed
+within the DMA address space, an IOMMU notifier for unmaps will be added
+to the memory region that will forward unmaps to the emulation process
+over the IOMMU socket.
+
+device hot-plug via QMP
+
+An QMP =E2=80=9Cdevice_add=E2=80=9D command can add a device emulated by=
 a remote
+process. It needs to add a =E2=80=9Cremote=E2=80=9D option to the comman=
d, just as the
+_-device_ command line option does. The remote process may either be one
+started at QEMU startup, or be one added by the =E2=80=9Cadd-process=E2=80=
=9D QMP
+command described above. In either case, the remote process proxy will
+forward the new device=E2=80=99s JSON description to the corresponding e=
mulation
+process.
+
+live migration
+
+The remote process proxy will also register for live migration
+notifications with vmstate_register(). When called to save state, the
+proxy will send the remote process a secondary socket file descriptor to
+save the remote process=E2=80=99s device _vmstate_ over. The incoming by=
te
+stream length and data will be saved as the proxy=E2=80=99s _vmstate_. W=
hen the
+proxy is resumed on its new host, this _vmstate_ will be extracted, and
+a secondary socket file descriptor will be sent to the new remote
+process through which it receives the _vmstate_ in order to restore the
+devices there.
+
+device emulation in remote process
+
+The parts of QEMU that the emulation program will need include the
+object model; the memory emulation objects; the device emulation objects
+of the targeted device, and any dependent devices; and, the device=E2=80=
=99s
+backends. It will also need code to setup the machine environment,
+handle requests from the QEMU process, and route machine-level requests
+(such as interrupts or IOMMU mappings) back to the QEMU process.
+
+initialization
+
+The process initialization sequence will follow the same sequence
+followed by QEMU. It will first initialize the backend objects, then
+device emulation objects. The JSON descriptions sent by the QEMU process
+will drive which objects need to be created.
+
+-   address spaces
+
+    Before the device objects are created, the initial address spaces
+    and memory regions must be configured with memory_map_init(). This
+    creates a RAM memory region object (_system_memory_) and an IO
+    memory region object (_system_io_).
+
+-   RAM
+
+    RAM memory region creation will follow how pc_memory_init() creates
+    them, but must use memory_region_init_ram_from_fd() instead of
+    memory_region_allocate_system_memory(). The file descriptors needed
+    will be supplied by the guest memory table from above. Those RAM
+    regions would then be added to the _system_memory_ memory region
+    with memory_region_add_subregion().
+
+-   PCI
+
+    IO initialization will be driven by the JSON descriptions sent from
+    the QEMU process. For a PCI device, a PCI bus will need to be
+    created with pci_root_bus_new(), and a PCI memory region will need
+    to be created and added to the _system_memory_ memory region with
+    memory_region_add_subregion_overlap(). The overlap version is
+    required for architectures where PCI memory overlaps with RAM
+    memory.
+
+MMIO handling
+
+The device emulation objects will use memory_region_init_io() to install
+their MMIO handlers, and pci_register_bar() to associate those handlers
+with a PCI BAR, as they do within QEMU currently.
+
+In order to use address_space_rw() in the emulation process to handle
+MMIO requests from QEMU, the PCI physical addresses must be the same in
+the QEMU process and the device emulation process. In order to
+accomplish that, guest BAR programming must also be forwarded from QEMU
+to the emulation process.
+
+interrupt injection
+
+When device emulation wants to inject an interrupt into the VM, the
+request climbs the device=E2=80=99s bus object hierarchy until the point=
 where a
+bus object knows how to signal the interrupt to the guest. The details
+depend on the type of interrupt being raised.
+
+-   PCI pin interrupts
+
+    On x86 systems, there is an emulated IOAPIC object attached to the
+    root PCI bus object, and the root PCI object forwards interrupt
+    requests to it. The IOAPIC object, in turn, calls the KVM driver to
+    inject the corresponding interrupt into the VM. The simplest way to
+    handle this in an emulation process would be to setup the root PCI
+    bus driver (via pci_bus_irqs()) to send a interrupt request back to
+    the QEMU process, and have the device proxy object reflect it up the
+    PCI tree there.
+
+-   PCI MSI/X interrupts
+
+    PCI MSI/X interrupts are implemented in HW as DMA writes to a
+    CPU-specific PCI address. In QEMU on x86, a KVM APIC object receives
+    these DMA writes, then calls into the KVM driver to inject the
+    interrupt into the VM. A simple emulation process implementation
+    would be to send the MSI DMA address from QEMU as a message at
+    initialization, then install an address space handler at that
+    address which forwards the MSI message back to QEMU.
+
+DMA operations
+
+When a emulation object wants to DMA into or out of guest memory, it
+first must use dma_memory_map() to convert the DMA address to a local
+virtual address. The emulation process memory region objects setup above
+will be used to translate the DMA address to a local virtual address the
+device emulation code can access.
+
+IOMMU
+
+When an IOMMU is in use in QEMU, DMA translation uses IOMMU memory
+regions to translate the DMA address to a guest physical address before
+that physical address can be translated to a local virtual address. The
+emulation process will need similar functionality.
+
+-   IOTLB cache
+
+    The emulation process will maintain a cache of recent IOMMU
+    translations (the IOTLB). When the translate() callback of an IOMMU
+    memory region is invoked, the IOTLB cache will be searched for an
+    entry that will map the DMA address to a guest PA. On a cache miss,
+    a message will be sent back to QEMU requesting the corresponding
+    translation entry, which be both be used to return a guest address
+    and be added to the cache.
+
+-   IOTLB purge
+
+    The IOMMU emulation will also need to act on unmap requests from
+    QEMU. These happen when the guest IOMMU driver purges an entry from
+    the guest=E2=80=99s translation table.
+
+live migration
+
+When a remote process receives a live migration indication from QEMU, it
+will set up a channel using the received file descriptor with
+qio_channel_socket_new_fd(). This channel will be used to create a
+_QEMUfile_ that can be passed to qemu_save_device_state() to send the
+process=E2=80=99s device state back to QEMU. This method will be reverse=
d on
+restore - the channel will be passed to qemu_loadvm_state() to restore
+the device state.
+
--=20
1.8.3.1


