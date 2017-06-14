Received: from eggs.gnu.org ([2001:4830:134:3::10]:49282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL546-0003k0-IJ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL543-00014W-Hb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:58:18 -0400
Received: from mail-ve1eur01on0105.outbound.protection.outlook.com
	([104.47.1.105]:28832
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dL542-00013m-Ox
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:58:15 -0400
Date: Wed, 14 Jun 2017 12:58:04 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170614095759.GH2004@rkaganb.sw.ru>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-14-rkagan@virtuozzo.com>
	<20170613183434.GY5016@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613183434.GY5016@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH 13/23] hyperv: qdev-ify SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Tue, Jun 13, 2017 at 03:34:34PM -0300, Eduardo Habkost wrote:
> On Tue, Jun 06, 2017 at 09:19:38PM +0300, Roman Kagan wrote:
> > Make Hyper-V SynIC a device which is attached as a child to X86CPU.  For
> > now it only makes SynIC visibile in the qom hierarchy and exposes a few
> > properties which are maintained in sync with the respecitve msrs of the
> > parent cpu.
[...]
> > +static SynICState *get_synic(X86CPU *cpu)
> > +{
> > +    SynICState *synic =
> > +        SYNIC(object_resolve_path_component(OBJECT(cpu), "synic"));
> > +    assert(synic);
> > +    return synic;
> 
> How often this will run?  I think a new X86CPU struct field would
> be acceptable to avoid resolving a QOM path on every hyperv exit.

It's only used at the points where synic state is updated: at
realize/save/load/unrealize and when the guest configures synics via
msrs (i.e. a few times per cpu at guest startup).  None of those is
performance-critical.

> Do you even need QOM for this?

I need to reach the synic from the cpu on slow paths, and IMHO the
pointer on X86CPU is not justified here.  Besides there are two memory
regions associated with every synic (in a followup patch) and I thought
it made sense to have a dedicated parent QOM node for them.

> > +static Property synic_props[] = {
> > +    DEFINE_PROP_BOOL("enabled", SynICState, enabled, false),
> > +    DEFINE_PROP_UINT64("msg-page-addr", SynICState, msg_page_addr, 0),
> > +    DEFINE_PROP_UINT64("evt-page-addr", SynICState, evt_page_addr, 0),
> 
> What do you need the QOM properties for?  Are they supposed to be
> configurable by the user?

No.  Actually I wanted to define them as read-only, but I failed to find
a way to do so.

> Are they supposed to be queried from outside QEMU?  On which cases?

ATM I only see them as informational fields that may prove useful during
debugging.

Roman.
