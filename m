Received: from eggs.gnu.org ([2001:4830:134:3::10]:43888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1THw-0004qo-FS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1THr-0004gD-F4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:19:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e1THr-0004fw-8i
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:19:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C29383F3F
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 08:19:42 +0000 (UTC)
Date: Mon, 9 Oct 2017 16:19:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171009081938.GD2196@pxdev.xzpeter.org>
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004103933.7898-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Add basic migration precopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Oct 04, 2017 at 12:39:28PM +0200, Juan Quintela wrote:

[...]

(having some unit tests for migration is really good...)

> +static void test_precopy(const char *uri)
> +{
> +    QTestState *from, *to;
> +
> +    test_migrate_start(&from, &to, uri);
> +
> +    /* We want to pick a speed slow enough that the test completes
> +     * quickly, but that it doesn't complete precopy even on a slow
> +     * machine, so also set the downtime.
> +     */
> +    /* 100 ms */
> +    migrate_set_parameter(from, "downtime-limit", "100");
> +    /* 1MB/s slow*/

This is 100MB/s?

> +    migrate_set_parameter(from, "max-bandwidth", "100000000");
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    migrate(from, uri);
> +
> +    wait_for_migration_pass(from);
> +
> +    /* 1GB/s now it should converge */
> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");

Curious: would it possible that 1GB/s won't suffice in some cases?
Is there any reason behind this 1GB/s value?

(I agree with Thomas that it would be good to work upon the existing
 postcopy-test.c file, at least easier to review :)

Thanks,

-- 
Peter Xu
