Received: from eggs.gnu.org ([2001:4830:134:3::10]:37019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eCOn9-0003vT-JK
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eCOn3-0000gf-GM
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:45:11 -0500
Date: Wed, 8 Nov 2017 11:45:00 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171108114500.GQ2787@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
	<facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/curl: fix minor memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, eblake@redhat.com

On Tue, Nov 07, 2017 at 05:27:23PM -0500, Jeff Cody wrote:
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/curl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 00a9879..35cf417 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -857,6 +857,9 @@ out_noclean:
>      qemu_mutex_destroy(&s->mutex);
>      g_free(s->cookie);
>      g_free(s->url);
> +    g_free(s->username);
> +    g_free(s->proxyusername);
> +    g_free(s->proxypassword);
>      qemu_opts_del(opts);
>      return -EINVAL;
>  }
> @@ -955,6 +958,9 @@ static void curl_close(BlockDriverState *bs)
>  
>      g_free(s->cookie);
>      g_free(s->url);
> +    g_free(s->username);
> +    g_free(s->proxyusername);
> +    g_free(s->proxypassword);

username & proxyusername are allocated with g_strdup and so
should obviously be freed.

proxypassword is returned by qcrypto_secret_lookup_as_utf8, and it's
not clear to me if we should free that or not.  However examining the
code of qcrypto_secret_lookup it looks as if this string is allocated
by g_new0, which would indicate that it should also be freed.

Therefore:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
