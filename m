Received: from eggs.gnu.org ([2001:4830:134:3::10]:37912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTTdp-0000Du-3h
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTTdl-00040p-U4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTTdl-00040c-Kk
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:49:49 -0400
From: "Eduardo Habkost" <ehabkost@redhat.com>
Date: Fri, 7 Jul 2017 10:49:40 -0300
Message-ID: <20170707134940.GI10776@localhost.localdomain>
References: <1499237876.3041.4.camel@linux.intel.com>
	<20170705110431.GE22008@redhat.com>
	<20170705114411.GE29382@lemon.lan>
	<c1f43fc3-7db8-50af-ee8c-331895721bd6@redhat.com>
	<20170705122200.GH29382@lemon.lan>
	<20170706104940.GJ3988@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706104940.GJ3988@redhat.com>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, Thomas Huth <thuth@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, qemu-devel@nongnu.org

On Thu, Jul 06, 2017 at 11:49:40AM +0100, Daniel P. Berrange wrote:
> On Wed, Jul 05, 2017 at 08:22:00PM +0800, Fam Zheng wrote:
> > On Wed, 07/05 13:58, Thomas Huth wrote:
> > > On 05.07.2017 13:44, Fam Zheng wrote:
> > > > On Wed, 07/05 12:04, Daniel P. Berrange wrote:
> > > >> While you can say people should just add '-M pc' that isn't a nice
> > > >> user experiance, because it makes the assumption that people actually
> > > >> understand what caused their breakage. When the incompatibilities
> > > >> arise the error messages are unlikely to give any hint to users that
> > > >> the problems are caused by the machine type change. So unless someone
> > > >> is very familiar with debugging QEMU, they're not going to realize
> > > >> that '-M pc' will fix their problem.
> > > > 
> > > > While we change the default, can we start to print a message like 'machine type
> > > > ("-M" option) not specified, default to Q35. If you find compatibility issues,
> > > > try "-M pc"'?
> > > 
> > > Or we could simply remove the default machine type completely for a
> > > couple of releases? That would force people to update their script with
> > > "-M pc" ... and once this has been established, we can finally make q35
> > > the default?
> > 
> > I wouldn't do that.. Defaults are for those who don't care about setting it, or
> > want something that just works, by default. It's fine not to provide a default
> > machine type if we decide there isn't a clear win, just like arm, but IMHO
> > removing it just to restore it later in order to educate people makes a very
> > poor experience.
> 
> Since the idea of removing the default machine type was brought up, we should
> perhaps consider that as a distinct solution. Going from using 'pc' by defailt
> to having no default machine type, has significantly better user experiance
> than changing the default machine to 'q35' IMHO.
> 
> eg if we killed the default, currently QEMU would say something like
> 
>    qemu-system-x86_64: No machine specified, and there is no default
>    Use -machine help to list supported machines
> 
> We could augment that with further details:
> 
>    qemu-system-x86_64: No machine specified, and there is no default
>    Use -machine help to list supported machines
> 
>    For compatibility with previous releases of QEMU, pick the 'pc'
>    machine type. New deployments are suggested to use the 'q35'
>    machine type.
> 
> This avoids the user having problems with guest ABI silently changing
> behind their back, or migration suddenly failing to load vm state,
> and gives them clear immediate guidance on how to resolve the problem
> they're facing, as well as encouraging usage of 'q35' going forward,
> without having to actually make it the default.

Won't this make things more fragile for libvirt, as it would
fallback to the first machine-type on the list?  If we
inadvertently change the order of the list in QEMU, it could
break users' setups.

Or it would be feasible for libvirt to also stop choosing a
default if there's no clear winner?

-- 
Eduardo
