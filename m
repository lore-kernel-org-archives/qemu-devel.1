Received: from eggs.gnu.org ([2001:4830:134:3::10]:51088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkPav-0006P5-7G
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkPau-0001r8-8n
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:56:53 -0400
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-7-pbonzini@redhat.com>
	<20170823041358.GA21343@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b26f12e-c453-1e46-5bc5-4446ac94ecca@redhat.com>
Date: Wed, 23 Aug 2017 08:56:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170823041358.GA21343@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/10] scsi,
 file-posix: add support for persistent reservation management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 23/08/2017 06:13, Fam Zheng wrote:
> On Tue, 08/22 15:18, Paolo Bonzini wrote:
>> diff --git a/docs/pr-manager.rst b/docs/pr-manager.rst
> 
> Is docs/interop/persistent-reservation-manager.rst better? (Move to interop/ and
> de-abbreviate) ...
> 
>> new file mode 100644
>> index 0000000000..b6089fb57c
>> --- /dev/null
>> +++ b/docs/pr-manager.rst
>> @@ -0,0 +1,51 @@
>> +======================================
>> +Persistent reservation managers
>> +======================================
>> +
>> +SCSI persistent Reservations allow restricting access to block devices
>> +to specific initiators in a shared storage setup.  When implementing
>> +clustering of virtual machines, it is a common requirement for virtual
>> +machines to send persistent reservation SCSI commands.  However,
>> +the operating system restricts sending these commands to unprivileged
>> +programs because incorrect usage can disrupt regular operation of the
>> +storage fabric.
>> +
>> +For this reason, QEMU's SCSI passthrough devices, ``scsi-block``
>> +and ``scsi-generic`` (both are only available on Linux) can delegate
>> +implementation of persistent reservations to a separate object,
>> +the "persistent reservation manager".  Only PERSISTENT RESERVE OUT and
>> +PERSISTENT RESERVE IN commands are passed to the persistent reservation
>> +manager object; other commands are processed by QEMU as usual.
>> +
>> +-----------------------------------------
>> +Defining a persistent reservation manager
>> +-----------------------------------------
>> +
>> +A persistent reservation manager is an instance of a subclass of the
>> +"pr-manager" QOM class.
> 
> Or is this abstraction class the reason it is not under interop? Why not just
> define the protocol?

It is not under interop because this is user documentation.  The
protocol documentation is under interop because the protocol is public,
and if someone else wants to talk to qemu-pr-helper they can.

(If the protocol was private, the protocol documentation would have been
under docs/devel).

Paolo

>> +
>> +Right now only one subclass is defined, ``pr-manager-helper``, which
>> +forwards the commands to an external privileged helper program
>> +over Unix sockets.  The helper program only allows sending persistent
>> +reservation commands to devices for which QEMU has a file descriptor,
>> +so that QEMU will not be able to effect persistent reservations
>> +unless it has access to both the socket and the device.
>> +
>> +``pr-manager-helper`` has a single string property, ``path``, which
>> +accepts the path to the helper program's Unix socket.  For example,
>> +the following command line defines a ``pr-manager-helper`` object and
>> +attaches it to a SCSI passthrough device::
>> +
>> +      $ qemu-system-x86_64
>> +          -device virtio-scsi \
>> +          -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
>> +          -drive if=none,id=hd,driver=raw,file.filename=/dev/sdb,file.pr-manager=helper0
>> +          -device scsi-block,drive=hd
>> +
>> +Alternatively, using ``-blockdev``::
>> +
>> +      $ qemu-system-x86_64
>> +          -device virtio-scsi \
>> +          -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
>> +          -blockdev node-name=hd,driver=raw,file.driver=host_device,file.filename=/dev/sdb,file.pr-manager=helper0
>> +          -device scsi-block,drive=hd
> 
> Fam
> 
