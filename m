Received: from eggs.gnu.org ([2001:4830:134:3::10]:52690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1fxZWb-00058E-Aw
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1fxZWY-0001z2-6r
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:15:21 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:6588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1fxZWX-0001rJ-V8
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:15:18 -0400
Date: Wed, 5 Sep 2018 17:05:10 +0200
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20180905150510.wn4cfhj73z7cbtvb@olga.proxmox.com>
References: <20180618140854.17824-1-armbru@redhat.com>
	<20180618140854.17824-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618140854.17824-7-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PULL 6/7] monitor: move init global earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On Mon, Jun 18, 2018 at 04:08:53PM +0200, Markus Armbruster wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Before this patch, monitor fd helpers might be called even earlier than
> monitor_init_globals().  This can be problematic.
> 
> After previous work, now monitor_init_globals() does not depend on
> accelerator initialization any more.  Call it earlier (before CLI
> parsing; that's where the monitor APIs might be called) to make sure it
> is called before any of the monitor APIs.

It looks like this patch moves the creation of the 'IO mon_iothread' to
before the call to os_daemonize().
With qemu 3.0 I'm experiencing crashes when shutting down daemonized
qemu instances, at pthread_join() on the 'IO mon_iothread' thread.

monitor_init_globals() calls monitor_iothread_init(), which in turn uses
iothread_create() to create a joinable thread. Then os_daemonize() is
called after which the thread is no longer "ours".
Debug-writing the thread IDs at pthread_create() and pthread_join()
together with the 'detachable' flag revealed that the mon_iothread ID is
already being reused, in my trace for a detached thread, and the join
then ends with a coredump and ugly log output.

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Message-Id: <20180608035511.7439-7-peterx@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  vl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 6e34fb348d..b3426e03d0 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2978,6 +2978,7 @@ int main(int argc, char **argv, char **envp)
>  
>      runstate_init();
>      postcopy_infrastructure_init();
> +    monitor_init_globals();
>  
>      if (qcrypto_init(&err) < 0) {
>          error_reportf_err(err, "cannot initialize crypto: ");
> @@ -4412,12 +4413,6 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>  
> -    /*
> -     * Note: qtest_enabled() (which is used in monitor_qapi_event_init())
> -     * depends on configure_accelerator() above.
> -     */
> -    monitor_init_globals();
> -
>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>                            mon_init_func, NULL, NULL)) {
>          exit(1);
> -- 
> 2.17.1
