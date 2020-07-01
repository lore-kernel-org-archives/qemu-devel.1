Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6659FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 22:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8932082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 22:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJ1I8heJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8932082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqlTQ-0004wr-Ec
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 18:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1jqlSJ-0004PH-9a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 18:43:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1jqlQv-0003tv-J3
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 18:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593643344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YP51gbz2eFPGvHNAZn6Mpz/3yjbOdqbadWGyF3fyGtw=;
 b=VJ1I8heJiDIwCZoMX5H7MaCscH6rSe82HIpBOAlrZUC/6MLnkw6RrDxjR/RthODSyYheRe
 YrBYKsFTGrI5oleNre1E87ej2ZIlMPToo6bNzBv7+fggPK3JiKlMzE5qDmMcyaH1LkrbaR
 66rggD6I0XbIxZR9/8zTDlLjghWzwZg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-KM31f6UBOo6uUo-uoF_daw-1; Wed, 01 Jul 2020 18:42:21 -0400
X-MC-Unique: KM31f6UBOo6uUo-uoF_daw-1
Received: by mail-qt1-f200.google.com with SMTP id o11so17874607qti.23
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 15:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YP51gbz2eFPGvHNAZn6Mpz/3yjbOdqbadWGyF3fyGtw=;
 b=LR4xX/2FvdqBFGbcOoz0vOEc/2l5fIk5GjKJ1vl9N9HHq5/tRSAoAfTqWwffYF7zQs
 F1N4ZNQYZcrr/20mWcrKpBKF4Lc5QePtt/OHWKafNU9q9mQWIqPs3J0WGHZu/Xy59t4w
 SunzjO8mrx2HQmWb09tBEV7mj/cDjVb7wnLUAtRfvnXxQ7zPlISvHXB46RgFE4a4mkh9
 EyuJGgjAuyLDZHsZfQErL1uBg1SZ+mBbPz3/Cs8xJ7SLnn/x7h17+pR6MgolAJXYNtwx
 rxaCTcvjgpVODdG3yKsiicZdU8cTT1kwqG7jBL2V7kKR9bxIcIMNmGJ0T+EtR1cKSvuV
 onwQ==
X-Gm-Message-State: AOAM531NVzOi+ms/NayuGjlDGR6CJJmD1zF+XBPcOtuLo4zfGgfC+WJs
 805B9wc9lt8qYmtDnAC8dEDNOLQHj95VgWwk/ci+1JCPmt4hQVczsUa6AseMXFLLNcQ4poCelEY
 frYiA/iKoVmkicPk=
X-Received: by 2002:ac8:4411:: with SMTP id j17mr28208692qtn.77.1593643340983; 
 Wed, 01 Jul 2020 15:42:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxuxeQMXI9tFpcEM6J9ofI/wy/zw3uH6UOaJvc2CIlfdZfgqy5ToBSaoNtSW2RQdp1Ga2Vxw==
X-Received: by 2002:ac8:4411:: with SMTP id j17mr28208673qtn.77.1593643340708; 
 Wed, 01 Jul 2020 15:42:20 -0700 (PDT)
Received: from [192.168.0.172] (c-71-63-171-240.hsd1.or.comcast.net.
 [71.63.171.240])
 by smtp.gmail.com with ESMTPSA id k45sm7997921qtc.62.2020.07.01.15.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 15:42:20 -0700 (PDT)
Subject: Re: [PATCH] block: Raise an error when backing file parameter is an
 empty string
From: Connor Kuehl <ckuehl@redhat.com>
To: kwolf@redhat.com, mreitz@redhat.com
References: <20200617182725.951119-1-ckuehl@redhat.com>
Message-ID: <47f5b1fe-e6cd-2302-e36f-5ad071cd3374@redhat.com>
Date: Wed, 1 Jul 2020 15:42:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617182725.951119-1-ckuehl@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 18:42:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin & Max,

Just pinging this patch for your consideration.

Thank you,

Connor

On 6/17/20 11:27 AM, Connor Kuehl wrote:
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
> ---
>   block.c                    |  4 ++++
>   tests/qemu-iotests/298     | 47 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/298.out |  5 ++++
>   tests/qemu-iotests/group   |  1 +
>   4 files changed, 57 insertions(+)
>   create mode 100755 tests/qemu-iotests/298
>   create mode 100644 tests/qemu-iotests/298.out
> 
> diff --git a/block.c b/block.c
> index 6dbcb7e083..b335d6bcb2 100644
> --- a/block.c
> +++ b/block.c
> @@ -6116,6 +6116,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
>                                "same filename as the backing file");
>               goto out;
>           }
> +        if (backing_file[0] == '\0') {
> +            error_setg(errp, "Expected backing file name, got empty string");
> +            goto out;
> +        }
>       }
>   
>       backing_fmt = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
> new file mode 100755
> index 0000000000..1e30caebec
> --- /dev/null
> +++ b/tests/qemu-iotests/298
> @@ -0,0 +1,47 @@
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
> +        actual = iotests.qemu_img_pipe(
> +                'create',
> +                '-f', 'qcow2',
> +                '-b', '',
> +                '/tmp/foo'
> +        )
> +        expected = 'qemu-img: /tmp/foo: Expected backing file name,' \
> +                   ' got empty string'
> +
> +        self.assertEqual(actual.strip(), expected.strip())
> +
> +
> +if __name__ == '__main__':
> +    iotests.main(supported_fmts=['raw', 'qcow2'])
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
> index d886fa0cb3..4bca2d9e05 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -302,3 +302,4 @@
>   291 rw quick
>   292 rw auto quick
>   297 meta
> +298 img auto quick
> 


