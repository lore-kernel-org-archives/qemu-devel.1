Received: from eggs.gnu.org ([209.51.188.92]:42543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hMami-0006ZN-AY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hMamg-0005In-VF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1hMamg-0005Hs-Pt
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:38 -0400
Date: Fri, 3 May 2019 17:11:35 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190503161135.GW3926@redhat.com>
References: <20190503154613.4192-1-kchamart@redhat.com>
	<20190503154613.4192-2-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503154613.4192-2-kchamart@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] VirtIO-RNG: Update default entropy source
 to `/dev/urandom`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, amit@kernel.org, armbru@redhat.com, berrange@redhat.com

On Fri, May 03, 2019 at 05:46:13PM +0200, Kashyap Chamarthy wrote:
> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> source of entropy, and that source needs to be "non-blocking", like
> `/dev/urandom`.  However, currently QEMU defaults to the problematic
> `/dev/random`, which is "blocking" (as in, it waits until sufficient
> entropy is available).
> 
> So change the entropy source to the recommended `/dev/urandom`.
> 
> Related discussion in these[1][2] past threads.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
>     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.html
>     -- "[RFC] Virtio RNG: Consider changing the default entropy source to
>        /dev/urandom"
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  backends/rng-random.c | 2 +-
>  qemu-options.hx       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/rng-random.c b/backends/rng-random.c
> index e2a49b0571..eff36ef140 100644
> --- a/backends/rng-random.c
> +++ b/backends/rng-random.c
> @@ -112,7 +112,7 @@ static void rng_random_init(Object *obj)
>                              rng_random_set_filename,
>                              NULL);
>  
> -    s->filename = g_strdup("/dev/random");
> +    s->filename = g_strdup("/dev/urandom");
>      s->fd = -1;
>  }
>  
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 51802cbb26..a525609149 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4276,7 +4276,7 @@ Creates a random number generator backend which obtains entropy from
>  a device on the host. The @option{id} parameter is a unique ID that
>  will be used to reference this entropy backend from the @option{virtio-rng}
>  device. The @option{filename} parameter specifies which file to obtain
> -entropy from and if omitted defaults to @option{/dev/random}.
> +entropy from and if omitted defaults to @option{/dev/urandom}.
>  
>  @item -object rng-egd,id=@var{id},chardev=@var{chardevid}

I think this is a very sensible change, removing a bit of superstition
about randomness.

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
