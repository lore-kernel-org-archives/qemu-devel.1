Received: from eggs.gnu.org ([2001:4830:134:3::10]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1eBoX6-000793-9a
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 16:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1eBoX3-0004fn-3n
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 16:02:12 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:48183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick.ohly@intel.com>)
	id 1eBoX2-0004e3-Py
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 16:02:09 -0500
Received: by mail-wm0-x22e.google.com with SMTP id p75so16427600wmg.3
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 13:02:08 -0800 (PST)
Message-ID: <1510002125.22094.10.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
Date: Mon, 06 Nov 2017 22:02:05 +0100
In-Reply-To: <20171106172646.GO23361@redhat.com>
References: <1509988303.22094.8.camel@intel.com>
	<20171106172646.GO23361@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] RFC: connecting chardev to a command forked by qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Amarnath Valluri <amarnath.valluri@intel.com>

On Mon, 2017-11-06 at 17:26 +0000, Daniel P. Berrange wrote:
> I can see the argument about it making QEMU easier to use, and those
> who care about security aren't forced to use this new feature. It
> none the less has a cost on maintainers and existance of these
> features does reflect on QEMU's security reputation even if many
> don't use it.

With Yocto we really don't have much choice: we need a patch like this
because the alternative (introducing support for spawning and stopping
swtpm and then passing the right parameters to QEMU) is way more
complex. So if this patch isn't acceptable to QEMU upstream, then I
will keep it as simple as possible and propose it as a local patch in
Yocto.

But that then won't help others who might be using QEMU in a similar
situation.

> > +static void chardev_open_socket_cmd(Chardev *chr,
> > +                                    const char *cmd,
> > +                                    Error **errp)
> > +{
> > +    int fds[2] = { -1, -1 };
> > +    QIOChannelSocket *sioc = NULL;
> > +    pid_t pid = -1;
> > +    const char *argv[] = { "/bin/sh", "-c", cmd, NULL };
> > +
> > +    if (socketpair(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0, fds)) {
> > +        error_setg_errno(errp, errno, "Error creating
> > socketpair(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC)");
> > +        goto error;
> > +    }
> > +
> > +    pid = qemu_fork(errp);
> > +    if (pid < 0) {
> > +        goto error;
> > +    }
> > +
> > +    if (!pid) {
> > +        /* child */
> > +        dup2(fds[1], STDIN_FILENO);
> > +        execv(argv[0], (char * const *)argv);
> > +        _exit(1);
> > +    }
> > +
> > +    /*
> > +     * Hand over our end of the socket pair to the qio channel.
> > +     * TODO: We don't reap the child at the moment.
> > +     */
> > +    sioc = qio_channel_socket_new_fd(fds[0], errp);
> 
> NB, you've mostly re-invented qio_channel_command_new_spawn() here,
> though you're using a socketpair instead of pipe, which has the
> slight benefit of meaning we can do FD passing across the external
> command.

Yes, that's exactly the reason. swtpm depends on a bidirectional stream
with support for FD passing. I should have added that an option for a
new "-charset cmd" might be to choose two uni-direction pipes connected
to stdin/stdout of the command. That would be useful for some other
commands.

> If the latter is why you chose socketpair, then it would
> be nice to improve QIOChannelCommand 

Yes, that would be better. But before touching too many different files
and thus increasing the risk of merge conflicts (which is an issue when
maintaining the patch downstream) I'd like to get a feeling for whether
it's worth enhancing the patch to make it suitable for upstream or
whether there are strong reasons to never include anything like it.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
