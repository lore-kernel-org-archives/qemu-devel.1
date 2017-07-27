Received: from eggs.gnu.org ([2001:4830:134:3::10]:54514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dafMy-000346-Bu
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dafMv-0001B6-6C
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dafMu-0001Ab-Sq
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:09 -0400
Date: Thu, 27 Jul 2017 11:46:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727114603.77b801e2@gondolin>
In-Reply-To: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Channel Path realted CRW generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

On Thu, 27 Jul 2017 03:54:15 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> This series is trying to:
> 1. clear up CRW related code.
> 2. generate the right channel path related CRW at the right time.
> 
> I did this mainly because it's a requirement from my current work, that is I'm
> in preparation of a group of patch for channel path virtualization. I can use
> the inerface that provided by this series later, so as to, for vfio-ccw
> devices, notify the guest with channel path status vary that happens on the
> host side.

Sounds cool.

> 
> During an internal discussion, Halil and Pierre pointed out that for path
> hotplug, generating a CRW seems logical, but how is it covered by the AR is not
> clear - we have problem in understanding some grammar ambiguous paragraphs.
> While certain parts of the AR is not available outside, but I'm still wondering
> if the author ;) could give us some clue... BTW, we know that, in Linux kernel
> we had code that handles un-solicited chp crw, so we tend to believe it's right
> to generate channel path initialized CRW for path hotplug. It's just we can not
> find the reason from the document.

I always found path notifications to be a bit odd. They depend on
various things:
- whether you're running under LPAR or under z/VM
- whether it's a hardware condition (path failure) or something
  triggered by the admin (path vary on/off)
- if it's admin triggered, where it was done (on the SE, by one of
  several mechanisms in CP, via SCLP)

You're bound to get different kinds of notifications: via a CRW with
source channel path, via event information retrievable via CHSC
(indicated by a CRW with source CSS), via a PNO indication, or nothing
at all.

[Reminds me of a case where we got path gone CRWs under LPAR when a
path was deactivated at the SE (which we would notice via PNO anyway),
but no CRW when the path was reactivated - not very useful. When trying
to report this as an issue, we got the answer that we of course need to
use the OS interface to vary off the path beforehand. Silly penguins.]

My recommendation would be to generate a fitting CRW if the wording
allows to do so. I would hope that getting as many useful indications
as possible is most helpful to the OS. (I had added the path-come CRW
handling in Linux back then and afterwards wondered why we did not get
it - I must have interpreted the PoP in the same way as you did.)

I'll double check with how I'd interpret the PoP today.

> 
> Pierre also suggested to add an @erc param for css_generate_chp_crws() in patch3,
> while others have a different opinion. This is for your consideration.
> 
> Best regards!
> 
> Dong Jia Shi (3):
>   s390x/css: use macro for event-information pending error recover code
>   s390x/css: generate solicited crw for rchp completion signaling
>   s390x/css: generate channel path initialized CRW for channel path
>     hotplug
> 
>  hw/s390x/3270-ccw.c       |  3 ++-
>  hw/s390x/css.c            | 66 +++++++++++++++++++++++++++++++++++------------
>  hw/s390x/s390-ccw.c       |  2 +-
>  hw/s390x/virtio-ccw.c     |  3 ++-
>  include/hw/s390x/css.h    | 10 ++++---
>  include/hw/s390x/ioinst.h |  6 +++--
>  6 files changed, 64 insertions(+), 26 deletions(-)
> 
