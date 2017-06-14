Received: from eggs.gnu.org ([2001:4830:134:3::10]:40767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL7gp-00086f-Fg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL7gm-0004Rr-D5
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:46:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dL7gm-0004Rc-3L
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:46:24 -0400
Date: Wed, 14 Jun 2017 09:46:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170614124620.GB5016@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-14-rkagan@virtuozzo.com>
	<20170613183434.GY5016@thinpad.lan.raisama.net>
	<20170614095759.GH2004@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614095759.GH2004@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [PATCH 13/23] hyperv: qdev-ify SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 12:58:04PM +0300, Roman Kagan wrote:
> On Tue, Jun 13, 2017 at 03:34:34PM -0300, Eduardo Habkost wrote:
> > On Tue, Jun 06, 2017 at 09:19:38PM +0300, Roman Kagan wrote:
> > > Make Hyper-V SynIC a device which is attached as a child to X86CPU.  For
> > > now it only makes SynIC visibile in the qom hierarchy and exposes a few
> > > properties which are maintained in sync with the respecitve msrs of the
> > > parent cpu.
> [...]
> > > +static SynICState *get_synic(X86CPU *cpu)
> > > +{
> > > +    SynICState *synic =
> > > +        SYNIC(object_resolve_path_component(OBJECT(cpu), "synic"));
> > > +    assert(synic);
> > > +    return synic;
> > 
> > How often this will run?  I think a new X86CPU struct field would
> > be acceptable to avoid resolving a QOM path on every hyperv exit.
> 
> It's only used at the points where synic state is updated: at
> realize/save/load/unrealize and when the guest configures synics via
> msrs (i.e. a few times per cpu at guest startup).  None of those is
> performance-critical.
> 
> > Do you even need QOM for this?
> 
> I need to reach the synic from the cpu on slow paths, and IMHO the
> pointer on X86CPU is not justified here.  Besides there are two memory
> regions associated with every synic (in a followup patch) and I thought
> it made sense to have a dedicated parent QOM node for them.

Makes sense.

> 
> > > +static Property synic_props[] = {
> > > +    DEFINE_PROP_BOOL("enabled", SynICState, enabled, false),
> > > +    DEFINE_PROP_UINT64("msg-page-addr", SynICState, msg_page_addr, 0),
> > > +    DEFINE_PROP_UINT64("evt-page-addr", SynICState, evt_page_addr, 0),
> > 
> > What do you need the QOM properties for?  Are they supposed to be
> > configurable by the user?
> 
> No.  Actually I wanted to define them as read-only, but I failed to find
> a way to do so.
> 
> > Are they supposed to be queried from outside QEMU?  On which cases?
> 
> ATM I only see them as informational fields that may prove useful during
> debugging.
> 

You can use object_property_add_uint64_ptr() on instance_init to
add read-only properties.

If the enabled/msg_page_addr/evt_page_addr struct fields exist
only because of the properties, you can also use
object_property_add() and write your own getter that will query
the MSRs only when reading the property.  I normally don't like
custom getters/setters, but it sounds acceptable for a read-only
property that's only for debugging.

Either way you choose to implement it, I would add a comment
noting that the properties are there just for debugging.

BTW, would you still want to add this amount of boilerplate code
just for debugging if we had a generic msr_get HMP command?
There's a series in the list (submitted on April) adding msr_get
and msr_set HMP commands, but it was never merged.

-- 
Eduardo
