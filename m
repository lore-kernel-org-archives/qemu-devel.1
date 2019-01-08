Received: from eggs.gnu.org ([209.51.188.92]:48973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggqJB-0004kt-Fd
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggqJA-0005oF-ME
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:16:37 -0500
Date: Tue, 8 Jan 2019 13:16:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108121625.GA11492@linux.fritz.box>
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
	<20190107184058.GN27120@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107184058.GN27120@redhat.com>
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
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 07.01.2019 um 19:40 hat Richard W.M. Jones geschrieben:
> On Mon, Jan 07, 2019 at 06:50:53PM +0100, Max Reitz wrote:
> [...]
> 
> I don't particularly care how we fix this, but it breaks the nbdkit
> tests on FreeBSD so I am keen to fix it one way or another.
> 
> > And if optreset not being available for glibc is the only issue, I'd say
> > adding it as a weak global variable would work without #ifdefs.
> 
> The weak global variable doesn't make the code "#ifdef free".  I tried
> a patch like this:
> 
> +int optreset __attribute__((weak));
> 
> ...
> 
>  static int command(...)
>  {
>    ...
>    optind = 0;
> +  optreset = 1;
>   ...
>  }
> 
> but that still doesn't work on FreeBSD.
> 
> You have to set optind=1 apparently.  So if we want to set optreset=1
> we still end up with #ifdef __FreeBSD__.  The final patch will
> end up looking something like:
> 
>  static int command(...)
>  {
>    ...
> +#ifdef __FreeBSD__
> +  optind = 1;
> +  optreset = 1;
> +#else
>    optind = 0;
> +#endif
>   ...
>  }

Unconditionally setting optind = 1 looks fine. I would, however, quote a
different part of the glibc man page (in addition or instead of the
paragraph you already quoted):

    The  variable  optind is the index of the next element to be
    processed in argv.  The system initializes this value to 1.  The
    caller can reset it to 1 to restart scanning of the same argv, or
    when scanning a new argument vector.

This makes it pretty clear that optind = 1 is fine for our case with
glibc. The FreeBSD man page still suggests that we need optreset = 1, so
I suppose we'd end up with something like:

...
optind = 1;
#ifdef __FreeBSD__
optreset = 1;
#endif
...

I think I slightly prefer the #ifdef to a weak variable, but that's
another option.

Kevin
