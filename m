Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C723C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31B620756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoJVDz6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31B620756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkF9-0008BX-Lk
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHkC9-0002qC-FH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:50:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHkC7-0005Wq-EX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4Wo5Z2i/X/sxFOUNOUG3JHJiIJgz0itEIadPtk81WwA=;
 b=RoJVDz6dNyQUrPKn7l09bWRRg0yH5VmFXbwCOfytkEi5w8SlwzVOWRjvS26OdXntgdNWSX
 oswa1TESnHXdSuHV7qLb/0JgUb+shp9/t2+xVQ+9LAv2sJFakvBRrsx4jBk1wlcBwGyOr4
 OMh+sk1VZdTuXrPUmNR+NRUaHkagOQM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-OIm3fxgTMSO3QQwWRAXJoA-1; Mon, 14 Sep 2020 04:50:35 -0400
X-MC-Unique: OIm3fxgTMSO3QQwWRAXJoA-1
Received: by mail-wr1-f72.google.com with SMTP id w7so6657090wrp.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 01:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4Wo5Z2i/X/sxFOUNOUG3JHJiIJgz0itEIadPtk81WwA=;
 b=dgF6jy9iAfh0ypf30gwIGHPGarNFUvpb/ip8+ZuypctSW9AkkklNCam+KvHqvOGT/Z
 R50O3mL5GFX55GlbEWfS3TPniQdnOXy1vfTScjXqjU8hTT+JUEt8Ygu7DSsnQbJ7NRLf
 qSWUse2pSTuMthVUi0OOEzS79fyijvwMT4j3D2xzcHhUeFTQ8E8xGHuk1wcmLf6o/thW
 YLIa6y9m/14LRPxw0wNSA6lMhh3G5WZ9kDFlmUay4oeyqMCODS7QzslCSp98UH/NuRdP
 kpviI9jIXDx4twxAOHlV+Aua9nt2n6f0XHy7HZJHIAbS+ucP3qgv7sGfh2WfAhVRfCpz
 ndfA==
X-Gm-Message-State: AOAM531Qy0qXl9hZnyvbeeTq1B8H99nNsSlgu9+lkfo6qjSokiDlkASD
 jJPTTEUOYFPaehGafuOCi9JnrY6ihdstobmmld9tRJkJv7fmS48iAo0ZYR92F7L1GcLsHfMkx/c
 9wIRtQHoUF5+1IH0=
X-Received: by 2002:adf:8187:: with SMTP id 7mr14885731wra.266.1600073433011; 
 Mon, 14 Sep 2020 01:50:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkGbAjY05+jBiBRwWSzBHc4rhVY7y3Nc3iD+ssMbXbmZAmqGW6IbHvpX6P3OXPqsJiAJKiIQ==
X-Received: by 2002:adf:8187:: with SMTP id 7mr14885693wra.266.1600073432697; 
 Mon, 14 Sep 2020 01:50:32 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k4sm19974545wrx.51.2020.09.14.01.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 01:50:32 -0700 (PDT)
Subject: Re: [PATCH v8 16/27] cirrus: Building freebsd in a single short
To: Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-devel@nongnu.org
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-17-luoyonggang@gmail.com>
 <78c65c60-9598-97a2-0dc7-116c3c0f94a9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <401c7ac1-6575-1d77-40ef-a4ee4178711b@redhat.com>
Date: Mon, 14 Sep 2020 10:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <78c65c60-9598-97a2-0dc7-116c3c0f94a9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Ed Maste <emaste@FreeBSD.org>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 9:27 AM, Thomas Huth wrote:
> On 13/09/2020 00.44, Yonggang Luo wrote:
>> This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba
>> ("cirrus.yml: Split FreeBSD job into two parts").
>>
>> freebsd 1 hour limit not hit anymore
>>
>> I think we going to a wrong direction, I think there is some tests a stall the test runner,
>> please look at
>> https://cirrus-ci.com/task/5110577531977728
>> When its running properly, the consumed time are little, but when tests running too long,
>> look at the cpu usage, the cpu usage are nearly zero. doesn't consuming time.
>>
>> And look at
>> https://cirrus-ci.com/task/6119341601062912
>>
>> If the tests running properly, the time consuming are little
>> We should not hide the error by split them
>>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: Ed Maste <emaste@FreeBSD.org>
>> ---
>>  .cirrus.yml | 35 ++++++++---------------------------
>>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> I tried this a couple of times now, and currently the problem seems to
> be gone, indeed. I'd still prefer to understand first why we have seen
> the slowdown a couple of weeks ago, but if people agree that we should
> revert the patch now, that's ok for me now, too.

Not sure if related (probably not as failure and not timeout),
I hit this during the night:

  TEST    iotest-qcow2: 030 [fail]
QEMU          --
"/tmp/cirrus-ci-build/build/tests/qemu-iotests/../../qemu-system-alpha"
-nodefaults -display none -accel qtest
QEMU_IMG      --
"/tmp/cirrus-ci-build/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/tmp/cirrus-ci-build/build/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      --
"/tmp/cirrus-ci-build/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 cirrus-task-6204750985166848 12.1-RELEASE
TEST_DIR      -- /tmp/cirrus-ci-build/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.VuwmKXUW
SOCKET_SCM_HELPER --
--- /tmp/cirrus-ci-build/tests/qemu-iotests/030.out	2020-09-13
21:08:32.261276000 +0000
+++ /tmp/cirrus-ci-build/build/tests/qemu-iotests/030.out.bad	2020-09-13
21:30:59.736699000 +0000
@@ -1,5 +1,17 @@
-...........................
+.............F.............
+======================================================================
+FAIL: test_stream_parallel (__main__.TestParallelOps)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "030", line 251, in test_stream_parallel
+    self.assert_qmp(result, 'return', {})
+  File "/tmp/cirrus-ci-build/tests/qemu-iotests/iotests.py", line 888,
in assert_qmp
+    result = self.dictpath(d, path)
+  File "/tmp/cirrus-ci-build/tests/qemu-iotests/iotests.py", line 862,
in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not found"}}"
+
+----------------------------------------------------------------------
Failures: 030
Failed 1 of 74 iotests
gmake[1]: *** [/tmp/cirrus-ci-build/tests/Makefile.include:144:
check-block] Error 1
gmake[1]: Leaving directory '/tmp/cirrus-ci-build/build'

https://cirrus-ci.com/task/6204750985166848


