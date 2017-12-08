Received: from eggs.gnu.org ([2001:4830:134:3::10]:36608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eNMVR-0000F2-6M
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eNMVM-0006iq-G7
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:32:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eNMVM-0006iZ-A3
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:32:08 -0500
Date: Fri, 8 Dec 2017 18:32:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171208183203.2d11374b@redhat.com>
In-Reply-To: <20171208161422.GW3037@localhost.localdomain>
References: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
	<20171207174832.42663bef@redhat.com>
	<CAFEAcA9o-LyKZBZwSoz3SSPCY-sjo9e011UWy1=EwJ4U9rWYsg@mail.gmail.com>
	<20171207170719.GT3037@localhost.localdomain>
	<CAFEAcA9fzkedj_VLeTaK-WOTLGk1RinyadRmR5FaJ44KOAQU3w@mail.gmail.com>
	<CAFEAcA9Uh9f3UddCNiB3u6BD9Qg=sUMDmMYYn1+sryiJUMOFYg@mail.gmail.com>
	<20171208141618.11e60846@redhat.com>
	<CAFEAcA8Gc1XQVYR9+_uD7Be3WSDE5tzxVAuJNBTokb3HdJ6fHw@mail.gmail.com>
	<20171208155050.1a6db1c2@redhat.com>
	<20171208161422.GW3037@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] in a device or CPU instance init/realize,
 can I rely on something having the BQL or equivalent?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 8 Dec 2017 14:14:22 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Dec 08, 2017 at 03:50:50PM +0100, Igor Mammedov wrote:
> > On Fri, 8 Dec 2017 13:19:27 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> > > On 8 December 2017 at 13:16, Igor Mammedov <imammedo@redhat.com> wrote:  
> > > > TBH:
> > > >  I do not recall why we have x86 max/host cpu types do feature
> > > >  loading at realize time instead of at class init like the rest
> > > >  of static cpu types.    
> > > 
> > > class init is too early, IIRC -- it's before KVM has been set up at all.  
> > 
> > that shouldn't be an issue as kvm_ppc_register_host_cpu_type() demonstrates
> > (i.e. an additional class init at kvm/tcg init time),  
> 
> It is possible, but IMO it's not a good idea.  We should be able
> to enumerate all CPU types before the accelerator has been
> initialized, so query-cpu-definitions and "-cpu help" will always
> work.
> 
> 
> > 
> > so it might be some compat issue or just legacy approach why it
> > havn't been rewritten to class_init for x86 the way PPC does.
> > But Eduardo probably knows better if there is anything left that
> > prevents using class init there.  
> 
> It's the opposite: x86 "host" CPU model used to work the same way
> as PPC, but we changed it so all classes are registered at
> type_init()-time.
Is it for libvirt convenience, so that it would be able to cache
all supported cpus regardless of whether they would actually work
or not?
