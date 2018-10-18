Received: from eggs.gnu.org ([2001:4830:134:3::10]:46587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gD53y-0007uA-NQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gD53v-0006VR-HK
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gD53v-0006TO-Au
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:57:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E66281F01
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 09:57:48 +0000 (UTC)
Date: Thu, 18 Oct 2018 11:57:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181018115742.7a5f840e@redhat.com>
In-Reply-To: <2890bcd3-1ebf-7b56-f99a-cadf9f8be7d8@redhat.com>
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
	<2890bcd3-1ebf-7b56-f99a-cadf9f8be7d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] call HotplugHandler->plug() as the last
 step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, 17 Oct 2018 13:40:00 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 16/10/2018 15:33, Igor Mammedov wrote:
> > TODO:
> >  remove usage of Error** from plug() callback, we need to factor out
> >  pre_plug part from plug() callbacks, before proceeding with it.
> >  DavidH has recently finished it for pc-dimm/memory_devices, cpus
> >  mostly have pre_plug parts factored out, but there still are parts
> >  that could fail so it needs some more work to eliminate failure points
> >  from plug() callbacks. Meanwhile, I'll plan to treat other misc
> >  handlers (pci[e]/acpi/usb/...) and introduce pre_plug() where
> >  necessary.  
> 
> I am not sure it's a good idea to do this first, rather than last (so
> that we risk introducing a ping-pong of bugs that appear now and are
> fixed when the other changes are made), but if others disagree I am okay
> with the patch.
It will take a time to cleanup Error** handling, but it's not
must have req for moving plug() handler to the right place,
even if error gets triggered on this patch ever it cleanly fails
device_realize().

I'm posting this first, so post_plug() won't confuse people and
won't introduce a new code that would depend on it or even worse
some plug handler would depend on plug() happening before reset.
This patch should prevent that from happening. (Error** concerns
are secondary here and I'll deal with it later on, hopefully
during 3.2 cycle)

PS:
 post_plug() is recurring idea which indicates that current plug()
 is misplaced. (previous instance that's slipped in, was nvdimm's
 75b0713e1 which was removed later on by c7f8d0f3a5).

[...]
