Received: from eggs.gnu.org ([2001:4830:134:3::10]:58077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cjnDP-0001sW-Hl
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cjnDK-0004Tq-HV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:25:47 -0500
Date: Fri, 3 Mar 2017 14:25:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170303132535.GB14351@noname.redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-6-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488491046-2549-6-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/15] sheepdog: Fix snapshot ID parsing in
 _open(), _create, _goto()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

Am 02.03.2017 um 22:43 hat Markus Armbruster geschrieben:
> sd_parse_uri() and sd_snapshot_goto() screw up error checking after
> strtoul(), and truncate long tag names silently.  Fix by replacing
> those parts by new sd_parse_snapid_or_tag(), which checks more
> carefully.
> 
> sd_snapshot_delete() also parses snapshot IDs, but is currently too
> broken for me to touch.  Mark TODO.
> 
> Two calls of strtol() without error checking remain in
> parse_redundancy().  Mark them FIXME.
> 
> More silent truncation of configuration strings remains elsewhere.
> Not marked.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 5554f47..deb110e 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -914,6 +914,49 @@ static int get_sheep_fd(BDRVSheepdogState *s, Error **errp)
>      return fd;
>  }
>  
> +/*
> + * Parse numeric snapshot ID in @str
> + * If @str can't be parsed as number, return false.
> + * Else, if the number is zero or too large, set *@snapid to zero and
> + * return true.
> + * Else, set *@snapid to the number and return true.
> + */
> +static bool sd_parse_snapid(const char *str, uint32_t *snapid)
> +{
> +    unsigned long ul;
> +    int ret;
> +
> +    ret = qemu_strtoul(str, NULL, 10, &ul);
> +    if (ret == -ERANGE) {
> +        ul = ret = 0;
> +    }
> +    if (ret) {
> +        return false;
> +    }
> +    if (ul > UINT32_MAX) {
> +        ul = 0;
> +    }
> +
> +    *snapid  = ul;

Redundant space.

> +    return true;
> +}

Looks good otherwise.

Kevin
