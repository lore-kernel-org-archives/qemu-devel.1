Received: from eggs.gnu.org ([209.51.188.92]:47653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghuDX-0004tz-Am
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghuDW-0006hW-Gt
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:39:11 -0500
Date: Fri, 11 Jan 2019 11:38:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111103858.GB5010@dhcp-200-186.str.redhat.com>
References: <20190110191901.5082-1-eblake@redhat.com>
	<20190110191901.5082-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110191901.5082-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] block: Take advantage of QemuOpt
 default integers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lbloch@janustech.com, armbru@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>

Am 10.01.2019 um 20:18 hat Eric Blake geschrieben:
> Instead of defining an integer to a default string value (where we
> have to be careful how we spelled the integer because of the use of
> stringify), populate a default integer value instead.
> 
> Drop a useless stringify(0); a missing default is just as easy to
> interpret as 0 as an explicit string 0.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/vhdx.c b/block/vhdx.c
> index b785aef4b7b..54bf6805fc6 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -2085,13 +2085,12 @@ static QemuOptsList vhdx_create_opts = {
>         {
>             .name = VHDX_BLOCK_OPT_LOG_SIZE,
>             .type = QEMU_OPT_SIZE,
> -           .def_value_str = stringify(DEFAULT_LOG_SIZE),
> +           .def_value_int = DEFAULT_LOG_SIZE,
>             .help = "Log size; min 1MB."
>         },
>         {
>             .name = VHDX_BLOCK_OPT_BLOCK_SIZE,
>             .type = QEMU_OPT_SIZE,
> -           .def_value_str = stringify(0),
>             .help = "Block Size; min 1MB, max 256MB. " \
>                     "0 means auto-calculate based on image size."
>         },

Before the patch:
$ ./qemu-img create -f vhdx /tmp/test.vhdx 64M
Formatting '/tmp/test.vhdx', fmt=vhdx size=67108864 log_size=1048576 block_size=0

After the patch:
$ ./qemu-img create -f vhdx /tmp/test.vhdx 64M
Formatting '/tmp/test.vhdx', fmt=vhdx size=67108864 log_size=1048576

Intentional?

Kevin
