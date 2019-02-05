Received: from eggs.gnu.org ([209.51.188.92]:37483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gr4De-0004Vy-3J
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gr4Dd-0001mt-3V
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:09:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gr4Dc-0001ie-R3
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:09:09 -0500
References: <20190205151810.571-1-peter.maydell@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <04561627-3b15-d688-9fb8-107017175fa4@redhat.com>
Date: Tue, 5 Feb 2019 11:52:53 -0500
MIME-Version: 1.0
In-Reply-To: <20190205151810.571-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Consider cluster index in
 tb_lookup__cpu_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Howard Spoelstra <hsp.cat7@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>



On 2/5/19 10:18 AM, Peter Maydell wrote:
> In commit f7b78602fdc6c6e4be we added the CPU cluster number to the
> cflags field of the TB hash; this included adding it to the value
> kept in tb->cflags, since we pass that field directly into the hash
> calculation in some places. Unfortunately we forgot to check whether
> other parts of the code were doing comparisons against tb->cflags
> that would need to be updated.
> 
> It turns out that there is exactly one such place: the
> tb_lookup__cpu_state() function checks whether the TB it has
> found in the tb_jmp_cache has a tb->cflags matching the cf_mask
> that is passed in. The tb->cflags has the cluster_index in it
> but the cf_mask does not.
> 
> Hoist the "add cluster index to the cf_mask" code up from
> tb_htable_lookup() to tb_lookup__cpu_state() so it can be considered
> in the "did this TB match in the jmp cache" condition, as well as
> when we do the full hash lookup by physical PC, flags, etc.
> (tb_htable_lookup() is only called from tb_lookup__cpu_state(),
> so this change doesn't require any further knock-on changes.)
> 
> Fixes: f7b78602fdc6c6e4be ("accel/tcg: Add cluster number to TCG TB hash")
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Reported-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Does anybody know why tb_lookup__cpu_state() has that odd
> double-underscore in the middle of its name?
> 
> Since the jmp_cache is per-vcpu we know that we're always going
> to match on the cluster_index, so the other option would be to
> leave the cluster_index bits out of the comparison, and leave the
> "fold in cluster index to cf_mask" code in tb_htable_lookup().
> Or we could require the callers of tb_lookup__cpu_state() to all
> provide the cluster index, but that's more places to change,
> so I prefer this.

I can confirm the performance regression I experienced is fixed by this
patch.

Tested-by: Cleber Rosa <crosa@redhat.com>
