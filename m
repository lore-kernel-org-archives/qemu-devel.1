Received: from eggs.gnu.org ([2001:4830:134:3::10]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fniry-0004n6-Eu
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fniru-000790-Ce
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:12:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fniru-000788-5l
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:12:38 -0400
Date: Thu, 9 Aug 2018 12:12:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180809111233.GA2619@work-vm>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807114501.12370-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, liqsub1 <liqsub1@163.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> The data in an mbuf buffer is not necessarily at the start of the
> allocated buffer. (For instance m_adj() allows data to be trimmed
> from the start by just advancing the pointer and reducing the length.)
> This means that the allocated buffer size (m->m_size) and the
> amount of space from the m_data pointer to the end of the
> buffer (M_ROOM(m)) are not necessarily the same.
> 
> Commit 864036e251f54c9 tried to change the m_inc() function from
> taking the new allocated-buffer-size to taking the new room-size,
> but forgot to change the initial "do we already have enough space"
> check. This meant that if we were trying to extend a buffer which
> had a leading gap between the buffer start and the data, we might
> incorrectly decide it didn't need to be extended, and then
> overrun the end of the buffer, causing memory corruption and
> an eventual crash.
> 
> Change the "already big enough?" condition from checking the
> argument against m->m_size to checking against M_ROOM().
> This only makes a difference for the callsite in m_cat();
> the other three callsites all start with a freshly allocated
> mbuf from m_get(), which will have m->m_size == M_ROOM(m).
> 
> Fixes: 864036e251f54c9
> Fixes: https://bugs.launchpad.net/qemu/+bug/1785670
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  slirp/mbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/slirp/mbuf.c b/slirp/mbuf.c
> index 0c189e1a7bf..1b7868355a3 100644
> --- a/slirp/mbuf.c
> +++ b/slirp/mbuf.c
> @@ -154,7 +154,7 @@ m_inc(struct mbuf *m, int size)
>      int datasize;
>  
>      /* some compilers throw up on gotos.  This one we can fake. */
> -    if (m->m_size > size) {
> +    if (M_ROOM(m) > size) {
>          return;
>      }

I'm worried about a side effect of this change.
A few lines below we have:

        datasize = m->m_data - m->m_dat;
        m->m_ext = g_malloc(size + datasize);
        memcpy(m->m_ext, m->m_dat, m->m_size);
        m->m_flags |= M_EXT;

Question: What guarantees there's m_size room for that
memcpy in the new m_ext?

Before this fix, it used to be the case that m_size was
smaller than size, so we knew it fitted; but that's
no longer true.

I don't think I understand the relationship between datasize
and m_size enough to know if anything is sufficient.

Dave

>  
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
