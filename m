Received: from eggs.gnu.org ([209.51.188.92]:42732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <john.g.johnson@oracle.com>) id 1h22Sm-00050d-Kg
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 18:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <john.g.johnson@oracle.com>) id 1h22Si-0001wr-P4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 18:30:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <john.g.johnson@oracle.com>)
	id 1h22Sg-0001mz-CD
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 18:30:04 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20190307192727.GG2915@stefanha-x1.localdomain>
Date: Thu, 7 Mar 2019 15:29:41 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, sstabellini@kernel.org, Jag Raman <jag.raman@oracle.com>, konrad.wilk@oracle.com, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com



> On Mar 7, 2019, at 11:27 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrang=C3=A9 =
wrote:
>> On Thu, Mar 07, 2019 at 02:26:09PM +0000, Stefan Hajnoczi wrote:
>>> On Wed, Mar 06, 2019 at 11:22:53PM -0800, elena.ufimtseva@oracle.com =
wrote:
>>>> diff --git a/docs/devel/qemu-multiprocess.txt =
b/docs/devel/qemu-multiprocess.txt
>>>> new file mode 100644
>>>> index 0000000..e29c6c8
>>>> --- /dev/null
>>>> +++ b/docs/devel/qemu-multiprocess.txt
>>>=20
>>> Thanks for this document and the interesting work that you are =
doing.
>>> I'd like to discuss the security advantages gained by disaggregating
>>> QEMU in more detail.
>>>=20
>>> The security model for VMs managed by libvirt (most production x86, =
ppc,
>>> s390 guests) is that the QEMU process is untrusted and only has =
access
>>> to resources belonging to the guest.  SELinux is used to restrict =
the
>>> process from accessing other files, processes, etc on the host.
>>=20
>> NB it doesn't have to be SELinux. Libvirt also supports AppArmor and
>> can even do isolation with traditional DAC by putting each QEMU under
>> a distinct UID/GID and having libvirtd set ownership on resources =
each
>> VM is permitted to use.
>>=20
>>> QEMU does not hold privileged resources that must be kept away from =
the
>>> guest.  An escaped guest can access its image file, tap file =
descriptor,
>>> etc but they are the same resources it could already access via =
device
>>> emulation.
>>>=20
>>> Can you give specific examples of how disaggregation improves =
security?
>=20
> Elena & collaborators: Dan has posted some ideas but please share =
yours
> so the security benefits of this patch series can be better =
understood.
>=20

	Dan covered the main point.  The security regime we use =
(selinux)
constrains the actions of processes on objects, so having multiple =
processes
allows us to apply more fine-grained policies.


>> I guess one obvious answer is that the existing security mechanisms =
like
>> SELinux/ApArmor/DAC can be made to work in a more fine grained manner =
if
>> there are distinct processes. This would allow for a more useful =
seccomp
>> filter to better protect against secondary kernel exploits should =
QEMU
>> itself be exploited, if we can protect individual components.
>=20
> Fine-grained sandboxing is possible in theory but tedious in practice.
> =46rom what I can tell this patch series doesn't implement any =
sandboxing
> for child processes.
>=20

	The policies aren=E2=80=99t in QEMU, but in the selinux config =
files.
They would say, for example, that when the QEMU process exec()s the
disk emulation process, the process security context type transitions
to a new type.  This type would have permission to access the VM image
objects, whereas the QEMU process type (and any other device emulation
process types) cannot access them.

	If you wanted to use DAC, you could do the something similar by
making the disk emulation executable setuid to a UID than can access
VM image files.

	In either case, the policies and permissions are set up before
libvirt even runs, so it doesn=E2=80=99t need to be aware of them.


> There must be a convenient way to get fine-grained sandboxing for
> disaggregated devices.  In other words, it shouldn't be left as an
> exercise to device process authors.
>=20

	We can add some MAC or DAC suggestions in the documentation.


> How to do this in practice must be clear from the beginning if
> fine-grained sandboxing is the main selling point.
>=20
> Some details to start the discussion:
>=20
> * How will fine-grained SELinux/AppArmor/DAC policies be configured =
for
>   each process?  I guess this requires root, so does libvirt need to
>   know about each process?
>=20

	The polices would apply to process security context types (or
UIDs in a DAC regime), so I would not expect libvirt to be aware of =
them.


> * We need to make sure that processes cannot send signals to each
>   other, ptrace, interfere in /proc/$PID, etc.  How will this be done?
>=20

	Any process type restrictions would be enforced by selinux.


> * Were you planning to use any other sandboxing mechanisms
>   (namespaces?)?  How will they be set up if the device processed is
>   forked/executed by an unprivileged QEMU?
>=20

	All of the QEMU-related process related to a single VM will run
in the same container, but the container is created, along with it =
selinux
policies, before libvirt is run.


>> Not everything is protected by MAC/DAC. For example network based =
disks
>> typically have a username + password for accessing the remote storage
>> server. Best practice would be a distinct username for every QEMU =
process
>> such that each can only access its own storage, but I don't know of =
any
>> app which does that. So ability to split off backends into separate
>> processes could limit exposure of information that is not otherwise
>> protected by current protection models.
>=20
> If the disaggregated disk process with a global username + password is
> compromised then all your disk images are compromised.  So you still
> need to follow the best practice of per-VM credentials even with
> disaggregation, and if you do then disaggregation doesn't add =
anything!
>=20

	You could put disk secrets in files that can only be read by the
disk emulation process type.  If you wanted even finer granularity, you
could use MCS to run each disk controller instance in a different =
security
context category, and make the secret files only readable by the =
corresponding
category.

	Another layer of security would be to have network security =
policies
that only allow the disk emulation processes to connect to the storage =
servers.

								JJ
