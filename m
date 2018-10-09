Received: from eggs.gnu.org ([2001:4830:134:3::10]:43410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9sv6-0007oS-QJ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9sut-0005fU-Uj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9suq-0005eE-10
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:23:16 -0400
Date: Tue, 9 Oct 2018 15:23:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181009142309.GH22838@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
	<875zybzdzm.fsf@dusky.pond.sub.org>
	<87zhvntg6k.fsf@dusky.pond.sub.org>
	<20181009154312.771c276a.cohuck@redhat.com>
	<CAFEAcA-EV4YO7TtTqC74LfeLnceM7nphxsYc7WT9nPWTdap22g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-EV4YO7TtTqC74LfeLnceM7nphxsYc7WT9nPWTdap22g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Oct 09, 2018 at 02:58:41PM +0100, Peter Maydell wrote:
> On 9 October 2018 at 14:43, Cornelia Huck <cohuck@redhat.com> wrote:
> > I'm not sure why a single accelerator (any of them) would be a good
> > default. A list (tcg:kvm:<whatever>) sounds much saner, as it would
> > continue to work even if some accelerators have been disabled (right?)
> >
> > (And I'd prefer kvm to be first in that list; anything that relies on
> > tcg being used should specify it explicitly... a normal user will
> > likely always want the fast variant.)
> 
> tcg should be the default for binaries without KVM compiled in,
> of course... But as Thomas points out, the reason for our current
> default is the usual "because we tend not to change things that
> would break existing working command lines".

Putting KVM first shouldn't break existing working command lines
in general.

If user doesn't have KVM it won't have any impact as it'll still
fallback to TCG. If user does have KVM, their VMs will be faster. 

It could conceivably break if

  - TCG had some different behaviour to KVM that
    the guest relied upon (we should fix such differences)
  - KVM kmod was buggy (eg broken nested virt, again should be
    something we fix)
  - If the guest OS relied on things being slow (that's already
    fragile)

IMHO we should assume that TCG & KVM are functionally equivalent
and non-broken, and thus changing default accelerator should not
be considered an incompatible change.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
