Received: from eggs.gnu.org ([2001:4830:134:3::10]:56626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gClbG-00079R-I9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gClb3-0008IU-Jm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gClb3-0008G4-9A
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CDFD308403E
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 13:10:44 +0000 (UTC)
Date: Wed, 17 Oct 2018 15:10:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181017131041.GB31479@localhost.localdomain>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-39-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017082702.5581-39-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 38/38] vpc: Fail open on bad header
 checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Am 17.10.2018 um 10:27 hat Markus Armbruster geschrieben:
> vpc_open() merely prints a warning when it finds a bad header
> checksum.  Turn that into a hard error.
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/vpc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/vpc.c b/block/vpc.c
> index bf294abfa7..1729c0cb44 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -284,9 +284,11 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      checksum = be32_to_cpu(footer->checksum);
>      footer->checksum = 0;
> -    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum)
> -        fprintf(stderr, "block-vpc: The header checksum of '%s' is "
> -            "incorrect.\n", bs->filename);
> +    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum) {
> +        error_setg(errp, "incorrect header checksum");

Upper case would be more consistent with most other error messages in
the vpc driver.

> +        ret = -EINVAL;
> +        goto fail;
> +    }

With that fixed:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
