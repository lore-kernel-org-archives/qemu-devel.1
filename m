Received: from eggs.gnu.org ([2001:4830:134:3::10]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCm9D-0007Z7-KG
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCm9A-0005zF-EO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gCm9A-0005tR-6K
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B18553081D01
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 13:45:57 +0000 (UTC)
Date: Wed, 17 Oct 2018 15:45:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181017134555.GC31479@localhost.localdomain>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-38-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017082702.5581-38-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 37/38] raw: Convert a warning to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 17.10.2018 um 10:27 hat Markus Armbruster geschrieben:
> Convert the warning about dangerous automatic probing of raw images to
> warn_report().  Split its text to conform to conventions spelled out
> in warn_report()'s contract.

One of the things the warn_report() documentation says is:

    It's wrong to call this in a QMP monitor.  Use error_setg() there.

Probably a bug in the comment (copy and paste from error_report())? The
same sentence is also there for info_report().

> Update expected output of qemu-iotest 109 accordingly.  Update
> qemu-iotest 099's output filtering to keep filtering out the warning.
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> --- a/tests/qemu-iotests/109.out
> +++ b/tests/qemu-iotests/109.out
> @@ -5,8 +5,9 @@ QA output created by 109
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
>  {"return": {}}
> -WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
> -         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
> +warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
> +Automatically detecting the format is dangerous for raw images, write
> +operations on block 0 will be restricted.
>           Specify the 'raw' format explicitly to remove the restrictions.

I honestly like the old formatting better, with indentation and without
the arbitrary \n in the error_printf() line that is probably shorter
than the warning line anyway.

Also, I know that qemu-iotests ignores whitespace for diffing the
result, but not adjusting the last line in the reference output still
looks a bit odd.

Kevin
