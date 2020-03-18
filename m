Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7893FC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFE42076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMM5ytJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFE42076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWl3-0000O2-Ct
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEWjy-000828-RJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEWjw-0007Mp-Rb
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:20:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEWjw-0007ME-Hn
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584530399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wa364ervPYI3EooDLAjbx36vUkv7jNRY4PNaA9Zcakw=;
 b=JMM5ytJPVVLcU5hgWEzlJ5N7c60bb1OsSQQYg2vq7RWjOIjLVCD7jGmGcJnQLbad1NhcPA
 S6/vvjyIhSSDzQl/z4qHQWhnSDYIHZFFO9bLny0eOfBymSN5zKHtCDHWbDoza2gpdEYn5R
 Thi4B1aRl6O37hkoxTqkIPzoTbrvOzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-5DXJ6oPKPv6oXQz7pwLfKA-1; Wed, 18 Mar 2020 07:19:55 -0400
X-MC-Unique: 5DXJ6oPKPv6oXQz7pwLfKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6B161005509;
 Wed, 18 Mar 2020 11:19:54 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E6C819757;
 Wed, 18 Mar 2020 11:19:54 +0000 (UTC)
Subject: Re: [PATCH] build: Silence clang warning on older glib autoptr usage
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200317175534.196295-1-eblake@redhat.com>
 <CAFEAcA8qGWhvoRwT1Wcg6RTWONG7gVSzGbhCFtG-AgQYwZHyQA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4880cc8b-ae70-508b-a0c1-603833699d87@redhat.com>
Date: Wed, 18 Mar 2020 06:19:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8qGWhvoRwT1Wcg6RTWONG7gVSzGbhCFtG-AgQYwZHyQA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 1:11 PM, Peter Maydell wrote:
> On Tue, 17 Mar 2020 at 17:55, Eric Blake <eblake@redhat.com> wrote:
>>
>> glib's G_DEFINE_AUTOPTR_CLEANUP_FUNC() macro defines several static
>> inline functions, often with some of them unused, but prior to 2.57.2
>> did not mark the functions as such.  As a result, clang (but not gcc)
>> fails to build with older glib unless -Wno-unused-function is enabled.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> Half-tested: I proved to myself that this does NOT enable
>> -Wno-unused-function on my setup of glib 2.62.5 and gcc 9.2.1 (Fedora
>> 31), but would do so if I introduced an intentional compile error into
>> the sample program; but Iwas unable to test that it would prevent the
>> build failure encountered by Peter on John's pull request (older glib
>> but exact version unknown, clang, on NetBSD).
> 
> This wasn't a NetBSD failure. I hit it on my clang-on-x86-64-Ubuntu
> setup, and also on FreeBSD. (The latter is just the tests/vm
> FreeBSD config, so you can repro that if you need to.)
> 
> The ubuntu setup is libglib 2.56.4-0ubuntu0.18.04.4 and
> clang 6.0.0-1ubuntu2.

Thanks; I ran:

$ make docker-test-clang@ubuntu1804 DEBUG=1
...
bash-4.4$ cat > foo.c <<\EOF
 > #include <glib.h>
 > typedef struct Foo {
 >     int i;
 > } Foo;
 > static void foo_free(Foo *f)
 > {
 >     g_free(f);
 > }
 > G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free);
 > int main(void) { return 0; }
 > EOF
bash-4.4$ clang -Wall -Werror $(pkg-config --cflags gmodule-2.0) \
   -o foo -c foo.c
...
glib_slistautoptr_cleanup_Foo
^
3 errors generated.
bash-4.4$ clang -Wall -Werror $(pkg-config --cflags gmodule-2.0) \
   -o foo -c foo.c -Wno-unused-function
bash-4.4$

to confirm that my test snippet does flush out the error in question. 
However, removing DEBUG=1 takes a long time to run (hmm, maybe I should 
set TARGET_LIST to speed it up), and did not reproduce the failure for 
me without the patch (making it hard to tell if the patch made a 
difference).  I'm still playing with testing, but at least I feel better 
that this patch is on the right track, now that I have an environment 
that can reproduce the situation.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


