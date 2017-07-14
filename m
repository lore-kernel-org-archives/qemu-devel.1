Received: from eggs.gnu.org ([2001:4830:134:3::10]:40810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW2hd-00074G-4Q
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW2hY-0005Vw-5Z
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dW2hX-0005VW-VJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:40:20 -0400
Date: Fri, 14 Jul 2017 12:40:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170714154010.GC6020@localhost.localdomain>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712145121.GF6020@localhost.localdomain>
	<20170712181652-mutt-send-email-mst@kernel.org>
	<20170712201550.GN6020@localhost.localdomain>
	<20170712232214-mutt-send-email-mst@kernel.org>
	<20170712205646.GQ6020@localhost.localdomain>
	<20170713003116-mutt-send-email-mst@kernel.org>
	<91a1c7c2-0e87-4023-c960-5078267abf95@redhat.com>
	<20170713151740.GR6020@localhost.localdomain>
	<20170714013246-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714013246-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jul 14, 2017 at 01:41:58AM +0300, Michael S. Tsirkin wrote:
> On Thu, Jul 13, 2017 at 12:17:40PM -0300, Eduardo Habkost wrote:
> > > > Oh right. So you need to find dots and split at these points.
> > > > Something like the below? Completely untested.
> > > > 
> > > > int mstcmp(const char *s1, const char *s2)
> > > > {
> > > > 	const char *e1, *e2;
> > > >  	int l1, l2, c;
> > > > 
> > > > 	do {
> > > > 		e1 = strchr(s1, '.');
> > > > 		e2 = strchr(s2, '.');
> > > > 
> > > > 		l1 = e1 ? e1 - s1 + 1 : strlen(s1);
> > > > 		l2 = e2 ? e2 - s2 + 1 : strlen(s2);
> > > > 
> > > > 		/* compare numerically: shorter strings give smaller numbers */
> > > > 		if (l1 != l2) {
> > > > 			break;
> > > > 		}
> > > > 		c = strncmp(s1, s2, l1);
> > > > 		if (c) {
> > > > 			return c;
> > > > 		}
> > > > 		s1 += l1;
> > > > 		s2 += l1;
> > > > 	} while (l1);
> > > > 
> > > > 	return l1 - l2;
> > > > }
> > 
> > I believe copying strverscmp() from gnulib as-is is better than
> > reimplementing a subset of it.
> 
> I would then probably copy it unconditionally.

That's probably what I will do.  Saving a few bytes in the QEMU
binary is probably not worth the extra ./configure cruft.

-- 
Eduardo
