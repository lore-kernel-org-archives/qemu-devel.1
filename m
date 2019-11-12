Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FC8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D97206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D97206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaE6-0000vq-N1
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iUa8I-0001sj-1I
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iUa8F-0005lK-JR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:13 -0500
Received: from relay64.bu.edu ([128.197.228.104]:55481)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iUa8F-0005kZ-Fb
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:11 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: 144.121.20.162.lightower.net [144.121.20.162] (may be forged)
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id xACHcRg2028407
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
 Tue, 12 Nov 2019 12:38:27 -0500
Subject: Re: [PATCH v4 12/20] libqtest: add in-process qtest.c tx/rx handlers
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-13-alxndr@bu.edu>
 <20191106165622.GK340561@stefanha-x1.localdomain>
From: Alexander Bulekov <alxndr@bu.edu>
Message-ID: <59cab58d-1976-b22e-9459-75c8a61001cd@bu.edu>
Date: Tue, 12 Nov 2019 12:38:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191106165622.GK340561@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
X-Received-From: 128.197.228.104
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 11:56 AM, Stefan Hajnoczi wrote:
> On Wed, Oct 30, 2019 at 02:49:58PM +0000, Oleinik, Alexander wrote:
>> From: Alexander Oleinik <alxndr@bu.edu>
>>
>> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>> ---
>> There's a particularily ugly line here:
>> qtest_client_set_tx_handler(qts,
>>          (void (*)(QTestState *s, const char*, size_t)) send);
> 
> Please typedef the function pointer to avoid repetition:
> 
>    typedef void (*QTestSendFn)(QTestState *s, const char *buf, size_t len);
> 
> And then introduce a wrapper function for type-safety:
> 
>    /* A type-safe wrapper for s->send() */
>    static void send_wrapper(QTestState *s, const char *buf, size_t len)
>    {
>        s->send(s, buf, len);
>    }
> 
>    ...
> 
>    qts->send = send;
>    qtest_client_set_tx_handler(qts, send_wrapper);
> 
> Does this solve the issue?
So there should be two pointers qts->send and qts->ops->send? Otherwise 
qtest_client_set_tx_handler simply overwrites qts->send with the 
send_wrapper.

What I'm worried about is having to cast a
(void (*)(void *s, const char*, size_t) to a
(void (*)(QTestState *s, const char*, size_t)
I don't think this is defined according to the standard. If we add a 
secondary send function pointer to qts (void (*)(void *s, const char*, 
size_t)), then I think its no longer an issue, which I think is what you 
suggest above.

> By the way, I also wonder whether the size_t len arguments are necessary
> since const char *buf is a NUL-terminated C string.  The string should
> be enough since the length can be calculated from it.
I'll change it.

>> diff --git a/qtest.c b/qtest.c
>> index 9fbfa0f08f..f817a5d789 100644
>> --- a/qtest.c
>> +++ b/qtest.c
>> @@ -812,6 +812,6 @@ void qtest_server_inproc_recv(void *dummy, const char *buf, size_t size)
>>       g_string_append(gstr, buf);
>>       if (gstr->str[gstr->len - 1] == '\n') {
>>           qtest_process_inbuf(NULL, gstr);
>> -        g_string_free(gstr, true);
>> +        g_string_truncate(gstr, 0);
> 
> Ah, a fix for the bug in an earlier commit.  Please squash it.
> 
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index ff3153daf2..6143af33da 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -71,6 +71,7 @@ static void qtest_client_set_tx_handler(QTestState *s,
>>   static void qtest_client_set_rx_handler(QTestState *s,
>>           GString * (*recv)(QTestState *));
>>   
>> +static GString *recv_str;
> 
> Can this be a QTestState field?
> 


-- 
===
I recently changed my last name from Oleinik to Bulekov
===

