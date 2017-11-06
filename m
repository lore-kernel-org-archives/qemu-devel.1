Received: from eggs.gnu.org ([2001:4830:134:3::10]:43550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBlAk-0001ay-8q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBlAh-0000nO-IO
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:26:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBlAh-0000mU-9Z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:26:51 -0500
Date: Mon, 6 Nov 2017 17:26:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171106172646.GO23361@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1509988303.22094.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1509988303.22094.8.camel@intel.com>
Subject: Re: [Qemu-devel] RFC: connecting chardev to a command forked by qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: qemu-devel@nongnu.org, Amarnath Valluri <amarnath.valluri@intel.com>

On Mon, Nov 06, 2017 at 06:11:43PM +0100, Patrick Ohly wrote:
> Hello!
> 
> When Amarnath proposed the initial patch set for interacting with swtpm
> without relying on CUSE, letting QEMU invoke swtpm was part of the
> patch series. When using some virtual machine management framework like
>  virt-manager that might not be necessary. But our goal was to use
> QEMU+swtpm to test TPM support in Yocto, and there QEMU is started by a
> simple wrapper script where handling additional processes would be
> awkward.
> 
> To achieve that goal without having to make that script more complex,
> I'd like to propose that with some minor (?) changes, a chardev could
> also be configured to use an external command. As a proof of concept
> I'm attaching a patch which modifies char-socket.c accordingly.

Personally I'm not a huge fan of adding more ways for QEMU to spawn
external commands. QEMU is already a very large & complex beast which
is hard to confine, and when QEMU spawns a command it is hard to lock
it down to any useful extent without us adding alot of extra features
to QEMU. Most stuff we've been doing in QEMU has tended to go in the
opposite direction of facilitating integration with helpers spawned
by a 3rd party, whether it be the mgmt app that launches QEMU or
something else. cf vhost-user where we just expose a normal chardev
unix socket and assume someone/thing else spawned the service on
the other end, or the new approach to host FS passthrough where we
expose vsock and run NFS server externally.

I can see the argument about it making QEMU easier to use, and those
who care about security aren't forced to use this new feature. It
none the less has a cost on maintainers and existance of these features
does reflect on QEMU's security reputation even if many don't use it.


> +static void chardev_open_socket_cmd(Chardev *chr,
> +                                    const char *cmd,
> +                                    Error **errp)
> +{
> +    int fds[2] = { -1, -1 };
> +    QIOChannelSocket *sioc = NULL;
> +    pid_t pid = -1;
> +    const char *argv[] = { "/bin/sh", "-c", cmd, NULL };
> +
> +    if (socketpair(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0, fds)) {
> +        error_setg_errno(errp, errno, "Error creating socketpair(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC)");
> +        goto error;
> +    }
> +
> +    pid = qemu_fork(errp);
> +    if (pid < 0) {
> +        goto error;
> +    }
> +
> +    if (!pid) {
> +        /* child */
> +        dup2(fds[1], STDIN_FILENO);
> +        execv(argv[0], (char * const *)argv);
> +        _exit(1);
> +    }
> +
> +    /*
> +     * Hand over our end of the socket pair to the qio channel.
> +     * TODO: We don't reap the child at the moment.
> +     */
> +    sioc = qio_channel_socket_new_fd(fds[0], errp);

NB, you've mostly re-invented qio_channel_command_new_spawn() here,
though you're using a socketpair instead of pipe, which has the
slight benefit of meaning we can do FD passing across the external
command. If the latter is why you chose socketpair, then it would
be nice to improve QIOChannelCommand 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
