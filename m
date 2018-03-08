Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etyjT-0008KS-9o
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etyjP-0007Bk-KK
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:49:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etyjP-0007BQ-E4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:49:27 -0500
Date: Thu, 8 Mar 2018 16:49:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308164910.GF4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-9-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308124901.83533-9-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v12 08/28] target/i386: add Secure
 Encrypted Virtulization (SEV) object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 08, 2018 at 06:48:41AM -0600, Brijesh Singh wrote:
> Add a new memory encryption object 'sev-guest'. The object will be used
> to create enrypted VMs on AMD EPYC CPU. The object provides the properties
> to pass guest owner's public Diffie-hellman key, guest policy and session
> information required to create the memory encryption context within the
> SEV firmware.
> 
> e.g to launch SEV guest
>  # $QEMU \
>     -object sev-guest,id=sev0 \
>     -machine ....,memory-encryption=sev0
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>


> diff --git a/qemu-options.hx b/qemu-options.hx
> index 4c280142c52c..6113bce08a8c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4353,6 +4353,50 @@ contents of @code{iv.b64} to the second secret
>           data=$SECRET,iv=$(<iv.b64)
>  @end example
>  
> +@item -object sev-guest,id=@var{id},cbitpos=@var{cbitpos},reduced-phys-bits=@var{val},[sev-device=@var{string},policy=@var{policy},handle=@var{handle},dh-cert-file=@var{file},session-file=@var{file}]
> +
> +Create a Secure Encrypted Virtualization (SEV) guest object, which can be used
> +to provide the guest memory encryption support on AMD processors.
> +
> +When memory encryption is enabled, one of the physical address bit (aka the
> +C-bit) is utilized to mark if a memory page is protected. The @option{cbitpos}
> +is used to provide the C-bit position. The C-bit position is Host family dependent
> +hence user must provide this value. On EPYC, the value should be 47.
> +
> +When memory encryption is enabled, we loose certain bits in physical address space.
> +The @option{reduced-phys-bits} is used to provide the number of bits we loose in
> +physical address space. Similar to C-bit, the value is Host family dependent.
> +On EPYC, the value should be 5.

Is it valid to specify a different value for either of these properties ?
eg what happens if I pass cbitpos=45 instead of 47 on an EPYC host ?

In particular I thinking about possible migration scenario, where EPYC
uses 47 by default but some $NEXT AMD CPU uses 48 by default. In that
case we might want to use '47' on both CPUs if we need ability to live
migrate between different host CPU generations. Would that be valid ?

On the flip side, if the value really it strictly tied to the host
CPU family and no deviation is permitted, could the kernel not just
pick the right value automatically avoiding the config option ?



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
