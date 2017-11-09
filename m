Received: from eggs.gnu.org ([2001:4830:134:3::10]:53151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCsge-0006tR-Ij
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCsgZ-0003cK-Ec
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:40:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eCsgZ-0003bs-7s
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:40:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35423680EE
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 19:40:22 +0000 (UTC)
Date: Thu, 9 Nov 2017 17:40:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171109194007.GE3111@localhost.localdomain>
References: <20171108144809.56305-1-marcel@redhat.com>
	<bb3fdd1b-a1bf-51cf-284c-69eedef0ccde@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb3fdd1b-a1bf-51cf-284c-69eedef0ccde@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V3] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

On Thu, Nov 09, 2017 at 12:02:10PM +0100, Laszlo Ersek wrote:
[...]
> (3) An idea for the property defaults: you remove
> DEFAULT_PCI_HOLE64_SIZE, which is cool. How about introducing (in the
> proper header files)
> 
> #define DEFAULT_I440FX_PCI_HOLE64_SIZE (1ULL << 31)
> #define DEFAULT_Q35_PCI_HOLE64_SIZE    (1ULL << 35)
> 
> The main reason for my suggestion is that (1ULL << 35) is used twice in
> the code, for an obscure qdev/qom reason. The comments definitely help,
> so keep them, but a greppable macro would help even more, IMO.
> 
> And, once we add DEFAULT_Q35_PCI_HOLE64_SIZE, we should add
> DEFAULT_I440FX_PCI_HOLE64_SIZE too, for consistency.

Agreed, especially considering how the code that initializes the
defaults is non-obvious.

> 
> Anyway, I'll leave this up to you as well.

If we do that, I recommend adding a bigger warning to
q35_host_props.  The one in this patch is very easy to miss if
people try to touch the defaults for other mch.* properties in
the future.  I suggest something like:

    /*
     * NOTE: setting defaults for the mch.* fields in this table
     * don't work, because mch is a separate QOM object that is
     * zeroed by the object_initialize(&s->mch, ...) call inside
     * q35_host_initfn().  The default values for those
     * properties need to be initialized manually by
     * q35_host_initfn() after the object_initialize() call.
     */


> 
> 
> (4) I also have a suggestion for the commit message: please move the
> paragraph that starts with
> 
>   "Even if the new defaults..."
> 
> from the v2->v3 changelog to the commit message proper. IMO it is
> important information.
> 
> 
> With (4) addressed:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks!
> Laszlo

-- 
Eduardo
