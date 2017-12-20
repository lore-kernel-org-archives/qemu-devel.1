Received: from eggs.gnu.org ([2001:4830:134:3::10]:57887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRc0H-0004Bq-N6
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRc0G-0003nJ-Nc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:53:37 -0500
References: <20171220103412.13048-1-kwolf@redhat.com>
	<20171220103412.13048-15-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f41e87e2-2b36-e05d-482d-7d14472a6767@redhat.com>
Date: Wed, 20 Dec 2017 11:53:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171220103412.13048-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/19] test-bdrv-drain: Test behaviour in
 coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

On 20/12/2017 11:34, Kevin Wolf wrote:
> If bdrv_do_drained_begin/end() are called in coroutine context, they
> first use a BH to get out of the coroutine context. Call some existing
> tests again from a coroutine to cover this code path.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
> index c00d96bb2f..a1e5693f33 100644
> --- a/tests/test-bdrv-drain.c
> +++ b/tests/test-bdrv-drain.c
> @@ -188,6 +188,30 @@ static void test_drv_cb_drain_subtree(void)
>      test_drv_cb_common(BDRV_SUBTREE_DRAIN, true);
>  }
>  
> +static coroutine_fn void test_drv_cb_coroutine_entry(void *opaque)
> +{
> +    bool *done = opaque;
> +
> +    // XXX bdrv_drain_all() doesn't work in coroutine context
> +    //test_drv_cb_drain_all();
> +    test_drv_cb_drain();
> +    test_drv_cb_drain_subtree();
> +
> +    *done = true;
> +}
> +
> +static void test_drv_cb_coroutine(void)
> +{
> +    Coroutine *co;
> +    bool done;
> +
> +    co = qemu_coroutine_create(test_drv_cb_coroutine_entry, &done);
> +    qemu_coroutine_enter(co);
> +    while (!done) {
> +        aio_poll(qemu_get_aio_context(), true);
> +    }
> +}
> +
>  static void test_quiesce_common(enum drain_type drain_type, bool recursive)
>  {
>      BlockBackend *blk;
> @@ -235,6 +259,30 @@ static void test_quiesce_drain_subtree(void)
>      test_quiesce_common(BDRV_SUBTREE_DRAIN, true);
>  }
>  
> +static coroutine_fn void test_quiesce_coroutine_entry(void *opaque)
> +{
> +    bool *done = opaque;
> +
> +    // XXX bdrv_drain_all() doesn't work in coroutine context
> +    //test_quiesce_drain_all();
> +    test_quiesce_drain();
> +    test_quiesce_drain_subtree();
> +
> +    *done = true;
> +}
> +
> +static void test_quiesce_coroutine(void)
> +{
> +    Coroutine *co;
> +    bool done;
> +
> +    co = qemu_coroutine_create(test_quiesce_coroutine_entry, &done);
> +    qemu_coroutine_enter(co);
> +    while (!done) {
> +        aio_poll(qemu_get_aio_context(), true);
> +    }
> +}
> +
>  static void test_nested(void)
>  {
>      BlockBackend *blk;
> @@ -421,11 +469,14 @@ int main(int argc, char **argv)
>      g_test_add_func("/bdrv-drain/driver-cb/drain", test_drv_cb_drain);
>      g_test_add_func("/bdrv-drain/driver-cb/drain_subtree",
>                      test_drv_cb_drain_subtree);
> +    g_test_add_func("/bdrv-drain/driver-cb/coroutine", test_drv_cb_coroutine);
> +
>  
>      g_test_add_func("/bdrv-drain/quiesce/drain_all", test_quiesce_drain_all);
>      g_test_add_func("/bdrv-drain/quiesce/drain", test_quiesce_drain);
>      g_test_add_func("/bdrv-drain/quiesce/drain_subtree",
>                      test_quiesce_drain_subtree);
> +    g_test_add_func("/bdrv-drain/quiesce/coroutine", test_quiesce_coroutine);

Maybe split the two sub-tests of test_{drv_cb,quiesce}_coroutine into
separate g_test_add_func?

Thanks,

Paolo

>      g_test_add_func("/bdrv-drain/nested", test_nested);
>  
> 
