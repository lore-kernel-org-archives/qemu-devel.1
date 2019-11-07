Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADED3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D0B20663
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwn6XRWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D0B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSk4o-00058s-5j
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSk3j-0004he-4e
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSk3e-0005a1-SV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:50:55 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSk3e-0005Zj-FL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:50:50 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so3617500wrx.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 07:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SfQrpwdJOkM4NdnHIaajwTbC7+NQftjf/5CMbdC1O/c=;
 b=pwn6XRWUbyOU14j3I+Q8ytEqKEK2P8z50av+KtjpkY6ej0zL/Tm1FlEEz77jzeJ8lC
 ZFzKaYV83RRy+GklrnYkszsfVrmeZ6uPyuuVjeyQ/sGIEfe9gmgPItz5pkSyHeKODH6b
 IkQ2joLvja/Uzv0nHmSgXjwl8QivB/BLE6pJJ0p3r2HxkroY5aIZMpLJhB7M2f18cXi9
 17fvZOg++MWp8tu7HHdr/jbro2uWTC43/eE1pYbESZLtNnZeHzrX5vnIunA2J9A0DPaw
 uOFGkIDh62PfuUkxooEQvLb6PCld9LjE6MFYyXdtDgQaM53qzEhmB1OvtA2hIXHP77dB
 kBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SfQrpwdJOkM4NdnHIaajwTbC7+NQftjf/5CMbdC1O/c=;
 b=X6vl8jvvV9Q4gRMBqdS0/iOxQkoynGX+CKK3mmbihVsQeBrX5FVwIayDiPA4S1jLGD
 7uR/ACLeoHbE81f1PYXFCJbHJjZsFxNXVsrepM+FKoUFgLtGZvdW2JUgePwV6HoPDf5P
 HUW4L85LKAX7BBzgA6YCJTF5l8UWPzTkKcvJgTtf7roA5SiA3b1xz9H3yFC9megEBNc6
 JBkLsvjsGfZEZ9vjCG17rZy8exnczkrI1pBEcGbgT3JtD6Uu8ywMpc+R7BEoU2iBdRfE
 pORhz5YmAH4L70N5qT3PRnvhVO6+2QrIv8qmoSJ4gTXUeYvEJe8Y/tNZyD5yeyQxZ1n9
 Xaqw==
X-Gm-Message-State: APjAAAX/d9Vr4LCXUrY1J4fS/k9sIUo+Xy983TZeXeeerKkCJ8fyjIZw
 fFATRBfgGKExY22FOiI0/EM=
X-Google-Smtp-Source: APXvYqzGuWsogPdwvtmKXz+sEN1kVSTTuNXsoY4quKH/rzLapizHmCeFe6jY+GBm2Cd4Wr9zFYr42g==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr3689738wrq.22.1573141848116;
 Thu, 07 Nov 2019 07:50:48 -0800 (PST)
Received: from localhost (77.119.131.75.wireless.dyn.drei.com. [77.119.131.75])
 by smtp.gmail.com with ESMTPSA id e27sm3435239wra.21.2019.11.07.07.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 07:50:47 -0800 (PST)
Date: Thu, 7 Nov 2019 16:50:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 48/49] multi-process: add the concept description
 to docs/devel/qemu-multiprocess
Message-ID: <20191107155038.GJ365089@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <1ee67238bd543959c3218612bff4acca06d15baa.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Content-Disposition: inline
In-Reply-To: <1ee67238bd543959c3218612bff4acca06d15baa.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:09:29AM -0400, Jagannathan Raman wrote:
> diff --git a/docs/devel/qemu-multiprocess.rst b/docs/devel/qemu-multiprocess.rst
> new file mode 100644
> index 0000000..2c42c6e
> --- /dev/null
> +++ b/docs/devel/qemu-multiprocess.rst
> @@ -0,0 +1,1102 @@
> +Disaggregating QEMU
> +===================
> +
> +QEMU is often used as the hypervisor for virtual machines running in the
> +Oracle cloud. Since one of the advantages of cloud computing is the
> +ability to run many VMs from different tenants in the same cloud
> +infrastructure, a guest that compromised its hypervisor could
> +potentially use the hypervisor's access privileges to access data it is
> +not authorized for.
> +
> +QEMU can be susceptible to security attack because it is a large,
> +monolithic program that provides many features to the VMs it services.
> +Many of these feature can be configured out of QEMU, but even a reduced
> +configuration QEMU has a large amount of code a guest can potentially
> +attack in order to gain additional privileges.

The "additional privileges" are only host userspace code execution (i.e.
syscalls) within an unprivileged process that is sandboxed using seccomp
and SELinux on a properly configured system.  If QEMU has access to
resources that do not belong to the guest then you have not configured
QEMU correctly (libvirt handles a lot of this setup for you).

I think it's more accurate to describe the motivation for multi-process
QEMU in terms of the principle of least privilege: each component in the
system should only have access to the resources that it needs to perform
its job.  That way people don't get the impression that QEMU is a
trusted component with access to resources that must be kept from the
guest.

> +QEMU services
> +-------------
> +
> +QEMU can be broadly described as providing three main services. One is a
> +VM control point, where VMs can be created, migrated, re-configured, and
> +destroyed. A second is to emulate the CPU instructions within the VM,
> +often accelerated by HW virtualization features such as Intel's VT
> +extensions. Finally, it provides IO services to the VM by emulating HW
> +IO devices, such as disk and network devices.
> +
> +A disaggregated QEMU
> +~~~~~~~~~~~~~~~~~~~~
> +
> +A disaggregated QEMU involves separating QEMU services into separate
> +host processes. Each of these processes can be given only the privileges
> +it needs to provide its service, e.g., a disk service could be given
> +access only the the disk images it provides, and not be allowed to
> +access other files, or any network devices. An attacker who compromised
> +this service would not be able to use this exploit to access files or
> +devices beyond what the disk service was given access to.
> +
> +A QEMU control process would remain, but in disaggregated mode, it would
> +be a control point that executes the processes needed to support the VM
> +being created, but have no direct interfaces to the VM. During VM
> +execution, it would still provide the user interface to hot-plug devices
> +or live migrate the VM.

"it would be a control point that executes the processes needed to
support the VM being created"

libvirt does the sandboxing setup.  I think the responsibility of
executing and sandboxing device processes would also be left to libvirt,
not to QEMU.

Perhaps it's best to leave this sentence out and enable both approaches
(1. QEMU executes device processes, 2. management tool executes device
processes).

> +A first step in creating a disaggregated QEMU is to separate IO services
> +from the main QEMU program, which would continue to provide CPU
> +emulation. i.e., the control process would also be the CPU emulation
> +process. In a later phase, CPU emulation could be separated from the
> +control process.
> +
> +Disaggregating IO services
> +--------------------------
> +
> +Disaggregating IO services is a good place to begin QEMU disaggregating
> +for a couple of reasons. One is the sheer number of IO devices QEMU can
> +emulate provides a large surface of interfaces which could potentially
> +be exploited, and, indeed, have been a source of exploits in the past.
> +Another is the modular nature of QEMU device emulation code provides
> +interface points where the QEMU functions that perform device emulation
> +can be separated from the QEMU functions that manage the emulation of
> +guest CPU instructions.
> +
> +QEMU device emulation
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +QEMU uses a object oriented SW architecture for device emulation code.
> +Configured objects are all compiled into the QEMU binary, then objects
> +are instantiated by name when used by the guest VM. For example, the
> +code to emulate a device named "foo" is always present in QEMU, but its
> +instantiation code is only run when the device is included in the target
> +VM. (e.g., via the QEMU command line as *-device foo*)
> +
> +The object model is hierarchical, so device emulation code names its
> +parent object (such as "pci-device" for a PCI device) and QEMU will
> +instantiate a parent object before calling the device's instantiation
> +code.
> +
> +Current separation models
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +In order to separate the device emulation code from the CPU emulation
> +code, the device object code must run in a different process. There are
> +a couple of existing QEMU features that can run emulation code
> +separately from the main QEMU process. These are examined below.
> +
> +vhost user model
> +^^^^^^^^^^^^^^^^
> +
> +Virtio guest device drivers can be connected to vhost user applications
> +in order to perform their IO operations. This model uses special virtio
> +device drivers in the guest and vhost user device objects in QEMU, but
> +once the QEMU vhost user code has configured the vhost user application,
> +mission-mode IO is performed by the application. The vhost user
> +application is a daemon process that can be contacted via a known UNIX
> +domain socket.
> +
> +vhost socket
> +''''''''''''
> +
> +As mentioned above, one of the tasks of the vhost device object within
> +QEMU is to contact the vhost application and send it configuration
> +information about this device instance. As part of the configuration
> +process, the application can also be sent other file descriptors over
> +the socket, which then can be used by the vhost user application in
> +various ways, some of which are described below.
> +
> +vhost MMIO store acceleration
> +'''''''''''''''''''''''''''''
> +
> +VMs are often run using HW virtualization features via the KVM kernel
> +driver. This driver allows QEMU to accelerate the emulation of guest CPU
> +instructions by running the guest in a virtual HW mode. When the guest
> +executes instructions that cannot be executed by virtual HW mode,
> +execution returns to the KVM driver so it can inform QEMU to emulate the
> +instructions in SW.
> +
> +One of the events that can cause a return to QEMU is when a guest device
> +driver accesses an IO location. QEMU then dispatches the memory
> +operation to the corresponding QEMU device object. In the case of a
> +vhost user device, the memory operation would need to be sent over a
> +socket to the vhost application. This path is accelerated by the QEMU
> +virtio code by setting up an eventfd file descriptor that the vhost
> +application can directly receive MMIO store notifications from the KVM
> +driver, instead of needing them to be sent to the QEMU process first.
> +
> +vhost interrupt acceleration
> +''''''''''''''''''''''''''''
> +
> +Another optimization used by the vhost application is the ability to
> +directly inject interrupts into the VM via the KVM driver, again,
> +bypassing the need to send the interrupt back to the QEMU process first.
> +The QEMU virtio setup code configures the KVM driver with an eventfd
> +that triggers the device interrupt in the guest when the eventfd is
> +written. This irqfd file descriptor is then passed to the vhost user
> +application program.
> +
> +vhost access to guest memory
> +''''''''''''''''''''''''''''
> +
> +The vhost application is also allowed to directly access guest memory,
> +instead of needing to send the data as messages to QEMU. This is also
> +done with file descriptors sent to the vhost user application by QEMU.
> +These descriptors can be passed to ``mmap()`` by the vhost application
> +to map the guest address space into the vhost application.
> +
> +IOMMUs introduce another level of complexity, since the address given to
> +the guest virtio device to DMA to or from is not a guest physical
> +address. This case is handled by having vhost code within QEMU register
> +as a listener for IOMMU mapping changes. The vhost application maintains
> +a cache of IOMMMU translations: sending translation requests back to
> +QEMU on cache misses, and in turn receiving flush requests from QEMU
> +when mappings are purged.
> +
> +applicability to device separation
> +''''''''''''''''''''''''''''''''''
> +
> +Much of the vhost model can be re-used by separated device emulation. In
> +particular, the ideas of using a socket between QEMU and the device
> +emulation application, using a file descriptor to inject interrupts into
> +the VM via KVM, and allowing the application to ``mmap()`` the guest
> +should be re used.
> +
> +There are, however, some notable differences between how a vhost
> +application works and the needs of separated device emulation. The most
> +basic is that vhost uses custom virtio device drivers which always
> +trigger IO with MMIO stores. A separated device emulation model must
> +work with existing IO device models and guest device drivers. MMIO loads
> +break vhost store acceleration since they are synchronous - guest
> +progress cannot continue until the load has been emulated. By contrast,
> +stores are asynchronous, the guest can continue after the store event
> +has been sent to the vhost application.
> +
> +Another difference is that in the vhost user model, a single daemon can
> +support multiple QEMU instances. This is contrary to the security regime
> +desired, in which the emulation application should only be allowed to
> +access the files or devices the VM it's running on behalf of can access.
> +#### qemu-io model
> +
> +Qemu-io is a test harness used to test changes to the QEMU block backend
> +object code. (e.g., the code that implements disk images for disk driver
> +emulation) Qemu-io is not a device emulation application per se, but it
> +does compile the QEMU block objects into a separate binary from the main
> +QEMU one. This could be useful for disk device emulation, since its
> +emulation applications will need to include the QEMU block objects.
> +
> +New separation model based on proxy objects
> +-------------------------------------------
> +
> +A different model based on proxy objects in the QEMU program
> +communicating with remote emulation programs could provide separation
> +while minimizing the changes needed to the device emulation code. The
> +rest of this section is a discussion of how a proxy object model would
> +work.
> +
> +Remote emulation processes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The remote emulation process will run the QEMU object hierarchy without
> +modification. The device emulation objects will be also be based on the
> +QEMU code, because for anything but the simplest device, it would not be
> +a tractable to re-implement both the object model and the many device
> +backends that QEMU has.
> +
> +The processes will communicate with the QEMU process over UNIX domain
> +sockets. The processes can be executed either as standalone processes,
> +or be executed by QEMU. In both cases, the host backends the emulation
> +processes will provide are specified on its command line, as they would
> +be for QEMU. For example:
> +
> +::
> +
> +    disk-proc -blockdev driver=file,node-name=file0,filename=disk-file0  \
> +    -blockdev driver=qcow2,node-name=drive0,file=file0
> +
> +would indicate process *disk-proc* uses a qcow2 emulated disk named
> +*file0* as its backend.
> +
> +Emulation processes may emulate more than one guest controller. A common
> +configuration might be to put all controllers of the same device class
> +(e.g., disk, network, etc.) in a single process, so that all backends of
> +the same type can be managed by a single QMP monitor.
> +
> +communication with QEMU
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Remote emulation processes will recognize a *-socket* argument that
> +specifies the path of a UNIX domain socket used to communicate with the
> +QEMU process. If no *-socket* argument is present, the process will use
> +file descriptor 0 to communicate with QEMU. For example,
> +
> +::
> +
> +    disk-proc -socket /tmp/disk0-sock <backend list>
> +
> +will communicate with QEMU using the socket path */tmp/dik0-sock*.

s/dik/disk/

> +
> +remote process QMP monitor
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Remote emulation processes can be monitored via QMP, similar to QEMU
> +itself. The QMP monitor socket is specified the same as for a QEMU
> +process:
> +
> +::
> +
> +    disk-proc -qmp unix:/tmp/disk-mon,server
> +
> +can be monitored over the UNIX socket path */tmp/disk-mon*.
> +
> +QEMU command line
> +~~~~~~~~~~~~~~~~~
> +
> +The QEMU command line options will need to be modified to indicate which
> +items are emulated by a separate program, and which remain emulated by
> +QEMU itself.
> +
> +identifying remote emulation processes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Remote emulation processes will be identified to QEMU using a *-remote*
> +command line option. This option can either specify a command that QEMU
> +will execute, or can specify a UNIX domain socket that QEMU can use to
> +connect to an existing process. Both forms require a "id" option that
> +identifies the process to later *-device* options. The process version
> +is:
> +
> +::
> +
> +    -remote id=disk-proc,command="disk-proc <backend list>"
> +
> +And the socket version is:
> +
> +::
> +
> +    -remote id=disk-proc,socket="/tmp/disk0-sock"
> +
> +In the latter case, the remote process must be given the same socket on
> +its command line when it is executed:
> +
> +::
> +
> +    disk-proc -socket /tmp/disk0-sock <backend list>
> +
> +identifying devices emulated remotely
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Devices that are to be emulated in a separate process will be identify

s/be//

> +the remote process with a "remote" option on their *-device* command
> +line specification. e.g., an LSI SCSI controller and disk can be
> +specified as:
> +
> +::
> +
> +    -device lsi53c895a,id=scsi0
> +    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0
> +
> +If these devices are emulated by remote process "disk-proc," as
> +described in the previous section, the QEMU command line would be:
> +
> +::
> +
> +    -device lsi53c895a,id=scsi0,remote=disk-proc
> +    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0,remote=disk-proc

The next patch documents rid=.  This seems to be the same as remote=?
Please use remote= everywhere.

> +
> +Some devices are implicitly created by the machine object. e.g., the q35
> +machine object will create its PCI bus, and attach an ich9-ahci IDE
> +controller to it. In this case, options will need to be added to the
> +*-machine* command line. e.g.,
> +
> +::
> +
> +    -machine pc-q35,ide-remote=disk-proc
> +
> +will use the remote process with an "id" of "disk-proc" to emulate the
> +IDE controller and its disks.

It might be possible to avoid introducing special-purpose *-remote=
parameters using the -set command-line option.  If you know the id of
the on-board device then you can set the remote= property on it:

  -set piix4-ide.ide0.remote=disk-proc

I haven't tried this but if it works then no code changes are required.

> +The disks themselves still need to be specified with *-remote* option,
> +as in the example above. e.g.,
> +
> +::
> +
> +    -device ide-hd,drive=drive0,bus=ide.0,unit=0,remote=disk-proc
> +
> +QEMU management of remote processes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Each *-remote* instance on the QEMU command line will create a remote
> +process proxy instance in QEMU. They will be held on a *QList* that can
> +be searched for by its "id" property. The remote process proxy will also
> +establish a communication channel between QEMU and the remote process.
> +This can be done in one of two methods: direction execution of the
> +process by QEMU with ``fork()`` and ``exec()`` system calls, or by
> +connecting to an existing process.
> +
> +direct execution
> +^^^^^^^^^^^^^^^^
> +
> +When the remote process is directly executed, the remote process proxy
> +will setup a communication channel between itself and the emulation
> +process. This channel will be created using ``socketpair()`` and the
> +remote process side of the pair will be given to the process as file
> +descriptor 0.
> +
> +connecting to an existing process
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Some environments wish to deny QEMU the ability to execute ``fork()``
> +and ``exec()`` In these case, emulation processes will be started before
> +QEMU, and a UNIX domain socket will be given to each emulation process
> +to communicate with QEMU over. After communication is established, the
> +socket will be unlinked from the file system space by the QEMU process.
> +
> +communication with emulation process
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +primary socket
> +''''''''''''''
> +
> +Whether the process was executed by QEMU or externally, there will be a
> +primary socket for communication between QEMU and the remote process.
> +This channel will handle configuration commands from QEMU to the
> +process, either from the QEMU command line, or from QMP commands that
> +affect the devices being emulated by the process. This channel will only
> +allow one message to be pending at a time; if additional messages
> +arrive, they must wait for previous ones to be acknowledged from the
> +remote side.
> +
> +secondary sockets
> +'''''''''''''''''
> +
> +The primary socket can pass the file descriptors of secondary sockets
> +for operations that occur in parallel with commands on the primary
> +channel. These include MMIO operations generated by the guest, interrupt
> +notifications generated by the devices being emulated, or *vmstate* for
> +live migration. These secondary sockets will be created at the behest of
> +the device proxies that require them. A disk device proxy wouldn't need
> +any secondary sockets, but a disk controller device proxy may need both
> +an MMIO socket and an interrupt socket.
> +
> +emulation process attached via QMP command
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +There will be a new "attach-process" QMP command to facilitate device

The QMP command name "remote-add" would be consistent with object-add.
(There is also netdev_add and device_add but their names use underscores
for legacy reasons.)

> +hot-plug. This command's arguments will be the same as the *-remote*
> +command line when it's used to attach to a remote process. i.e., it will
> +need an "id" argument so that hot-plugged devices can later find it, and
> +a "socket" argument to identify the UNIX domain socket that will be used
> +to communicate with QEMU.
> +
> +QEMU device proxy objects
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +QEMU has an object model based on sub-classes inherited from the
> +"object" super-class. The sub-classes that are of interest here are the
> +"device" and "bus" sub-classes whose child sub-classes make up the
> +device tree of a QEMU emulated system.
> +
> +The proxy object model will use device proxy objects to replace the
> +device emulation code within the QEMU process. These objects will live
> +in the same place in the object and bus hierarchies as the objects they
> +replace. i.e., the proxy object for an LSI SCSI controller will be a
> +sub-class of the "pci-device" class, and will have the same PCI bus
> +parent and the same SCSI bus child objects as the LSI controller object
> +it replaces.
> +
> +After the QEMU command line has been parsed, the remote devices will be
> +instantiated in the same manner as local devices are. (i.e.,
> +``qdev_device_add()``). In order to distinguish them from regular
> +*-device* device objects, their class name will be the name of the class
> +it replaces, with "-proxy" appended. e.g., the "lsi53c895a" proxy class
> +will be "lsi53c895a-proxy."

Did you consider defining just -device pci-device-proxy,remote=ID and
then transferring the device-specific details (e.g. PCI Configuration
Space, BARs, and interrupt configuration) over the socket during
initialization?

That way it's not necessary to write proxy devices.  There is just one
PCI proxy device that automatically reflects the information from the
device emulation process.

> +
> +device JSON description
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The remote process needs a JSON representation of the command line
> +options used to create the object. This JSON representation is used to
> +create the corresponding object in the emulation process. e.g., for an
> +LSI SCSI controller invoked as:
> +
> +::
> +
> +     -device lsi53c895a,id=scsi0,remote=lsi-scsi
> +
> +the proxy object would create a
> +
> +::
> +
> +    { "driver" : "lsi53c895a", "id" : "scsi0" }
> +
> +JSON description. The "driver" option is assigned to the device name
> +when the command line is parsed, so the "-proxy" appended by the command
> +line parsing code is removed. The "remote" option isn't needed in the
> +JSON description since it only applies to the proxy object in the QEMU
> +process.
> +
> +device object whitelist
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Some device objects may not need a proxy. These are devices with no
> +direct guest interfaces. (e.g., no MMIO, PIO, or interrupts). There will
> +be a whitelist of such devices, and any devices on this list will not be
> +instantiated in QEMU. Their JSON representation will still be sent to
> +the remote process, so the object can be created there.
> +
> +object initialization
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +QEMU object initialization occurs in two phases. The first
> +initialization happens once per object class. (i.e., there can be many
> +SCSI disks in an emulated system, but the "scsi-hd" class has its
> +``class_init()`` function called only once) The second phase happens
> +when each object's ``instance_init()`` function is called to initialize
> +each instance of the object.
> +
> +All device objects are sub-classes of the "device" class, so they also
> +have a ``realize()`` function that is called after ``instance_init()``
> +is called and after the object's static properties have been
> +initialized. Many device objects don't even provide an instance\_init()
> +function, and do all their per-instance work in ``realize()``.
> +
> +class\_init
> +'''''''''''
> +
> +The ``class_init()`` method of a proxy object will, in general behave
> +similarly to the object it replaces, including setting any static
> +properties and methods needed by the proxy.
> +
> +instance\_init / realize
> +''''''''''''''''''''''''
> +
> +The ``instance_init()`` and ``realize()`` functions would only need to
> +perform tasks related to being a proxy, such are registering its own
> +MMIO handlers, or creating a child bus that other proxy devices can be
> +attached to later.
> +
> +Other tasks will are device-specific. For example, PCI device objects
> +will initialize the PCI config space in order to make a valid PCI device
> +tree within the QEMU process.
> +
> +address space registration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Most devices are driven by guest device driver accesses to IO addresses
> +or ports. The QEMU device emulation code uses QEMU's memory region
> +function calls (such as ``memory_region_init_io()``) to add callback
> +functions that QEMU will invoke when the guest accesses the device's
> +areas of the IO address space. When a guest driver does access the
> +device, the VM will exit HW virtualization mode and return to QEMU,
> +which will then lookup and execute the corresponding callback function.
> +
> +A proxy object would need to mirror the memory region calls the actual
> +device emulator would perform in its initialization code, but with its
> +own callbacks. When invoked by QEMU as a result of a guest IO operation,
> +they will forward the operation to the device emulation process.
> +
> +PCI config space
> +^^^^^^^^^^^^^^^^
> +
> +PCI devices also have a configuration space that can be accessed by the
> +guest driver. Guest accesses to this space is not handled by the device
> +emulation object, but by its PCI parent object. Much of this space is
> +read-only, but certain registers (especially BAR and MSI-related ones)
> +need to be propagated to the emulation process.
> +
> +PCI parent proxy
> +''''''''''''''''
> +
> +One way to propagate guest PCI config accesses is to create a
> +"pci-device-proxy" class that can serve as the parent of a PCI device
> +proxy object. This class's parent would be "pci-device" and it would
> +override the PCI parent's ``config_read()`` and ``config_write()``
> +methods with ones that forward these operations to the emulation
> +program.
> +
> +interrupt receipt
> +^^^^^^^^^^^^^^^^^
> +
> +A proxy for a device that generates interrupts will need to create a
> +socket to receive interrupt indications from the emulation process. An
> +incoming interrupt indication would then be sent up to its bus parent to
> +be injected into the guest. For example, a PCI device object may use
> +``pci_set_irq()``.
> +
> +live migration
> +^^^^^^^^^^^^^^
> +
> +The proxy will register to save and restore any *vmstate* it needs over
> +a live migration event. The device proxy does not need to manage the
> +remote device's *vmstate*; that will be handled by the remote process
> +proxy (see below).
> +
> +QEMU remote device operation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Generic device operations, such as DMA, will be performs by the remote

s/performs/performed/

> +process proxy by sending messages to the remote process.
> +
> +DMA operations
> +^^^^^^^^^^^^^^
> +
> +DMA operations would be handled much like vhost applications do. One of
> +the initial messages sent to the emulation process is a guest memory
> +table. Each entry in this table consists of a file descriptor and size
> +that the emulation process can ``mmap()`` to directly access guest
> +memory, similar to ``vhost_user_set_mem_table()``. Note guest memory
> +must be backed by file descriptors, such as when QEMU is given the
> +*-mem-path* command line option.
> +
> +IOMMU operations
> +^^^^^^^^^^^^^^^^
> +
> +When the emulated system includes an IOMMU, the remote process proxy in
> +QEMU will need to create a socket for IOMMU requests from the emulation
> +process. It will handle those requests with an
> +``address_space_get_iotlb_entry()`` call. In order to handle IOMMU
> +unmaps, the remote process proxy will also register as a listener on the
> +device's DMA address space. When an IOMMU memory region is created
> +within the DMA address space, an IOMMU notifier for unmaps will be added
> +to the memory region that will forward unmaps to the emulation process
> +over the IOMMU socket.
> +
> +device hot-plug via QMP
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +An QMP "device\_add" command can add a device emulated by a remote
> +process. It needs to add a "remote" option to the command, just as the
> +*-device* command line option does. The remote process may either be one

device_add parameters are parsed by the same code as -device.  It
shouldn't be necessary to add a "remote" option to device_add.

> +started at QEMU startup, or be one added by the "add-process" QMP
> +command described above. In either case, the remote process proxy will
> +forward the new device's JSON description to the corresponding emulation
> +process.
> +
> +live migration
> +^^^^^^^^^^^^^^
> +
> +The remote process proxy will also register for live migration
> +notifications with ``vmstate_register()``. When called to save state,
> +the proxy will send the remote process a secondary socket file
> +descriptor to save the remote process's device *vmstate* over. The
> +incoming byte stream length and data will be saved as the proxy's
> +*vmstate*. When the proxy is resumed on its new host, this *vmstate*
> +will be extracted, and a secondary socket file descriptor will be sent
> +to the new remote process through which it receives the *vmstate* in
> +order to restore the devices there.
> +
> +device emulation in remote process
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The parts of QEMU that the emulation program will need include the
> +object model; the memory emulation objects; the device emulation objects
> +of the targeted device, and any dependent devices; and, the device's
> +backends. It will also need code to setup the machine environment,
> +handle requests from the QEMU process, and route machine-level requests
> +(such as interrupts or IOMMU mappings) back to the QEMU process.
> +
> +initialization
> +''''''''''''''
> +
> +The process initialization sequence will follow the same sequence
> +followed by QEMU. It will first initialize the backend objects, then
> +device emulation objects. The JSON descriptions sent by the QEMU process
> +will drive which objects need to be created.
> +
> +-  address spaces
> +
> +Before the device objects are created, the initial address spaces and
> +memory regions must be configured with ``memory_map_init()``. This
> +creates a RAM memory region object (*system\_memory*) and an IO memory
> +region object (*system\_io*).
> +
> +-  RAM
> +
> +RAM memory region creation will follow how ``pc_memory_init()`` creates
> +them, but must use ``memory_region_init_ram_from_fd()`` instead of
> +``memory_region_allocate_system_memory()``. The file descriptors needed
> +will be supplied by the guest memory table from above. Those RAM regions
> +would then be added to the *system\_memory* memory region with
> +``memory_region_add_subregion()``.
> +
> +-  PCI
> +
> +IO initialization will be driven by the JSON descriptions sent from the
> +QEMU process. For a PCI device, a PCI bus will need to be created with
> +``pci_root_bus_new()``, and a PCI memory region will need to be created
> +and added to the *system\_memory* memory region with
> +``memory_region_add_subregion_overlap()``. The overlap version is
> +required for architectures where PCI memory overlaps with RAM memory.
> +
> +MMIO handling
> +'''''''''''''
> +
> +The device emulation objects will use ``memory_region_init_io()`` to
> +install their MMIO handlers, and ``pci_register_bar()`` to associate
> +those handlers with a PCI BAR, as they do within QEMU currently.
> +
> +In order to use ``address_space_rw()`` in the emulation process to
> +handle MMIO requests from QEMU, the PCI physical addresses must be the
> +same in the QEMU process and the device emulation process. In order to
> +accomplish that, guest BAR programming must also be forwarded from QEMU
> +to the emulation process.
> +
> +interrupt injection
> +'''''''''''''''''''
> +
> +When device emulation wants to inject an interrupt into the VM, the
> +request climbs the device's bus object hierarchy until the point where a
> +bus object knows how to signal the interrupt to the guest. The details
> +depend on the type of interrupt being raised.
> +
> +-  PCI pin interrupts
> +
> +On x86 systems, there is an emulated IOAPIC object attached to the root
> +PCI bus object, and the root PCI object forwards interrupt requests to
> +it. The IOAPIC object, in turn, calls the KVM driver to inject the
> +corresponding interrupt into the VM. The simplest way to handle this in
> +an emulation process would be to setup the root PCI bus driver (via
> +``pci_bus_irqs()``) to send a interrupt request back to the QEMU
> +process, and have the device proxy object reflect it up the PCI tree
> +there.
> +
> +-  PCI MSI/X interrupts
> +
> +PCI MSI/X interrupts are implemented in HW as DMA writes to a
> +CPU-specific PCI address. In QEMU on x86, a KVM APIC object receives
> +these DMA writes, then calls into the KVM driver to inject the interrupt
> +into the VM. A simple emulation process implementation would be to send
> +the MSI DMA address from QEMU as a message at initialization, then
> +install an address space handler at that address which forwards the MSI
> +message back to QEMU.
> +
> +DMA operations
> +''''''''''''''
> +
> +When a emulation object wants to DMA into or out of guest memory, it
> +first must use dma\_memory\_map() to convert the DMA address to a local
> +virtual address. The emulation process memory region objects setup above
> +will be used to translate the DMA address to a local virtual address the
> +device emulation code can access.
> +
> +IOMMU
> +'''''
> +
> +When an IOMMU is in use in QEMU, DMA translation uses IOMMU memory
> +regions to translate the DMA address to a guest physical address before
> +that physical address can be translated to a local virtual address. The
> +emulation process will need similar functionality.
> +
> +-  IOTLB cache
> +
> +The emulation process will maintain a cache of recent IOMMU translations
> +(the IOTLB). When the translate() callback of an IOMMU memory region is
> +invoked, the IOTLB cache will be searched for an entry that will map the
> +DMA address to a guest PA. On a cache miss, a message will be sent back
> +to QEMU requesting the corresponding translation entry, which be both be
> +used to return a guest address and be added to the cache.
> +
> +-  IOTLB purge
> +
> +The IOMMU emulation will also need to act on unmap requests from QEMU.
> +These happen when the guest IOMMU driver purges an entry from the
> +guest's translation table.
> +
> +live migration
> +''''''''''''''
> +
> +When a remote process receives a live migration indication from QEMU, it
> +will set up a channel using the received file descriptor with
> +``qio_channel_socket_new_fd()``. This channel will be used to create a
> +*QEMUfile* that can be passed to ``qemu_save_device_state()`` to send
> +the process's device state back to QEMU. This method will be reversed on
> +restore - the channel will be passed to ``qemu_loadvm_state()`` to
> +restore the device state.
> +

I have reviewed up to here... :)

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3EPU4ACgkQnKSrs4Gr
c8j0lAf/Usv31dXtoxf2QbehjlMdf9oKbO2m5b0i0a+3muKK7gcWz6ZduBmTrIZk
c7mEteOgJ5VU1tWKorLL910UmNv/HH2Vh/ej5Vwetf2siSC7QRqWhj2RPx3d7cp+
QgGglm3Vk5NkN+xZSxCCPDpgbZOK3eHdhgJqKXPcAq064mSgMVUyFJJcqRuM+5uH
ZGXKeJhH7OsbHfNjXrYYtObWux4wmc1fu54E9i/iEbGB4AwQ6ByQBc8gPoluSCFP
nLxEKuSMPcbYRrZkVtgqVT6HvhycZxghtvaHF6UD0HEv2XwwipMVN/k9eW1u3+m+
xqhQhtJCVfNfBGxQN/p/vJ75twSTdg==
=kDVQ
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--

