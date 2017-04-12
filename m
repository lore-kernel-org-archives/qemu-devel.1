Received: from eggs.gnu.org ([2001:4830:134:3::10]:47977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cyAVK-0006VL-Ut
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cyAVJ-0004fM-K1
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:07:42 -0400
Date: Wed, 12 Apr 2017 01:07:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170412050732.GA10279@flamenco>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-11-git-send-email-cota@braap.org>
	<93ae643a-582f-8f1a-3f2a-63ae2d9261bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ae643a-582f-8f1a-3f2a-63ae2d9261bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/10] tb-hash: improve tb_jmp_cache hash
 function in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On Wed, Apr 12, 2017 at 11:46:47 +0800, Paolo Bonzini wrote:
> 
> 
> On 12/04/2017 09:17, Emilio G. Cota wrote:
> > +
> > +/* In user-mode we can get better hashing because we do not have a TLB */
> > +static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
> > +{
> > +    return (pc ^ (pc >> TB_JMP_CACHE_BITS)) & (TB_JMP_CACHE_SIZE - 1);
> > +}
> 
> What about multiplicative hashing?
> 
> 	return (uint64_t) (pc * 2654435761) >> 32;

I tested this one, taking the TB_JMP_CACHE_SIZE-1 lower bits of
the result:

  http://imgur.com/QIhm875

In terms of quality it's good (I profile hit rates and they're all
pretty good), but shift+xor are just so hard to beat: shift+xor
take 1 cycle each; the multiplication takes on my machine 3 or 4
cycles (source: Fog's tables).

Thanks,

		E.
