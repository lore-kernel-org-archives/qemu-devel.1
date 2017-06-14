Received: from eggs.gnu.org ([2001:4830:134:3::10]:34295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL9xA-0002bm-Ie
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL9x6-0002wx-HI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:11:28 -0400
Received: from mail-eopbgr40123.outbound.protection.outlook.com
	([40.107.4.123]:39520
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dL9x5-0002uy-Vb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:11:24 -0400
Date: Wed, 14 Jun 2017 18:11:03 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170614151053.GD2044@rkaganb.sw.ru>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-14-rkagan@virtuozzo.com>
	<20170613183434.GY5016@thinpad.lan.raisama.net>
	<20170614095759.GH2004@rkaganb.sw.ru>
	<20170614124620.GB5016@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614124620.GB5016@thinpad.lan.raisama.net>
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

On Wed, Jun 14, 2017 at 09:46:20AM -0300, Eduardo Habkost wrote:
> On Wed, Jun 14, 2017 at 12:58:04PM +0300, Roman Kagan wrote:
> > On Tue, Jun 13, 2017 at 03:34:34PM -0300, Eduardo Habkost wrote:
> > > On Tue, Jun 06, 2017 at 09:19:38PM +0300, Roman Kagan wrote:
> > > > +static Property synic_props[] = {
> > > > +    DEFINE_PROP_BOOL("enabled", SynICState, enabled, false),
> > > > +    DEFINE_PROP_UINT64("msg-page-addr", SynICState, msg_page_addr, 0),
> > > > +    DEFINE_PROP_UINT64("evt-page-addr", SynICState, evt_page_addr, 0),
> > > 
> > > What do you need the QOM properties for?  Are they supposed to be
> > > configurable by the user?
> > 
> > No.  Actually I wanted to define them as read-only, but I failed to find
> > a way to do so.
> > 
> > > Are they supposed to be queried from outside QEMU?  On which cases?
> > 
> > ATM I only see them as informational fields that may prove useful during
> > debugging.
> > 
> 
> You can use object_property_add_uint64_ptr() on instance_init to
> add read-only properties.
> 
> If the enabled/msg_page_addr/evt_page_addr struct fields exist
> only because of the properties, you can also use
> object_property_add() and write your own getter that will query
> the MSRs only when reading the property.  I normally don't like
> custom getters/setters, but it sounds acceptable for a read-only
> property that's only for debugging.

Actually that was what I did at first, but then I decided it was useful
to have the fields directly on SynICState (see followup patches).

> Either way you choose to implement it, I would add a comment
> noting that the properties are there just for debugging.
> 
> BTW, would you still want to add this amount of boilerplate code
> just for debugging if we had a generic msr_get HMP command?
> There's a series in the list (submitted on April) adding msr_get
> and msr_set HMP commands, but it was never merged.

Yes I guess it would do.  So I'm now tempted to just drop the
properties, and leave the fields invisible through QOM.

Thanks,
Roman.
