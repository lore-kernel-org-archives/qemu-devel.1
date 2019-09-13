Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 23:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA882083B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 23:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCq2/r4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA882083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8vTP-0002pE-Q3
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 19:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i8vSd-0002MI-7X
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 19:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i8vSb-0006DH-AP
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 19:58:43 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i8vSY-0006Az-IS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 19:58:39 -0400
Received: by mail-ed1-x542.google.com with SMTP id a23so26189780edv.5
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZhzCf5O/iwQfe3FPmra8yJP26zJl4VyE/RBkrcIHqMM=;
 b=HCq2/r4C/pwhCvr2JtbV9rJyWkg/0MtMgSUaJcUpIavAm6wzM/98V4rRqRUAUyW8VZ
 7Ah5R6VBDzRUh5a9/O2u/ElMrggq58jcKacxCfj1eu7u1S9WbPgGlh5s30iTxYHNlxID
 Erq1SWShL8fhCw97gVvQCnnp4PkaRlLOl3N68hCczGOR2actWpp2+96hgzX23trwMBNg
 ZMjdhJfFk453MiY7MSC6/Fj3wbkPIlHMq+hAlYl8A6q73GqqoSUe8kwa/JL6z/t1wmUY
 fBh2GD4rbFBy+GX1vXs9TYIibNqCYvKF7FAlBiVe0uh0OWa36lfQD4OV6A5ujjtcyI2/
 S8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZhzCf5O/iwQfe3FPmra8yJP26zJl4VyE/RBkrcIHqMM=;
 b=nnTLec6buXggw+tule2+f/HOiOqob0WPen1vZ6WYZBFdCzj/oohRNGLhj6+jzTmoOa
 eSVUvC6PnddY/0ydGsUG3X/LuSQti2qgKvXPwxTvPpaiwBlblCQyBKaiiJADiJNzd20e
 kZLTb1DJ9VVKsPwXDShxA6LjoccenPbXqgvRZOc+DncVVLsNuCDe/5fhuByEZ5Beu9xC
 4tuk/Yfk3+F3bhm+Un1ryGEXU61F0Jn9+0aALwlWbJpYemnQTTQO7aIDb1xSRJK9hBVu
 /m9YP8sr1MGLwlMozvqIC1N/C2EcXF0PnqNsiB5Wi5Y4uXlyyq2XRMpgAziGZbYVst/7
 JtRQ==
X-Gm-Message-State: APjAAAXZ7Kk9VG+ii+iO0gpbai/2ruglSSkngb9u5q/lHGtU24G1mFS2
 HxYio369WANX4w4+HKU96L0=
X-Google-Smtp-Source: APXvYqz1mhfF6cRtAkNbD05GZd6pioUZmlbg2IgTdWRjJRFjUsVndWIsiQCORZu57I1dSMqTf6MRuw==
X-Received: by 2002:a50:8d5e:: with SMTP id t30mr50630095edt.112.1568419117494; 
 Fri, 13 Sep 2019 16:58:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id q25sm5608375eds.72.2019.09.13.16.58.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Sep 2019 16:58:36 -0700 (PDT)
Date: Fri, 13 Sep 2019 23:58:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190913235836.vynt6ubiuigrsp64@master>
References: <20190712032704.7826-1-richardw.yang@linux.intel.com>
 <20190719175400.GJ3000@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719175400.GJ3000@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] migration: check length directly to make
 sure the range is aligned
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, quintela@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 06:54:00PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> Since the start addr is already checked, to make sure the range is
>> aligned, checking the length is enough.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  exec.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>> 
>> diff --git a/exec.c b/exec.c
>> index 50ea9c5aaa..8fa980baae 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -4067,10 +4067,9 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>>  
>>      if ((start + length) <= rb->used_length) {
>>          bool need_madvise, need_fallocate;
>> -        uint8_t *host_endaddr = host_startaddr + length;
>> -        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
>> -            error_report("ram_block_discard_range: Unaligned end address: %p",
>> -                         host_endaddr);
>> +        if (length & (rb->page_size - 1)) {
>> +            error_report("ram_block_discard_range: Unaligned length: %lx",
>> +                         length);
>
>Yes, I *think* this is safe, we'll need to watch out for any warnings;
>David Gibson's balloon fix from February means that the balloon code
>should now warn in it's case.
>
>rth: Want to pick this up?
>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Any other task I should do for progress?

>>              goto err;
>>          }
>>  
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

