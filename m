Received: from eggs.gnu.org ([2001:4830:134:3::10]:39356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5X4v-0002YS-3f
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5X4r-0006HZ-R0
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:38:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d5X4r-0006HA-Hc
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:38:49 -0400
Date: Tue, 2 May 2017 13:38:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170502123842.GM3459@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
	<f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
	<df5e01ee-a97f-7e28-9f95-840654bf48a5@de.ibm.com>
	<7c69341a-9584-8208-023a-42bfeeec6dee@redhat.com>
	<20170502115953.GJ3459@redhat.com>
	<69beede1-b218-2e8f-e2b7-b8225cf75a87@redhat.com>
	<20170502121633.GK3459@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170502121633.GK3459@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Vincent Palatin <vpalatin@chromium.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 02, 2017 at 01:16:33PM +0100, Daniel P. Berrange wrote:
> On Tue, May 02, 2017 at 02:07:15PM +0200, Thomas Huth wrote:
> > On 02.05.2017 13:59, Daniel P. Berrange wrote:
> > > On Tue, May 02, 2017 at 01:26:17PM +0200, Thomas Huth wrote:
> > >> On 02.05.2017 12:48, Christian Borntraeger wrote:
> > >>> On 05/02/2017 12:37 PM, Thomas Huth wrote:
> > >>>> On 02.05.2017 12:32, Christian Borntraeger wrote:
> > >>>>> On 05/02/2017 12:06 PM, Thomas Huth wrote:
> > >>>>>> The '-enable-...' option do not make too much sense: They do not
> > >>>>>> allow additional parameters, using '-accel xxx' is shorter than
> > >>>>>> '-enable-xxx' and we're also inconsistent here, since there is
> > >>>>>> no '-enable-xen' option available. So let's try to convince the
> > >>>>>> users to use '-accel xxx' instead.
> > >>>>>
> > >>>>> google has 36000 hits for "--enable-kvm" and 18000 hits for "--accel kvm"
> > >>>>> So I assume this will affect a lot of setups for only a very small benefit.
> > >>>>
> > >>>> I'm aware of the fact that likely a lot of users are still using
> > >>>> -enable-kvm, and I did not mean that we should remove it soon yet. But
> > >>>> IMHO we should start now to inform the users that they should slowly
> > >>>> switch to the better option "-accel" instead, so that we could maybe
> > >>>> remove this "-enable-xxx" stuff sometime in the distant future (let's
> > >>>> say QEMU v4.0?).
> > >>>
> > >>> I come from the Linux side, where "breaking a working setup" will result in
> > >>> an angry Linus.
> > >>
> > >> IMHO that's a good approach, but I think it should primarily applied for
> > >> the interfaces that are designed as "API" to other software layers, i.e.
> > >> things like QMP and the "-machine" parameter.
> > >> "-enable-kvm" is in my eyes rather a "syntactic sugar" convenience
> > >> option, so I'd not apply this rule to this option.
> > >>
> > >>> We certainly have not such strict rules here and we could
> > >>> base the decision on the question "how expensive is the maintenance
> > >>> of this option?". I think marking it as "legacy option" is fine, but I doubt
> > >>> that removing it will make qemu maintenance cheaper.
> > >>
> > >> Likely not. Actually, I have another point of view in mind here: You
> > >> have to consider that QEMU has a *lot* of options, and I think this is
> > >> very confusing for the users, especially the new ones. If we always
> > >> provide two or three ways to achieve a goal, especially in an
> > >> inconsistent way like we do it here, we likely rather create frustration
> > >> than joy for the normal users. Providing a clean, straightforward CLI
> > >> interface one day could help to improve the user experience quite a bit.
> > > 
> > > The issue is that we have mutually exclusive requirements here. For a
> > > straightforward, easy to understand CLI, things like "--enable-kvm" are
> > > much quicker to discover & understand than "-machine accel=kvm". The
> > > latter gives much more flexibility since it can set all the other opts,
> > > but most of those are rarely used by people who are invoking QEMU
> > > manually/directly. We need the things like -machine for libvirt and
> > > similar, but they are not end user friendly. Killing all the shortcuts
> > > like --enable-kvm would cut down the args we expose, but forcing users
> > > onto more complex syntax for args like -machine is not improving their
> > > lives in general if they don't need that extra flexibility.
> > 
> > Theoretically yes, but in this case we also have the "-accel kvm" option
> > which is IMHO also straighforward and easy to understand, and even
> > shorter than "-enable-kvm". If you look at my patch, I did *not* want to
> > force the normal users to use "-machine accel=kvm" here, so I don't see
> > the point of your argument here.
> 
> Just looking at the -help output though we have
> 
>   "-machine [type=]name[,prop[=value][,...]]
>                    property accel=accel1[:accel2[:...]] selects accelerator
>                    supported accelerators are kvm, xen, tcg (default: tcg)"
> 
> and
> 
>   "-enable-kvm     enable KVM full virtualization support"
> 
> but the "-accel" option is not documented, so essentially doesn't exist,
> unless you read the man page to see if there are other secret options
> listed there. So from -help output, "-enable-kvm" looks like the best
> option to pick from a novice user POV.

Opps, I was looking at wrong QEMU binary - it is listed

   "-accel [accel=]accelerator[,thread=single|multi]
               select accelerator ('-accel help for list')"

but it doesn't mention KVM, so I still think -enable-kvm is the more obvious
right answer based on what we're telling users in help


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
