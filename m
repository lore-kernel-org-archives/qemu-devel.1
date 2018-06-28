Received: from eggs.gnu.org ([2001:4830:134:3::10]:33735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYeiF-00076l-OC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYeiC-0006l8-JU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:44:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYeiC-0006iA-Du
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:44:20 -0400
References: <20180626151038.24771-1-sameeh@daynix.com>
	<20180626151038.24771-2-sameeh@daynix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e9b9ca6-b493-d10b-be98-9b9eb480c685@redhat.com>
Date: Thu, 28 Jun 2018 16:44:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180626151038.24771-2-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qga-win: prevent crash when executing
 fsinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>

On 06/26/2018 10:10 AM, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> The fsinfo command is currently implemented for Windows only and it's disk
> parameter can be enabled by adding the define "CONFIG_QGA_NTDDSCSI" to the qga
> code. When enabled and executed the qemu-ga crashed with the following message:
> 
> ------------------------------------------------
> File qapi/qapi-visit-core.c, Line 49
> 
> Expression: !(v->type & VISITOR_OUTPUT) || *obj)
> ------------------------------------------------
> 
> After some digging, turns out that the GuestPCIAddress is null and the
> qapi visitor doesn't like that, so we can always allocate it instead and
> initiate all it's members to -1.

Adding Markus for a qapi back-compat question.

Is faking an invalid address better than making the output optional instead?

> +++ b/qga/commands-win32.c
> @@ -485,6 +485,11 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
>       char *buffer = NULL;
>       GuestPCIAddress *pci = NULL;
>       char *name = g_strdup(&guid[4]);
> +    pci = g_malloc0(sizeof(*pci));
> +    pci->domain = -1;
> +    pci->slot = -1;
> +    pci->function = -1;
> +    pci->bus = -1;

Right now, we have:

##
# @GuestDiskAddress:
#
# @pci-controller: controller's PCI address
# @bus-type: bus type
# @bus: bus id
# @target: target id
# @unit: unit id
#
# Since: 2.2
##
{ 'struct': 'GuestDiskAddress',
   'data': {'pci-controller': 'GuestPCIAddress',
            'bus-type': 'GuestDiskBusType',
            'bus': 'int', 'target': 'int', 'unit': 'int'} }

and the problem you ran into is that under certain conditions, we have 
no idea what to populate in GuestPCIAddress.  Your patch populates 
garbage instead; but I'm wondering if it would be better to instead mark 
pci-controller as optional, where code that CAN populate it would set 
has_pci_controller=true, and the code that crashed will now work by 
leaving the struct NULL (and has_pci_controller=false).  But that 
removes output that the client may expect to be present, hence, this is 
a back-compat question of the best way to approach this.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
