Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F7C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3DC2147A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3DC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57247 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQArC-0000um-JD
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:19:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQAe2-0005mO-2i
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQAe1-0008PG-1O
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:05:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQAe0-0008LU-Qx
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:05:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so15209801wra.3
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 06:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=6itApyjXnEbSCeJT5c9l/Z/GIJifu4LTHrClxtvqmpg=;
	b=pG3DbGQFnG7kcdgkaBOD9icSGbVf7cPkYPEzTEzIH/IxuOKskgBwDFpkV1I7qdaS7R
	vJddj7F4YYSD2rm2i+5NG0UN5ehFQLS6DRhE0HuGMG8isEj2WPNx4c4S8PvLapWm9EfA
	16VdblZkkFKgkB/hADVywkHVtWNmXyIum6wYZcbDFyKwiztbTYXWGs0++yZOn2Cj0cud
	EwMdKJaVqPck704sKfv2A5fivuMct6novNb5hEb6qF/j/u/sWPb2spAZS90CMwMVuZJL
	81fFEWGUrmFzxDQ4BYZUTDa7bqS467yw4ERuFS14TlSfxKGfDMNjdx+FTx83a8MiVaiY
	Bvkg==
X-Gm-Message-State: APjAAAUaxIQvGJ+TodNJ/LcXDxEdxO4/w6/nD6oUemkXmxz4fywUhO89
	ja3J+TWIeKrzKkxMGYjD1OZ44V98edE=
X-Google-Smtp-Source: APXvYqwByNiCAGzAfrPMzf33PHKf7w2imfCWj35SfH4eij3Z6KNMbGnDDD6pcs/ExZSso8h7pe0E8w==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr8008680wrp.322.1557752719281; 
	Mon, 13 May 2019 06:05:19 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	q4sm10246700wrx.25.2019.05.13.06.05.18
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 06:05:18 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-4-armbru@redhat.com>
	<78da03ed-2b9f-2357-6f28-44115d8b2955@redhat.com>
	<87ef527clf.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cd22d43c-6a97-1fe7-5d61-0b84e5710b4c@redhat.com>
Date: Mon, 13 May 2019 15:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ef527clf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 3/6] gdbstub: Reject invalid RLE repeat
 counts
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 2:39 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 4/18/19 4:53 PM, Markus Armbruster wrote:
>>> "Debugging with GDB / Appendix E GDB Remote Serial Protocol /
>>> Overview" specifies "The printable characters '#' and '$' or with a
>>> numeric value greater than 126 must not be used."  gdb_read_byte()
>>> only rejects values < 32.  This is wrong.  Impact depends on the caller:
>>>
>>> * gdb_handlesig() passes a char.  Incorrectly accepts '#', '$' and
>>>   '\127'.
>>>
>>> * gdb_chr_receive() passes an uint8_t.  Additionally accepts
>>>   characters with the most-significant bit set.
>>>
>>> Correct the validity check to match the specification.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  gdbstub.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index d54abd17cc..a6dce1b027 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -2064,7 +2064,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>>>              }
>>>              break;
>>>          case RS_GETLINE_RLE:
>>> -            if (ch < ' ') {
>>
>> Can you add a comment referring to the ""Debugging with GDB / Appendix E
>> GDB Remote Serial Protocol / Overview" here?
> 
> Like this?
> 
>         case RS_GETLINE_RLE:
>             /*
>              * Run-length encoding is explained in "Debugging with GDB /
>              * Appendix E GDB Remote Serial Protocol / Overview".
>              */
>             if (ch < ' ') {

Yes, thanks!

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks!
> 
>>> +            if (ch < ' ' || ch == '#' || ch == '$' || ch > 126) {
>>>                  /* invalid RLE count encoding */
>>>                  trace_gdbstub_err_invalid_repeat((uint8_t)ch);
>>>                  s->state = RS_GETLINE;
>>>

