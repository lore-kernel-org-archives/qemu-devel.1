Received: from eggs.gnu.org ([2001:4830:134:3::10]:34591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gJeCs-0003od-VF
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gJeCp-0003iX-JX
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:42:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gJeCp-0003fY-A5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:42:11 -0500
Date: Mon, 5 Nov 2018 07:42:09 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <1678079774.40522989.1541421729839.JavaMail.zimbra@redhat.com>
In-Reply-To: <1541420337.16655.496.camel@redhat.com>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
	<1540208764.16655.240.camel@redhat.com>
	<1541087251.16655.419.camel@redhat.com>
	<20181105065258.4mpdv5w4rp3eui5p@sirius.home.kraxel.org>
	<1541420337.16655.496.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH spice v2 1/2] QXL interface: add
 functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

> On Mon, 2018-11-05 at 07:52 +0100, Gerd Hoffmann wrote:
> > > 2. Have a single function as follows:
> > > 
> > > void spice_qxl_set_device_info(QXLInstance *instance,
> > >                                const char *device_address,
> > >                                uint32_t device_display_id_start,
> > >                                uint32_t device_display_id_count);
> > 
> > How about:
> > 
> > void spice_qxl_set_device_info(QXLInstance *instance,
> >                                const char *device_address,
> >                                uint32_t device_display_id);
> > 
> > I don't think we need start+count:
> > 
> >  * For single-head devices device_display_id will be zero.
> >  * For one-channel-per-head multihead devices (i.e. virtio-gpu)
> >    device_display_id will enumerate the heads (so everybody can figure
> >    which channel is which head).
> >  * For one-channel-per-device multihead devices (i.e. qxl/linux)
> >    device_display_id will be zero too.  Number of heads is set via
> >    spice_qxl_set_max_monitors().
> 
> That requires nontrivial and unexpected logic for the one-channel-per-
> device multihead devices case. The API should be doing what it says and
>  the dumber the better, this seems too smart to me...
> 
> That said, I don't find it significantly worse than the other options
> (none of which seems great), so I'd just like we reached some consesus
> and be done with it...
> 
> Cheers,
> Lukas
> 
> > cheers,
> >   Gerd
> > 

Personally I prefer the single function API, either with or without count.

About the not trivial for compatibility you'll have to support Qemu versions
that either:
- does not call new APIs or spice_qxl_set_max_monitors. A QXL card will have
  the maximum possible number of monitors in the guest;
- does not call new APIs but call spice_qxl_set_max_monitors. A QXL card will
  have a maximum of monitor specified by spice_qxl_set_max_monitors in the
  guest;
- call new APIs (the choice in this case to call spice_qxl_set_max_monitors
  or not is yours).

Frediano
