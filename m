Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2ABC31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09B520866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09B520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasBT-0001Ot-BE
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 21:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52038)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1has67-0000Se-11
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1has65-0008Kw-4j
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:30:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:22072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1has64-0008JE-PY
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:30:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jun 2019 18:30:30 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 11 Jun 2019 18:30:29 -0700
Date: Wed, 12 Jun 2019 09:30:05 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190612013005.GA31921@richard>
References: <20190610030852.16039-1-richardw.yang@linux.intel.com>
 <20190610030852.16039-3-richardw.yang@linux.intel.com>
 <20190611175926.GJ2777@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611175926.GJ2777@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/xbzrle: make
 xbzrle_encode_buffer little easier to read
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11, 2019 at 06:59:26PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> The encoding process could be described below:
>> 
>>     for [content]
>>         get length of a run
>>         encode this run
>> 
>> By refactoring the code with this logic, it maybe a little easier to
>> understand.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/xbzrle.c | 153 +++++++++++++++++++++------------------------
>>  1 file changed, 73 insertions(+), 80 deletions(-)
>> 
>> diff --git a/migration/xbzrle.c b/migration/xbzrle.c
>> index 1ba482ded9..25c69708ec 100644
>> --- a/migration/xbzrle.c
>> +++ b/migration/xbzrle.c
>> @@ -14,6 +14,59 @@
>>  #include "qemu/cutils.h"
>>  #include "xbzrle.h"
>>  
>> +static int next_run(uint8_t *old_buf, uint8_t *new_buf, int off, int slen,
>> +                    bool zrun)
>> +{
>> +    uint32_t len = 0;
>> +    long res;
>> +
>> +    res = (slen - off) % sizeof(long);
>> +
>> +    /* first unaligned bytes */
>> +    while (res) {
>> +        uint8_t xor = old_buf[off + len] ^ new_buf[off + len];
>> +
>> +        if (!(zrun ^ !!xor)) {
>> +            break;
>> +        }
>> +        len++;
>> +        res--;
>> +    }
>> +
>> +    if (res) {
>> +        return len;
>> +    }
>> +
>> +    /* word at a time for speed, use of 32-bit long okay */
>> +    while (off + len < slen) {
>> +        /* truncation to 32-bit long okay */
>> +        unsigned long mask = (unsigned long)0x0101010101010101ULL;
>> +        long xor = (*(long *)(old_buf + off + len)) ^
>> +                   (*(long *)(new_buf + off + len));
>> +
>> +        if (zrun && !(zrun ^ !!xor)) {
>
>Are lines like this really making it easier to read?
>

BTW, this line could be simplified to 

        if (!(zrun ^ !!xor)) {

>Juan: Opinion?
>
>Dave
>

-- 
Wei Yang
Help you, Help me

