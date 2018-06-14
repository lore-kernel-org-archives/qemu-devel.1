Received: from eggs.gnu.org ([2001:4830:134:3::10]:37057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTRtH-0004L0-UF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTRtC-00051P-5G
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:02:15 -0400
Date: Thu, 14 Jun 2018 15:02:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180614150204.78047e2e@redhat.com>
In-Reply-To: <20180613213337.GP7451@localhost.localdomain>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-7-david@redhat.com>
	<20180613145624.3004935c@redhat.com>
	<bb0b033f-d048-06db-96d1-89085000d792@redhat.com>
	<20180613213337.GP7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/11] pc-dimm: don't allow to access
 "size" before the device was realized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, "Michael S
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Wed, 13 Jun 2018 18:33:37 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jun 13, 2018 at 04:03:35PM +0200, David Hildenbrand wrote:
> > On 13.06.2018 14:56, Igor Mammedov wrote:  
> > > On Mon, 11 Jun 2018 14:16:50 +0200
> > > David Hildenbrand <david@redhat.com> wrote:
> > >   
> > >> "size" should not be queried before the device was realized. Let' make
> > >> that explicit.
> > >>
> > >> Signed-off-by: David Hildenbrand <david@redhat.com>  
> > > It's generic property getter, it should work even before realize is called.  
> > 
> > That's the point, as we can see in NVDIMM code , it is *not* a generic
> > property getter.  
> 
> If it were a writeable property, I would agree with Igor because
> it would make it impossible to find out what's the default value
> for the property.
> 
> As it's a read-only property, returning an error seems harmless.
> Igor, why exactly do you think it's a problem?
I'm not welcoming putting random restrictions on when property could be read.
For me it's just another qom property and it should return valid value
that corresponds to the current state of the object or error out if
it can't return anything useful at the moment.

In this particular case it should error out if 'memdev' isn't set and
return a value corresponding to current state of [pc|nv]dimm object
if 'memdev' is set.

This patch is obviously wrong, putting restriction based on "realized"
as getter might be easily accessed before Device::realized becomes True,
i.e. during setting properties or within device_set_realized() time.
