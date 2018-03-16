Received: from eggs.gnu.org ([2001:4830:134:3::10]:35621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ewlvr-00054K-Fz
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ewlvo-0000GT-98
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:45:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49104
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ewlvo-0000Fe-18
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:45:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2G9iLTZ117325
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 05:45:47 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gr8j4es3c-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 05:45:46 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 09:45:44 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
	[9.149.105.60])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id w2G9jhIs54591544
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:45:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E9F42049
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:37:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85AF542041
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:37:55 +0000 (GMT)
Received: from [9.152.224.146] (unknown [9.152.224.146])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:37:55 +0000 (GMT)
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-8-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 10:45:42 +0100
MIME-Version: 1.0
In-Reply-To: <1521156300-19296-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <55e83fd1-df7f-3daf-1035-94c75231b7ab@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/7] s390: doc: detailed specifications
 for AP virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 16/03/2018 00:25, Tony Krowiak wrote:
> This patch provides documentation describing the AP architecture and
> design concepts behind the virtualization of AP devices. It also
> includes an example of how to configure AP devices for exclusive
> use of KVM guests.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   docs/vfio-ap.txt |  624 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   1 files changed, 624 insertions(+), 0 deletions(-)
>   create mode 100644 docs/vfio-ap.txt
>
> diff --git a/docs/vfio-ap.txt b/docs/vfio-ap.txt
> new file mode 100644
> index 0000000..54e7523
> --- /dev/null
> +++ b/docs/vfio-ap.txt
> @@ -0,0 +1,624 @@
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
> +* AP Matrix Configuration for a Linux Guest
> +* Starting a Linux Guest Configured with an AP Matrix
> +* Example: Configure AP Matrices for Two Linux Guests
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
> +  functions. There can be from 0 to 256 adapters assigned to an LPAR. =
Adapters
> +  assigned to the LPAR in which a linux host is running will be availa=
ble to
> +  the linux host. Each adapter is identified by a number from 0 to 255=
. When
> +  installed, an AP adapter is accessed by AP instructions executed by =
any CPU.
> +
> +* AP domain
> +
> +  An adapter is partitioned into domains. Each domain can be thought o=
f as
> +  a set of hardware registers for processing AP instructions. An adapt=
er can
> +  hold up to 256 domains. Each domain is identified by a number from 0=
 to 255.
> +  Domains can be further classified into two types:
> +
> +    * Usage domains are domains that can be accessed directly to proce=
ss AP
> +      commands
> +
> +    * Control domains are domains that are accessed indirectly by AP
> +      commands sent to a usage domain to control or change the domain,=
 for
> +      example; to set a secure private key for the domain.
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
> +Start Interpretive Execution (SIE) Instruction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +A KVM guest is started by executing the Start Interpretive Execution (=
SIE)
> +instruction. The SIE state description is a control block that contain=
s the
> +state information for a KVM guest and is supplied as input to the SIE
> +instruction. The SIE state description contains a field that reference=
s
> +a Crypto Control Block (CRYCB). The CRYCB contains three fields to ide=
ntify the
> +adapters, usage domains and control domains assigned to the KVM guest:
> +
> +* The AP Mask (APM) field is a bit mask that identifies the AP adapter=
s assigned
> +  to the KVM guest. Each bit in the mask, from most significant to lea=
st
> +  significant bit, corresponds to an APID from 0-255. If a bit is set,=
 the
> +  corresponding adapter is valid for use by the KVM guest.
> +
> +* The AP Queue Mask (AQM) field is a bit mask identifying the AP queue=
s assigned
> +  to the KVM guest. Each bit in the mask, from most significant to lea=
st
> +  significant bit, corresponds to an AP queue index (APQI) from 0-255.=
 If a bit
> +  is set, the corresponding queue is valid for use by the KVM guest.
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
> +intersection of all assigned adapter numbers (APM) with all assigned q=
ueue
> +indexes (AQM). For example, if adapters 1 and 2 and usage domains 5 an=
d 6 are
> +assigned to a guest, the APQNs (1,5), (1,6), (2,5) and (2,6) will be v=
alid for
> +the guest.
> +
> +The APQNs provide secure key functionality - i.e., a private key is st=
ored on
> +the adapter card for each of its domains - so each APQN must be assign=
ed to at
> +most one guest or the linux host.
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
> +   Example 2: Invalid configuration:
> +   --------------------------------
> +   Guest1: adapters 1,2  domains 5,6
> +   Guest2: adapter  1    domains 6,7
> +
> +   This is an invalid configuration because both guests have access to
> +   APQN (1,6).
> +
> +AP device Configuration on Linux Host:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +A linux system is a guest of the LPAR in which it is running and has a=
ccess to
> +the AP resources configured for the LPAR. The LPAR's AP matrix is
> +configured using the 'Customize/Delete Activation Profiles' dialog fro=
m the HMC.
> +This dialog displays the activation profiles configured for the linux =
system.
> +Selecting the specific activation profile to be edited and clicking th=
e
> +'Customize Profile' button will open the 'Customize Image Profiles' di=
alog.
> +Selecting the 'Crypto' link in the tree view on the left hand side of =
the dialog
> +will display the AP matrix configuration in the right hand panel. Ther=
e, one can
> +assign AP adapters - called Cryptos - and domains to the LPAR. When th=
e linux
> +system is started using this activation profile, it will have access t=
o the
> +matrix of AP adapters and domains configured via the activation profil=
e.
> +
> +When the linux system is started, the AP adapter devices will be conne=
cted to
> +the AP bus and the following AP matrix interfaces will be created in s=
ysfs:
> +
> +/sys/bus/ap
> +... [devices]
> +...... xx.yyyy
> +...... ...
> +...... cardxx
> +...... ...
> +
> +Where:
> +    cardxx     is adapter number xx (in hex)
> +    yyyy       is a usage domain number yyyy (in hex)
> +....xx.yyyy    is APQN (xx,yyyy)
> +
> +For example, if AP adapters 5 and 6 and domains 4 and 71 (0x47) are co=
nfigured
> +for the LPAR, the sysfs representation on the linux system would look =
like this:
> +
> +/sys/bus/ap
> +... [devices]
> +...... 05.0004
> +...... 05.0047
> +...... 06.0004
> +...... 06.0047
> +...... card05
> +...... card06
> +
> +There will also be AP device drivers created to control each type of A=
P matrix
> +interface available to the IBM Z system:
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
> +Links to the AP interfaces controlled by each AP device driver will be=
 created
> +in the device driver's sysfs directory. For example, if AP adapter 5 a=
nd domains
> +4 and 71 (0x47) are assigned to the LPAR and adapter 5 is a CEX5 card,=
 the
> +following links will be created in the CEX5 drivers' sysfs directories=
:
> +
> +/sys/bus/ap
> +... [drivers]
> +...... [cex4card]
> +......... [card05]
> +...... [cex4queue]
> +......... [05.0004]
> +......... [05.0047]
> +
> +AP Matrix Configuration for a Linux Guest:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +In order to configure the AP matrix for a guest, the adapters, usage d=
omains
> +and control domains to be used by the guest must be assigned to the gu=
est. This
> +section describes how to configure a guest's AP matrix.
> +
> +The kernel interfaces for configuring an AP matrix for a linux guest a=
re built
> +on the VFIO mediated device framework and are provided by the vfio_ap
> +kernel module. By default, the vfio_ap module is a loadable module, Th=
e
> +dependency chain for the vfio_ap module is:
> +* vfio
> +* mdev
> +* vfio_mdev
> +* vfio_ap
> +
> +When installed, the vfio_ap module is initialized. During module initi=
alization,
> +a vfio_ap driver is created and registered with the AP bus creating th=
e
> +following sysfs interfaces:
> +
> + /sys/bus/ap/drivers/
> +...[vfio_ap]
> +...... bind
> +...... unbind
> +
> +The vfio_ap device driver will create a 'matrix' device to hold the AP=
QNs
> +reserved for exclusive use by KVM guests:
> +
> +/sys/devices/
> +... [vfio_ap]
> +......[matrix] symlink to the matrix device directory
> +
> +The vfio_ap device driver serves several purposes:
> +1. Provides an interface for securing APQNs preventing their use by th=
e host
> +   linux system and reserving their use by one or more guests.
> +2. Creates the sysfs interfaces for configuring an AP matrix for a lin=
ux guest.
> +
> +Securing APQNs
> +--------------
> +   An APQN is reserved by unbinding an AP queue device AP bus device d=
river and
> +   binding it to the vfio_ap device driver. For example, suppose we wa=
nt to
> +   secure APQN (05,0004). Assuming that the AP adapter card 5 is a CEX=
5
> +   coprocessor card:
> +
> +   echo 05.0004 > /sys/bus/ap/drivers/cex4queue/unbind
> +   echo 05.0004 > /sys/bus/ap/drivers/vfio_ap/bind
> +
> +   This action will store the APQN in the /sys/devices/vfio_ap/matrix =
device
> +   which makes it available for use by a linux guest.
> +
> +Configuring an AP matrix for a linux guest.
> +------------------------------------------
> +These sysfs interfaces are built on the VFIO mediated device framework=
. To
> +configure an AP matrix for a guest, a mediated matrix device must firs=
t be
> +created for the /sys/devices/vfio_ap/matrix device. The sysfs interfac=
eAPQI corresponding to
> +for creating a mediated matrix device is in:
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
ute
> +file named 'create', for example:
> +
> +   uuidgen > create
> +
> +When a mediated AP matrix device is created, a sysfs directory named a=
fter
> +the UUID:
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
> +   'assign_adapter' file. This may be done multiple times to assign mo=
re than
> +   one adapter. The APID may be specified using conventional semantics
> +   as a decimal, hexidecimal, or octal number. For example, to assign =
adapters
> +   4, 5 and 16 to mediated matrix device $uuid in decimal, hexidecimal=
 and octal
> +   respectively:
> +
> +       echo 4 > assign_adapter
> +       echo 0x5 > assign_adapter
> +       echo 020
> +
> +unassign_adapter
> +   To unassign an AP adapter, its APID is written to the 'unassign_ada=
pter'
> +   file. This may also be done multiple times to unassign more than on=
e adapter.
> +
> +assign_domain
> +   To assign a usage domain, the APQI corresponding to the domain numb=
er is
> +   written into the 'assign_domain' file. This may be done multiple ti=
mes to
> +   assign more than one usage domain. The APQI may be specified using
> +   conventional semantics as a decimal, hexidecimal, or octal number. =
For
> +   example, to assign usage domains 4, 8, and 71 to mediated matrix de=
vice
> +   $uuid in decimal, hexidecimal and octal respectively:
> +
> +      echo 4 > assign_domain
> +      echo 0x8 > assign_domain
> +      echo 0107 > assign_domain
> +
> +unassign_domain
> +   To unassign a usage domain, the APQI corresponding to the domain nu=
mber is
> +   written into the 'unassign_domain' file. This may be done multiple =
times to
> +   unassign more than one usage domain.
> +
> +assign_control_domain
> +   To assign a control domain, the domain number is written into the
> +   'assign_control_domain' file. This may be done multiple times to
> +   assign more than one control domain. The domain number may be speci=
fied using
> +   conventional semantics as a decimal, hexidecimal, or octal number. =
For
> +   example, to assign  control domains 4, 8, and 71 to mediated matrix=
 device
> +   $uuid in decimal, hexidecimal and octal respectively:
> +
> +      echo 4 > assign_domain
> +      echo 0x8 > assign_domain
> +      echo 0107 > assign_domain
> +
> +unassign_control_domain
> +   To unassign a control domain, the domain number is written into the
> +   'unassign_domain' file. This may be done multiple times to unassign=
 more than
> +   one control domain.
> +
> +Notes:
> +* Hot plug/unplug is not currently supported for mediated AP matrix de=
vices,
> +  so the AP matrix resulting from assignment and/or unassignment of AP
> +  adapters, usage domains and control domains to a mediated AP matrix =
device
> +  while the guest is running will not take affect until the linux gues=
t is
> +  rebooted.
> +* By architectural convention, all usage domains configured for a KVM =
guest
> +  will also be implicitly assigned as control domains also, to there i=
s no
> +  need to assign control domains that are assigned as usage domains.
> +
> +Starting a Linux Guest Configured with an AP Matrix:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +In addition to providing the sysfs interfaces for configuring the AP m=
atrix for
> +a linux guest, a mediated matrix device also acts as a communication p=
athway
> +between QEMU and the vfio_ap device driver. To gain access to the
> +device driver, the following option must be specified on the QEMU comm=
and line:
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
> +When the linux guest is subsequently started, the guest will open the =
mediated
> +matrix device's file descriptor to get information about the mediated =
matrix
> +device. The vfio_ap device driver will update the APM, AQM, and ADM fi=
elds in the
> +guest's CRYCB with the adapter, usage domain and control domains assig=
ned to
> +via the mediated matrix device's sysfs attribute files. Programs runni=
ng on the
> +linux guest will then:
> +
> +1. Have direct access to the APQNs derived from the intersection of th=
e AP
> +   adapter and usage domain numbers specified in the APM and AQM respe=
ctively
> +
> +2. Have authorization to process AP commands to change - e.g., store a=
 new
> +   secure key - a control domain identified in an AP instruction sent =
to a valid
> +   APQN.
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
> +   are installed on the host system. It will turned on automatically f=
or guests
> +   started with CPU model zEC12 or newer. The feature is s390-specific=
 and is
> +   represented as a parameter of the -cpu option on the QEMU command l=
ine:
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
> +                   installed (off). The default for CPU models zEC12 o=
r newer
> +                   is ap=3Don. AP facilities must be installed when th=
is parameter
> +                   is used in conjunction with -device vfio-ap,sysfsde=
v=3D$path or
> +                   the guest will not start.
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
> +      qemu-system-s390x -cpu $model,qci=3Don|off
> +
> +      Where:
> +
> +         $model is the CPU model defined for the guest
> +
> +         qci=3Don|off indicates whether the QCI facility is installed =
(on) or not
> +                    installed (off). The default for CPU models zEC12 =
or newer
> +                    is qci=3Don. Turning the QCI facility on makes no =
sense if it
> +                    is not used in conjunction with the
> +                    '-device vfio-ap,sysfsdev=3D$path' option. A warni=
ng will be
> +                    presented if QCI is turned on and the AP facilitie=
s are not
> +                    installed.
> +
> +                    If the QCI facility is turned off, APQNs with an A=
PQI
> +                    greater than 15 will not be accessible from the gu=
est.
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
> +                     not installed (off). The default for CPU models z=
EC12 and
> +                     newer is apft=3Don. Turning the APFT facility on =
makes no
> +                     sense if it is not used in conjunction with the
> +                     -device vfio-ap,sysfsdev=3D$path option. A warnin=
g will be
> +                     presented if APFT is turned on and the AP facilit=
ies are
> +                     not installed.
> +
> +                     It also makes no sense to turn APFT off when used=
 in
> +                     conjunction with the vfio-ap device because the A=
PFT
> +                     facility is required; the AP bus running on the g=
uest will
> +                     not detect CEX4 and newer devices without it. Sin=
ce only
> +                     CEX4 and newer devices are supported for guest us=
age, no AP
> +                     devices can be made accessible to a guest started=
 without
> +                     APFT installed.
> +
> +Example: Configure AP Matrixes for Two Linux Guests:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +Let's now provide an example to illustrate how KVM guests may be given
> +access to AP facilities. For this example, we will show how to configu=
re
> +two guests such that executing the lszcrypt command on the guests woul=
d
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
5 whitespace at the end of lines
> +
> +Guest2
> +------
> +CARD.DOMAIN TYPE  MODE
> +------------------------------
> +05          CEX5A Accelerator
> +05.0047     CEX5A Accelerator
> +05.00ff     CEX5A Accelerator
> +
> +These are the steps for configuring the Guest1 and Guest2:
> +
> +1. The first thing that needs to be done is to secure the AP queues to=
 be
> +   used by the two guests so that the host can not access them. This i=
s done
> +   by unbinding each AP Queue device from its respective AP driver. In=
 our
> +   example, these queues are bound to the cex4queue driver. This would=
 be
> +   the sysfs location of these devices:
> +
> +   /sys/bus/ap
> +   --- [drivers]
> +   ------ [cex4queue]
> +   --------- [05.0004]
> +   --------- [05.0047]   --------------------- control_domains
> +   --------------------- domains
> +   --------- [05.00ab]
> +   --------- [05.00ff]
> +   --------- [06.0004]
> +   --------- [06.00ab]
> +   --------- unbind
> +
> +   To unbind AP queue 05.0004 from the cex4queue device driver:
> +
> +    echo 05.0004 > unbind
> +
> +   This must also be done for AP queues 05.00ab, 05.0047, 05.00ff, 06.=
0004,
> +   and 06.00ab.
> +
> +2. The next step is to reserve the queues for use by the two KVM guest=
s.
> +   This is accomplished by binding them to the VFIO AP device driver.
> +   This is the sysfs location of the VFIO AP device driver:
> +
> +   /sys/bus/ap
> +   ---[drivers]
> +   ------ [vfio_ap]
> +   ---------- bind
> +
> +   To bind queue 05.0004 to the vfio_ap driver:
> +
> +    echo 05.0004 > bind
> +
> +   This must also be done for AP queues 05.00ab, 05.0047, 05.00ff, 06.=
0004,
> +   and 06.00ab.
> +
> +3. Create the mediated devices needed to configure the AP matrixes for=
 the
> +   two guests and to provide an interface to the vfio_ap driver for
> +   use by the guests:
> +
> +   /sys/devices/
> +   --- [vfio_ap]
> +   ------ [matrix] (this is the matrix device)
> +   --------- [mdev_supported_types]
> +   ------------ [vfio_ap-passthrough] (passthrough mediated matrix dev=
ice type)
> +   --------------- create
> +   --------------- [devices]
> +
> +   To create the mediated devices for the two guests:
> +
> +    uuidgen > create
> +    uuidgen > create
> +
> +   This will create two mediated devices in the [devices] subdirectory=
 named
> +   with the UUID written to the create attribute file. We call them $u=
uid1
> +   and $uuid2:
> +
> +   /sys/devices/
> +   --- [vfio_ap]
> +   ------ [matrix]
> +   --------- [mdev_supported_types]
> +   ------------ [vfio_ap-passthrough]
> +   --------------- [devices]
> +   ------------------ [$uuid1]
> +   --------------------- assign_adapter
> +   --------------------- assign_control_domain
> +   --------------------- assign_domain
> +   --------------------- matrix
> +   --------------------- unassign_adapter
> +   --------------------- unassign_control_domain
> +   --------------------- unassign_domain
> +
> +   ------------------ [$uuid2]
> +   --------------------- assign_adapter
> +   --------------------- assign_cTo assign an adapter, the APID of the=
 adapter is written to the
> +      file. ontrol_domain
> +   --------------------- assign_domain
> +   --------------------- matrix
> +   --------------------- unassign_adapter
> +   --------------------- unassign_control_domain
> +   --------------------- unassign_domain
> +
> +4. The administrator now needs to configure the matrixes for mediated
> +   devices $uuid1 (for Guest1) and $uuid2 (for Guest2).
> +
> +   This is how the matrix is configured for Guest1:
> +
> +   echo 5 > assign_adapter
> +   echo 6 > assign_adapter
> +   echo 4 > assign_domain
> +   echo 0xab > assign_domain
> +
> +   By architectural convention, all usage domains - i.e., domains assi=
gned
> +   via the assign_domain attribute file - will also be configured in t=
he ADM
> +   field of the KVM guest's CRYCB, so there is no need to assign contr=
ol
> +   domains here unless you want to assign control domains that are not
> +   assigned as usage domains.
> +
> +   If a mistake is made configuring an adapter, domain or control doma=
in,
> +   you can use the unassign_xxx files to unassign the adapter, domain =
or
> +   control domain.
> +
> +   To display the matrix configuration for Guest1:
> +
> +   cat matrix
> +
> +   This is how the matrix is configured for Guest2:
> +
> +   echo 5 > assign_adapter
> +   echo 0x47 > assign_domain
> +   echo 0xff > assign_domain
> +
> +5. Start Guest1
> +
> +   /usr/bin/qemu-system-s390x ... -device vfio-ap,sysfsdev=3D/sys/devi=
ces/vfio_ap/matrix/$uuid1 ...
> +
> +6. Start Guest2
> +
> +   /usr/bin/qemu-system-s390x ... -device vfio-ap,sysfsdev=3D/sys/devi=
ces/vfio_ap/matrix/$uuid2 ...


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
