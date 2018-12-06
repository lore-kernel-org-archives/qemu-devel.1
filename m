Received: from eggs.gnu.org ([2001:4830:134:3::10]:47332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=871f73acd=anthony.perard@citrix.com>)
	id 1gUvWM-0006CZ-Hw
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=871f73acd=anthony.perard@citrix.com>)
	id 1gUvVg-0004BB-6V
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:24:19 -0500
Date: Thu, 6 Dec 2018 15:24:06 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181206152406.GC18875@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-16-paul.durrant@citrix.com>
	<20181204153510.GW14786@perard.uk.xensource.com>
	<66fe7ee71e9642d3bbbda0f4f900c799@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66fe7ee71e9642d3bbbda0f4f900c799@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH 15/18] xen: add a mechanism to
 automatically create XenDevice-s...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Dec 06, 2018 at 12:36:52PM +0000, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 04 December 2018 15:35
> > 
> > On Wed, Nov 21, 2018 at 03:12:08PM +0000, Paul Durrant wrote:
> > > +    xenbus->backend_watch =
> > > +        xen_bus_add_watch(xenbus, "", /* domain root node */
> > > +                          "backend", xen_bus_enumerate, xenbus,
> > &local_err);
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +        error_prepend(errp, "failed to set up enumeration watch: ");
> > 
> > You should use error_propagate_prepend instead
> > error_propagate;error_prepend. And it looks like there is the same
> > mistake in other patches that I haven't notice.
> > 
> 
> Oh, I didn't know about that one either... I've only seen the separate calls used elsewhere.

That information is all in "include/qapi/error.h", if you which to know
more on how to use Error.

> > Also you probably want goto fail here.
> > 
> 
> Not sure about that. Whilst the bus scan won't happen, it doesn't mean devices can't be added via QMP.

In that case, don't modify errp, and use error_reportf_err instead, or
warn_reportf_err (then local_err = NULL, in case it is reused in a
future modification of the function).

Setting errp (with error_propagate) means that the function failed, and
QEMU is going to exit(1), because of qdev_init_nofail call in
xen_bus_init.

> > > +static void xen_device_backend_changed(void *opaque)
> > > +{
> > > +    XenDevice *xendev = opaque;
> > > +    const char *type = object_get_typename(OBJECT(xendev));
> > > +    enum xenbus_state state;
> > > +    unsigned int online;
> > > +
> > > +    trace_xen_device_backend_changed(type, xendev->name);
> > > +
> > > +    if (xen_device_backend_scanf(xendev, "state", "%u", &state) != 1) {
> > > +        state = XenbusStateUnknown;
> > > +    }
> > > +
> > > +    xen_device_backend_set_state(xendev, state);
> > 
> > It's kind of weird to set the internal state base on the external one
> > that something else may have modified. Shouldn't we check that it is
> > fine for something else to modify the state and that it is a correct
> > transition?
> 
> The only thing (apart from this code) that's going to have perms to write the backend state is the toolstack... which is, of course, be definition trusted.

"trusted" doesn't mean that there isn't a bug somewhere else :-). But I
guess it's good enough for now.

> > Also aren't we going in a loop by having QEMU set the state, then the
> > watch fires again? (Not really a loop since the function _set_state
> > check for changes.
> 
> No. It's de-bounced inside the set_state function.
> 
> > 
> > Also maybe we should watch for the state changes only when something
> > else like libxl creates (ask for) the backend, and ignore changes when
> > QEMU did it itself.
> 
> I don't think it's necessary to add that complexity.

Ok.

-- 
Anthony PERARD
