Received: from eggs.gnu.org ([209.51.188.92]:54238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDYfo-0008BY-4N
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDYfm-0004Nj-JE
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:07:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
	<20190408172202.GH3926@redhat.com>
Date: Mon, 08 Apr 2019 20:07:00 +0200
In-Reply-To: <20190408172202.GH3926@redhat.com> (Richard W. M. Jones's message
	of "Mon, 8 Apr 2019 18:22:11 +0100")
Message-ID: <87mul0jrqz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Whither qemu's ssh driver?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, ptoscano@redhat.com, Max Reitz <mreitz@redhat.com>

"Richard W.M. Jones" <rjones@redhat.com> writes:

> I don't know much about this patch which looks like internal qemu
> rearrangements so I guess fine.  However I do have a few things to say
> about the ssh driver ...
>
> As you know I wrote this a few years ago, and it uses libssh2.
> libssh2 has not evolved as quickly as we'd like and it may be better
> to use libssh instead -- despite the names, these are two separate and
> unrelated libraries.  libssh supports a wider range of SSH encryption
> and has more features.  It's generally more likely to work against a
> random SSH server.  It has also been through the FIPS process.  Indeed
> Red Hat made the decision to switch exclusively to libssh in RHEL 8,
> if that carries any weight.
>
> Pino posted a libssh2 -> libssh conversion patch a while back, but it
> has been somewhat stuck in review.  If I recall the latest concern was
> whether it performs as well as the libssh2 version.
>
>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07267.html

I doubt we'd need "as well as" for this driver.  But Max observed a
factor of five with v4.  Pino reported improvements with v5 ("no more
than 200%"), and some more with libssh master instead of 0.7, but didn't
quantify those.  To make progress, we need a rebased patch with actual
performance numbers, I think.

> In the meantime I added libssh support to nbdkit.  nbdkit can be used
> as a complete replacement for qemu's ssh driver.
>
>   nbdkit ssh host=foo.example.com disk.img -U tmpdirXXXXXX/sock
>   qemu -hda nbd:unix:tmpdirXXXXXX/sock
>
> In fact it's somewhat superior (IMHO) because all of the tricky code
> handling libssh runs outside qemu in a separate process, improving
> isolation and potentially allowing separate, restrictive security
> policies to be applied.  For example it would no longer be necessary
> to give qemu permission to connect to remote SSH servers.

Good point.

> Could we make this really smooth somehow?  nbdkit has a concept
> [https://www.mankier.com/1/nbdkit-captive] where we make it easy to
> manage external commands owned by nbdkit.  Is there an equivalent
> feature of qemu where:
>
>   qemu -object exec,id=nbd1,cmd='nbdkit -f -U $sock ssh ...' \
>        -drive file.driver=nbd,file.socket=nbd1
>
> would run the command but also allocate a socket and kill the
> subcommand on exit (of qemu)?

I'm not aware of general infrastructure to run helper processes.  But
I'm sure we could come up with something.

> Basically I'm trying to think about how to make this a reality:
>
>   https://rwmj.files.wordpress.com/2018/10/drawing2-svg.png

Looks like you're also targeting curl.c's drivers.  Any others?

Got a backward compatibility story other than "let's deprecate these
drivers"?
