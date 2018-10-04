Received: from eggs.gnu.org ([2001:4830:134:3::10]:49285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g811l-0003ZL-RH
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g811h-00020H-VH
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:38:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33596
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1g811h-0001wh-JU
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:38:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w94AXq6U094124
	for <qemu-devel@nongnu.org>; Thu, 4 Oct 2018 06:38:33 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2mwgrahc57-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:38:33 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 4 Oct 2018 11:38:31 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180926225440.6204-7-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 4 Oct 2018 12:38:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180926225440.6204-7-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <19699347-b240-c24b-7470-ffb2dca9e943@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 6/6] s390: doc: detailed specifications
 for AP virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 27/09/2018 00:54, Tony Krowiak wrote:
> This patch provides documentation describing the AP architecture and
> design concepts behind the virtualization of AP devices. It also
> includes an example of how to configure AP devices for exclusive
> use of KVM guests.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   MAINTAINERS      |   1 +
>   docs/vfio-ap.txt | 787 ++++++++++++++++++++++++++++++++++++++++++++++=
+
>   2 files changed, 788 insertions(+)
>   create mode 100644 docs/vfio-ap.txt
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29041da69237..b64a12034c2c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1210,6 +1210,7 @@ F: hw/s390x/ap-bridge.c
>   F: include/hw/s390x/ap-device.h
>   F: include/hw/s390x/ap-bridge.h
>   F: hw/vfio/ap.c
> +F: docs/vfio-ap.txt
>   L: qemu-s390x@nongnu.org
>=20
>   vhost
> diff --git a/docs/vfio-ap.txt b/docs/vfio-ap.txt
> new file mode 100644
> index 000000000000..fd17ce48967b
> --- /dev/null
> +++ b/docs/vfio-ap.txt
> @@ -0,0 +1,787 @@
> +Adjunct Processor (AP) Device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Contents:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +* Introduction
> +* AP Architectural Overview
> +* Start Interpretive Execution (SIE) Instruction
> +* AP Matrix Configuration on Linux Host
> +* Starting a Linux Guest Configured with an AP Matrix
> +* Example: Configure AP Matrices for Three Linux Guests
> +
> +Introduction:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The IBM Adjunct Processor (AP) Cryptographic Facility is comprised
> +of three AP instructions and from 1 to 256 PCIe cryptographic adapter =
cards.
> +These AP devices provide cryptographic functions to all CPUs assigned =
to a
> +linux system running in an IBM Z system LPAR.
> +
> +On s390x, AP adapter cards are exposed via the AP bus. This document
> +describes how those cards may be made available to KVM guests using th=
e
> +VFIO mediated device framework.
> +
> +AP Architectural Overview:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +In order understand the terminology used in the rest of this document,=
 let's
> +start with some definitions:
> +
> +* AP adapter
> +
> +  An AP adapter is an IBM Z adapter card that can perform cryptographi=
c
> +  functions. There can be from 0 to 256 adapters assigned to an LPAR; =
however,
> +  the maximum adapter number allowed is determined by machine model. A=
dapters
> +  assigned to the LPAR in which a linux host is running will be availa=
ble to the
> +  linux host. Each adapter is identified by a number from 0 to 255. Wh=
en
> +  installed, an AP adapter is accessed by AP instructions executed by =
any CPU.
> +
> +* AP domain
> +
> +  An adapter is partitioned into domains. Each domain can be thought o=
f as
> +  a set of hardware registers for processing AP instructions. An adapt=
er can
> +  hold up to 256 domains; however, the maximum domain number allowed i=
s
> +  determined by machine model. Each domain is identified by a number f=
rom 0 to
> +  255. Domains can be further classified into two types:
> +
> +    * Usage domains are domains that can be accessed directly to proce=
ss AP
> +      commands
> +
> +    * Control domains are domains that are accessed indirectly by AP
> +      commands sent to a usage domain to control or change the domain;=
 for
> +      example, to set a secure private key for the domain.
> +
> +* AP Queue
> +
> +  An AP queue is the means by which an AP command-request message is s=
ent to an
> +  AP usage domain inside a specific AP. An AP queue is identified by a=
 tuple
> +  comprised of an AP adapter ID (APID) and an AP queue index (APQI). T=
he
> +  APQI corresponds to a given usage domain number within the adapter. =
This tuple
> +  forms an AP Queue Number (APQN) uniquely identifying an AP queue. AP
> +  instructions include a field containing the APQN to identify the AP =
queue to
> +  which the AP command-request message is to be sent for processing.
> +
> +* AP Instructions:
> +
> +  There are three AP instructions:
> +
> +  * NQAP: to enqueue an AP command-request message to a queue
> +  * DQAP: to dequeue an AP command-reply message from a queue
> +  * PQAP: to administer the queues
> +
> +  AP instructions identify the domain that is targeted to process the =
AP
> +  command; this must be one of the usage domains. An AP command may mo=
dify a
> +  domain that is not one of the usage domains, but the modified domain
> +  must be one of the control domains.
> +
> +Start Interpretive Execution (SIE) Instruction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +A KVM guest is started by executing the Start Interpretive Execution (=
SIE)
> +instruction. The SIE state description is a control block that contain=
s the
> +state information for a KVM guest and is supplied as input to the SIE
> +instruction. The SIE state description contains a satellite control bl=
ock called
> +the Crypto Control Block (CRYCB). The CRYCB contains three fields to i=
dentify
> +the adapters, usage domains and control domains assigned to the KVM gu=
est:
> +
> +* The AP Mask (APM) field is a bit mask that identifies the AP adapter=
s assigned
> +  to the KVM guest. Each bit in the mask, from most significant to lea=
st
> +  significant bit, corresponds to an APID from 0-255. If a bit is set,=
 the
> +  corresponding adapter is valid for use by the KVM guest.
> +
> +* The AP Queue Mask (AQM) field is a bit mask identifying the AP usage=
 domains
> +  assigned to the KVM guest. Each bit in the mask, from most significa=
nt to
> +  least significant bit, corresponds to an AP queue index (APQI) from =
0-255. If
> +  a bit is set, the corresponding queue is valid for use by the KVM gu=
est.
> +
> +* The AP Domain Mask field is a bit mask that identifies the AP contro=
l domains
> +  assigned to the KVM guest. The ADM bit mask controls which domains c=
an be
> +  changed by an AP command-request message sent to a usage domain from=
 the
> +  guest. Each bit in the mask, from least significant to most signific=
ant bit,
> +  corresponds to a domain from 0-255. If a bit is set, the correspondi=
ng domain
> +  can be modified by an AP command-request message sent to a usage dom=
ain
> +  configured for the KVM guest.
> +
> +If you recall from the description of an AP Queue, AP instructions inc=
lude
> +an APQN to identify the AP adapter and AP queue to which an AP command=
-request
> +message is to be sent (NQAP and PQAP instructions), or from which a
> +command-reply message is to be received (DQAP instruction). The validi=
ty of an
> +APQN is defined by the matrix calculated from the APM and AQM; it is t=
he
> +cross product of all assigned adapter numbers (APM) with all assigned =
queue
> +indexes (AQM). For example, if adapters 1 and 2 and usage domains 5 an=
d 6 are
> +assigned to a guest, the APQNs (1,5), (1,6), (2,5) and (2,6) will be v=
alid for
> +the guest.
> +
> +The APQNs can provide secure key functionality - i.e., a private key i=
s stored
> +on the adapter card for each of its domains - so each APQN must be ass=
igned to
> +at most one guest or the linux host.
> +
> +   Example 1: Valid configuration:
> +   ------------------------------
> +   Guest1: adapters 1,2  domains 5,6
> +   Guest2: adapter  1,2  domain 7
> +
> +   This is valid because both guests have a unique set of APQNs: Guest=
1 has
> +   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,=
7).
> +
> +   Example 2: Valid configuration:
> +   ------------------------------
> +   Guest1: adapters 1,2 domains 5,6
> +   Guest2: adapters 3,4 domains 5,6
> +
> +   This is also valid because both guests have a unique set of APQNs:
> +      Guest1 has APQNs (1,5), (1,6), (2,5), (2,6);
> +      Guest2 has APQNs (3,5), (3,6), (4,5), (4,6)
> +
> +   Example 3: Invalid configuration:
> +   --------------------------------
> +   Guest1: adapters 1,2  domains 5,6
> +   Guest2: adapter  1    domains 6,7
> +
> +   This is an invalid configuration because both guests have access to
> +   APQN (1,6).
> +
> +AP Matrix Configuration on Linux Host:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +A linux system is a guest of the LPAR in which it is running and has a=
ccess to
> +the AP resources configured for the LPAR. The LPAR's AP matrix is
> +configured via its Activation Profile which can be edited on the HMC. =
When the
> +linux system is started, the AP bus will detect the AP devices assigne=
d to the
> +LPAR and create the following in sysfs:
> +
> +/sys/bus/ap
> +... [devices]
> +...... xx.yyyy
> +...... ...
> +...... cardxx
> +...... ...
> +
> +Where:
> +    cardxx     is AP adapter number xx (in hex)
> +....xx.yyyy    is an APQN with xx specifying the APID and yyyy specify=
ing the
> +               APQI
> +
> +For example, if AP adapters 5 and 6 and domains 4, 71 (0x47), 171 (0xa=
b) and
> +255 (0xff) are configured for the LPAR, the sysfs representation on th=
e linux
> +host system would look like this:
> +
> +/sys/bus/ap
> +... [devices]
> +...... 05.0004
> +...... 05.0047
> +...... 05.00ab
> +...... 05.00ff
> +...... 06.0004
> +...... 06.0047
> +...... 06.00ab
> +...... 06.00ff
> +...... card05
> +...... card06
> +
> +A set of default device drivers are also created to control each type =
of AP
> +device that can be assigned to the LPAR on which a linux host is runni=
ng:
> +
> +/sys/bus/ap
> +... [drivers]
> +...... [cex2acard]        for Crypto Express 2/3 accelerator cards
> +...... [cex2aqueue]       for AP queues served by Crypto Express 2/3
> +                          accelerator cards
> +...... [cex4card]         for Crypto Express 4/5/6 accelerator and cop=
rocessor
> +                          cards
> +...... [cex4queue]        for AP queues served by Crypto Express 4/5/6
> +                          accelerator and coprocessor cards
> +...... [pcixcccard]       for Crypto Express 2/3 coprocessor cards
> +...... [pcixccqueue]      for AP queues served by Crypto Express 2/3
> +                          coprocessor cards
> +
> +Binding AP devices to device drivers
> +------------------------------------
> +There are two sysfs files that specify bitmasks marking a subset of th=
e APQN
> +range as 'usable by the default AP queue device drivers' or 'not usabl=
e by the
> +default device drivers' and thus available for use by the alternate de=
vice
> +driver(s). The sysfs locations of the masks are:
> +
> +   /sys/bus/ap/apmask
> +   /sys/bus/ap/aqmask
> +
> +The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
> +(APID). Each bit in the mask, from most significant to least significa=
nt bit,
> +corresponds to an APID from 0-255. If a bit is set, the APID is marked=
 as
> +usable only by the default AP queue device drivers; otherwise, the API=
D is
> +usable by the vfio_ap device driver.
> +
> +The 'aqmask' is a 256-bit mask that identifies a set of AP queue index=
es
> +(APQI). Each bit in the mask, from most significant to least significa=
nt bit,
> +corresponds to an APQI from 0-255. If a bit is set, the APQI is marked=
 as
> +usable only by the default AP queue device drivers; otherwise, the APQ=
I is
> +usable by the vfio_ap device driver.
> +
> +The APQN of each AP queue device assigned to the linux host is checked=
 by the
> +AP bus against the set of APQNs derived from the cross product of the =
APIDs
> +and APQIs marked as usable only by the default AP queue device drivers=
. If a
> +match is detected, only the default AP queue device drivers will be pr=
obed;
> +otherwise, the alternate device driver(s) will be probed.
> +
> +By default, the two masks are set to mark all APQNs for use by the def=
ault
> +AP queue device drivers. There are two ways the default masks can be c=
hanged:
> +
> +   1. The masks can be changed at boot time with the kernel command li=
ne
> +      like this:
> +
> +      ap.apmask=3D0xffff ap.aqmask=3D0x40
> +
> +      This would give these two pools:
> +
> +         default drivers pool:    adapter 0-15, domain 1
> +         alternate drivers pool:  adapter 16-255, domains 2-255
> +
> +   2. The sysfs mask files can also be edited by echoing a string into=
 the
> +      respective file in one of two formats:
> +
> +      * An absolute hex string starting with 0x - like "0x12345678" - =
sets
> +        the mask. If the given string is shorter than the mask, it is =
padded
> +        with 0s on the right. If the string is longer than the mask, t=
he
> +        operation is terminated with an error (EINVAL).
> +
> +      * A plus ('+') or minus ('-') followed by a numerical value. Val=
id
> +        examples are "+1", "-13", "+0x41", "-0xff" and even "+0" and "=
-0". Only
> +        the corresponding bit in the mask is switched on ('+') or off =
('-'). The
> +        values may also be specified in a comma-separated list to swit=
ch more
> +        than one bit on or off.
> +
> +Configuring an AP matrix for a linux guest.
> +------------------------------------------
> +The sysfs interfaces for configuring an AP matrix for a guest are buil=
t on the
> +VFIO mediated device framework. To configure an AP matrix for a guest,=
 a
> +mediated matrix device must first be created for the /sys/devices/vfio=
_ap/matrix
> +device. When the vfio_ap device driver is loaded, it registers with th=
e VFIO
> +mediated device framework. When the driver registers, the sysfs interf=
aces for
> +creating mediated matrix devices is created:
> +
> +/sys/devices
> +... [vfio_ap]
> +......[matrix]
> +......... [mdev_supported_types]
> +............ [vfio_ap-passthrough]
> +............... create
> +............... [devices]
> +
> +A mediated AP matrix device is created by writing a UUID to the attrib=
ute file
> +named 'create', for example:
> +
> +   uuidgen > create
> +
> +   or
> +
> +   echo $uuid > create
> +
> +When a mediated AP matrix device is created, a sysfs directory named a=
fter
> +the UUID is created in the 'devices' subdirectory:
> +
> +/sys/devices
> +... [vfio_ap]
> +......[matrix]
> +......... [mdev_supported_types]
> +............ [vfio_ap-passthrough]
> +............... create
> +............... [devices]
> +.................. [$uuid]
> +
> +There will also be three sets of attribute files created in the mediat=
ed
> +matrix device's sysfs directory to configure an AP matrix for the
> +KVM guest:
> +
> +/sys/devices
> +... [vfio_ap]
> +......[matrix]
> +......... [mdev_supported_types]
> +............ [vfio_ap-passthrough]
> +............... create
> +............... [devices]
> +.................. [$uuid]
> +..................... assign_adapter
> +..................... assign_control_domain
> +..................... assign_domain
> +..................... matrix
> +..................... unassign_adapter
> +..................... unassign_control_domain
> +..................... unassign_domain
> +
> +assign_adapter
> +   To assign an AP adapter to the mediated matrix device, its APID is =
written
> +   to the 'assign_adapter' file. This may be done multiple times to as=
sign more
> +   than one adapter. The APID may be specified using conventional sema=
ntics
> +   as a decimal, hexidecimal, or octal number. For example, to assign =
adapters
> +   4, 5 and 16 to a mediated matrix device in decimal, hexidecimal and=
 octal
> +   respectively:
> +
> +       echo 4 > assign_adapter
> +       echo 0x5 > assign_adapter
> +       echo 020 > assign_adapter
> +
> +   In order to successfully assign an adapter:
> +
> +   * The adapter number specified must represent a value from 0 up to =
the
> +     maximum adapter number configured for the system. If an adapter n=
umber
> +     higher than the maximum is specified, the operation will terminat=
e with
> +     an error (ENODEV).
> +
> +   * All APQNs that can be derived from the adapter ID being assigned =
and the
> +     IDs of the previously assigned domains must be bound to the vfio_=
ap device
> +     driver. If no domains have yet been assigned, then there must be =
at least
> +     one APQN with the specified APID bound to the vfio_ap driver. If =
no such
> +     APQNs are bound to the driver, the operation will terminate with =
an
> +     error (EADDRNOTAVAIL).
> +
> +     No APQN that can be derived from the adapter ID and the IDs of th=
e
> +     previously assigned domains can be assigned to another mediated m=
atrix
> +     device. If an APQN is assigned to another mediated matrix device,=
 the
> +     operation will terminate with an error (EADDRINUSE).
> +
> +unassign_adapter
> +   To unassign an AP adapter, its APID is written to the 'unassign_ada=
pter'
> +   file. This may also be done multiple times to unassign more than on=
e adapter.
> +
> +assign_domain
> +   To assign a usage domain, the domain number is written into the
> +   'assign_domain' file. This may be done multiple times to assign mor=
e than one
> +   usage domain. The domain number is specified using conventional sem=
antics as
> +   a decimal, hexidecimal, or octal number. For example, to assign usa=
ge domains
> +   4, 8, and 71 to a mediated matrix device in decimal, hexidecimal an=
d octal
> +   respectively:
> +
> +      echo 4 > assign_domain
> +      echo 0x8 > assign_domain
> +      echo 0107 > assign_domain
> +
> +   In order to successfully assign a domain:
> +
> +   * The domain number specified must represent a value from 0 up to t=
he
> +     maximum domain number configured for the system. If a domain numb=
er
> +     higher than the maximum is specified, the operation will terminat=
e with
> +     an error (ENODEV).
> +
> +   * All APQNs that can be derived from the domain ID being assigned a=
nd the IDs
> +     of the previously assigned adapters must be bound to the vfio_ap =
device
> +     driver. If no domains have yet been assigned, then there must be =
at least
> +     one APQN with the specified APQI bound to the vfio_ap driver. If =
no such
> +     APQNs are bound to the driver, the operation will terminate with =
an
> +     error (EADDRNOTAVAIL).
> +
> +     No APQN that can be derived from the domain ID being assigned and=
 the IDs
> +     of the previously assigned adapters can be assigned to another me=
diated
> +     matrix device. If an APQN is assigned to another mediated matrix =
device,
> +     the operation will terminate with an error (EADDRINUSE).
> +
> +unassign_domain
> +   To unassign a usage domain, the domain number is written into the
> +   'unassign_domain' file. This may be done multiple times to unassign=
 more than
> +   one usage domain.
> +
> +assign_control_domain
> +   To assign a control domain, the domain number is written into the
> +   'assign_control_domain' file. This may be done multiple times to
> +   assign more than one control domain. The domain number may be speci=
fied using
> +   conventional semantics as a decimal, hexidecimal, or octal number. =
For
> +   example, to assign  control domains 4, 8, and 71 to  a mediated mat=
rix device
> +   in decimal, hexidecimal and octal respectively:
> +
> +      echo 4 > assign_domain
> +      echo 0x8 > assign_domain
> +      echo 0107 > assign_domain
> +
> +   In order to successfully assign a control domain, the domain number
> +   specified must represent a value from 0 up to the maximum domain nu=
mber
> +   configured for the system. If a control domain number higher than t=
he maximum
> +   is specified, the operation will terminate with an error (ENODEV).
> +
> +unassign_control_domain
> +   To unassign a control domain, the domain number is written into the
> +   'unassign_domain' file. This may be done multiple times to unassign=
 more than
> +   one control domain.
> +
> +Notes: Hot plug/unplug is not currently supported for mediated AP matr=
ix
> +devices, so no changes to the AP matrix will be allowed while a guest =
using
> +the mediated matrix device is running. Attempts to assign an adapter,
> +domain or control domain will be rejected and an error (EBUSY) returne=
d.
> +
> +Starting a Linux Guest Configured with an AP Matrix:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +To provide a mediated matrix device for use by a guest, the following =
option
> +must be specified on the QEMU command line:
> +
> +   -device vfio_ap,sysfsdev=3D$path-to-mdev
> +
> +The sysfsdev parameter specifies the path to the mediated matrix devic=
e.
> +There are a number of ways to specify this path:
> +
> +/sys/devices/vfio_ap/matrix/$uuid
> +/sys/bus/mdev/devices/$uuid
> +/sys/bus/mdev/drivers/vfio_mdev/$uuid
> +/sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/d=
evices/$uuid
> +
> +When the linux guest is started, the guest will open the mediated
> +matrix device's file descriptor to get information about the mediated =
matrix
> +device. The vfio_ap device driver will update the APM, AQM, and ADM fi=
elds in
> +the guest's CRYCB with the adapter, usage domain and control domains a=
ssigned
> +via the mediated matrix device's sysfs attribute files. Programs runni=
ng on the
> +linux guest will then:
> +
> +1. Have direct access to the APQNs derived from the cross product of t=
he AP
> +   adapter numbers (APID) and queue indexes (APQI) specified in the AP=
M and AQM
> +   fields of the guests's CRYCB respectively. These APQNs identify the=
 AP queues
> +   that are valid for use by the guest; meaning, AP commands can be se=
nt by the
> +   guest to any of these queues for processing.
> +
> +2. Have authorization to process AP commands to change a control domai=
n
> +   identified in the ADM field of the guest's CRYCB. The AP command mu=
st be sent
> +   to a valid APQN (see 1 above).
> +
> +CPU model features:
> +
> +Three CPU model features are available for controlling guest access to=
 AP
> +facilities:
> +
> +1. AP facilities feature
> +
> +   The AP facilities feature indicates that AP facilities are installe=
d on the
> +   guest. This feature will be enabled by the kernel only if the AP fa=
cilities
> +   are installed on the host system. It will be turned on automaticall=
y for
> +   guests started with CPU model zEC12 or newer. The feature is s390-s=
pecific
> +   and is represented as a parameter of the -cpu option on the QEMU co=
mmand
> +   line:
> +
> +      qemu-system-s390x -cpu $model,ap=3Don|off
> +
> +      Where:
> +
> +         $model is the CPU model defined for the guest (defaults to th=
e model of
> +                the host system if not specified).
> +
> +         ap=3Don|off indicates whether AP facilities are installed (on=
) or not
> +                   (off). The default for CPU models zEC12 or newer
> +                   is ap=3Don. AP facilities must be installed on the =
guest if a
> +                   vfio-ap device (-device vfio-ap,sysfsdev=3D$path) i=
s configured
> +                   for the guest or the guest will fail to start.
> +
> +2. Query Configuration Information (QCI) facility
> +
> +   The QCI facility is used by the AP bus running on the guest to quer=
y the
> +   configuration of the AP facilities. This facility will be enabled b=
y
> +   the kernel only if the QCI facility is installed on the host system=
. It will
> +   be turned on automatically for guests started with CPU model zEC12 =
or newer.
> +   The feature is s390-specific and is represented as a parameter of t=
he -cpu
> +   option on the QEMU command line:
> +
> +      qemu-system-s390x -cpu $model,apqci=3Don|off
> +
> +      Where:
> +
> +         $model is the CPU model defined for the guest
> +
> +         apqci=3Don|off indicates whether the QCI facility is installe=
d (on) or
> +                      not (off). The default for CPU models zEC12 or n=
ewer
> +                      is apqci=3Don; for older models, QCI will not be=
 installed.
> +
> +                      If QCI is installed (apqci=3Don) but AP faciliti=
es are not
> +                      (ap=3Doff), an error message will be logged, but=
 the guest
> +                      will be allowed to start. It makes no sense to h=
ave QCI
> +                      installed if the AP facilities are not; this is =
considered
> +                      an invalid configuration.
> +
> +                      If the QCI facility is not installed, APQNs with=
 an APQI
> +                      greater than 15 will not be detected by the AP b=
us
> +                      running on the guest.
> +
> +3. Adjunct Process Facility Test (APFT) facility
> +
> +   The APFT facility is used by the AP bus running on the guest to tes=
t the
> +   AP facilities available for a given AP queue. This facility will be=
 enabled
> +   by the kernel only if the APFT facility is installed on the host sy=
stem. It
> +   will be turned on automatically for guests started with CPU model z=
EC12 or
> +   newer. The feature is s390-specific and is represented as a paramet=
er of the
> +   -cpu option on the QEMU command line:
> +
> +      qemu-system-s390x -cpu $model,apft=3Don|off
> +
> +      Where:
> +
> +         $model is the CPU model defined for the guest (defaults to th=
e model of
> +                the host system if not specified).
> +
> +         apft=3Don|off indicates whether the APFT facility is installe=
d (on) or
> +                     not (off). The default for CPU models zEC12 and
> +                     newer is apft=3Don for older models, APFT will no=
t be
> +                     installed.
> +
> +                     If APFT is installed (apft=3Don) but AP facilitie=
s are not
> +                     (ap=3Doff), an error message will be logged, but =
the guest
> +                     will be allowed to start. It makes no sense to ha=
ve APFT
> +                     installed if the AP facilities are not; this is c=
onsidered
> +                     an invalid configuration.
> +
> +                     It also makes no sense to turn APFT off because t=
he AP bus
> +                     running on the guest will not detect CEX4 and new=
er devices
> +                     without it. Since only CEX4 and newer devices are=
 supported
> +                     for guest usage, no AP devices can be made access=
ible to a
> +                     guest started without APFT installed.
> +
> +Example: Configure AP Matrixes for Three Linux Guests:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Let's now provide an example to illustrate how KVM guests may be given
> +access to AP facilities. For this example, we will show how to configu=
re
> +three guests such that executing the lszcrypt command on the guests wo=
uld
> +look like this:
> +
> +Guest1
> +------
> +CARD.DOMAIN TYPE  MODE
> +------------------------------
> +05          CEX5C CCA-Coproc
> +05.0004     CEX5C CCA-Coproc
> +05.00ab     CEX5C CCA-Coproc
> +06          CEX5A Accelerator
> +06.0004     CEX5A Accelerator
> +06.00ab     CEX5C CCA-Coproc
> +
> +Guest2
> +------
> +CARD.DOMAIN TYPE  MODE
> +------------------------------
> +05          CEX5A Accelerator
> +05.0047     CEX5A Accelerator
> +05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
> +
> +Guest3
> +------
> +CARD.DOMAIN TYPE  MODE
> +------------------------------
> +06          CEX5A Accelerator
> +06.0047     CEX5A Accelerator
> +06.00ff     CEX5A Accelerator
> +
> +These are the steps:
> +
> +1. Install the vfio_ap module on the linux host. The dependency chain =
for the
> +   vfio_ap module is:
> +   * iommu
> +   * s390
> +   * zcrypt
> +   * vfio
> +   * vfio_mdev
> +   * vfio_mdev_device
> +   * KVM
> +
> +   To build the vfio_ap module, the kernel build must be configured wi=
th the
> +   following Kconfig elements selected:
> +   * IOMMU_SUPPORT
> +   * S390
> +   * ZCRYPT
> +   * S390_AP_IOMMU
> +   * VFIO
> +   * VFIO_MDEV
> +   * VFIO_MDEV_DEVICE
> +   * KVM
> +
> +   If using make menuconfig select the following to build the vfio_ap =
module:
> +   -> Device Drivers
> +      -> IOMMU Hardware Support
> +         select S390 AP IOMMU Support
> +      -> VFIO Non-Privileged userspace driver framework
> +         -> Mediated device driver frramework
> +            -> VFIO driver for Mediated devices
> +   -> I/O subsystem
> +      -> VFIO support for AP devices
> +
> +2. Secure the AP queues to be used by the three guests so that the hos=
t can not
> +   access them. To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.=
00ff,
> +   06.0004, 06.0047, 06.00ab, and 06.00ff for use by the vfio_ap devic=
e driver,
> +   the corresponding APQNs must be removed from the default queue driv=
ers pool
> +   as follows:
> +
> +      echo -5,-6 > /sys/bus/ap/apmask
> +
> +      echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask
> +
> +   This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 0=
6.0004,
> +   06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device d=
river. The
> +   sysfs directory for the vfio_ap device driver will now contain symb=
olic links
> +   to the AP queue devices bound to it:
> +
> +   /sys/bus/ap
> +   ... [drivers]
> +   ...... [vfio_ap]
> +   ......... [05.0004]
> +   ......... [05.0047]
> +   ......... [05.00ab]
> +   ......... [05.00ff]
> +   ......... [06.0004]
> +   ......... [06.0047]
> +   ......... [06.00ab]
> +   ......... [06.00ff]
> +
> +   Keep in mind that only type 10 and newer adapters (i.e., CEX4 and l=
ater)
> +   can be bound to the vfio_ap device driver. The reason for this is t=
o
> +   simplify the implementation by not needlessly complicating the desi=
gn by
> +   supporting older devices that will go out of service in the relativ=
ely near
> +   future, and for which there are few older systems on which to test.
> +
> +   The administrator, therefore, must take care to secure only AP queu=
es that
> +   can be bound to the vfio_ap device driver. The device type for a gi=
ven AP
> +   queue device can be read from the parent card's sysfs directory. Fo=
r example,
> +   to see the hardware type of the queue 05.0004:
> +
> +   cat /sys/bus/ap/devices/card05/hwtype
> +
> +   The hwtype must be 10 or higher (CEX4 or newer) in order to be boun=
d to the
> +   vfio_ap device driver.
> +
> +3. Create the mediated devices needed to configure the AP matrixes for=
 the
> +   three guests and to provide an interface to the vfio_ap driver for
> +   use by the guests:
> +
> +   /sys/devices/vfio_ap/matrix/
> +   --- [mdev_supported_types]
> +   ------ [vfio_ap-passthrough] (passthrough mediated matrix device ty=
pe)
> +   --------- create
> +   --------- [devices]
> +
> +   To create the mediated devices for the three guests:
> +
> +       uuidgen > create
> +       uuidgen > create
> +       uuidgen > create
> +
> +        or
> +
> +        echo $uuid1 > create
> +        echo $uuid2 > create
> +        echo $uuid3 > create
> +
> +   This will create three mediated devices in the [devices] subdirecto=
ry named
> +   after the UUID used to create the mediated device. We'll call them =
$uuid1,
> +   $uuid2 and $uuid3 and this is the sysfs directory structure after c=
reation:
> +
> +   /sys/devices/vfio_ap/matrix/
> +   --- [mdev_supported_types]
> +   ------ [vfio_ap-passthrough]
> +   --------- [devices]
> +   ------------ [$uuid1]
> +   --------------- assign_adapter
> +   --------------- assign_control_domain
> +   --------------- assign_domain
> +   --------------- matrix
> +   --------------- unassign_adapter
> +   --------------- unassign_control_domain
> +   --------------- unassign_domain
> +
> +   ------------ [$uuid2]
> +   --------------- assign_adapter
> +   --------------- assign_control_domain
> +   --------------- assign_domain
> +   --------------- matrix
> +   --------------- unassign_adapter
> +   ----------------unassign_control_domain
> +   ----------------unassign_domain
> +
> +   ------------ [$uuid3]
> +   --------------- assign_adapter
> +   --------------- assign_control_domain
> +   --------------- assign_domain
> +   --------------- matrix
> +   --------------- unassign_adapter
> +   ----------------unassign_control_domain
> +   ----------------unassign_domain
> +
> +4. The administrator now needs to configure the matrixes for the media=
ted
> +   devices $uuid1 (for Guest1), $uuid2 (for Guest2) and $uuid3 (for Gu=
est3).
> +
> +   This is how the matrix is configured for Guest1:
> +
> +      echo 5 > assign_adapter
> +      echo 6 > assign_adapter
> +      echo 4 > assign_domain
> +      echo 0xab > assign_domain
> +
> +      Control domains can similarly be assigned using the assign_contr=
ol_domain
> +      sysfs file.
> +
> +      If a mistake is made configuring an adapter, domain or control d=
omain,
> +      you can use the unassign_xxx interfaces to unassign the adapter,=
 domain or
> +      control domain.
> +
> +      To display the matrix configuration for Guest1:
> +
> +         cat matrix
> +
> +         The output will display the APQNs in the format xx.yyyy, wher=
e xx is
> +         the adapter number and yyyy is the domain number. The output =
for Guest1
> +         will look like this:
> +
> +         05.0004
> +         05.00ab
> +         06.0004
> +         06.00ab
> +
> +   This is how the matrix is configured for Guest2:
> +
> +      echo 5 > assign_adapter
> +      echo 0x47 > assign_domain
> +      echo 0xff > assign_domain
> +
> +   This is how the matrix is configured for Guest3:
> +
> +      echo 6 > assign_adapter
> +      echo 0x47 > assign_domain
> +      echo 0xff > assign_domain
> +
> +5. Start Guest1:
> +
> +   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3D=
on \
> +      -device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid1 ...
> +
> +7. Start Guest2:
> +
> +   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3D=
on \
> +      -device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid2 ...
> +
> +7. Start Guest3:
> +
> +   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3D=
on \
> +      -device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid3 ...
> +
> +When the guest is shut down, the mediated matrix devices may be remove=
d.
> +
> +Using our example again, to remove the mediated matrix device $uuid1:
> +
> +   /sys/devices/vfio_ap/matrix/
> +      --- [mdev_supported_types]
> +      ------ [vfio_ap-passthrough]
> +      --------- [devices]
> +      ------------ [$uuid1]
> +      --------------- remove
> +
> +
> +   echo 1 > remove
> +
> +   This will remove all of the mdev matrix device's sysfs structures i=
ncluding
> +   the mdev device itself. To recreate and reconfigure the mdev matrix=
 device,
> +   all of the steps starting with step 3 will have to be performed aga=
in. Note
> +   that the remove will fail if a guest using the mdev is still runnin=
g.
> +
> +   It is not necessary to remove an mdev matrix device, but one may wa=
nt to
> +   remove it if no guest will use it during the remaining lifetime of =
the linux
> +   host. If the mdev matrix device is removed, one may want to also re=
configure
> +   the pool of adapters and queues reserved for use by the default dri=
vers.
> +
> +Limitations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +* The KVM/kernel interfaces do not provide a way to prevent restoring =
an APQN
> +  to the default drivers pool of a queue that is still assigned to a m=
ediated
> +  device in use by a guest. It is incumbent upon the administrator to
> +  ensure there is no mediated device in use by a guest to which the AP=
QN is
> +  assigned lest the host be given access to the private data of the AP=
 queue
> +  device, such as a private key configured specifically for the guest.
> +
> +* Dynamically modifying the AP matrix for a running guest (which would=
 amount to
> +  hot(un)plug of AP devices for the guest) is currently not supported
> +
> +* Live guest migration is not supported for guests using AP devices.
>=20


obviously all remarks from Linux documentation for VFIO_AP are
here to be handled too.
With this:

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>

It also can be used as is to configure Linux/Qemu and make the guest=20
working as expected:

Tested-by: Pierre Morel<pmorel@linux.ibm.com>


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
