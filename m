Received: from eggs.gnu.org ([2001:4830:134:3::10]:33489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJNi-0002Dq-Rs
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJNf-0005US-OR
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:04:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59311)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUJNf-0005UG-LD
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:04:39 -0400
Date: Sun, 9 Jul 2017 17:04:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170709210438.GC32582@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-20-git-send-email-cota@braap.org>
	<87ce6f03-0895-a2a8-eba2-573145507c07@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ce6f03-0895-a2a8-eba2-573145507c07@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 19/22] tcg: introduce tcg_context_clone
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

On Sun, Jul 09, 2017 at 10:48:27 -1000, Richard Henderson wrote:
> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> >@@ -409,6 +411,18 @@ void tcg_context_init(TCGContext *s)
> >  }
> >  /*
> >+ * Clone the initial TCGContext. Used by TCG threads to copy the TCGContext
> >+ * set up by their parent thread via tcg_context_init().
> >+ */
> >+void tcg_context_clone(TCGContext *s)
> >+{
> >+    if (unlikely(tcg_init_ctx == NULL || tcg_init_ctx == s)) {
> >+        tcg_abort();
> >+    }
> >+    memcpy(s, tcg_init_ctx, sizeof(*s));
> >+}
> 
> Under what conditions will this be called?  How much of this might you need
> to zero out again after the fact?

I checked the profile/tb counts and all of them are zero when this
is called, which is right after the thread has been created.
But it is conceivable that those counts might be !0 for some targets,
so yes it'd be better to actively zero out those.

I don't think there are any other fields that would have to be zeroed
out.

		E.
