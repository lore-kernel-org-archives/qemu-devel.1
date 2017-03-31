Received: from eggs.gnu.org ([2001:4830:134:3::10]:36716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cu03R-000454-CH
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cu03N-0005kk-Bg
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:09:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cu03N-0005k5-5C
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:09:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B6F87F3EC
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 17:09:35 +0000 (UTC)
Date: Fri, 31 Mar 2017 18:09:30 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170331170930.GJ13825@redhat.com>
References: <20170331164322.24020-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331164322.24020-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char: kick main loop after adding a watch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Mar 31, 2017 at 05:43:22PM +0100, Stefan Hajnoczi wrote:
> The ISA serial port device's output can hang when the pipe on stdout
> becomes full.  This is a race condition where the vcpu thread executing
> serial emulation code adds a watch on stdout while the main loop thread
> is blocked in ppoll(2).  If no timer or other event wakes up the main
> loop, there will be no further output from the serial device even when
> the pipe becomes writable.
> 
> Richard W. M. Jones was able to reproduce the hang on recent versions of
> guestfs-tools-c and libglib2 on Fedora 26 hosts.
> 
> This patch kicks the main loop so the next iteration invokes ppoll(2)
> with the watch fd.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1435432
> Reported-by: Richard W. M. Jones <rjones@redhat.com>
> Tested-by: Richard W. M. Jones <rjones@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  chardev/char.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 3df1163..6c99c34 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1059,6 +1059,11 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
>      tag = g_source_attach(src, NULL);
>      g_source_unref(src);
>  
> +    /* The main loop may be in blocked waiting on events in another thread.
> +     * Kick it so the new watch will be added.
> +     */
> +    qemu_notify_event();
> +
>      return tag;
>  }
>  

Obviously Paolo has provided further insights in the other part of
this thread, but from my point of view this does appear to fix the
problem.  I tested it on 3 different physical machines which
previously showed hangs, and on all 3 the test ran for > 30 mins
[before I killed the test] which is far longer than seen before.

Therefore: ACK.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
