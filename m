Received: from eggs.gnu.org ([2001:4830:134:3::10]:44576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYLFm-00018m-HA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYLFj-0005gj-Gv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:53:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYLFj-0005fJ-9U
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:53:07 -0400
Date: Thu, 20 Jul 2017 19:53:06 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170720235306.GA6330@flamenco>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-36-git-send-email-cota@braap.org>
	<06200ec3-3c8b-4e69-a339-76b22b99e4d1@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06200ec3-3c8b-4e69-a339-76b22b99e4d1@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 35/43] tcg: dynamically allocate
 optimizer temps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Wed, Jul 19, 2017 at 21:39:35 -1000, Richard Henderson wrote:
> On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
> >Groundwork for supporting multiple TCG contexts.
> >That is, 2.70% slowdown.
> 
> That's disappointing.  How about using tcg_malloc?
> 
> Maximum allocation is sizeof(tcg_temp_info) * TCG_MAX_TEMPS = 12288, which
> is less than TCG_POOL_CHUNK_SIZE, so we'll retain the allocation in the pool
> across translations.

             exec time (s)  Relative slowdown wrt original (%)
---------------------------------------------------------------
 original     20.213321616                                  0.
 tcg_malloc   20.441130078                           1.1270214
 TCGContext   20.477846517                           1.3086662
 g_malloc     20.780527895                           2.8061013

So will go with tcg_malloc.

BTW, is there any chance that the pool will be initialized before we copy
tcg_init_ctx? That'd mean the main thread has performed translation, which
seems unlikely to me. But should then we bother clearing the TCGProfile
counters after we copy tcg_init_ctx? I don't see how without translation
counters would be !0.

		E.
