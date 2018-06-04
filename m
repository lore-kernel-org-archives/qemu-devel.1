Received: from eggs.gnu.org ([2001:4830:134:3::10]:54330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPmnE-0000n8-GF
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPmnB-0001Y0-Ah
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:32:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPmnB-0001XW-5U
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:32:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F64EBD9E
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 10:32:48 +0000 (UTC)
Date: Mon, 4 Jun 2018 11:32:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180604103244.GD19749@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cli: Don't run early event loop if no
 --preconfig was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com

On Sat, Jun 02, 2018 at 12:34:52PM +0200, Michal Privoznik wrote:
> After 047f7038f586d215 it is possible for event loop to run two
> times. First time whilst parsing command line options (the idea
> is to bring up monitor early so that management applications can
> tweak config before machine is initialized). And the second time
> is after everything is set up (this is the usual place). In both
> cases the event loop is called as main_loop_wait(nonblocking =
> false) which causes the event loop to block until at least one
> event occurred.
> 
> Now, consider that somebody (i.e. libvirt) calls us with
> -daemonize. This operation is split in two steps. The main()
> calls os_daemonize() which fork()-s and then waits in read()
> until child notifies it via write():
> 
> /qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 -S -daemonize \
>   -no-user-config -nodefaults -nographic
> 
>   main():                child:
>     os_daemonize():
>       read(pipe[0])
> 
>                            main_loop():
>                              main_loop_wait(false)
> 
>                            os_setup_post():
>                              write(pipe[1])
> 
>                            main_loop():
>                              main_loop_wait(false)
> 
> Here it can be clearly seen that main() does not exit until an
> event occurs, but at the same time nobody will touch the monitor
> socket until their exec("qemu-system-*") finishes. So the whole
> thing deadlocks.
> 
> The solution is to not call main_loop() unless --preconfig was
> specified (in which case caller knows they must connect to the
> socket before exec() finishes).
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  vl.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 70f090c823..cde2934c40 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4469,8 +4469,13 @@ int main(int argc, char **argv, char **envp)
>      }
>      parse_numa_opts(current_machine);
>  
> -    /* do monitor/qmp handling at preconfig state if requested */
> -    main_loop();
> +    if (preconfig_exit_requested) {
> +        runstate_set(RUN_STATE_PRELAUNCH);
> +        preconfig_exit_requested = false;
> +    } else {
> +        /* do monitor/qmp handling at preconfig state if requested */
> +        main_loop();
> +    }

Avoiding the double-run of main_loop is good, however, I think we should
also not have put current_run_state in RUN_STATE_PRECONFIG in the first
place if --preconfig wasn't set.  I've sent a patch to fix that problem
too, so if yours is also applied, it could be changed to just do:

    if (current_run_state == RNU_STATE_PRECONFIG) {
        main_loop();
    }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
