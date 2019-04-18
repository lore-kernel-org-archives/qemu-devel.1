Received: from eggs.gnu.org ([209.51.188.92]:48872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hH2im-0005xX-B7
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hH2il-0003iW-2A
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hH2ik-0003hI-QA
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:48:39 -0400
Date: Thu, 18 Apr 2019 09:48:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190418084825.GC13773@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
	<e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
	<20190417192610.GC19065@antique-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417192610.GC19065@antique-laptop>
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Hrdina <phrdina@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>, pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, rth@twiddle.net

On Wed, Apr 17, 2019 at 09:26:10PM +0200, Pavel Hrdina wrote:
> On Wed, Apr 17, 2019 at 10:53:04PM +0800, Pu Wen wrote:
> > On 2019/4/16 22:17, Pavel Hrdina wrote:
> > > On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> > > > Add a new base CPU model called 'Dhyana' to model processors from Hygon
> > > > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > > > 
> > > > The following features bits have been removed compare to AMD EPYC:
> > > > aes, pclmulqdq, sha_ni
> > > > 
> > > > The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> > > > So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> > > > CPU model.
> > > 
> > > I have once question that we will have to solve for EPYC CPUs as well.
> > > The name should not be based on the Product name or Model name as that
> > > usually doesn't change with introduction of new microarchitecture.
> > > 
> > > With EPYC we made a mistake to name the CPU like that, luckily with
> > > Intel we already use the microarchitecture name, so the EPYC CPU should
> > > have been named ZEN-Server and for Ryzen CPUs there should be ZEN-Client
> > > if there is any difference or otherwise we can simply use ZEN.
> > > 
> > > The issue here is what happens once the ZEN2 microarchitecture is out
> > > wihch introduces new features and we will have to come up with a CPU
> > > name.
> > > 
> > > Obviously we cannot change/remove the EPYC models so the question is
> > > what is the difference between the AMD EPYC CPU and this new Dhyana CPU
> > > if they are both based on the ZEN microarchitecture?
> > 
> > Right now there's no much difference between Dhyana and EPYC from the
> > software's view. Dhyana removed the instructions aes, pclmulqdq, sha_ni
> > compared to EPYC, but will have it's own implementation such as for aes in
> > future CPU models. Hygon also will implement something different from AMD in
> > the future.
> > 
> > > In addition is there any way how we can introduce ZEN-Server &
> > > ZEN-Client or simply ZEN, if there is no difference, as an alias or a
> > > new model next to the EPYC?
> > 
> > Also as Eduardo mentioned that there's no CPU model alias or inheritance
> > system in x86, so I think it's worthwhile to keep a separate CPU model for
> > Hygon.
> 
> So what happens once Zen2 is out and there are new Dhyana CPUs based on
> the Zen2 microarchitecture with some new features, what CPU models we
> will introduce, EPYC-G2 and Dhyana-G2, but that will not correspond to
> the CPU model anymore.
> 
> My idea was that we should probably introduce CPU model Zen-Server which
> could cover both EPYC and Dhyana as they are both based on the Zen
> microarchitecture.  The fact that Dhyana doesn't support all the
> features is not an issue as QEMU will not use them if they are not
> available on the host.

I don't think this is a good idea. AFAICT, Dhyana and EPYC should not be
thought of as the same microarchitecture. Dhyana is a fork of the Zen
microarchitecture as illustrated by the dropping of a number of CPU
features. The Dhyana SEV patches show that it has had other significant
changes, which are likely to require extra work in QEMU to support too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
