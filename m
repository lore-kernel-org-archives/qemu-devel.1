Received: from eggs.gnu.org ([2001:4830:134:3::10]:60288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEd1Y-0004n6-2y
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEd1U-0004ak-Ou
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:21:16 -0500
Date: Tue, 14 Nov 2017 16:21:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171114162104.401b051a.cohuck@redhat.com>
In-Reply-To: <1509033294-4945-6-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1509033294-4945-6-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/5] s390x/docs: documentation for ap-matrix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Thu, 26 Oct 2017 11:54:54 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

Cool, documentation!

> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  docs/ap_matrix.txt |  529 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 529 insertions(+), 0 deletions(-)
>  create mode 100644 docs/ap_matrix.txt
> 
> diff --git a/docs/ap_matrix.txt b/docs/ap_matrix.txt
> new file mode 100644
> index 0000000..ec7bd44
> --- /dev/null
> +++ b/docs/ap_matrix.txt
> @@ -0,0 +1,529 @@
> +Adjunct Processor (AP) Matrix Devices
> +=====================================
> +
> +Contents:
> +=========
> +* Introduction
> +* AP Architectural Overview
> +* Start Interpretive Execution (SIE) Instruction
> +* AP Matrix Configuration on Linux Host
> +* AP Matrix Configuration for a Linux Guest
> +* Starting a Linux Guest Configured with an AP Matrix
> +* Example: Configure AP Matrices for Two Linux Guests
> +
> +Introduction:
> +============
> +The IBM Adjunct Processor (AP) Cryptographic Facility is comprised 
> +of three AP instructions and from 1 to 256 PCIe cryptographic adapter cards.
> +These AP devices provide cryptographic functions to all CPUs assigned to a
> +linux system running in an IBM Z system LPAR.

Before you start with the details: Give a very, very high level
overview? Like:

On s390x, crypto cards are exposed via the AP bus. This document
describes how those cards can be made available to KVM guests via vfio.

> + 
> +The intent of this document is to provide administrators with the basic
> +knowledge needed to provide a linux guest with direct access to one or more AP
> +adapters available to the host linux system using an AP matrix device 
> +
> +AP Architectural Overview:
> +=========================
> +In order understand the terminology used in the rest of this document, let's 
> +start with some definitions:
> +
> +* AP adapter
> +
> +  An AP adapter is a PCIe cryptographic adapter that can perform cryptographic
> +  functions. There can be from 0 to 256 AP adapters assigned to an LPAR.
> +  Each adapter is identified by a number from 0 to 255. When 
> +  installed, an AP is accessed by AP instructions executed by any CPU. 
> +
> +* AP domain
> +
> +  An adapter is partitioned into domains. Each domain can be thought of as 
> +  a set of hardware registers dedicated to an active LPAR. An adapter can hold 
> +  up to 256 domains. Each domain is identified by a number from 0 to 255. 
> +  Domains can be further classified into two types: 
> +  
> +    * Usage domains are domains that can be accessed directly to process AP 
> +      commands
> +  
> +    * Control domains are domains that are accessed indirectly by AP 
> +      commands sent to a usage domain to control or change the domain, for 
> +      example; to specify a private key that can be used by the domain to 
> +      perform cryptographic functions.
> +
> +* AP Queue
> +
> +  An AP queue is the means by which an AP command is sent to an 
> +  AP usage domain inside a specific AP. An AP queue is identified by a tuple 
> +  comprised of an AP adapter ID and a usage domain index. The index corresponds
> +  to a given usage domain within the adapter. This tuple forms an AP Queue 
> +  Number (APQN). AP instructions specify an APQN to identify the AP Queue 
> +  to which an AP command-request message is to be sent, or from which a 
> +  command-reply message is to be received. An APQN is specified in this 
> +  document with one of two formats: APQN (xx,yyyy) or simply xx.yyyy, where 
> +  xx is an adapter number and yyyy is a domain number. Both numbers will be 
> +  specified in hexidecimal format.
> +
> +* AP Instructions:
> +
> +  There are three AP instructions:
> +
> +  * NQAP: to enqueue an AP command-request message to an AP queue
> +  * DQAP: to dequeue an AP command-reply message from an AP queue
> +  * PQAP: to administer an AP queue
> +
> +Start Interpretive Execution (SIE) Instruction
> +==============================================
> +A linux guest running on an IBM Z system is started under KVM by executing the 
> +Start Interpretive Execution (SIE) instruction. The SIE state description is a 
> +control block that contains the state information for a KVM guest and is 
> +supplied as input to the SIE instruction. The SIE state description contains a 
> +field that references a Crypto Control Block (CRYCB) containing three
> +fields to identify the AP adapters, usage domains and control domains assigned 
> +to the KVM guest: 
> +
> +* The AP Mask (APM) field specifies the AP adapter numbers assigned to the 
> +  KVM guest. The APM controls which adapters are valid for the KVM guest.
> +
> +* The AP Queue Mask (AQM) field specifies the AP usage domain numbers assigned 
> +  to the KVM guest. The AQM controls which usage domains are valid for the 
> +  KVM guest.
> +
> +* The AP Domain Mask field specifies the AP control domains assigned to the 
> +  KVM guest. The ADM controls which control domains are valid for the 
> +  KVM guest.
> +
> +These three fields comprise the AP matrix for the guest. The APQNs accessible
> +to the guest is the intersection of all assigned adapter numbers (APM) and 
> +all assigned usage domain numbers (AQM). For example, if adapters 1 and 2 and 
> +usage domains 5 and 6 are assigned to a guest, the APQNs (1,5), (1,6), (2,5) and
> +(2,6) will be valid for AP instructions executed on the guest.
> +
> +The SIE instruction is run in interpretive execution mode which means the 
> +AP instructions executed on the guest are interpreted by the hardware. This 
> +allows a guest direct access to the AP adapter cards. Since each domain within
> +a given adapter holds the master key used in the cryptographic functions it 
> +supports, each APQN must be assigned to at most one guest.
> +
> +   Example 1: Valid configuration for two guests:
> +   ---------------------------------------------
> +   Guest1: adapters 1,2  domains 5,6
> +   Guest2: adapter  1,2  domain 7
> +
> +   This is valid because both guests have a unique set of APQNs: Guest1 has
> +   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQN (1,7) and (2,7). There
> +   is not overlap.
> +
> +   Example 2: Invalid configuration for two guests:
> +   -----------------------------------------------
> +   Guest1: adapters 1,2  domains 5,6
> +   Guest2: adapter  1    domains 6,7
> +
> +   This is an invalid configuration because both guests have access to 
> +   APQNs (1,6).
> +
> +AP Matrix Configuration on Linux Host:
> +=====================================
> +A linux system is a guest of the LPAR in which it is running and has access to
> +the AP resources configured for the LPAR. The LPAR's AP matrix is 
> +configured using the 'Customize/Delete Activation Profiles' dialog from the HMC. 
> +This dialog displays the activation profiles configured for the linux system. 
> +Selecting the specific activation profile to be edited and clicking the 
> +'Customize Profile' button will open the 'Customize Image Profiles' dialog. 
> +Selecting the 'Crypto' link in the tree view on the left hand side of the dialog 
> +will display the AP matrix configuration in the right hand panel. There, one can 
> +assign AP adapters - called Cryptos - and domains to the LPAR. When the linux 
> +system is started using this activation profile, it will have access to the
> +AP matrix configured via the activation profile.
> +
> +When the linux system is started, the AP adapter devices will be connected to 
> +the AP bus and the following AP matrix interfaces will be created in sysfs:
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
> +For example, if AP adapters 5 and 6 and domains 4 and 71 are configured for the
> +LPAR, the sysfs representation on the linux system would look like this:
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
> +There will also be AP device drivers created to control each type of AP matrix 
> +interface available to the IBM Z system:
> +
> +/sys/bus/ap
> +... [drivers]
> +...... [cex2acard]        for Crypto Express 2/3 accelerator cards
> +...... [cex2aqueue]       for AP queues served by Crypto Express 2/3 
> +                          accelerator cards
> +...... [cex4card]         for Crypto Express 4/5/6 accelerator and coprocessor 
> +                          cards
> +...... [cex4queue]        for AP queues served by Crypto Express 4/5/6 
> +                          accelerator and coprocessor cards
> +...... [pcixcccard]       for Crypto Express 2/3 coprocessor cards
> +...... [pcixccqueue]      for AP queues served by Crypto Express 2/3 
> +                          coprocessor cards
> +
> +Links to the AP interfaces controlled by each AP device driver will be created 
> +in the device driver's sysfs directory. For example, if AP adapter 5 and domains
> +4 and 71 (0x47) are assigned to the LPAR and adapter 5 is a CEX5 card, the 
> +following links will be created in the CEX5 drivers' sysfs directories:
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
> +=========================================
> +In order to configure the AP matrix for a guest, the adapters, usage domains 
> +and control domains to be used by the guest must be identified. This section
> +describes how to configure a guest's AP matrix.
> +
> +When the linux host is booted, an AP matrix bus will be initialized. When 
> +initialized, the AP matrix bus creates a single AP matrix device to 
> +hold the APQNs to be made available to guests:
> +
> +/sys/bus/ap_matrix
> +... [devices]
> +......[matrix] symlink to the AP matrix device directory
> +
> +/sys/devices
> +... [ap_matrix]
> +......[matrix] the AP matrix device directory
> +
> +The kernel interfaces for configuring an AP matrix for a linux guest are built 
> +on the VFIO mediated device framework and are provided by the vfio_ap_matrix 
> +kernel module. The dependency chain for the vfio_ap_matrix module is:
> +
> +* vfio
> +* mdev
> +* vfio_mdev
> +* vfio_ap_matrix
> +
> +When the vfio_ap_matrix module is loaded, it will create the following sysfs 
> +interfaces:
> +
> +/sys/bus/ap
> +... [drivers]
> +...... [vfio_ap_matrix]
> +......... bind
> +
> +The vfio_ap_matrix device driver is created to provide an interface for securing
> +APQNs from use by the host linux system. This is accomplished by unbinding the
> +APQNs from the host device driver and binding them to the vfio_ap_matrix 
> +device driver. For example, suppose we want to secure APQN (05,0004). Assuming
> +for this example that AP adapter card 5 is a CEX5 coprocessor card:
> +
> +    echo 05.0004 > /sys/bus/ap/drivers/cex4queue/unbind
> +    echo 05.0004 > /sys/bus/ap/drivers/vfio_ap_matrix/bind
> +
> +This action will store the APQN in the /sys/devices/ap_matrix/matrix device 
> +which makes it available for use by a linux guest.
> +
> +Another side effect of loading the vfio_ap_matrix module is the creation of the
> +sysfs interfaces for configuring an AP matrix for a linux guest. These sysfs 
> +interfaces are built on the VFIO mediated device framework. To configure an AP 
> +matrix for a guest, a mediated matrix device must be created for the 
> +/sys/devices/ap_matrix/matrix device. A mediated matrix device must be created
> +for each guest that needs access to one or more AP queues. The sysfs interface 
> +for creating a mediated matrix device is in:
> +
> +/sys/devices
> +... [ap_matrix]
> +......[matrix]
> +......... [mdev_supported_types]
> +............ [ap_matrix-passthrough]
> +............... create
> +............... [devices]
> +
> +A mediated AP matrix device is created by writing a UUID to the attribute
> +file named 'create', for example:
> +
> +    uuidgen > create
> +
> +When a mediated AP matrix device is created, a sysfs directory named after 
> +the UUID will be created in the devices subdirectory:
> +
> +/sys/devices
> +... [ap_matrix]
> +......[matrix]
> +......... [mdev_supported_types]
> +............ [ap_matrix-passthrough]
> +............... create
> +............... [devices]
> +.................. [$uuid]
> +..................... adapters
> +..................... assign_adapter
> +..................... assign_control_domain
> +..................... assign_domain
> +..................... control_domains
> +..................... domains
> +..................... remove
> +..................... unassign_adapter
> +..................... unassign_control_domain
> +..................... unassign_domain
> +
> +There will also be three sets of attribute files created in the mediated matrix 
> +device's sysfs directory:
> +
> +1 Adapter assignment
> +    * An adapter is assigned by writing the adapter's number into the 
> +      'assign_adapter' file. This may be repeated multiple times to assign
> +      multiple adapters. For example, to assign adapters 5 and 6 to mediated 
> +      matrix device $uuid:
> +      
> +          echo 5 > assign_adapter
> +          echo 6 > assign_adapter
> +
> +    * An adapter may be unassigned by writing the adapter's number into the 
> +      'unassign_adapter' file. This may also be done multiple times to
> +      unassign multiple adapters.
> +
> +    * To view the adapter numbers assigned to the AP matrix mediated device, 
> +      print the 'adapters' file:
> +
> +          cat adapters
> +
> +1 Usage Domain assignment
> +    * A usage domain is assigned by writing the usage domain's number into the 
> +      'assign_domain' file. This may be repeated multiple times to assign
> +      multiple usage domains. For example, to assign usage domains 4 and 
> +      71 (0x47) to mediated matrix device $uuid:
> +
> +          echo 4 > assign_domain
> +          echo 47 > assign_domain
> +
> +    * A domain may be unassigned by writing the usage domain's number into the 
> +      'unassign_domain' file. This may be repeated multiple times to unassign
> +      multiple usage domains.
> +
> +    * To view the usage domain numbers assigned to the AP matrix mediated 
> +    device, print the 'domains' file:
> +
> +          cat domains
> +
> +1 Control domain assignment
> +    * A control domain is assigned by writing the control domain's number into 
> +      the 'assign_control_domain' file. This may be repeated multiple times to 
> +      assign multiple control domains. It is not necessary to assign 
> +      usage domain numbers as control domains, that is done automatically by 
> +      default. To assign control domains 4 and 37 (0x35) to mediated matrix 
> +      device $uuid:
> +      
> +          echo 4 > assign_control_domain
> +          echo 25 > assign_control_domain
> +
> +    * A control domain may be unassigned by writing the control domain's number 
> +      into the 'unassign_control_domain' file. This may be repeated multiple
> +      times to unassign multiple control domains.
> +
> +    * To view the control domain numbers assigned to the AP matrix mediated 
> +      device, print the 'control_domains' file:
> +
> +          cat control_domains
> +
> +Note: Hot plug/unplug is not currently supported for mediated AP matrix devices,
> +      so the AP matrix resulting from assignment and/or unassignment of AP 
> +      adapters, usage domains and control domains to a mediated AP matrix device 
> +      will not take affect until the linux guest is rebooted.
> +
> +Starting a Linux Guest Configured with an AP Matrix:
> +===================================================
> +In addition to providing the sysfs interfaces for configuring the AP matrix for 
> +a linux guest, a mediated AP matrix device also acts as a communication pathway 
> +between QEMU and the vfio_ap_matrix device driver. To gain access to the 
> +device driver, the following option must be specified on the QEMU command line:
> +
> +-device vfio_ap_matrix,sysfsdev=$path-to-mdev
> +
> +The sysfsdev parameter specifies the path to the mediated matrix device.
> +There are a number of ways to specify this path:
> +
> +/sys/devices/ap_matrix/matrix/$uuid
> +/sys/bus/mdev/devices/$uuid
> +/sys/bus/mdev/drivers/vfio_mdev/$uuid
> +/sys/devices/ap_matrix/matrix/mdev_supported_types/ap_matrix-passthrough/devices/$uuid
> +
> +When the linux guest is subsequently started, the guest will open the mediated 
> +matrix device's file descriptor to issue the command instructing the device 
> +driver to configure the AP matrix for the linux guest. In response, the 
> +vfio_ap_matrix device driver will update the APM, AQM, and ADM fields in the 
> +guest's CRYCB with the adapter, usage domain and control domain numbers 
> +specified via the mediated matrix device's sysfs attribute files. Programs 
> +running on the linux guest will then:
> +
> +1. Have access to the APQNs derived from the intersection of the AP adapter and
> +   usage domain numbers specified in the APM and AQM respectively
> +
> +2. Have authorization to process AP commands to change a control domains
> +   identified in an AP instruction sent to a valid APQN.
> +
> +Example: Configure AP Matrices for Two Linux Guests:
> +===================================================
> +Let's now provide an example to illustrate how KVM guests may be given
> +direct access to APQNs. For this example, we will illustrate how to configure 
> +two guests such that executing the lszcrypt command on the guests would 
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
> +05.00ff     CEX5A Accelerator 
> +
> +These are the steps for configuring Guest1 and Guest2:
> +   
> +1. The first thing that needs to be done is to unbind each AP Queue device from
> +   its respective AP device driver to prevent access from the host linux system
> +   and to reserve it for use by a linux guest. For our example, let's assume
> +   the AP queues are bound to the cex4queue driver. 
> +
> +   /sys/bus/ap
> +   --- [drivers]
> +   ------ [cex4queue]
> +   --------- [05.0004]
> +   --------- [05.0047]
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
> +   This must also be done for AP queues 05.00ab, 05.0047, 05.00ff, 06.0004,
> +   and 06.00ab.
> +
> +2. The next step is to reserve the queues for use by the two KVM guests. 
> +   This is accomplished by binding them to the VFIO AP matrix device driver:
> +
> +   /sys/bus/ap
> +   ---[drivers]
> +   ------ [vfio_ap_matrix]
> +   ---------- bind
> +
> +   For Guest1:
> +
> +    echo 05.0004 > bind
> +    echo 05.00ab > bind
> +    echo 06.0004 > bind
> +    echo 06.00ab > bind
> +
> +   For Guest2:
> +
> +   echo 05.0047 > bind
> +   echo 05.00ff > bind
> +
> +3. Create the mediated matrix devices needed to configure the AP matrices for 
> +   and to provide an interface to the vfio_ap_matrix driver for use by the 
> +   two guests:
> +
> +   /sys/devices/
> +   --- [ap_matrix]
> +   ------ [matrix] (this is the AP matrix device)
> +   --------- [mdev_supported_types]
> +   ------------ [ap_matrix-passthrough] (the mediated device type)
> +   --------------- create
> +   --------------- [devices]
> +
> +   To create the mediated devices for the two guests:
> +
> +    uuidgen > create
> +    uuidgen > create
> +
> +   This will create two mediated devices in the [devices] subdirectory named 
> +   with the UUID written to the create attribute file. We call them $uuid1
> +   and $uuid2:
> +
> +   /sys/devices/
> +   --- [ap_matrix]
> +   ------ [matrix]
> +   --------- [mdev_supported_types]
> +   ------------ [ap_matrix-passthrough]
> +   --------------- [devices]
> +   ------------------ [$uuid1]
> +   --------------------- adapters
> +   --------------------- assign_adapter
> +   --------------------- assign_control_domain
> +   --------------------- assign_domain
> +   --------------------- control_domains
> +   --------------------- domains
> +   --------------------- unassign_adapter
> +   --------------------- unassign_control_domain
> +   --------------------- unassign_domain
> +   ------------------ [$uuid2]
> +   --------------------- adapters
> +   --------------------- assign_adapter
> +   --------------------- assign_control_domain
> +   --------------------- assign_domain
> +   --------------------- control_domains
> +   --------------------- domains
> +   --------------------- unassign_adapter
> +   --------------------- unassign_control_domain
> +   --------------------- unassign_domain
> +
> +4. The administrator now needs to configure the matrices for mediated 
> +   devices $uuid1 (for Guest1) and $uuid2 (for Guest2). 
> +
> +   For Guest1:
> +   cd /sys/devices/ap_matrix/matrix/mdev_supported_types/ap_matrix_passthrough
> +   cd ./devices/$uuid1:
> +
> +   echo 5 > assign_adapter
> +   echo 6 > assign_adapter 
> +   echo 4 > assign_domain
> +   echo ab > assign_domain
> +
> +   For Guest2:
> +   cd /sys/devices/ap_matrix/matrix/mdev_supported_types/ap_matrix_passthrough
> +   cd ./devices/$uuid2:
> +
> +   echo 5 > assign_adapter 
> +   echo 47 > assign_domain
> +   echo ff > assign_domain
> +
> +   By architectural convention, all usage domains - i.e., domains assigned 
> +   via the assign_domain attribute file - will also be configured in the ADM 
> +   field of the KVM guest's CRYCB, so there is no need to assign control 
> +   domains here unless you want to assign control domains that are not 
> +   assigned as usage domains.
> +
> +5. Start Guest1
> +
> +   /usr/bin/qemu-system-s390x ... -device vfio_ap_matrix,sysfsdev=/sys/devices/ap_matrix/matrix/$uuid1 ...
> +
> +6. Start Guest2
> +
> +   /usr/bin/qemu-system-s390x ... -device vfio_ap_matrix,sysfsdev=/sys/devices/ap_matrix/matrix/$uuid2 ...
> \ No newline at end of file

Please add a newline :)

I think this document can be improved by some ascii art for the
matrices. Especially if you put in a matrix for the host view, two
matrices for two well-configured guests and two matrices for two guests
with a bad (conflicting) configuration. That makes it more clear why we
need this interface.
