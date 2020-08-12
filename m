Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8EC2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sxh3Z6kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8EC2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5kit-00019C-6Z
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 02:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k5kiH-0000cp-W7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:58:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k5kiF-0004a0-3m
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597215493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YbPw+XunWdacl8A6u6cZs/Y7S4UboKpR75P+EZBH96M=;
 b=Sxh3Z6kQJXLyHTcV5VIZxAdHHNuoxEhc4Pv4NPIdi3OQHkEMcNev2HLsx3GLW/OVI83Fum
 c9RQiHJw3C9Fga9HAFGr2dL00FcpXU8bm5XnrhKqBpckBCXiMwexTTVFayCB2mUDyW4HtY
 9ONrl73+oGy1Rv3L/DGKVXxlv57C5LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-wuq3FTzzOmyisE2ukSF2NQ-1; Wed, 12 Aug 2020 02:58:10 -0400
X-MC-Unique: wuq3FTzzOmyisE2ukSF2NQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7086558;
 Wed, 12 Aug 2020 06:58:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-134.ams2.redhat.com [10.36.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EBD419D7B;
 Wed, 12 Aug 2020 06:58:08 +0000 (UTC)
Date: Wed, 12 Aug 2020 08:58:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH v2] block: Raise an error when backing file parameter is
 an empty string
Message-ID: <20200812065806.GA6587@linux.fritz.box>
References: <20200811212318.708290-1-ckuehl@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200811212318.708290-1-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 02:58:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.08.2020 um 23:23 hat Connor Kuehl geschrieben:
> Providing an empty string for the backing file parameter like so:
> 
> 	qemu-img create -f qcow2 -b '' /tmp/foo
> 
> allows the flow of control to reach and subsequently fail an assert
> statement because passing an empty string to
> 
> 	bdrv_get_full_backing_filename_from_filename()
> 
> simply results in NULL being returned without an error being raised.
> 
> To fix this, let's check for an empty string when getting the value from
> the opts list.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Fixes: https://bugzilla.redhat.com/1809553
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>

In 'qemu-img rebase' we accept an empty string to mean "no backing
file". I guess it would be a bit more consistent to do the same here,
though of course there is no real reason to use -b '' in 'create'. So I
don't really mind an error either, I just wanted to mention it.

> v2:
>   - Removed 4 spaces to resolve pylint warning
>   - Updated format to be 'iotests.imgfmt' instead
>     of hardcoding 'qcow2'
>   - Use temporary file instead of '/tmp/foo'
>   - Give a size parameter to qemu-img
>   - Run test for qcow2, qcow, qed and *not* raw
> 
>  block.c                    |  4 ++++
>  tests/qemu-iotests/298     | 49 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/298.out |  5 ++++

We have multiple series using 298. You were first, though, so in case of
doubt, the others will have to rebase.

>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 59 insertions(+)
>  create mode 100755 tests/qemu-iotests/298
>  create mode 100644 tests/qemu-iotests/298.out
> 
> diff --git a/block.c b/block.c
> index d9ac0e07eb..1f72275b87 100644
> --- a/block.c
> +++ b/block.c
> @@ -6117,6 +6117,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
>                               "same filename as the backing file");
>              goto out;
>          }
> +        if (backing_file[0] == '\0') {
> +            error_setg(errp, "Expected backing file name, got empty string");
> +            goto out;
> +        }
>      }
>  
>      backing_fmt = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
> new file mode 100755
> index 0000000000..879dae2d8e
> --- /dev/null
> +++ b/tests/qemu-iotests/298
> @@ -0,0 +1,49 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (C) 2020 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +
> +
> +# Regression test for avoiding an assertion when the 'backing file'
> +# parameter (-b) is set to an empty string for qemu-img create
> +#
> +#   qemu-img create -f qcow2 -b '' /tmp/foo
> +#
> +# This ensures the invalid parameter is handled with a user-
> +# friendly message instead of a failed assertion.
> +
> +import iotests
> +
> +class TestEmptyBackingFilename(iotests.QMPTestCase):
> +
> +
> +    def test_empty_backing_file_name(self):
> +        with iotests.FilePath('test.img') as img_path:
> +            actual = iotests.qemu_img_pipe(
> +                'create',
> +                '-f', iotests.imgfmt,
> +                '-b', '',
> +                img_path,
> +                '1M'
> +            )
> +            expected = f'qemu-img: {img_path}: Expected backing file name,' \
> +                       ' got empty string'
> +
> +            self.assertEqual(actual.strip(), expected.strip())
> +
> +
> +if __name__ == '__main__':
> +    iotests.main(supported_fmts=['qed', 'qcow', 'qcow2'])

This looks like a test case that would be better served by not using
QMPTestCase, but just printing the qemu-img output and having the
message compared against the reference output.

In fact, there is already 049 for testing some qemu-img create options
and we could just add a line there (or multiple lines to cover other
backing file related error cases, too).

Putting it there would both simplify the test code and keep 298 free for
the other series.

> diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
> new file mode 100644
> index 0000000000..ae1213e6f8
> --- /dev/null
> +++ b/tests/qemu-iotests/298.out
> @@ -0,0 +1,5 @@
> +.
> +----------------------------------------------------------------------
> +Ran 1 tests
> +
> +OK
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 025ed5238d..6f80c884a1 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -306,6 +306,7 @@
>  295 rw
>  296 rw
>  297 meta
> +298 img auto quick
>  299 auto quick
>  301 backing quick
>  302 quick

None of the above is really a reason to reject the patch. I guess this
is more of a "are you sure? (y/n)" before I apply it. :-)

Kevin


