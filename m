Received: from eggs.gnu.org ([209.51.188.92]:45997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ggZus-0008JQ-Tz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ggZus-0005oY-4E
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:46:26 -0500
Date: Mon, 7 Jan 2019 18:40:58 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190107184058.GN27120@redhat.com>
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not
 0) before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Mon, Jan 07, 2019 at 06:50:53PM +0100, Max Reitz wrote:
[...]

I don't particularly care how we fix this, but it breaks the nbdkit
tests on FreeBSD so I am keen to fix it one way or another.

> And if optreset not being available for glibc is the only issue, I'd say
> adding it as a weak global variable would work without #ifdefs.

The weak global variable doesn't make the code "#ifdef free".  I tried
a patch like this:

+int optreset __attribute__((weak));

...

 static int command(...)
 {
   ...
   optind = 0;
+  optreset = 1;
  ...
 }

but that still doesn't work on FreeBSD.

You have to set optind=1 apparently.  So if we want to set optreset=1
we still end up with #ifdef __FreeBSD__.  The final patch will
end up looking something like:

 static int command(...)
 {
   ...
+#ifdef __FreeBSD__
+  optind = 1;
+  optreset = 1;
+#else
   optind = 0;
+#endif
  ...
 }

If you want me to submit a formal patch like this let me know.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
