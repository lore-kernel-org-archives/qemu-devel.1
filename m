Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA943C54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADED20663
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSd8Ip4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADED20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFyBI-0002Xz-BS
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 06:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFyAA-00021Q-H8
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFyA9-0006sN-5m
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:49:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFyA9-0006rl-1Q
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584874140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fP+Aa/ofD0ISRNhR6sMnT4nb+Zp6C76B0UB9KqlVOw=;
 b=BSd8Ip4dR96spLZv/31xPjaTIAhm+ehJwT7USg6P0KqV9NirLWUW1oPPnffdNOHCstt5Gl
 dGfOQE3/q6ltzd/+hlspU2ham/0pRm8ZQBxmQ1exyK1E+n028ytuFxeEPE9G8tGAFAUiMR
 uKQjUVwPbwhUvBbVHxvpzcAiH64Ot/8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-u2rpZOQePy27n7wIpz2Opg-1; Sun, 22 Mar 2020 06:48:58 -0400
X-MC-Unique: u2rpZOQePy27n7wIpz2Opg-1
Received: by mail-ed1-f70.google.com with SMTP id m24so9000717edq.8
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 03:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7BM7Wu655dkZ0ZIVZCi3dNWP8hM2B6N/tgRrda1EYuU=;
 b=K6IqqR4Dlg+ZISckO9cgwptuhSqPTlz/45G0iCb0cjehDIJ5DxAmqwte7OqyIrzL0Y
 4KA1D8ShIsnckoy0fIdvoQsY3K+fFn9wk6gvZ/YYATDJJeso3QPS3vJ5TVOtPyqZMzrf
 qRUIIwtIgn6oms9MeroT0MALr/S+Fgo+pchfsmZFCN5Vqjtq5KnLeMN4HuJVWgKJSI0a
 3JD4WEZIP86Hir+sU9Kr8n5AzBsJp8BuiE+QX42IRl4cxavLlXEZJoJwyGVXBN/0cQ3v
 2F/MnGSDpZ9wV+LBhq+DrzBtFWrkwQtKJ3Wc7uuBoUr5mhAN8UlGEBH5dzbElFdjBtVt
 +txA==
X-Gm-Message-State: ANhLgQ30rdXho9fNlhOCChmJgT01PKNgXfyQ9Bs8LzLMrANusNdYv+cr
 FTSnM8bqNqB+kt58lVLnEx4aFa4d1NmsYH4oIQsj1J0IZpejW973k7PdIDq9ULJ6Vj1guWwuhSx
 FPxdHP902RlmT7Ug=
X-Received: by 2002:a17:906:2794:: with SMTP id
 j20mr4256804ejc.157.1584874137642; 
 Sun, 22 Mar 2020 03:48:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vszMCg4oAoTTaYgzXLB/AhqBZ8uQY1G/HuuWGiAoQtke2nmZbym0HlByaygnMjph4aaC6jKCA==
X-Received: by 2002:a17:906:2794:: with SMTP id
 j20mr4256785ejc.157.1584874137434; 
 Sun, 22 Mar 2020 03:48:57 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id s17sm87883ejr.65.2020.03.22.03.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Mar 2020 03:48:56 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 2/4] tests/test-util-sockets: Skip test on
 non-x86 Travis containers
To: Cornelia Huck <cohuck@redhat.com>
References: <20200318222717.24676-1-philmd@redhat.com>
 <20200318222717.24676-3-philmd@redhat.com>
 <20200320123958.354e6cbb.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d8bb6633-5574-887d-d5bb-4725b28ee7dd@redhat.com>
Date: Sun, 22 Mar 2020 11:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320123958.354e6cbb.cohuck@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 12:39 PM, Cornelia Huck wrote:
> On Wed, 18 Mar 2020 23:27:15 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Similarly to commit 4f370b1098, test-util-sockets fails in
>> restricted non-x86 Travis containers since they apparently
>> blacklisted some required system calls there.
>=20
> Is "they" =3D=3D "Travis admins"? Can we get them to remove those calls
> from the blacklist?

I suppose, I copy/pasted Thomas's description from commit 4f370b1098.

No clue, but we can try :)

>=20
> (I'm wondering why x86 allows those calls. Probably just because it has
> been around for longer.)
>=20
>> Let's simply skip the test if we detect such an environment.
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   tests/test-util-sockets.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
>> index 5fd947c7bf..046ebec8ba 100644
>> --- a/tests/test-util-sockets.c
>> +++ b/tests/test-util-sockets.c
>> @@ -231,11 +231,18 @@ static void test_socket_fd_pass_num_nocli(void)
>>   int main(int argc, char **argv)
>>   {
>>       bool has_ipv4, has_ipv6;
>> +    char *travis_arch;
>>  =20
>>       socket_init();
>>  =20
>>       g_test_init(&argc, &argv, NULL);
>>  =20
>> +    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
>> +    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
>> +        g_printerr("Test does not work on non-x86 Travis containers.");
>> +        goto end;
>> +    }
>> +
>>       /* We're creating actual IPv4/6 sockets, so we should
>>        * check if the host running tests actually supports
>>        * each protocol to avoid breaking tests on machines
>=20


