Received: from eggs.gnu.org ([2001:4830:134:3::10]:42844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eph0I-0006ZD-Fg
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eph0H-000652-HR
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:05:10 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
Date: Sat, 24 Feb 2018 15:04:53 -0600
MIME-Version: 1.0
In-Reply-To: <20180224154033.29559-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/7] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/24/2018 09:40 AM, Max Reitz wrote:
> This patch was generated using the following Coccinelle script:
> 

> and a bit of manual fix-up for overly long lines and three places in
> tests/check-qjson.c that Coccinelle did not find.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---

> diff --git a/block.c b/block.c
> index 814e5a02da..cb69fd7ae4 100644
> --- a/block.c
> +++ b/block.c
> @@ -1457,7 +1457,7 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
>           return NULL;
>       }
>   
> -    options = qobject_to_qdict(options_obj);
> +    options = qobject_to(options_obj, QDict);

Bikeshedding - would it read any easier as:

options = qobject_to(QDict, options_obj);

?  If so, your Coccinelle script can be touched up, and patch 2/7 swaps 
argument order around, so it would be tolerable but still slightly 
busywork to regenerate the series.  But I'm not strongly attached to 
either order, and so I'm also willing to take this as-is (especially 
since that's less work), if no one else has a strong opinion that 
swapping order would aid legibility.

Reviewed-by: Eric Blake <eblake@redhat.com>


> +++ b/block/rbd.c
> @@ -256,14 +256,14 @@ static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs_json,
>       if (!keypairs_json) {
>           return ret;
>       }
> -    keypairs = qobject_to_qlist(qobject_from_json(keypairs_json,
> -                                                  &error_abort));
> +    keypairs = qobject_to(qobject_from_json(keypairs_json, &error_abort),
> +                          QList);

The question about legibility gets a bit more obvious when you span lines.

> @@ -893,8 +893,9 @@ static void simple_number(void)
>           QNum *qnum;
>           int64_t val;
>   
> -        qnum = qobject_to_qnum(qobject_from_json(test_cases[i].encoded,
> -                                                 &error_abort));
> +        qnum = qobject_to(qobject_from_json(test_cases[i].encoded,
> +                                            &error_abort),
> +                          QNum);

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
