Received: from eggs.gnu.org ([2001:4830:134:3::10]:46451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv0lE-0000Qz-9e
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv0lB-0005Em-7N
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:39:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dv0lB-0005Dz-0o
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:39:17 -0400
Date: Thu, 21 Sep 2017 13:39:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170921123908.GF2717@work-vm>
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164826eucas1p249e6e9759612d74cd5c69bd375a01cd9@eucas1p2.samsung.com>
	<1505839684-10046-10-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505839684-10046-10-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v10 09/10] migration: add blocktime
 calculation into postcopy-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> This patch just requests blocktime calculation, but doesn't
> add any facility to check or show it.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  tests/postcopy-test.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
> index 8142f2a..1db5359 100644
> --- a/tests/postcopy-test.c
> +++ b/tests/postcopy-test.c
> @@ -425,6 +425,17 @@ static void test_migrate(void)
>      g_assert(qdict_haskey(rsp, "return"));
>      QDECREF(rsp);
>  
> +#ifdef UFFD_FEATURE_THREAD_ID
> +    global_qtest = to;
> +    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
> +                  "'arguments': { "
> +                      "'capabilities': [ {"
> +                          "'capability': 'postcopy-blocktime',"
> +                          "'state': true } ] } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +#endif
> +

I think that'll break;  once you sync the kernel headers up,
we'll always get that defined even when we're building or running
on an older kernel.
So I think you need to try and enable it but fall back if it's not
available somehow.

Dave

>      /* We want to pick a speed slow enough that the test completes
>       * quickly, but that it doesn't complete precopy even on a slow
>       * machine, so also set the downtime.
> @@ -441,7 +452,6 @@ static void test_migrate(void)
>      g_assert(qdict_haskey(rsp, "return"));
>      QDECREF(rsp);
>  
> -
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
