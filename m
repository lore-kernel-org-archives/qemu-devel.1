Received: from eggs.gnu.org ([2001:4830:134:3::10]:59993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cuzwK-0001QC-5a
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cuzwH-0000Jl-Ez
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:14:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cuzwH-0000Ja-8r
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:14:25 -0400
Date: Mon, 3 Apr 2017 12:14:14 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403111414.GN2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <4712D8F4B26E034E80552F30A67BE0B1A3D97E@ORSMSX112.amr.corp.intel.com>
	<20170327132454.GD28620@stefanha-x1.localdomain>
	<4712D8F4B26E034E80552F30A67BE0B1A40E6D@ORSMSX112.amr.corp.intel.com>
	<339080cc-c86d-93be-9c13-596eb43d56dd@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A42954@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A42954@ORSMSX112.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] Create libqemutrace.a for all trace.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Mar 28, 2017 at 07:00:34PM +0000, Xu, Anthony wrote:
> > >>> ./trace.o, ./qapi/trace.o and ./util/trace.o are added into
> > >>> libqemuutil.a  to avoid recursive dependencies between
> > >>> libqemuutil.a and libqemutrace.a.
> > >> Why would libqemutrace.a depend on libqemuutil.a?
> > > Each trace.c calls trace_event_register_group to register events,
> > > trace_event_register_group is defined in trace/control.c , which
> > > is linked into libqemuutil.a.
> > 
> > Ah:
> > 
> > util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
> > util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
> > util-obj-y += control.o
> > util-obj-y += qmp.o
> > 
> > With the introduction of libqemutrace.a, I believe these should be moved
> > into libqemutrace.a.
> 
> Agreed,
> But it doesn't solve infinite recursion issue. register_module_init is 
> needed by libqemutrace.a, which is defined util/module.c.
> 
> it is hard to remove libqemutrace.a dependency on libqemuutil.a.
> 
> Removing libqemuutil.a dependency on libqemutrace.a is feasible.
> Just like what I did in this patch, include all util related trace.o 
> to libqemuutila.
> 
> The other simple way is to include all trace.o into libqemuutil.a

Yeah, I'd suggest doing that - i don't see any benefit in having
them in a separate libqemutrace.a


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
