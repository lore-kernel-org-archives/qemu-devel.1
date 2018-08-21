Received: from eggs.gnu.org ([2001:4830:134:3::10]:51243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fsCHS-0006VB-Ev
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 15:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fsCHN-0003Xw-7K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 15:25:30 -0400
Date: Tue, 21 Aug 2018 16:25:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180821192518.GL18995@localhost.localdomain>
References: <20180817013400.13353-1-ehabkost@redhat.com>
	<20180817013400.13353-9-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817013400.13353-9-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 8/8] i386: Disable TOPOEXT by default on
 "-cpu host"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-stable@nongnu.org

CCing qemu-stable.

On Thu, Aug 16, 2018 at 10:34:00PM -0300, Eduardo Habkost wrote:
> Enabling TOPOEXT is always allowed, but it can't be enabled
> blindly by "-cpu host" because it may make guests crash if the
> rest of the cache topology information isn't provided or isn't
> consistent.
> 
> This addresses the bug reported at:
> https://bugzilla.redhat.com/show_bug.cgi?id=1613277
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Message-Id: <20180809221852.15285-1-ehabkost@redhat.com>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 52a77a7d08..4e4fe8fa8b 100644
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
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 
> 

-- 
Eduardo
