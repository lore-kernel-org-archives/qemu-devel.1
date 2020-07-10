Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31676C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16B520720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCFyDPc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16B520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvQd-0004D9-AR
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1jtvPW-0003PM-IP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:58:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1jtvPU-0001VG-Ej
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594396679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNFbfs70ZmUcK7BasdGtDzQq1AkBRMENe8EnHb3YKPo=;
 b=dCFyDPc0DNNm8mJVGQtbvNl4PeXmTcK6vztB36rcuG6eKqw8E+SKNWZabgPFjjppObf4tl
 XfRUwBqDEYVA9JA2fDG7YS9Q0XtXqi2TaOehn+tBMs2V8bdPIY9gEB9lrZeGt2O2KtuWqv
 3CkNf0MMP9yQ+zQTZ0RNpa8Sg2FmXdc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-k1PaSkMzN7ytFmqQqxMOUA-1; Fri, 10 Jul 2020 11:57:56 -0400
X-MC-Unique: k1PaSkMzN7ytFmqQqxMOUA-1
Received: by mail-il1-f200.google.com with SMTP id l17so3970375ilj.17
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yNFbfs70ZmUcK7BasdGtDzQq1AkBRMENe8EnHb3YKPo=;
 b=jO63SRRCA65oKjYgYRzgwNnr5dCGKSdhXQlPi9og027GGtDrtSu6NQ6J0TCiMrnyDm
 YAYAdt8AX5HuOvR5dA5rZXJb89WrYGnPHuxETEmbLtNFhM+hP5AQnYHMKijgQkic6sA5
 hU1gRXFi8jYZYhts9Y20Tj1pmsttnsPegOGFSj3GkfhX94B3wBcKqA7D2y/JBSuBmdum
 nGeUQ/CsudLIkJ5UOPSWBXQB1BKBW/uyWeuRyxUmiHAyfL2mAztda/HCxpvZmLhOCgoX
 7PgUfTV69Azka5iH//vpa+yi0UoESeniuANSdaJfeO1lH/rAHBuD5Xqp51ntYxf1Brke
 /J5Q==
X-Gm-Message-State: AOAM530U2qnzVTNOeUYkuV7PzIXryN+Y2uagGkeyKJYQFnu1YAIVvz8L
 U3LT9ZxkgEUQxkSqpGbBdo6P9oNc3xLdqAybwsGpOv93EV783N91MeUh/zDeIwWmUHgU3ig45QF
 NIBGXCd1Ca8MyN9w=
X-Received: by 2002:a92:10a:: with SMTP id 10mr50554538ilb.172.1594396676166; 
 Fri, 10 Jul 2020 08:57:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz51c9ELvuSSjcKCFpB8IBaUwT74scjiJlnhYhGZcO90VgyQkTC+1fkczXvA4dIE2pdYi6DBg==
X-Received: by 2002:a92:10a:: with SMTP id 10mr50554508ilb.172.1594396675858; 
 Fri, 10 Jul 2020 08:57:55 -0700 (PDT)
Received: from [192.168.0.172] (c-71-63-171-240.hsd1.or.comcast.net.
 [71.63.171.240])
 by smtp.gmail.com with ESMTPSA id r15sm3492975ilh.86.2020.07.10.08.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 08:57:55 -0700 (PDT)
Subject: Re: [PATCH] block: Raise an error when backing file parameter is an
 empty string
From: Connor Kuehl <ckuehl@redhat.com>
To: kwolf@redhat.com, mreitz@redhat.com
References: <20200617182725.951119-1-ckuehl@redhat.com>
 <47f5b1fe-e6cd-2302-e36f-5ad071cd3374@redhat.com>
Message-ID: <27d37640-d563-c4c9-52f5-f26b025d17fc@redhat.com>
Date: Fri, 10 Jul 2020 08:57:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <47f5b1fe-e6cd-2302-e36f-5ad071cd3374@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping

On 7/1/20 3:42 PM, Connor Kuehl wrote:
> Hi Kevin & Max,
> 
> Just pinging this patch for your consideration.
> 
> Thank you,
> 
> Connor
> 
> On 6/17/20 11:27 AM, Connor Kuehl wrote:
>> Providing an empty string for the backing file parameter like so:
>>
>>     qemu-img create -f qcow2 -b '' /tmp/foo
>>
>> allows the flow of control to reach and subsequently fail an assert
>> statement because passing an empty string to
>>
>>     bdrv_get_full_backing_filename_from_filename()
>>
>> simply results in NULL being returned without an error being raised.
>>
>> To fix this, let's check for an empty string when getting the value from
>> the opts list.
>>
>> Reported-by: Attila Fazekas <afazekas@redhat.com>
>> Fixes: https://bugzilla.redhat.com/1809553
>> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
>> ---
>>   block.c                    |  4 ++++
>>   tests/qemu-iotests/298     | 47 ++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/298.out |  5 ++++
>>   tests/qemu-iotests/group   |  1 +
>>   4 files changed, 57 insertions(+)
>>   create mode 100755 tests/qemu-iotests/298
>>   create mode 100644 tests/qemu-iotests/298.out
>>
>> diff --git a/block.c b/block.c
>> index 6dbcb7e083..b335d6bcb2 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6116,6 +6116,10 @@ void bdrv_img_create(const char *filename, 
>> const char *fmt,
>>                                "same filename as the backing file");
>>               goto out;
>>           }
>> +        if (backing_file[0] == '\0') {
>> +            error_setg(errp, "Expected backing file name, got empty 
>> string");
>> +            goto out;
>> +        }
>>       }
>>       backing_fmt = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
>> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
>> new file mode 100755
>> index 0000000000..1e30caebec
>> --- /dev/null
>> +++ b/tests/qemu-iotests/298
>> @@ -0,0 +1,47 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Copyright (C) 2020 Red Hat, Inc.
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +
>> +
>> +
>> +# Regression test for avoiding an assertion when the 'backing file'
>> +# parameter (-b) is set to an empty string for qemu-img create
>> +#
>> +#   qemu-img create -f qcow2 -b '' /tmp/foo
>> +#
>> +# This ensures the invalid parameter is handled with a user-
>> +# friendly message instead of a failed assertion.
>> +
>> +import iotests
>> +
>> +class TestEmptyBackingFilename(iotests.QMPTestCase):
>> +
>> +
>> +    def test_empty_backing_file_name(self):
>> +        actual = iotests.qemu_img_pipe(
>> +                'create',
>> +                '-f', 'qcow2',
>> +                '-b', '',
>> +                '/tmp/foo'
>> +        )
>> +        expected = 'qemu-img: /tmp/foo: Expected backing file name,' \
>> +                   ' got empty string'
>> +
>> +        self.assertEqual(actual.strip(), expected.strip())
>> +
>> +
>> +if __name__ == '__main__':
>> +    iotests.main(supported_fmts=['raw', 'qcow2'])
>> diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
>> new file mode 100644
>> index 0000000000..ae1213e6f8
>> --- /dev/null
>> +++ b/tests/qemu-iotests/298.out
>> @@ -0,0 +1,5 @@
>> +.
>> +----------------------------------------------------------------------
>> +Ran 1 tests
>> +
>> +OK
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index d886fa0cb3..4bca2d9e05 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -302,3 +302,4 @@
>>   291 rw quick
>>   292 rw auto quick
>>   297 meta
>> +298 img auto quick
>>
> 


