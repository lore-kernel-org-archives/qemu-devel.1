Received: from eggs.gnu.org ([2001:4830:134:3::10]:43974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5Yab-0003Hh-8F
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5YaX-0000pe-4c
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:15:41 -0400
Date: Tue, 2 May 2017 16:15:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170502141520.GD5805@noname.redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
	<20170502081832.9546-16-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502081832.9546-16-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v16 15/22] file-posix: Add 'locking' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 02.05.2017 um 10:18 hat Fam Zheng geschrieben:
> Making this option available even before implementing it will let
> converting tests easier: in coming patches they can specify the option
> already when necessary, before we actually write code to lock the
> images.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c   | 5 +++++
>  qapi/block-core.json | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ade71db..0fb3b31 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -392,6 +392,11 @@ static QemuOptsList raw_runtime_opts = {
>              .type = QEMU_OPT_STRING,
>              .help = "host AIO implementation (threads, native)",
>          },
> +        {
> +            .name = "locking",
> +            .type = QEMU_OPT_STRING,
> +            .help = "file locking mode (on/off/auto, default:auto)",

There should be a space after the colon.

On the other hand, this message isn't displayed anywhere anyway...

> +        },
>          { /* end of list */ }
>      },
>  };
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1cf29a1..29d3040 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2127,11 +2127,15 @@
>  #
>  # @filename:    path to the image file
>  # @aio:         AIO backend (default: threads) (since: 2.8)
> +# @locking:     whether to enable file locking. If set to 'auto', only enable
> +#               when Open File Descriptor (OFD) locking API is available
> +#               (default: auto, since 2.10)
>  #
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsFile',
>    'data': { 'filename': 'str',
> +            '*locking': 'OnOffAuto',
>              '*aio': 'BlockdevAioOptions' } }

It's unfortunate that file-posix and file-win32 share the same QAPI
type. Should we add a file-win32 implementation that just errors out
when locking=on is specified, or is it enough that block.c notices that
there is an option that hasn't been processed? (Even locking=off would
cause failure then.)

Kevin
