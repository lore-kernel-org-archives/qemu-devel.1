Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F101C4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DD721924
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwDIeLBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DD721924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtoG-0008KC-2Y
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kMtnL-0007d3-Cm
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kMtnF-0001Lk-SD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:06:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601301977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrbNBYhiCFWpMnOZACXCqp+/AWARvJibBABH9rzt3bE=;
 b=fwDIeLBl6rLhd958p63tnNe7JsmmBTpnYRkus7o8mNQAAQjHUfGlQPFp3ypUZA94fZd19e
 OB7J2mTiyXBUqBieg1lWRacrdl3n2UiJ1/QyZdvAk4PEiV2db7vl12hTfZAwZWJvLXigO2
 hK8F+QO6CO7wd8CGaBFTa1RFhnLz/Bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-XUJKkiOiOxK70tv83AC39Q-1; Mon, 28 Sep 2020 10:05:58 -0400
X-MC-Unique: XUJKkiOiOxK70tv83AC39Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2764410BBEC3;
 Mon, 28 Sep 2020 14:05:56 +0000 (UTC)
Received: from [10.3.112.208] (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 927031002382;
 Mon, 28 Sep 2020 14:05:55 +0000 (UTC)
Subject: Re: [PATCH 1/3] nbd: Simplify meta-context parsing
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-2-eblake@redhat.com>
 <403131e3-1712-ce00-63ff-6276cdfa83d7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6c88c1ed-6147-c7d6-505e-508611165ba2@redhat.com>
Date: Mon, 28 Sep 2020 09:05:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <403131e3-1712-ce00-63ff-6276cdfa83d7@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: pkrempa@redhat.com, rjones@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 7:58 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.09.2020 23:32, Eric Blake wrote:
>> We had a premature optimization of trying to read as little from the
>> wire as possible while handling NBD_OPT_SET_META_CONTEXT in phases.
>> But in reality, we HAVE to read the entire string from the client
>> before we can get to the next command, and it is easier to just read
>> it all at once than it is to read it in pieces.  And once we do that,
>> several functions end up no longer performing I/O, and no longer need
>> to return a value.
>>
>> While simplifying this, take advantage of g_str_has_prefix for less
>> repetition of boilerplate string length computation.
>>
>> Our iotests still pass; I also checked that libnbd's testsuite (which
>> covers more corner cases of odd meta context requests) still passes.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>>
>> -/* Read strlen(@pattern) bytes, and set @match to true if they match 
>> @pattern.
>> - * @match is never set to false.
>> - *
>> - * Return -errno on I/O error, 0 if option was completely handled by
>> - * sending a reply about inconsistent lengths, or 1 on success.
>> - *
>> - * Note: return code = 1 doesn't mean that we've read exactly @pattern.
>> - * It only means that there are no errors.
>> +
>> +/*
>> + * Check @ns with @len bytes, and set @match to true if it matches 
>> @pattern,
>> + * or if @len is 0 and the client is performing _LIST_. @match is 
>> never set
>> + * to false.
>>    */
>> -static int nbd_meta_pattern(NBDClient *client, const char *pattern, 
>> bool *match,
>> -                            Error **errp)
>> +static void nbd_meta_empty_or_pattern(NBDClient *client, const char 
>> *pattern,
>> +                                      const char *ns, uint32_t len,
> 
> ns changed its meaning, it's not just a namespace, but the whole query. 
> I think, better to rename it.

Sure, that makes sense.

> 
> Also, it's unusual to pass length together with nul-terminated string, 
> it seems redundant.
> And, it's used only to compare with zero, strlen(ns) == 0 or ns[0] == 0 
> is not slower.

Good point.

> 
> Also, errp is unused argument. And it violate Error API recommendation 
> to not create void functions with errp.

Another simplification.  Looks like I'll be spinning v2.

> 
> Also we can use bool return instead of return through pointer.

That changes the callers, but it's not necessarily a bad thing; whereas 
we were doing:

if (cond) {
     nbd_meta_pattern(..., &match, ...);
}

which either leaves match unchanged or sets it to true, we could instead do:

if (nbd_meta_pattern(...)) {
     match = true;
}

My only worry is that the more changes I make, the harder the patch is 
to read.  I don't know if it's worth breaking it into steps, or just 
doing all the simplifications in one blow.


>> +static void nbd_meta_base_query(NBDClient *client, 
>> NBDExportMetaContexts *meta,
>> +                                const char *ns, uint32_t len, Error 
>> **errp)
>>   {
>> -    return nbd_meta_empty_or_pattern(client, "allocation", len,
>> -                                     &meta->base_allocation, errp);
>> +    nbd_meta_empty_or_pattern(client, "allocation", ns + 5, len - 5,
> 
> This one is correct, but would be simpler, if only subquery (after 
> colon) passed here.
> (Really, no reason to pass 'base:' to _base_ func)
> 
> Hmm, I see that it gives a possibility to use 
> meta->exp->export_bitmap_context directly.

Yeah, that's where it got interesting.  A direct strcmp() is nice, but 
if we strip a prefix in one place, we have to strip it in the other.  I 
could go either way.


>> + * @len is the length of @ns, including the `qemu:' prefix.
>> + */
>> +static void nbd_meta_qemu_query(NBDClient *client, 
>> NBDExportMetaContexts *meta,
>> +                                const char *ns, uint32_t len, Error 
>> **errp)
>>   {
>> -    bool dirty_bitmap = false;
>> -    size_t dirty_bitmap_len = strlen("dirty-bitmap:");
>> -    int ret;
>> -
>>       if (!meta->exp->export_bitmap) {
>>           trace_nbd_negotiate_meta_query_skip("no dirty-bitmap 
>> exported");
>> -        return nbd_opt_skip(client, len, errp);
>> -    }
>> -
>> -    if (len == 0) {
>> +    } else if (len == 0) {
> 
> s/0/5/ ?

Oh, good catch.  Using 0 is an unintended logic change, but none of our 
iotests caught it, so we're also missing test coverage.

I'm working on adding 'nbd_opt_list_meta_context()' to libnbd, which 
will add testsuite coverage of this.


>> +    } else if (!g_str_has_prefix(ns + 5, "dirty-bitmap:")) {
>>           trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
>> -        return nbd_opt_skip(client, len, errp);
>> +    } else {
>> +        trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
>> +        nbd_meta_empty_or_pattern(client, 
>> meta->exp->export_bitmap_context,
>> +                                  ns, len, &meta->bitmap, errp);
> 
> hmm. _empty_ is impossible here, as ns includes "qemu:dirty-bitmap"..

Ultimately, we want something like:

if starts with "base:":
   if nothing else:
     if list mode:
       return "base:allocation"
     else:
       return empty list
   else if "base:allocation":
     return "base:allocation"
   else
     return empty list
else if starts with "qemu:":
   if nothing else:
     if list mode:
       return all possible sub-qemu contexts
     else:
       return empty list
   else if starts with "qemu:dirty-bitmap:":
     if nothing else:
       if list mode:
         return all possible dirty-bitmap contexts (right now, just one,
             but I want to allow an array of bitmaps in the future)
       else:
         return empty list
     else if exact match:
       return that bitmap
     else:
       return empty list
   else if "qemu:allocation-depth" (from next patch):
     return "allocation-depth"
   else:
     return empty list
else:
   return empty list

Maybe some function renames will help.

>>       if (ret <= 0) {
>>           return ret;
>>       }
>> +    ns[len] = '\0';
>> +    if (strlen(ns) != len) {
>> +        return nbd_opt_invalid(client, errp,
>> +                               "Embedded NUL in query for option %s",
>> +                               nbd_opt_lookup(client->opt));
>> +    }
> 
> Hmm, that's a new good check. Intersting, is it specified in NBD 
> protocol, that
> NUL shouldn't be in a string.. Probably it can be a separate patch, with
> new nbd_opt_string_read, which will check this thing. But I'm OK with it 
> as is
> in this patch.

I'll separate it.

> To avoid all this pointer arithmetic, what about something like this (I 
> didn't check, just an idea):
> 

I'll see what parts of that I can use in v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


