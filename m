Received: from eggs.gnu.org ([2001:4830:134:3::10]:35753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fo22u-0005vz-JX
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fo22r-0007qS-Eu
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fo22r-0007q9-8F
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:41:13 -0400
Date: Fri, 10 Aug 2018 08:41:10 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180810074110.GD1455@redhat.com>
References: <20180809221852.15285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809221852.15285-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Disable TOPOEXT by default on "-cpu
 host"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Babu Moger <babu.moger@amd.com>

On Thu, Aug 09, 2018 at 07:18:52PM -0300, Eduardo Habkost wrote:
> Enabling TOPOEXT is always allowed, but it can't be enabled
> blindly by "-cpu host" because it may make guests crash if the
> rest of the cache topology information isn't provided or isn't
> consistent.
> 
> This addresses the bug reported at:
> https://bugzilla.redhat.com/show_bug.cgi?id=1613277
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 723e02221e..3ac627978f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -849,6 +849,12 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .cpuid_eax = 0x80000001, .cpuid_reg = R_ECX,
>          .tcg_features = TCG_EXT3_FEATURES,
> +        /*
> +         * TOPOEXT is always allowed but can't be enabled blindly by
> +         * "-cpu host", as it requires consistent cache topology info
> +         * to be provided so it doesn't confuse guests.
> +         */
> +        .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
>      },
>      [FEAT_C000_0001_EDX] = {
>          .feat_names = {

Can confirm that this fixes the problem observed on the original AMD
Phenom machine, using qemu from git (@6ad908053) + your patch.
Therefore:

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
