Received: from eggs.gnu.org ([209.51.188.92]:35783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj75Q-0007ZY-J1
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj75P-0006Hv-Vk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:35:48 -0500
Date: Mon, 14 Jan 2019 13:35:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114133455-mutt-send-email-mst@kernel.org>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-17-sameo@linux.intel.com>
	<20181108152341.68e5a147@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108152341.68e5a147@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 16/24] hw: acpi: Fix memory hotplug AML
 generation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Yang Zhong <yang.zhong@intel.com>

On Thu, Nov 08, 2018 at 03:23:41PM +0100, Igor Mammedov wrote:
> On Mon,  5 Nov 2018 02:40:39 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > From: Yang Zhong <yang.zhong@intel.com>
> > 
> > When using the generated memory hotplug AML, the iasl
> > compiler would give the following error:
> > 
> > dsdt.dsl 266: Return (MOST (_UID, Arg0, Arg1, Arg2))
> > Error 6080 - Called method returns no value ^
> > 
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> I suggest to put this patch at the beginning of the series
> before reference tables in test are updated.

Samuel how about a separate small series with just bugfixes
for starters?


> > ---
> >  hw/acpi/memory_hotplug.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> > index db2c4df961..893fc2bd27 100644
> > --- a/hw/acpi/memory_hotplug.c
> > +++ b/hw/acpi/memory_hotplug.c
> > @@ -686,15 +686,15 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >  
> >              method = aml_method("_OST", 3, AML_NOTSERIALIZED);
> >              s = MEMORY_SLOT_OST_METHOD;
> > -            aml_append(method, aml_return(aml_call4(
> > -                s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
> > -            )));
> > +            aml_append(method,
> > +                       aml_call4(s, aml_name("_UID"), aml_arg(0),
> > +                                 aml_arg(1), aml_arg(2)));
> >              aml_append(dev, method);
> >  
> >              method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >              s = MEMORY_SLOT_EJECT_METHOD;
> > -            aml_append(method, aml_return(aml_call2(
> > -                       s, aml_name("_UID"), aml_arg(0))));
> > +            aml_append(method,
> > +                       aml_call2(s, aml_name("_UID"), aml_arg(0)));
> >              aml_append(dev, method);
> >  
> >              aml_append(dev_container, dev);
