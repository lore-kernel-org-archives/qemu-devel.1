Received: from eggs.gnu.org ([2001:4830:134:3::10]:51598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP65-0000cd-HF
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP62-0000sP-4t
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:41 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP61-0000sC-VY
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:38 -0500
Received: by mail-qk0-x242.google.com with SMTP id e1so7552880qkh.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 20:15:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486249715-5513-1-git-send-email-peter.maydell@linaro.org>
	<1486249715-5513-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a0c02d63-7559-f794-e5f4-663b5dbf8616@amsat.org>
Date: Sat, 11 Feb 2017 01:15:34 -0300
MIME-Version: 1.0
In-Reply-To: <1486249715-5513-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] slirp: Convert mbufs to use g_malloc()
 and g_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, patches@linaro.org

On 02/04/2017 08:08 PM, Peter Maydell wrote:
> The mbuf code currently doesn't check the result of doing a malloc()
> or realloc() of its data (spotted by Coverity, CID 1238946).
> Since the m_inc() API assumes that extending an mbuf must succeed,
> just convert to g_malloc() and g_free().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  slirp/mbuf.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/slirp/mbuf.c b/slirp/mbuf.c
> index 7eddc21..5ff2455 100644
> --- a/slirp/mbuf.c
> +++ b/slirp/mbuf.c
> @@ -10,7 +10,7 @@
>   * FreeBSD.  They are fixed size, determined by the MTU,
>   * so that one whole packet can fit.  Mbuf's cannot be
>   * chained together.  If there's more data than the mbuf
> - * could hold, an external malloced buffer is pointed to
> + * could hold, an external g_malloced buffer is pointed to
>   * by m_ext (and the data pointers) and M_EXT is set in
>   * the flags
>   */
> @@ -41,26 +41,26 @@ void m_cleanup(Slirp *slirp)
>      while ((struct quehead *) m != &slirp->m_usedlist) {
>          next = m->m_next;
>          if (m->m_flags & M_EXT) {
> -            free(m->m_ext);
> +            g_free(m->m_ext);
>          }
> -        free(m);
> +        g_free(m);
>          m = next;
>      }
>      m = (struct mbuf *) slirp->m_freelist.qh_link;
>      while ((struct quehead *) m != &slirp->m_freelist) {
>          next = m->m_next;
> -        free(m);
> +        g_free(m);
>          m = next;
>      }
>  }
>
>  /*
>   * Get an mbuf from the free list, if there are none
> - * malloc one
> + * allocate one
>   *
>   * Because fragmentation can occur if we alloc new mbufs and
>   * free old mbufs, we mark all mbufs above mbuf_thresh as M_DOFREE,
> - * which tells m_free to actually free() it
> + * which tells m_free to actually g_free() it
>   */
>  struct mbuf *
>  m_get(Slirp *slirp)
> @@ -71,8 +71,7 @@ m_get(Slirp *slirp)
>  	DEBUG_CALL("m_get");
>
>  	if (slirp->m_freelist.qh_link == &slirp->m_freelist) {
> -		m = (struct mbuf *)malloc(SLIRP_MSIZE);
> -		if (m == NULL) goto end_error;
> +                m = g_malloc(SLIRP_MSIZE);
>  		slirp->mbuf_alloced++;
>  		if (slirp->mbuf_alloced > MBUF_THRESH)
>  			flags = M_DOFREE;
> @@ -94,7 +93,6 @@ m_get(Slirp *slirp)
>          m->m_prevpkt = NULL;
>          m->resolution_requested = false;
>          m->expiration_date = (uint64_t)-1;
> -end_error:
>  	DEBUG_ARG("m = %p", m);
>  	return m;
>  }
> @@ -112,15 +110,15 @@ m_free(struct mbuf *m)
>  	   remque(m);
>
>  	/* If it's M_EXT, free() it */
> -	if (m->m_flags & M_EXT)
> -	   free(m->m_ext);
> -
> +        if (m->m_flags & M_EXT) {
> +                g_free(m->m_ext);
> +        }
>  	/*
>  	 * Either free() it or put it on the free list
>  	 */
>  	if (m->m_flags & M_DOFREE) {
>  		m->slirp->mbuf_alloced--;
> -		free(m);
> +                g_free(m);
>  	} else if ((m->m_flags & M_FREELIST) == 0) {
>  		insque(m,&m->slirp->m_freelist);
>  		m->m_flags = M_FREELIST; /* Clobber other flags */
> @@ -130,7 +128,7 @@ m_free(struct mbuf *m)
>
>  /*
>   * Copy data from one mbuf to the end of
> - * the other.. if result is too big for one mbuf, malloc()
> + * the other.. if result is too big for one mbuf, allocate
>   * an M_EXT data segment
>   */
>  void
> @@ -160,12 +158,12 @@ m_inc(struct mbuf *m, int size)
>
>          if (m->m_flags & M_EXT) {
>  	  datasize = m->m_data - m->m_ext;
> -	  m->m_ext = (char *)realloc(m->m_ext,size);
> +          m->m_ext = g_realloc(m->m_ext, size);
>  	  m->m_data = m->m_ext + datasize;
>          } else {
>  	  char *dat;
>  	  datasize = m->m_data - m->m_dat;
> -	  dat = (char *)malloc(size);
> +          dat = g_malloc(size);
>  	  memcpy(dat, m->m_dat, m->m_size);
>
>  	  m->m_ext = dat;
>
