Received: from eggs.gnu.org ([2001:4830:134:3::10]:37391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eJTf6-0005pp-Gb
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 19:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eJTf5-0005xS-HH
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 19:22:08 -0500
References: <20171123175747.2309-1-famz@redhat.com>
	<20171127232909.GF4903@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <4ee33b29-be8c-249f-f578-31ec9c478bef@redhat.com>
Date: Mon, 27 Nov 2017 19:21:54 -0500
MIME-Version: 1.0
In-Reply-To: <20171127232909.GF4903@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/1] block: Workaround for the
 iotests errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com



On 11/27/2017 06:29 PM, Kevin Wolf wrote:
> Am 23.11.2017 um 18:57 hat Fam Zheng geschrieben:
>> Jeff's block job patch made the latent drain bug visible, and I find this
>> patch, which by itself also makes some sense, can hide it again. :) With it
>> applied we are at least back to the ground where patchew's iotests (make
>> docker-test-block@fedora) can pass.
>>
>> The real bug is that in the middle of bdrv_parent_drained_end(), bs's parent
>> list changes. One drained_end call before the mirror_exit() already did one
>> blk_root_drained_end(), a second drained_end on an updated parent node can do
>> another same blk_root_drained_end(), making it unbalanced with
>> blk_root_drained_begin(). This is shown by the following three backtraces as
>> captured by rr with a crashed "qemu-img commit", essentially the same as in
>> the failed iotest 020:
> 
> My conclusion what really happens in 020 is that we have a graph like
> this:
> 
>                              mirror target BB --+
>                                                 |
>                                                 v
>     qemu-img BB -> mirror_top_bs -> overlay -> base
> 
> bdrv_drained_end(base) results in it being available for requests again,
> so it calls bdrv_parent_drained_end() for overlay. While draining
> itself, the mirror job completes and changes the BdrvChild between
> mirror_top_bs and overlay (which is currently being drained) to point to
> base instead. After returning, QLIST_FOREACH() continues to iterate the
> parents of base instead of those of overlay, resulting in a second
> blk_drained_end() for the mirror target BB.
> 
> This instance can be fixed relatively easily (see below) by using
> QLIST_FOREACH_SAFE() instead.
> 
> However, I'm not sure if all problems with the graph change can be
> solved this way and whether we can really allow graph changes while
> iterating the graph for bdrv_drained_begin/end. Not allowing it would
> require some more serious changes to the block jobs that delays their
> completion until after bdrv_drain_end() has finished (not sure how to
> even get a callback at that point...)
> 
> And the test cases that Jeff mentions still fail with this patch, too.
> But at least it doesn't only make failure less likely by reducing the
> window for a race condition, but seems to attack a real problem.
> 
> Kevin
> 
> 
> diff --git a/block/io.c b/block/io.c
> index 4fdf93a014..6773926fc1 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -42,9 +42,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>  
>  void bdrv_parent_drained_begin(BlockDriverState *bs)
>  {
> -    BdrvChild *c;
> +    BdrvChild *c, *next;
>  
> -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
>          if (c->role->drained_begin) {
>              c->role->drained_begin(c);
>          }
> @@ -53,9 +53,9 @@ void bdrv_parent_drained_begin(BlockDriverState *bs)
>  
>  void bdrv_parent_drained_end(BlockDriverState *bs)
>  {
> -    BdrvChild *c;
> +    BdrvChild *c, *next;
>  
> -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
>          if (c->role->drained_end) {
>              c->role->drained_end(c);
>          }
> 
> 

With this patch applied to 5e19aed5, I see the following failures (still?):

raw:
	055 (pause_job timeouts)
	109 (apparently a discrepancy over whether busy should be true/false.)

qcow2:
	056 (hang),
	087 (lacking crypto, normal for me)
	141 (unexpected timeout/hang)
	176 (SIGSEGV)
	188 (lacking crypto, normal for me)
	189 (lacking crypto, normal for me)
	198 (lacking crypto, I guess this is normal now)


I'm on my way to the gym for the evening, I will try to investigate
later this evening. I'm not worried about 087, 188, 189 or 198.

Anyway, as this micro-patchlet does fix observable problems with iotest 020;

Tested-by: John Snow <jsnow@redhat.com>
