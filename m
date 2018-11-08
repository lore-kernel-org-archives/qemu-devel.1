Received: from eggs.gnu.org ([2001:4830:134:3::10]:40561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKoZg-0004uo-DT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKoZZ-0003O8-F5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:58:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gKoZR-0003L8-S8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:58:24 -0500
References: <41ceda53-467e-32a1-8fa6-13f0f9c08ad1@redhat.com>
	<CAFEAcA9oCs+Y1fnY8dOR16n_Hn7PaHziL7K0HZK6=BAd_Gyecg@mail.gmail.com>
	<e496287e-f8ba-3608-42e1-efb697cfc784@redhat.com>
	<20181107154114.GC27585@caravaggio>
	<dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
	<20181108130648.GJ12503@habkost.net>
	<95a93d53-f87d-bd96-9363-582c4eae4160@redhat.com>
	<20181108171437.GM12503@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dda55f75-58d3-111c-4f43-99a9f686981e@redhat.com>
Date: Thu, 8 Nov 2018 18:58:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181108171437.GM12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 08/11/2018 18:14, Eduardo Habkost wrote:
> Keeping in mind that I might be talking about extra challenges we
> won't address right now (no cart before the horse), I have new
> questions:
> 
> Why you say backends are not a target configuration and
> accelerators are?  What's the definition of "target
> configuration"?

Something that affects the way

> Are we explicitly restricting the scope of this work to
> enabling/disabling device emulation code right now?  Why?  Why
> wouldn't we use kconfig to enable/disable simple backends with no
> host dependency like SLIRP?

I think it would be more confusing if some backends were to use kconfig
and some wouldn't.  We could certainly add something like

config VHOST_NET
    depends on HOST_LINUX
    default y

config SPICE
    depends on HAVE_SPICE_SERVER
    default Y

etc. but I think we agree it's more of a long term idea.

> Don't we want to make backends configurable per binary, too?
> e.g.: I would expect the default configuration for a NEMU-like
> binary to disable many backends.

Sure, we could do that.  However, right now you cannot have multiple
binaries for a single target, so you couldn't have one single build
include both a "full-blown" and a "reduced" x86 target.  Therefore,
including e.g. SLIRP in qemu-system-arm but not in qemu-system-x86_64
does not seem too interesting to me.  It would be different if you could
build qemu-system-arm, qemu-system-x86_64, qemu-system-x86_64-lite, etc.

Paolo

> 
>> It would surely be possible for configure to call into minikconf to
>> parse a configuration file and apply dependencies (do we actually have
>> dependencies across configure options?) or something like that, but
>> let's not put the cart before the horse...
> 
> Agreed.
> 
