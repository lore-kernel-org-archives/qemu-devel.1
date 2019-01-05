Received: from eggsout.gnu.org ([209.51.188.92]:53630 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfbwP-00044J-NP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 21:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfbwM-0002c2-JE
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 21:44:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gfbwM-0002bF-Bl
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 21:43:58 -0500
Date: Sat, 5 Jan 2019 00:43:51 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190105024350.GO4157@habkost.net>
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
	<20181210171845.4f132e25@Igors-MacBook-Pro.local>
	<61558042-beba-3a2a-b3de-c39faf8cc078@samsung.com>
	<20181211164823.6d048a83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211164823.6d048a83@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ilya Maximets <i.maximets@samsung.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 11, 2018 at 04:48:23PM +0100, Igor Mammedov wrote:
> On Tue, 11 Dec 2018 13:29:19 +0300
> Ilya Maximets <i.maximets@samsung.com> wrote:
> 
> CCing libvirt folk for an opinion
> 
> > On 10.12.2018 19:18, Igor Mammedov wrote:
> > > On Tue, 27 Nov 2018 16:50:27 +0300
> > > Ilya Maximets <i.maximets@samsung.com> wrote:
> > > 
> > > s/wihtout/without/ in subj
> > >   
> > >> If seals are not supported, memfd_create() will fail.
> > >> Furthermore, there is no way to disable it in this case because
> > >> '.seal' property is not registered.
> > >>
> > >> This issue leads to vhost-user-test failures on RHEL 7.2:
> > >>
> > >>   qemu-system-x86_64: -object memory-backend-memfd,id=mem,size=2M,: \
> > >>                       failed to create memfd: Invalid argument
> > >>
> > >> and actually breaks the feature on such systems.
> > >>
> > >> Let's restrict memfd backend to systems with sealing support.
> > >>
> [...]
> > >> @@ -177,7 +175,7 @@ static const TypeInfo memfd_backend_info = {
> > >>  
> > >>  static void register_types(void)
> > >>  {
> > >> -    if (qemu_memfd_check(0)) {
> > >> +    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
> > >>          type_register_static(&memfd_backend_info);  
> > > that would either lead to not clear error that type doesn't exist.
> > > it could be better to report sensible error from memfd_backend_memory_alloc() if
> > > the feature is required but not supported by host   
> > 
> > I'm not sure, but this could break the libvirt capability discovering.
> > 
> > Current patch changes behaviour probably only for RHEL/CentOS 7.2.
> > All other systems are not affected. Do you think that we need to
> > change behaviour on all the systems?
> you are changing behavior anyways, so when users start getting
> on some of 'All other systems' start getting 'type doesn't exist'
> error, they won't have a clue what's wrong. In case where we are
> fixing broken defaults, shouldn't we at least do it the way that
> would inform user about misconfiguration.
> 
> But I'm not insisting since memfd is fairly new, it might be fine
> for device to just disappear.

(Sorry for taking so long to reply on this series.  I couldn't
review the code yet.)

I'd like to make the QOM type hierarchy static, and not depend on
any runtime host capability checks.  But this is not a new
problem in the code, so I don't think it should block this
series.

-- 
Eduardo
