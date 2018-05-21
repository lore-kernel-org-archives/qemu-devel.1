Received: from eggs.gnu.org ([2001:4830:134:3::10]:35422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKgey-0006Ws-E2
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKgev-0003FC-9M
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:59:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fKgev-0003F4-3W
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:59:13 -0400
Date: Mon, 21 May 2018 09:59:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180521085907.GE23090@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180521084249.10640-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180521084249.10640-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC] monitor: turn on Out-Of-Band by default again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Mon, May 21, 2018 at 04:42:49PM +0800, Peter Xu wrote:
> We turned Out-Of-Band feature of monitors off for 2.12 release.  Now we
> try to turn that on again.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> --
> Now OOB should be okay with all known tests (except iotest qcow2, since
> it is still broken on master), and AFAIK now we should also be okay with
> ARM+Libvirt (not testsed, but Eric Auger helped to verify that before
> the release).  So I think it's now safe to turn OOB on again.  Please
> feel free to test this against any of existing testsuites to see whether
> it'll still break any stuff.  Thanks,

Can you remind us what the problem was with ARM+Libvirt that this
caused ?

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c        | 13 +++----------
>  tests/qmp-test.c |  2 +-
>  vl.c             |  9 ++++-----
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 46814af533..ce5cc5e34e 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4560,16 +4560,9 @@ void monitor_init(Chardev *chr, int flags)
>      bool use_readline = flags & MONITOR_USE_READLINE;
>      bool use_oob = flags & MONITOR_USE_OOB;
>  
> -    if (use_oob) {
> -        if (CHARDEV_IS_MUX(chr)) {
> -            error_report("Monitor Out-Of-Band is not supported with "
> -                         "MUX typed chardev backend");
> -            exit(1);
> -        }
> -        if (use_readline) {
> -            error_report("Monitor Out-Of-band is only supported by QMP");
> -            exit(1);
> -        }
> +    if (CHARDEV_IS_MUX(chr)) {
> +        /* MUX is still not supported for Out-Of-Band */
> +        use_oob = false;
>      }
>  
>      monitor_data_init(mon, false, use_oob);
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 88f867f8c0..c85a3964d9 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -89,7 +89,7 @@ static void test_qmp_protocol(void)
>      g_assert(q);
>      test_version(qdict_get(q, "version"));
>      capabilities = qdict_get_qlist(q, "capabilities");
> -    g_assert(capabilities && qlist_empty(capabilities));
> +    g_assert(capabilities);
>      qobject_unref(resp);
>  
>      /* Test valid command before handshake */
> diff --git a/vl.c b/vl.c
> index 3b39bbd7a8..b71fb8eb25 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2394,6 +2394,10 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>          flags = MONITOR_USE_READLINE;
>      } else if (strcmp(mode, "control") == 0) {
>          flags = MONITOR_USE_CONTROL;
> +        /* Out-Of-Band is on by default */
> +        if (qemu_opt_get_bool(opts, "x-oob", 1)) {
> +            flags |= MONITOR_USE_OOB;
> +        }
>      } else {
>          error_report("unknown monitor mode \"%s\"", mode);
>          exit(1);
> @@ -2402,11 +2406,6 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      if (qemu_opt_get_bool(opts, "pretty", 0))
>          flags |= MONITOR_USE_PRETTY;
>  
> -    /* OOB is off by default */
> -    if (qemu_opt_get_bool(opts, "x-oob", 0)) {
> -        flags |= MONITOR_USE_OOB;
> -    }
> -
>      chardev = qemu_opt_get(opts, "chardev");
>      chr = qemu_chr_find(chardev);
>      if (chr == NULL) {
> -- 
> 2.17.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
