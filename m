Received: from eggs.gnu.org ([2001:4830:134:3::10]:36792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dRyfv-0000CK-Sx
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dRyfs-000663-3f
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dRyfr-00065b-Qr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:33:48 -0400
Date: Mon, 3 Jul 2017 11:33:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170703103340.GF5663@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-2-git-send-email-yang.zhong@intel.com>
	<20170703102043.GE5663@redhat.com>
	<68cbc479-3707-cdab-4dcd-d055b02ede7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68cbc479-3707-cdab-4dcd-d055b02ede7d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/15] configure: add the disable-tcg
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On Mon, Jul 03, 2017 at 12:25:36PM +0200, Paolo Bonzini wrote:
> 
> 
> On 03/07/2017 12:20, Daniel P. Berrange wrote:
> >>  
> >> +if test "$tcg" = "no"; then
> >> +   for target in $target_list; do
> >> +      if test "$softmmu" = "yes"; then
> >> +        case $target in
> >> +           i386-softmmu|x86_64-softmmu)
> >> +           ;;
> >> +        *)
> >> +           error_exit "The current $target can't support disable-tcg,"\
> >> +              "only i386-softmmu|x86_64-softmmu support disable-tcg"
> >> +           ;;
> > This looks too simplistic in its logic.
> > 
> > You can disable TCG, if-and-only-if the system emulator supports KVM.
> > 
> > KVM is supported on many architectures, not only x86-64 & i386.
> > 
> > KVM is only supported if the guest emulator architecture matches the
> > host build target architecture.
> > 
> > ie if you are building an x86_64 system emulator on a PPC64 host,
> > then you can't disable TCG.
> > 
> > So this needs rewriting to *not* special case x86_64 / i386. Instead
> > you need to compare & match build target / system emulator architectures,
> > across all architectures supporting KVM.
> 
> i386-softmmu and x86_64-softmmu are singled out here, because they're
> the only targets where --disable-tcg compiles.  For the others, more
> work is needed (see patches 6-15 in Yang Zhong's series).

Even with that, you still can't disable TCG if building on a non-x86
host, since that'd leave you with no available CPU at all. So the
code still needs refactoring to check architectures properly.

> The part that is missing in this patch is disabling non-hypervisor
> targets when --disable-tcg is specified.  My original patch built only
> i386-softmmu and x86_64-softmmu if you specified --disable-tcg, see
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2012-09/msg02570.html
> https://lists.nongnu.org/archive/html/qemu-devel/2012-09/msg02571.html

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
