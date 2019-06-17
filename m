Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C7C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B982084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lDd70t09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B982084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwmU-0000vh-RN
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59299)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwC5-0006Bp-LE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBz-0002RT-De
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBx-0002NK-7q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8sul159134;
 Mon, 17 Jun 2019 18:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=l4cjbWrWepXOv5QlHHp3UiHTn8WQMC+MFGsAprzxklM=;
 b=lDd70t092lesgoa9Gyo023X2c96A4vVHbK0JCP0hX5uWroiRqHmj6cmh8b/c/g0qGtpn
 A1BfLM7Pi7lkg3zN7ENNqhOtL7S0op0HV8Ddr6rkdQNSMIeBJR40q9o21GXVVWeIIh7B
 LO93jIKyljMIGJUBBKJgoLRNeXzid2jirXY22oYBxe23J2YkhegFZfJFQd1+ztAkMKEp
 KNJA8L3HUUXC8MgHC7aLRkPgPY6gnGIG2nE3MghvPO0HJ+Ip4x5CI/4bCD/kAugF4Viy
 YlvJKMTPwHbRBcW2F9wWF217oUls1mqzl2YrfrNf7YgZ3CX+0TKzAygSmvFZbd5XuG4T Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t4saq7ym7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:17:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIGaYC181989;
 Mon, 17 Jun 2019 18:17:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgbe5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:17:07 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIH6fU032708;
 Mon, 17 Jun 2019 18:17:06 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:17:06 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:17:04 -0700
Message-Id: <20190617181704.30751-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC PATCH v2 34/35] multi-process: add the concept
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Changes in v2:
 - changed the command line options descriptions;
 - added section about communication with remote process for MMIO and QMP commands
   using different sockets;
---
 docs/devel/qemu-multiprocess.txt | 1137 ++++++++++++++++++++++++++++++
 1 file changed, 1137 insertions(+)
 create mode 100644 docs/devel/qemu-multiprocess.txt

diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-multiprocess.txt
new file mode 100644
index 0000000000..f814522178
--- /dev/null
+++ b/docs/devel/qemu-multiprocess.txt
@@ -0,0 +1,1137 @@
+Disaggregating QEMU
+
+This document describes implementation details of multi-process
+qemu.
+
+1. QEMU services
+
+        QEMU can be broadly described as providing three main
+services.  One is a VM control point, where VMs can be created,
+migrated, re-configured, and destroyed.  A second is to emulate the
+CPU instructions within the VM, often accelerated by HW virtualization
+features such as Intel's VT extensions.  Finally, it provides IO
+services to the VM by emulating HW IO devices, such as disk and
+network devices.
+
+1.1 A disaggregated QEMU
+
+        A disaggregated QEMU involves separating QEMU services into
+separate host processes.  Each of these processes can be given only
+the privileges it needs to provide its service, e.g., a disk service
+could be given access only the the disk images it provides, and not be
+allowed to access other files, or any network devices.  An attacker
+who compromised this service would not be able to use this exploit to
+access files or devices beyond what the disk service was given access
+to.
+
+        A control QEMU process would remain, but in disaggregated
+mode, it would be a control point that exec()s the processes needed to
+support the VM being created, but have no direct interface to the VM.
+During VM execution, it would still provide the user interface to
+hot-plug devices or live migrate the VM.
+
+        A first step in creating a disaggregated QEMU is to separate
+IO services from the main QEMU program, which would continue to
+provide CPU emulation. i.e., the control process would also be the CPU
+emulation process.  In a later phase, CPU emulation could be separated
+from the QEMU control process.
+
+
+2. Disaggregating IO services
+
+        Disaggregating IO services is a good place to begin QEMU
+disaggregating for a couple of reasons.  One is the sheer number of IO
+devices QEMU can emulate provides a large surface of interfaces which
+could potentially be exploited, and, indeed, have been a source of
+exploits in the past.  Another is the modular nature of QEMU device
+emulation code provides interface points where the QEMU functions that
+perform device emulation can be separated from the QEMU functions that
+manage the emulation of guest CPU instructions.
+
+2.1 QEMU device emulation
+
+        QEMU uses a object oriented SW architecture for device
+emulation code.  Configured objects are all compiled into the QEMU
+binary, then objects are instantiated by name when used by the guest
+VM.  For example, the code to emulate a device named "foo" is always
+present in QEMU, but its instantiation code is only run when a device
+named "foo" is included in the target VM (such as via the QEMU command
+line as -device "foo".)
+
+        The object model is hierarchical, so device emulation code can
+name its parent object (such as "pci-device" for a PCI device) and
+QEMU will instantiate a parent object before calling the device's
+instantiation code.
+
+2.2 Current separation models
+
+        In order to separate the device emulation code from the CPU
+emulation code, the device object code must run in a different
+process.  There are a couple of existing QEMU features that can run
+emulation code separately from the main QEMU process.  These are
+examined below.
+
+2.2.1 vhost user model
+
+        Virtio guest device drivers can be connected to vhost user
+applications in order to perform their IO operations.  This model uses
+special virtio device drivers in the guest and vhost user device
+objects in QEMU, but once the QEMU vhost user code has configured the
+vhost user application, mission-mode IO is performed by the
+application.  The vhost user application is a daemon process that can
+be contacted via a known UNIX domain socket.
+
+2.2.1.1 vhost socket
+
+        As mentioned above, one of the tasks of the vhost device
+object within QEMU is to contact the vhost application and send it
+configuration information about this device instance.  As part of the
+configuration process, the application can also be sent other file
+descriptors over the socket, which then can be used by the vhost user
+application in various ways, some of which are described below.
+
+2.2.1.2 vhost MMIO store acceleration
+
+        VMs are often run using HW virtualization features via the KVM
+kernel driver.  This driver allows QEMU to accelerate the emulation of
+guest CPU instructions by running the guest in a virtual HW mode.
+When the guest executes instructions that cannot be executed by
+virtual HW mode, execution return to the KVM driver so it can inform
+QEMU to emulate the instructions in SW.
+
+        One of the events that can cause a return to QEMU is when a
+guest device driver accesses an IO location. QEMU then dispatches the
+memory operation to the corresponding QEMU device object.  In the case
+of a vhost user device, the memory operation would need to be sent
+over a socket to the vhost application.  This path is accelerated by
+the QEMU virtio code by setting up an eventfd file descriptor that the
+vhost application can directly receive MMIO store notifications from
+the KVM driver, instead of needing them to be sent to the QEMU process
+first.
+
+2.2.1.3 vhost interrupt acceleration
+
+        Another optimization used by the vhost application is the
+ability to directly inject interrupts into the VM via the KVM driver,
+again, bypassing the need to send the interrupt back to the QEMU
+process first.  The QEMU virtio setup code configures the KVM driver
+with an eventfd that triggers the device interrupt in the guest when
+the eventfd is written. This irqfd file descriptor is then passed to
+the vhost user application program.
+
+2.2.1.4 vhost access to guest memory
+
+        The vhost application is also allowed to directly access guest
+memory, instead of needing to send the data as messages to QEMU.  This
+is also done with file descriptors sent to the vhost user application
+by QEMU.  These descriptors can be mmap()d by the vhost application to
+map the guest address space into the vhost application.
+
+        IOMMUs introduce another level of complexity, since the
+address given to the guest virtio device to DMA to or from is not a
+guest physical address.  This case is handled by having vhost code
+within QEMU register as a listener for IOMMU mapping changes.  The
+vhost application maintains a cache of IOMMMU translations: sending
+translation requests back to QEMU on cache misses, and in turn
+receiving flush requests from QEMU when mappings are purged.
+
+2.2.1.5 applicability to device separation
+
+        Much of the vhost model can be re-used by separated device
+emulation.  In particular, the ideas of using a socket between QEMU
+and the device emulation application, using a file descriptor to
+inject interrupts into the VM via KVM, and allowing the application to
+mmap() the guest should be re-used.
+
+        There are, however, some notable differences between how a
+vhost application works and the needs of separated device emulation.
+The most basic is that vhost uses custom virtio device drivers which
+always trigger IO with MMIO stores.  A separated device emulation model
+must work with existing IO device models and guest device drivers.
+MMIO loads break vhost store acceleration since they are synchronous -
+guest progress cannot continue until the load has been emulated.  By
+contrast, stores are asynchronous, the guest can continue after the
+store event has been sent to the vhost application.
+
+        Another difference is that in the vhost user model, a single
+daemon can support multiple QEMU instances.  This is contrary to the
+security regime desired, in which the emulation application should
+only be allowed to access the files or devices the VM it's running on
+behalf of can access.
+
+2.2.2 qemu-io model
+
+        Qemu-io is a test harness used to test changes to the QEMU
+block backend object code. (e.g., the code that implements disk images
+for disk driver emulation) Qemu-io is not a device emulation
+application per se, but it does compile the QEMU block objects into a
+separate binary from the main QEMU one.  This could be useful for disk
+device emulation, since its emulation applications will need to
+include the QEMU block objects.
+
+2.3 New separation model based on proxy objects
+
+        A different model based on proxy objects in the QEMU program
+communicating with proxy objects the separated emulation programs
+could provide separation while minimizing the changes needed to the
+device emulation code.  The rest of this section is a discussion of
+how a proxy object model would work.
+
+2.3.1 command line specification
+
+        The QEMU command line options will need to be modified to
+indicate which items are emulated by a separate program, and which
+remain emulated by QEMU itself.
+
+2.3.1.1 devices
+
+Devices that are to be emulated in a separate process will be identify the
+remote process with a "remote" option on their *-device*  command line
+specification.  e.g., an LSI SCSI controller and disk can be specified as:
+
+-device lsi53c895a,id=scsi0
+-device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0
+
+If these devices are emulated by remote process "lsi-scsi0," as described in
+the previous section, the QEMU command line would be:
+
+-device lsi53c895a,id=scsi0,remote,command=lsi-scsi0,rid=0
+-device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0,remote,command=lsi-scsi0,rid=0
+
+Some devices are implicitly created by the machine object. e.g., the q35 machine
+object will create its PCI bus, and attach an ich9-ahci IDE controller to it.
+In this case, options will need to be added to the *-machine* command line.  e.g.,
+
+-machine pc-q35,ide-remote=ahci-ide0
+
+will use the remote process with an "id" of "ahci-ide"  to emulate the IDE
+controller and its disks.
+
+The disks themselves still need to be specified with "remote" option, as in
+the example above. e.g.,
+
+-device ide-hd,drive=drive0,bus=ide.0,unit=0,remote=ahci-ide0
+
+2.3.1.2 backends
+
+        The device's backend would similarly have a changed command
+line specification.  e.g., a qcow2 block backend specified as:
+
+-blockdev driver=file,node-name=file0,filename=disk-file0
+-blockdev driver=qcow2,node-name=drive0,file=file0
+
+becomes
+
+-blockdev driver=file,node-name=file0,filename=disk-file0,remote=lsi-scsi0
+-blockdev driver=qcow2,node-name=drive0,file=file0,remote=lsi-scsi0
+
+2.3.1.3 emote processes
+
+Each *-remote* instance on the QEMU command line will create an entry
+on a *QList* that can be searched for by its "id" property. It will also create
+a communication channel between QEMU and a remote process.  This is done in one
+of two methods:  direction execution of the process by QEMU with `fork()` and
+`exec()` system calls, and connecting to an existing process.
+
+direct execution
+
+When the remote process is directly executed, QEMU will setup a communication
+channel between it and the emulation process.  This channel will be created
+using `socketpair()` so that file descriptors can be passed from QEMU to the
+process.
+
+connecting to existing process
+
+Some environments wish to deny QEMU the ability to execute `fork()` and `exec()`
+In these case, emulation processes will be started before QEMU, and a UNIX
+domain socket will be given to each emulation process to communicate with QEMU
+over. After communication is established, the socket will be unlinked from the
+file system space by the QEMU process.
+
+communication with emulation process
+
+primary socket
+
+Whether the process was executed by QEMU or externally, there will be a primary
+socket for communication between QEMU a remote emulation process.  This channel
+will handle configuration commands from QEMU to the process, either from the
+QEMU command line, or from QMP commands that affect the devices being emulated
+by the process. This channel will only allow one message to be pending at a
+time; if additional messages arrive, they must wait for previous ones to be
+acknowledged from the remote side.
+
+secondary sockets
+
+The primary socket can pass the file descriptors of secondary sockets for
+operations that occur in parallel with commands on the primary channel.
+These include MMIO operations generated by the guest, or interrupt notifications
+generated by the device being emulated.  These secondary sockets will be created
+at the behest of the device proxies that require them. A disk device proxy
+wouldn't need any secondary sockets, but a disk controller device proxy may need
+both an MMIO socket and an interrupt socket.
+
+Only one secondary socket is needed for each type: for example, if multiple
+devices emulated by the same process each have MMIO registers, only one MMIO
+socket is needed.  The MMIO address is used to distinguish which device is being
+accessed.
+
+#### remote process attached by QMP
+
+There will be a new "attach-process" QMP command to facilitate device hot-plug.
+This command's arguments will be the same as the *-remote*  command line when
+it's used to attach to a remote process.  i.e., it will need an "id" argument
+so that hot-plugged devices can later find it, and a "socket" argument to
+identify the UNIX domain socket that will be used to communicate with QEMU.
+
+
+2.3.2 device proxy objects
+
+        QEMU has an object model based on sub-classes inherited from
+the "object" super-class.  The sub-classes that are of interest here
+are the "device" and "bus" sub-classes whose child sub-classes make up
+the device tree of a QEMU emulated system.
+
+        The proxy object model will use device proxy objects to
+replace the device emulation code within the QEMU process.  These
+objects will live in the same place in the object and bus hierarchies
+as the objects they replace.  i.e., the proxy object for an LSI SCSI
+controller will be a sub-class of the "pci-device" class, and will
+have the same PCI bus parent and the same SCSI bus child objects as
+the LSI controller object it replaces.
+
+        After the QEMU command line has been parsed, the "-rdevice"
+devices will be instantiated in the same manner as "-device" devices
+are. (i.e., qdev_device_add()).  In order to distinguish them from
+regular "-device" device objects, their class name will be the name of
+the class it replaces, with "-proxy" appended.  e.g., the "scsi-hd"
+proxy class will be "scsi-hd-proxy"
+
+2.3.2.1 object initialization
+
+        QEMU object initialization occurs in two phases.  The first
+initialization happens once per object class. (i.e., there can be many
+SCSI disks in an emulated system, but the "scsi-hd" class has its
+class_init() function called only once) The second phase happens when
+each object's instance_init() function is called to initialize each
+instance of the object.
+
+        All device objects are sub-classes of the "device" class, so
+they also have a realize() function that is called after
+instance_init() is called and after the object's static properties
+have been initialized.  Many device objects don't even provide an
+instance_init() function, and do all their per-instance work in
+realize().
+
+2.3.2.1.1 class_init
+
+        The class_init() method of a proxy object will, in general
+behave similarly to the object it replaces, including setting any
+static properties and methods needed by the proxy.
+
+2.3.2.1.2 instance_init / realize
+
+        The instance_init() and realize() functions would only need to
+perform tasks related to being a proxy, such are registering its own
+MMIO handlers, or creating a child bus that other proxy devices can be
+attached to later.  They also need to add a "json_device" string
+property that contains the JSON representation of the command line
+options used to create the object.
+
+        This JSON representation is used to create the corresponding
+object in an emulation process.  e.g., for an LSI SCSI controller
+invoked as:
+
+ -device lsi53c895a,id=scsi0,remote,command="lsi-scsi"
+
+the proxy object would create a
+
+{ "driver" : "lsi53c895a", "id" : "scsi0" }
+
+JSON description.  The "driver" option is assigned to the device name
+when the command line is parsed, so the "-proxy" appended by the
+command line parsing code must be removed.  The "command" option isn't
+needed in the JSON description since it only applies to the proxy
+object in the QEMU process.
+
+        Other tasks will are device-specific.  PCI device objects will
+initialize the PCI config space in order to make a valid PCI device
+tree within the QEMU process.  Disk devices will probe their backend
+object to get its JSON description, and publish this description as a
+"json_backend" string property (see the backend discussion below.)
+
+2.3.2.2 address space registration
+
+        Most devices are driven by guest device driver accesses to IO
+addresses or ports.  The QEMU device emulation code uses QEMU's memory
+region function calls (such as memory_region_init_io()) to add
+callback functions that QEMU will invoke when the guest accesses the
+device's areas of the IO address space.  When a guest driver does
+access the device, the VM will exit HW virtualization mode and return
+to QEMU, which will then lookup and execute the corresponding callback
+function.
+
+        A proxy object would need to mirror the memory region calls
+the actual device emulator would perform in its initialization code,
+but with its own callbacks.  When invoked by QEMU as a result of a
+guest IO operation, they will forward the operation to the device
+emulation process via a proxy_proc_send() call.  Any response will
+be read via proxy_proc_recv().
+
+        Note that the callbacks are called with an address space lock,
+so it would not be a appropriate to synchronously wait for any
+response.  Instead the QEMU code must be changed to check if the
+thread needs to sleep after the address_space_rw() call (in
+kvm_cpu_exec().)
+
+2.3.2.3 PCI config space
+
+        PCI devices also have a configuration space that can be
+accessed by the guest driver.  Guest accesses to this space is not
+handled by the device emulation object, but by it's PCI parent object.
+Much of this space is read-only, but certain registers (especially BAR
+and MSI-related ones) need to be propagated to the emulation process.
+
+2.3.2.3.1 PCI parent proxy
+
+        One way to propagate guest PCI config accesses is to create a
+"pci-device-proxy" class that can serve as the parent of a PCI device
+proxy object.  This class's parent would be "pci-device" and it would
+override the PCI parent's config_read and config_write methods with
+ones that forward these operations to the emulation program.
+
+2.3.2.4 interrupt receipt
+
+        A proxy for a device that generates interrupts will receive
+the interrupt indication via the read callback it provided to
+proxy_ctx_alloc().  The interrupt indication would then be sent up to
+its bus parent to be injected into the guest.  For example, a PCI
+device object may use pci_set_irq().
+
+2.3.3 device backends
+
+        Each type of device has backends which perform IO operations
+in the host system.  For example, block backend objects emulate the
+disk images configured into the VM.  While block backends are
+implemented as objects, not all backends are.  For example, display
+backends (e.g., vnc) are not objects, they register a set of virtual
+functions that are called by QEMU's display emulation.
+
+        These device backends also need run in the device emulation
+processes, and the emulation process must be given access the the
+corresponding host files or devices.
+
+2.3.3.1 block backends
+
+        Block backends are objects that can implement file protocols
+(such as a local file or an iSCSI volume), implement disk image
+formats (such as qcow2), or serve as a request filter (such as IO
+throttling).  They are often stacked on each other (such as a qcow2
+format on a local file protocol.)  They're are named by "node-name"
+properties that are then matched to "drive" properties of the
+corresponding disk devices.
+
+        Block backend objects are not part of the QEMU object model
+(i.e., they're not sub-classes of "object").  They are instantiated
+when the bdrv_file_open() method is invoked with a Qdict dictionary
+of the backend's command line options.
+
+2.3.3.1.1 initialization
+
+        When a "-rblockdev" backend is initialized, it will not open
+the underlying backend object, as is done for "-blockdev" backends.
+Instead, it will create a BlockDriverState node that has a proxy name
+and the original options Qdict.  The proxy name will consist of the
+backend's node-name with "-peer" appended to it (i.e., a "drive0"
+node-name would have a "drive0-peer" peer.)
+
+        A proxy backend object with then be opened, using an
+initialization Qdict containing the "node-name" of the underlying
+backend, so that disk device objects and QMP commands can find it.
+The proxy's Qdict will also be given the proxy name as a "peer"
+property so it can lookup its underlying backend object and its
+associated Qdict.
+
+2.3.3.1.2 bdrv_probe_json
+
+        This API returns the JSON description of the peer of a given
+backend proxy.  It will be used by disk device proxy objects to get
+the JSON descriptions of the block backend (and any backends layered
+below) needed to emulate the disk image.
+
+2.3.3.1.3 bdrv_get_json
+
+        This is a new block backend object method that returns the
+JSON description this object, and all of its underlying objects.  It
+will recursively descend any layered backend objects (e.g., a format
+object will call its underlying protocol object) This method can be
+invoked on an object that has not been opened.  It will mainly be used
+by bdrv_probe_json().
+
+2.3.3.1.4 bdrv_assign_proxy_name
+
+        The API creates the node with a proxy name, and enters it on a
+list of peer nodes.  This list can be searched by proxy backends to
+find their associated peers.
+
+2.3.3.1.5 QMP commands
+
+        Various QMP command operate on blockdevs.  These will need
+to work on rblockevs in separated processes as well.  There are
+several cases that need to be handled.
+
+2.3.3.1.5.1 adding rblockdevs
+
+        QMP allows users to add blockdevs to a running QEMU instance.
+This is done not just to hot-plug a disk device into a guest, but also
+for advanced blockdev features such as changing quorum devices.
+Likewise, QMP needs be able to add an rblockdev to the guest, so
+similar operations can be performed on devices being emulated in a
+separate process.
+
+        This operation doesn't need to be performed differently from
+adding an rblockdev from the command line.  Blockdevs are added with a
+qmp_blockdev_add() routine that can be called from either the command
+line parser or from QMP.  Note the name of the C routine called from
+QMP is generated by a python script, so a "rblockdev-add" command must
+be implemented by qmp_rblockdev_add().
+
+2.3.3.1.5.2 targeted commands
+
+        Many QMP commands operate on specified blockdevs.  These
+commands will find the proxy node when they lookup the targeted name,
+which will then forward the request to the emulation process managing
+the peer node.
+
+2.3.3.1.5.3 blockdev lists
+
+        Several QMP query commands (such as query-block or
+query-block-jobs) operate on all blockdevs.   These will function
+much like targeted commands, with the proxy nodes forwarding the
+request to its peer emulation process.
+
+2.3.4 proxy APIs
+
+        There will be a set of APIs provided by a process execution
+service for proxy objects to use to manage the separate emulation
+program.
+
+2.3.4.1 proxy_register
+
+        A proxy device object must register itself with the
+proxy_register() API.  The registration call will include validation
+and execution callbacks that will be invoked after the emulated
+machine has been setup in QEMU.
+
+2.3.4.1.1 validation callback
+
+        This callback will invoked after all devices in the emulated
+system have been initialized.  Its purpose is to validate the device
+configuration by checking that its parent and child bus objects are
+compatible with being proxied.  For example, a disk controller can
+check that all the devices on its bus are all proxy objects, or a disk
+object can check that its backend object is a proxy.  If any of the
+validation callbacks return an error, QEMU will exit.  If there are no
+errors, the execution callbacks will be invoked.
+
+2.3.4.1.2 execution callback
+
+        A device proxy object that manages an emulation process will
+provide an execution callback in its proxy_register() call.  This
+callback will allocate an execution context with proxy_ctx_alloc(),
+marshal the arguments needed for the emulation program, and invoke
+proxy_execute() to execute it.
+
+2.3.4.2 proxy_ctx_alloc
+
+        Before the emulation program can be executed, the proxy object
+must call proxy_ctx_alloc() to create an execution context for the
+process.  The execution context will serve as a handle on which the
+other proxy APIs operate.
+
+2.3.4.3 proxy_ctx_callbacks
+
+        This API registers two callback functions: get_reply() and
+get_request(), on the context.  get_reply() is invoked to handle
+replies to requests sent to the emulation process.  get_request() is
+invoked to handle requests from the emulation process.  This API can
+be called multiple times on the same context; a class field within an
+incoming message indicates which callbacks will be invoked.
+
+2.3.4.4 proxy_execute
+
+        This function executes an emulation program.  It needs to be
+provided with an execution context, the file to execute, and any
+arguments needed by the program.  Before executing the given program,
+it will setup the communications channels for the new process.
+
+2.3.5 communication with emulation process
+
+        The execution service will setup two communication channels
+between the main QEMU process and the emulation process.  The channels
+will be created using socketpair() so that file descriptors can be
+passed from QEMU to the process.
+
+2.3.5.1 requests to emulation process
+
+        The stdin file descriptor of the emulation process will be
+used for requests from QEMU to the emulation process.  The execution
+service provides APIs to send and receive messages from the emulation
+process.
+
+2.3.5.1.1 proxy_proc_send
+
+        This API is for the proxy object in QEMU to send messages to
+the emulation process.  Its arguments will include an execution
+context in addition to the actual message.
+
+2.3.5.1.2 proxy_proc_recv
+
+        This API receives replies from the emulation process.  It
+requires the execution context of the target process, and will usually
+be called from the get_reply() callback specified in proxy_ctx_alloc.
+
+2.3.5.2 requests to QEMU process
+
+        The stdout file descriptor to the emulation process will be
+used for requests from the emulation process to QEMU.  As with
+requests to the emulation process, APIs will be provided to facilitate
+communication.
+
+2.3.5.2.1 proxy_qemu_recv
+
+        This API receives requests from the emulation process.  It
+requires the execution context of the target process, and will usually
+be called from the get_request() callback specified in
+proxy_ctx_alloc.
+
+2.3.5.2.2 proxy_qemu_send
+
+        This API is for the proxy object in QEMU to send replies to
+the emulation process.  Its arguments will include an execution
+context in addition to the actual reply.
+
+2.3.5.3 JSON descriptions
+
+        The initial messages sent to the emulation process will
+describe the devices its will be tasked to emulate.  The will be
+described as JSON arrays of backend and device objects that need to be
+instantiated by the emulation process.
+
+2.3.5.3.1 backend JSON
+
+        The device proxy object will aggregate the "json_backend"
+properties from the disk devices on the bus it controls, and send
+them as a JSON array of objects. e.g., this command line:
+
+-rblockdev driver=file,node-name=file0,filename=disk-file0
+-rblockdev driver=qcow2,node-name=drive0,file=file0
+
+would generate
+
+[
+  { "driver" : "file", "node-name" : "file0", "filename" : "disk-file0" }.
+  { "driver" : "qcow2", "node-name" : "drive0", "file" : "file0" }
+]
+
+2.3.5.3.2 device JSON
+
+        The device proxy object will aggregate a JSON description of
+itself and devices on the bus it controls (via their "json_device"
+properties), and send them to the emulation process as a JSON array of
+objects.
+
+2.3.5.4 DMA operations
+
+        DMA operations would be handled much like vhost applications
+do.  One of the initial messages sent to the emulation process is a
+guest memory table.  Each entry in this table consists of a file
+descriptor and size that the emulation process can mmap() to directly
+access guest memory, similar to vhost_user_set_mem_table().  Note
+guest memory must be backed by file descriptors, such as when QEMU is
+given the "-mem-path" command line option.
+
+2.3.5.5 IOMMU operations
+
+        When the emulated system includes an IOMMU, the proxy
+execution service will need to handle IOMMU requests from the
+emulation process using an address_space_get_iotlb_entry() call.  In
+order to handle IOMMU unmaps, the proxy execution service will also
+register as a listener on the device's DMA address space.  When an
+IOMMU memory region is created within the DMA address space, an IOMMU
+notifier for unmaps will be added to the memory region that will
+forward unmaps to the emulation process.
+
+        This also will require a proxy_ctx_callbacks() call to
+register an IOMMU handler for incoming IOMMU requests from the
+emulation program.
+
+2.3.6 device emulation process
+
+        The device emulation process will run the object hierarchy of
+the device, hopefully unmodified.  It will be based on the QEMU source
+code, because for anything but the simplest device, it would not be a
+tractable problem to re-implement both the object model and the many
+device backends that QEMU has.
+
+        The parts of QEMU that the emulation program will need include
+the object model; the memory emulation objects; the device emulation
+objects of the targeted device, and any dependent devices; and, the
+device's backends.  It will also need code to setup the machine
+environment, handle requests from the QEMU process, and route
+machine-level requests (such as interrupts or IOMMU mappings) back to
+the QEMU process.
+
+2.3.6.1 initialization
+
+        The process initialization sequence will follow the same
+sequence followed by QEMU.  It will first initialize the backend
+objects, then device emulation objects.  The JSON arrays sent by the
+QEMU process will drive which objects need to be created.
+
+2.3.6.1.1 address spaces
+
+        Before the device objects are created, the initial address
+spaces and memory regions must be configured with memory_map_init().
+This creates a RAM memory region object (system_memory) and an IO
+memory region object (system_io).
+
+2.3.6.1.2 RAM
+
+        RAM memory region creation will follow how pc_memory_init()
+creates them, but must use memory_region_init_ram_from_fd() instead of
+memory_region_allocate_system_memory().  The file descriptors needed
+will be supplied by the guest memory table from above.  Those RAM
+regions would then be added to the system_memory memory region with
+memory_region_add_subregion().
+
+2.3.6.1.3 PCI
+
+        IO initialization will be driven by the JSON description sent
+from the QEMU process.  For a PCI device, a PCI bus will need to be
+created with pci_root_bus_new(), and a PCI memory region will need to
+be created and added to the system_memory memory region with
+memory_region_add_subregion_overlap().  The overlap version is
+required for architectures where PCI memory overlaps with RAM memory.
+
+2.3.6.2 MMIO handling
+
+        The device emulation objects will use memory_region_init_io()
+to install their MMIO handlers, and pci_register_bar() to associate
+those handlers with a PCI BAR, as they do withing QEMU currently.
+
+        In order to use address_space_rw() in the emulation process to
+handle MMIO requests from QEMU, the PCI physical addresses must be the
+same in the QEMU process and the device emulation process.  In order
+to accomplish that, guest BAR programming must also be forwarded from
+QEMU to the emulation process.
+
+2.3.6.3 interrupt injection
+
+        When device emulation wants to inject an interrupt into the
+VM, the request climbs the device's bus object hierarchy until the
+point where a bus object knows how to signal the interrupt to the
+guest.  The details depend on the type of interrupt being raised.
+
+2.3.6.3.1 PCI pin interrupts
+
+        On x86 systems, there is an emulated IOAPIC object attached to
+the root PCI bus object, and the root PCI object forwards interrupt
+requests to it.  The IOAPIC object, in turn, calls the KVM driver to
+inject the corresponding interrupt into the VM.  The simplest way to
+handle this in an emulation process would be to setup the root PCI bus
+driver (via pci_bus_irqs()) to send a interrupt request back to the
+QEMU process, and have the device proxy object reflect it up the PCI
+tree there.
+
+2.3.6.3.2 PCI MSI/X interrupts
+
+        PCI MSI/X interrupts are implemented in HW as DMA writes to a
+CPU-specific PCI address.  In QEMU on x86, a KVM APIC object receives
+these DMA writes, then calls into the KVM driver to inject the
+interrupt into the VM.  A simple emulation process implementation
+would be to send the MSI DMA address from QEMU as a message at
+initialization, then install an address space handler at that address
+which forwards the MSI message back to QEMU.
+
+2.3.6.4 DMA operations
+
+        When a emulation object wants to DMA into or out of guest
+memory, it first must use dma_memory_map() to convert the DMA address
+to a local virtual address.  The emulation process memory region
+objects setup above will be used to translate the DMA address to a
+local virtual address the device emulation code can access.
+
+2.3.6.5 IOMMU
+
+        When an IOMMU is in use in QEMU, DMA translation uses IOMMU
+memory regions to translate the DMA address to a guest physical
+address before that physical address can be translated to a local
+virtual address.  The emulation process will need similar
+functionality.
+
+2.3.6.5.1 IOTLB cache
+
+        The emulation process will maintain a cache of recent IOMMU
+translations (the IOTLB).  When the translate() callback of an IOMMU
+memory region is invoked, the IOTLB cache will be searched for an
+entry that will map the DMA address to a guest PA.  On a cache miss, a
+message will be sent back to QEMU requesting the corresponding
+translation entry, which be both be used to return a guest address and
+be added to the cache.
+
+2.3.6.5.2 IOTLB purge
+
+        The IOMMU emulation will also need to act on unmap requests
+from QEMU.  These happen when the guest IOMMU driver purges an entry
+from the guest's translation table.
+
+2.4 Accelerating device emulation
+
+        The messages that are required to be sent between QEMU and the
+emulation process can add considerable latency to IO operations.  The
+optimizations described below attempt to ameliorate this effect by
+allowing the emulation process to communicate directly with the kernel
+KVM driver.  The KVM file descriptors created wold be passed to the
+emulation process via initialization messages, much like the guest
+memory table is done.
+
+2.4.1 MMIO acceleration
+
+        Vhost user applications can receive guest virtio driver stores
+directly from KVM.  The issue with the eventfd mechanism used by vhost
+user is that it does not pass any data with the event indication, so
+it cannot handle guest loads or guest stores that carry store data.
+This concept could, however, be expanded to cover more cases.
+
+        The expanded idea would require a new type of KVM device:
+KVM_DEV_TYPE_USER.  This device has two file descriptors: a master
+descriptor that QEMU can use for configuration, and a slave descriptor
+that the emulation process can use to receive MMIO notifications.
+QEMU would create both descriptors using the KVM driver, and pass the
+slave descriptor to the emulation process via an initialization
+message.
+
+2.4.1.1 data structures
+
+2.4.1.1.1 guest physical range
+
+        The guest physical range structure describes the address range
+that a device will respond to.  It includes the base and length of the
+range, as well as which bus the range resides on (e.g., on an x86
+machine, it can specify whether the range refers to memory or IO
+addresses).
+
+        A device can have multiple physical address ranges it responds
+to (e.g., a PCI device can have multiple BARs), so the structure will
+also include an enumeration value to specify which of the device's
+ranges is being referred to.
+
+2.4.1.1.2 MMIO request structure
+
+        This structure describes an MMIO operation.  It includes which
+guest physical range the MMIO was within, the offset within that
+range, the MMIO type (e.g., load or store), and its length and data.
+It also includes a sequence number that can be used to reply to the
+MMIO, and the CPU that issued the MMIO.
+
+2.4.1.1.3 MMIO request queues
+
+        MMIO request queues are FIFO arrays of MMIO request
+structures.  There are two queues: pending queue is for MMIOs that
+haven't been read by the emulation program, and the sent queue is for
+MMIOs that haven't been acknowledged.  The main use of the second
+queue is to validate MMIO replies from the emulation program.
+
+2.4.1.1.4 scoreboard
+
+        Each CPU in the VM is emulated in QEMU by a separate thread,
+so multiple MMIOs may be waiting to be consumed by an emulation
+program and multiple threads may be waiting for MMIO replies.  The
+scoreboard would contain a wait queue and sequence number for the
+per-CPU threads, allowing them to be individually woken when the MMIO
+reply is received from the emulation program.  It also tracks the
+number of posted MMIO stores to the device that haven't been replied
+to, in order to satisfy the PCI constraint that a load to a device
+will not complete until all previous stores to that device have been
+completed.
+
+2.4.1.1.5 device shadow memory
+
+        Some MMIO loads do not have device side-effects.  These MMIOs
+can be completed without sending a MMIO request to the emulation
+program if the emulation program shares a shadow image of the device's
+memory image with the KVM driver.
+
+        The emulation program will ask the KVM driver to allocate
+memory for the shadow image, and will then use mmap() to directly
+access it.  The emulation program can control KVM access to the shadow
+image by sending KVM an access map telling it which areas of the image
+have no side-effects (and can be completed immediately), and which
+require a MMIO request to the emulation program.  The access map can
+also inform the KVM drive which size accesses are allowed to the
+image.
+
+2.4.1.2 master descriptor
+
+        The master descriptor is used by QEMU to configure the new KVM
+device.  The descriptor would be returned by the KVM driver when QEMU
+issues a KVM_CREATE_DEVICE ioctl() with a KVM_DEV_TYPE_USER type.
+
+2.4.1.2.1 KVM_DEV_TYPE_USER device ops
+
+        The KVM_DEV_TYPE_USER operations vector will be registered by
+a kvm_register_device_ops() call when the KVM system in initialized by
+kvm_init().  These device ops are called by the KVM driver when QEMU
+executes certain ioctls() on its KVM file descriptor.  They include:
+
+2.4.1.1.2.1 create
+
+        This routine is called when QEMU issues a KVM_CREATE_DEVICE
+ioctl() on its per-VM file descriptor.  It will allocate and
+initialize a KVM user device specific data structure, and assign the
+kvm_device private field to it.
+
+2.4.1.1.2.2 ioctl
+
+        This routine is invoked when QEMU issues an ioctl() on the
+master descriptor.  The ioctl() commands supported are defined by the
+KVM device type.  KVM_DEV_TYPE_USER ones will need several commands:
+
+        KVM_DEV_USER_SLAVE_FD creates the slave file descriptor that
+will be passed to the device emulation program.  Only one slave can be
+created by each master descriptor.  The file operations performed by
+this descriptor are described below.
+
+        The KVM_DEV_USER_PA_RANGE command configures a guest physical
+address range that the slave descriptor will receive MMIO
+notifications for.  The range is specified by a guest physical range
+structure argument.  For buses that assign addresses to devices
+dynamically, this command can be executed while the guest is running,
+such as the case when a guest changes a device's PCI BAR registers.
+
+        KVM_DEV_USER_PA_RANGE will use kvm_io_bus_register_dev() to
+register kvm_io_device_ops callbacks to be invoked when the guest
+performs a MMIO operation within the range.  When a range is changed,
+kvm_io_bus_unregister_dev() is used to remove the previous
+instantiation.
+
+        KVM_DEV_USER_TIMEOUT will configure a timeout value that
+specifies how long KVM will wait for the emulation process to respond
+to a MMIO indication.
+
+2.4.1.1.2.3 destroy
+
+        This routine is called when the VM instance is destroyed.  It
+will need to destroy the slave descriptor; and free any memory
+allocated by the driver, as well as the kvm_device structure itself.
+
+2.4.1.3 slave descriptor
+
+        The slave descriptor will have its own file operations vector,
+which responds to system calls on the descriptor performed by the
+device emulation program.
+
+2.4.1.3.1 read
+
+        A read returns any pending MMIO requests from the KVM driver
+as MMIO request structures.  Multiple structures can be returned if
+there are multiple MMIO operations pending.  The MMIO requests are
+moved from the pending queue to the sent queue, and if there are
+threads waiting for space in the pending to add new MMIO operations,
+they will be woken here.
+
+2.4.1.3.2 write
+
+        A write also consists of a set of MMIO requests.  They are
+compared to the MMIO requests in the sent queue.  Matches are removed
+from the sent queue, and any threads waiting for the reply are woken.
+If a store is removed, then the number of posted stores in the per-CPU
+scoreboard is decremented.  When the number is zero, and a non
+side-effect load was waiting for posted stores to complete, the load
+is continued.
+
+2.4.1.3.3 ioctl
+
+        There are several ioctl()s that can be performed on the
+slave descriptor.
+
+        A KVM_DEV_USER_SHADOW_SIZE ioctl() causes the KVM driver to
+allocate memory for the shadow image.  This memory can later be
+mmap()ed by the emulation process to share the emulation's view of
+device memory with the KVM driver.
+
+        A KVM_DEV_USER_SHADOW_CTRL ioctl() controls access to the
+shadow image.  It will send the KVM driver a shadow control map, which
+specifies which areas of the image can complete guest loads without
+sending the load request to the emulation program.  It will also
+specify the size of load operations that are allowed.
+
+2.4.1.3.4 poll
+
+        An emulation program will use the poll() call with a POLLIN
+flag to determine if there are MMIO requests waiting to be read.  It
+will return if the pending MMIO request queue is not empty.
+
+2.4.1.3.5 mmap
+
+        This call allows the emulation program to directly access the
+shadow image allocated by the KVM driver.  As device emulation updates
+device memory, changes with no side-effects will be reflected in the
+shadow, and the KVM driver can satisfy guest loads from the shadow
+image without needing to wait for the emulation program.
+
+2.4.1.4 kvm_io_device ops
+
+        Each KVM per-CPU thread can handle MMIO operation on behalf of
+the guest VM.  KVM will use the MMIO's guest physical address to
+search for a matching kvm_io_devce to see if the MMIO can be handled
+by the KVM driver instead of exiting back to QEMU.  If a match is
+found, the corresponding callback will be invoked.
+
+2.4.1.4.1 read
+
+        This callback is invoked when the guest performs a load to the
+device.  Loads with side-effects must be handled synchronously, with
+the KVM driver putting the QEMU thread to sleep waiting for the
+emulation process reply before re-starting the guest.  Loads that do
+not have side-effects may be optimized by satisfying them from the
+shadow image, if there are no outstanding stores to the device by this
+CPU.  PCI memory ordering demands that a load cannot complete before
+all older stores to the same device have been completed.
+
+2.4.1.4.2 write
+
+        Stores can be handled asynchronously unless the pending MMIO
+request queue is full.  In this case, the QEMU thread must sleep
+waiting for space in the queue.  Stores will increment the number of
+posted stores in the per-CPU scoreboard, in order to implement the PCI
+ordering constraint above.
+
+2.4.2 interrupt acceleration
+
+        This performance optimization would work much like a vhost
+user application does, where the QEMU process sets up eventfds that
+cause the device's corresponding interrupt to be triggered by the KVM
+driver.  These irq file descriptors are sent to the emulation process
+at initialization, and are used when the emulation code raises a
+device interrupt.
+
+2.4.2.1 intx acceleration
+
+        Traditional PCI pin interrupts are level based, so, in
+addition to an irq file descriptor, a re-sampling file descriptor
+needs to be sent to the emulation program.  This second file
+descriptor allows multiple devices sharing an irq to be notified when
+the interrupt has been acknowledged by the guest, so they can
+re-trigger the interrupt if their device has not de-asserted it.
+
+2.4.2.1.1 intx irq descriptor
+
+        The irq descriptors are created by the proxy object using
+event_notifier_init() to create the irq and re-sampling eventds, and
+kvm_vm_ioctl(KVM_IRQFD) to bind them to an interrupt.  The interrupt
+route can be found with pci_device_route_intx_to_irq().
+
+2.4.2.1.2 intx routing changes
+
+        Intx routing can be changed when the guest programs the APIC
+the device pin is connected to.  The proxy object in QEMU will use
+pci_device_set_intx_routing_notifier() to be informed of any guest
+changes to the route.  This handler will broadly follow the VFIO
+interrupt logic to change the route: de-assigning the existing irq
+descriptor from its route, then assigning it the new route. (see
+vfio_intx_update())
+
+2.4.2.2 MSI/X acceleration
+
+        MSI/X interrupts are sent as DMA transactions to the host.
+The interrupt data contains a vector that is programed by the guest, A
+device may have multiple MSI interrupts associated with it, so
+multiple irq descriptors may need to be sent to the emulation program.
+
+2.4.2.2.1 MSI/X irq descriptor
+
+        This case will also follow the VFIO example.  For each MSI/X
+interrupt, an eventfd is created, a virtual interrupt is allocated by
+kvm_irqchip_add_msi_route(), and the virtual interrupt is bound to the
+eventfd with kvm_irqchip_add_irqfd_notifier().
+
+2.4.2.2.2 MSI/X config space changes
+
+        The guest may dynamically update several MSI-related tables in
+the device's PCI config space.  These include per-MSI interrupt
+enables and vector data.  Additionally, MSIX tables exist in device
+memory space, not config space.  Much like the BAR case above, the
+proxy object must look at guest config space programming to keep the
+MSI interrupt state consistent between QEMU and the emulation program.
+
+
+3. Disaggregated CPU emulation
+
+        After IO services have been disaggregated, a second phase
+would be to separate a process to handle CPU instruction emulation
+from the main QEMU control function.  There are no object separation
+points for this code, so the first task would be to create one.
+
+
+4. Host access controls
+
+        Separating QEMU relies on the host OS's access restriction
+mechanisms to enforce that the differing processes can only access the
+objects they are entitled to.  There are a couple types of mechanisms
+usually provided by general purpose OSs.
+
+4.1 Discretionary access control
+
+        Discretionary access control allows each user to control who
+can access their files. In Linux, this type of control is usually too
+coarse for QEMU separation, since it only provides three separate
+access controls: one for the same user ID, the second for users IDs
+with the same group ID, and the third for all other user IDs.  Each
+device instance would need a separate user ID to provide access
+control, which is likely to be unwieldy for dynamically created VMs.
+
+4.2 Mandatory access control
+
+        Mandatory access control allows the OS to add an additional
+set of controls on top of discretionary access for the OS to control.
+It also adds other attributes to processes and files such as types,
+roles, and categories, and can establish rules for how processes and
+files can interact.
+
+4.2.1 Type enforcement
+
+        Type enforcement assigns a 'type' attribute to processes and
+files, and allows rules to be written on what operations a process
+with a given type can perform on a file with a given type.  QEMU
+separation could take advantage of type enforcement by running the
+emulation processes with different types, both from the main QEMU
+process, and from the emulation processes of different classes of
+devices.
+
+        For example, guest disk images and disk emulation processes
+could have types separate from the main QEMU process and non-disk
+emulation processes, and the type rules could prevent processes other
+than disk emulation ones from accessing guest disk images.  Similarly,
+network emulation processes can have a type separate from the main
+QEMU process and non-network emulation process, and only that type can
+access the host tun/tap device used to provide guest networking.
+
+4.2.2 Category enforcement
+
+        Category enforcement assigns a set of numbers within a given
+ range to the process or file.  The process is granted access to the
+ file if the process's set is a superset of the file's set.  This
+ enforcement can be used to separate multiple instances of devices in
+ the same class.
+
+        For example, if there are multiple disk devices provides to a
+guest, each device emulation process could be provisioned with a
+separate category.  The different device emulation processes would not
+be able to access each other's backing disk images.
+
+        Alternatively, categories could be used in lieu of the type
+enforcement scheme described above.  In this scenario, different
+categories would be used to prevent device emulation processes in
+different classes from accessing resources assigned to other classes.
+
-- 
2.17.1


