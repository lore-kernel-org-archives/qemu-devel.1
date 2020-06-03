Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78BEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 02:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74002206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 02:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiFXtGeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74002206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgJAr-00047e-Hn
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 22:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgJA7-0003RN-NC
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 22:29:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43432
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgJA6-0002bI-A9
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 22:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591151389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hml5efEWrCr1YEEtEHWpl6G6R7/5CFIjHNlgQ1xx+aw=;
 b=EiFXtGeA1Vd2vDIakhYj6FKmrrl9LppVxoT1InJOX9NZYACo+ol95pTzvXnE5l+3ThWlFL
 Dwy2hxfNXZ4dZ4cyUmy5y+67Ky5JfhgNoc1Jem4e3ktT3wbuAFMBFP5RAQBddaZBmq/cwL
 spEKOdqkEPAkkcldU4VC5CILc5E9BWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-l14hWwGPObiU7XgRvZ45pg-1; Tue, 02 Jun 2020 22:29:42 -0400
X-MC-Unique: l14hWwGPObiU7XgRvZ45pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A67A81009600;
 Wed,  3 Jun 2020 02:29:41 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B2587F0B5;
 Wed,  3 Jun 2020 02:29:37 +0000 (UTC)
Subject: Re: [PATCH v3] osdep: Make MIN/MAX evaluate arguments only once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200603013603.2400199-1-eblake@redhat.com>
 <03a13d47-fe7d-88e5-b92e-3c396591f9c7@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ecef14ce-47ca-749e-25b4-8e3ee378bd34@redhat.com>
Date: Tue, 2 Jun 2020 21:29:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <03a13d47-fe7d-88e5-b92e-3c396591f9c7@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 20:15:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 crosthwaite.peter@gmail.com, quintela@redhat.com, f4bug@amsat.org,
 dgilbert@redhat.com, kraxel@redhat.com, dirty.ice.hu@gmail.com,
 pbonzini@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 9:07 PM, Richard Henderson wrote:
> On 6/2/20 6:36 PM, Eric Blake wrote:
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -176,11 +176,9 @@ extern unsigned long reserved_va;
>>    * avoid setting bits at the top of guest addresses that might need
>>    * to be used for tags.
>>    */
>> -#if MIN(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32
>> -# define GUEST_ADDR_MAX_  UINT32_MAX
>> -#else
>> -# define GUEST_ADDR_MAX_  (~0ul)
>> -#endif
>> +#define GUEST_ADDR_MAX_                                                 \
>> +    ((MIN_CONST(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) ?  \
>> +     UINT32_MAX : ~0ul)
> 
> This new expression is a type promotion to unsigned long...
> 
>>   #define GUEST_ADDR_MAX    (reserved_va ? reserved_va - 1 : GUEST_ADDR_MAX_)
> 
> ... which is probably ok, since it would be done here anyway.
> But I did wonder why the change.

Because:

#if MIN(...)

now fails to compile (you can't have { in a preprocessor expression), and:

#if MIN_CONST(...)

fails to compile (__builtin_constant_p() is not a preprocessor macro, so 
it warns that it is being treated as 0).  The only fix is to move the 
MIN() out of the #if and into the #define.

> 
>> +/*
>> + * Two variations of MIN/MAX macros. The first is for runtime use, and
>> + * evaluates arguments only once (so it is safe even with side
>> + * effects), but will not work in constant contexts (such as array
>> + * size declarations).  The second is for compile-time use, where
>> + * evaluating arguments twice is safe because the result is going to
>> + * be constant anyway.
>> + */
>> +#undef MIN
>> +#define MIN(a, b)                                       \
>> +    ({                                                  \
>> +        typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
>> +        _a < _b ? _a : _b;                              \
>> +    })
>> +#define MIN_CONST(a, b)                                         \
>> +    __builtin_choose_expr(                                      \
>> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
>> +        (a) < (b) ? (a) : (b),                                  \
>> +        __builtin_unreachable())
> 
> Is it possible to use qemu_build_not_reached?

Possibly.

/me goes and recompiles; touching osdep.h recompiles the world...

No, it blows up hard, because qemu_build_not_reached() is not embeddable 
in an expression:

In file included from /usr/lib64/glib-2.0/include/glibconfig.h:9,
                  from /usr/include/glib-2.0/glib/gtypes.h:32,
                  from /usr/include/glib-2.0/glib/galloca.h:32,
                  from /usr/include/glib-2.0/glib.h:30,
                  from /home/eblake/qemu/include/glib-compat.h:32,
                  from /home/eblake/qemu/include/qemu/osdep.h:126,
                  from /home/eblake/qemu/qemu-io-cmds.c:11:
/home/eblake/qemu/qemu-io-cmds.c: In function ‘create_iovec’:
/usr/include/glib-2.0/glib/gmacros.h:854:23: error: expected expression 
before ‘
do’
   854 | #define G_STMT_START  do
       |                       ^~
/usr/include/glib-2.0/glib/gtestutils.h:168:41: note: in expansion of 
macro ‘G_STMT_START’
   168 | #define g_assert_not_reached()          G_STMT_START { 
g_assertion_message_expr (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 
NULL); } G_STMT_END
       |                                         ^~~~~~~~~~~~
/home/eblake/qemu/include/qemu/compiler.h:243:35: note: in expansion of 
macro ‘g_assert_not_reached’
   243 | #define qemu_build_not_reached()  g_assert_not_reached()
       |                                   ^~~~~~~~~~~~~~~~~~~~
/home/eblake/qemu/include/qemu/osdep.h:257:9: note: in expansion of 
macro ‘qemu_build_not_reached’
   257 |         qemu_build_not_reached())
       |         ^~~~~~~~~~~~~~~~~~~~~~
/home/eblake/qemu/include/block/block.h:136:34: note: in expansion of 
macro ‘MIN_CONST’
   136 | #define BDRV_REQUEST_MAX_SECTORS MIN_CONST(SIZE_MAX >> 
BDRV_SECTOR_BITS, \
       |                                  ^~~~~~~~~
/home/eblake/qemu/include/block/block.h:138:33: note: in expansion of 
macro ‘BDRV_REQUEST_MAX_SECTORS’
   138 | #define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << 
BDRV_SECTOR_BITS)
       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
/home/eblake/qemu/qemu-io-cmds.c:500:19: note: in expansion of macro 
‘BDRV_REQUEST_MAX_BYTES’
   500 |         if (len > BDRV_REQUEST_MAX_BYTES) {
       |                   ^~~~~~~~~~~~~~~~~~~~~~
/home/eblake/qemu/qemu-io-cmds.c:500:41: error: expected statement 
before ‘)’ token
   500 |         if (len > BDRV_REQUEST_MAX_BYTES) {
       |                                         ^


> 
> I'd prefer we generate a compile-time error than a runtime trap (or nothing,
> depending on compiler flags controlling __builtin_unreachable).

What we have DOES produce a compile-time error.  If either expression to 
MIN_CONST() is not actually const, the fact that __builtin_unreachable() 
returns void causes a compilation failure because a value is expected.

With __builtin_unreachable(), there is no error when MIN_CONST is used 
correctly, and when used incorrectly, the commit message mentions the error:


Use of MIN_CONST when MIN is needed:

/home/eblake/qemu/qemu-img.c: In function ‘is_allocated_sectors’:
/home/eblake/qemu/qemu-img.c:1225:15: error: void value not ignored as 
it ought to be
  1225 |             i = MIN_CONST(i, n);
       |               ^


> 
>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> index 42ce1dfcff77..d77add79b218 100644
>> --- a/accel/tcg/translate-all.c
>> +++ b/accel/tcg/translate-all.c
>> @@ -2565,9 +2565,9 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
>>       /* This function should never be called with addresses outside the
>>          guest address space.  If this assert fires, it probably indicates
>>          a missing call to h2g_valid.  */
>> -#if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
>> -    assert(start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
>> -#endif
>> +    if (TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS) {
>> +        assert(start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
>> +    }
> 
> IIRC the ifdef is required for clang warnings vs the shift.
> Have you tested that?

I have not yet tested with clang.  We'll see if the CLI bots get to that 
before I do...  But if clang isn't happy, I may have to introduce yet a 
third macro, MIN_PP, safe for use in preprocessor statements.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


