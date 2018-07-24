Received: from eggs.gnu.org ([2001:4830:134:3::10]:45935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhzF5-0007ho-V4
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhzF2-0005V3-0D
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:28:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fhzF1-0005UU-F2
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:28:47 -0400
Date: Tue, 24 Jul 2018 17:28:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180724172844.5bea5a07@redhat.com>
In-Reply-To: <20180724123916.GC3896@localhost.localdomain>
References: <20180723193145.24705-1-ehabkost@redhat.com>
	<20180723193145.24705-3-ehabkost@redhat.com>
	<20180724142949.3078da82@redhat.com>
	<20180724123916.GC3896@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] acpi: Decouple ACPI hotplug
 callbacks from HotplugHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 24 Jul 2018 09:39:16 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Jul 24, 2018 at 02:29:49PM +0200, Igor Mammedov wrote:
> > On Mon, 23 Jul 2018 16:31:45 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > The ACPI hotplug callbacks get a HotplugHandler object as
> > > argument.  This has two problems:
> > > 
> > > 1) The functions require a TYPE_ACPI_DEVICE_IF object, but the
> > >    function prototype doesn't indicate that.  It's possible to
> > >    pass an object that would make the function crash.
> > > 2) The function does not require the object to implement
> > >    TYPE_HOTPLUG_HANDLER at all, but the function prototype
> > >    imposes that for no reason.
> > > 
> > > Change the argument type to AcpiDeviceIf instead of
> > > HotplugHandler.  
> > What is the motivation for this patch,
> > do you actually get crashes?  
> 
> I didn't get crashes, but the idea for the change came when
> Michael asked me how to get the HotplugHandler object.  I was
> going to suggest current_machine (which is also a hotplug
> handler), when I noticed he actually needed an AcpiDeviceIf
> object.
> 
> The main motivation, however, is to simply make the function
> prototypes make sense.  Is there a single reason to make the ACPI
> functions get a HotplugHandler argument instead of AcpiDeviceIf?
I'd rather to keep current *_cb() functions as is,
as we might actually need access to hotplug handler there and in
that case keeping more generic hotplug handler would be better
and it also sort of documents better what is being passed in.

Also we won't have to rewrite it back from AcpiDeviceIf to
HotplugHandler again if it's needed.
