Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94242C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662B92053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662B92053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2fj-0000I4-C5
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 16:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iB2d1-0005cB-Dv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iB2Sn-0003iK-Cz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:51:38 -0400
Received: from relay64.bu.edu ([128.197.228.104]:41045)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iB2Sn-0003hj-88
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:51:37 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id x8JJol2Z016355
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
 Thu, 19 Sep 2019 15:50:47 -0400
Subject: Re: [PATCH v3 13/22] libqtest: make qtest_bufwrite send "atomic"
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-14-alxndr@bu.edu>
 <20190919103741.GO3606@stefanha-x1.localdomain>
 <da63050e-73b2-d9ac-112b-75b9a7caa54d@redhat.com>
From: Alexander Oleinik <alxndr@bu.edu>
Message-ID: <3e6476e5-7632-5e2d-5270-b14599ffba35@bu.edu>
Date: Thu, 19 Sep 2019 15:50:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <da63050e-73b2-d9ac-112b-75b9a7caa54d@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 2:56 PM, John Snow wrote:
> 
> 
> On 9/19/19 6:37 AM, Stefan Hajnoczi wrote:
>> On Wed, Sep 18, 2019 at 11:19:40PM +0000, Oleinik, Alexander wrote:
>>> When using qtest "in-process" communication, qtest_sendf directly calls
>>> a function in the server (qtest.c). Combining the contents of the
>>> subsequent socket_sends into the qtest_sendf, makes it so the server can
>>> immediately handle the command, without building a local buffer and
>>> waiting for a newline.
>>>
>>> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>>> ---
>>>   tests/libqtest.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>>> index 19feea9e17..d770462869 100644
>>> --- a/tests/libqtest.c
>>> +++ b/tests/libqtest.c
>>> @@ -1086,9 +1086,7 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
>>>       gchar *bdata;
>>>   
>>>       bdata = g_base64_encode(data, size);
>>> -    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
>>> -    socket_send(s->fd, bdata, strlen(bdata));
>>> -    socket_send(s->fd, "\n", 1);
>>> +    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx %s\n", addr, size, bdata);
>>>       qtest_rsp(s, 0);
>>>       g_free(bdata);
>>>   }
>>> -- 
>>> 2.23.0
>>
>> Cc John Snow, who added the b64write command.
>>
>> The downside to doing this is that sprintf-formatting needs to be
>> performed on the entire base64 buffer.  This slows things down slightly
>> and a larger temporary buffer needs to be allocated, but I'm not sure it
>> matters.
>>
> 
> *struggles to remember*
> 
> I guess I wanted something that had some space savings while maintaining
> some semblance of debuggability. This is almost certainly meant for AHCI
> tests where it's writing various patterns to large blocks of memory.
> 
> I doubt I really measured the performance of it, but it seemed like the
> way to go for transferring medium amounts of data at the time via the
> qtest protocol.
> 
> Looks like I am the only user of it, still:
> 
> tests/ahci-test.c:    qtest_bufwrite(ahci->parent->qts, ptr, tx, bufsize);
> tests/ahci-test.c:    qtest_bufwrite(ahci->parent->qts, ptr, tx, bufsize);
> tests/libqos/ahci.c:        qtest_bufwrite(ahci->parent->qts, ptr,
> buffer, bufsize);
> 
> The buffers can be quite large, so you might be re-buffering a decent
> amount of data from the sender now.
> 
> 1, Are large transfers like this guaranteed to be atomic anyway? What
> kind of socket is it? we're probably eclipsing frame and packet sizes here.
> 
> 2, I am not sure what being "atomic" affords us in terms of allowing the
> server to not wait for newlines, how does this change help?
> 
> --js
> 
I'm modifying qtest to allow the server and client to co-exist within
the same process (facilitating coverage-guided fuzzing). One of the
modifications is making qtest_sendf directly call a function in
qtest.c. All the other qtest commands are sent with a single
qtest_sendf call, so the qtest.c function could immediately call
qtest_process_command. This breaks if the command is sent with
different qtest_send/socket_send calls, as in b64write.

It should be simple to change qtest_server_inproc_recv (the qtest.c 
receiver) to
wait for an "\n" prior to qtest_process_command, so I will probably do 
that and
then normal(socket) qtest will keep the memory-reduction benefits of the
non-"atomic" approach.

As a side note, would qtest_memwrite, also benefit from splitting up the 
send
command?

      for (i = 0; i < size; i++) {
          sprintf(&enc[i * 2], "%02x", ptr[i]);
      }

      qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
      qtest_rsp(s, 0);
      g_free(enc);

