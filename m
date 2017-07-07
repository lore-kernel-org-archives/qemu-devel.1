Received: from eggs.gnu.org ([2001:4830:134:3::10]:44286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTXpn-0008J9-Rw
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTXpj-0006iD-Px
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dTXpj-0006hQ-Jz
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:18:27 -0400
Date: Fri, 7 Jul 2017 20:18:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170707201820.5db54aa1@Igors-MacBook-Pro.local>
In-Reply-To: <20170707150956.GZ12152@localhost.localdomain>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<20170707131300.GG10776@localhost.localdomain>
	<20170707165817.1a0103c1@nial.brq.redhat.com>
	<20170707150956.GZ12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On Fri, 7 Jul 2017 12:09:56 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Jul 07, 2017 at 04:58:17PM +0200, Igor Mammedov wrote:
> > On Fri, 7 Jul 2017 10:13:00 -0300
> > "Eduardo Habkost" <ehabkost@redhat.com> wrote:
> [...]
> > > I don't disagree with adding the assert(), but it looks like
> > > making fw_cfg_find() return NULL if there are multiple devices
> > > can be useful for realize.
> > > 
> > > In this case, it looks like Mark is relying on that in
> > > fw_cfg_common_realize(): if multiple devices are created,
> > > fw_cfg_find() will return NULL, and realize will fail.  This
> > > sounds like a more graceful way to handle multiple-device
> > > creation than crashing on fw_cfg_find().  This is the solution
> > > used by find_vmgenid_dev()/vmgenid_realize(), BTW.
> > 
> > I suspect that find_vmgenid_dev() works by luck as it could be
> > placed only as /machine/peripheral-anon/foo1 or /machine/peripheral/foo2
> >   object_resolve_partial_path() : machine
> >            object_resolve_partial_path() : peripheral-anon => foo1
> >            object_resolve_partial_path() : peripheral => foo2
> >            if (found /* foo2 */) {
> >                if (obj /* foo1 */) {
> >                    return NULL;
> 
> I don't think this is luck: object_resolve_partial_path() is
> explicitly documented to always return NULL if multiple matches
> are found, and I don't see any bug in its implementation that
> would break that functionality.

Maybe I'm reading it wrong, but consider following:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg460692.html

it looks to me that using ambiguous argument is necessary for duplicate detection to work correctly.

> 
