Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C8C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E182074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix+p9wTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E182074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMd8X-00087l-GV
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 15:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMd73-0006pS-Sk
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMd71-00015v-Kj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:45:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58390
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMd71-00015h-Ha
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586461519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XSYsExtQWHiLBzSCSg/ucSeZf4s53XemZqw8erFc0U=;
 b=ix+p9wTjxAwunbLcFzU4ojcdOSJ7TZyz50jKX8b7SzEcxm8N8zuq32oIH5pvNC/RkrLwY5
 pr0UOJB47Y9t5UCdUA9115n99Yi7K9AIGVly3feVhrDGi4Xdkc8TBQpNZI+bYQwyOIc8Po
 jCGxD98JNDyoVwk/r3oa4osQJdcNOPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-aMxdy8mqM6uDSlNO-SR8gQ-1; Thu, 09 Apr 2020 15:45:12 -0400
X-MC-Unique: aMxdy8mqM6uDSlNO-SR8gQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02D15DB62;
 Thu,  9 Apr 2020 19:45:12 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73D601001DC0;
 Thu,  9 Apr 2020 19:45:11 +0000 (UTC)
Subject: Re: [PATCH for-5.1 8/8] qemu-option: Move is_valid_option_list() to
 qemu-img.c and rewrite
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e3d05915-268f-0d1a-e760-723a10807d16@redhat.com>
Date: Thu, 9 Apr 2020 14:45:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409153041.17576-9-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 10:30 AM, Markus Armbruster wrote:
> is_valid_option_list()'s purpose is ensuring qemu-img.c's can safely
> join multiple parameter strings separated by ',' like this:
> 
>          g_strdup_printf("%s,%s", params1, params2);
> 
> How it does that is anything but obvious.  A close reading of the code
> reveals that it fails exactly when its argument starts with ',' or
> ends with an odd number of ','.  Makes sense, actually, because when
> the argument starts with ',', a separating ',' preceding it would get
> escaped, and when it ends with an odd number of ',', a separating ','
> following it would get escaped.
> 
> Move it to qemu-img.c and rewrite it the obvious way.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qemu/option.h |  1 -
>   qemu-img.c            | 26 ++++++++++++++++++++++++++
>   util/qemu-option.c    | 22 ----------------------
>   3 files changed, 26 insertions(+), 23 deletions(-)
> 

> +++ b/qemu-img.c
> @@ -223,6 +223,32 @@ static bool qemu_img_object_print_help(const char *type, QemuOpts *opts)
>       return true;
>   }
>   
> +/*
> + * Is @optarg safe for accumulate_options()?
> + * It is when multiple of them can be joined together separated by ','.
> + * To make that work, @optarg must not start with ',' (or else a
> + * separating ',' preceding it gets escaped), and it must not end with
> + * an odd number of ',' (or else a separating ',' following it gets
> + * escaped).
> + */
> +static bool is_valid_option_list(const char *optarg)
> +{
> +    size_t len = strlen(optarg);
> +    size_t i;
> +
> +    if (optarg[0] == ',') {
> +        return false;
> +    }
> +
> +    for (i = len; i > 0 && optarg[i - 1] == ','; i--) {
> +    }
> +    if ((len - i) % 2) {
> +        return false;
> +    }
> +
> +    return true;

Okay, that's easy to read.  Note that is_valid_option_list("") returns 
true.  But proving it replaces the obtuse mess is harder...

> +++ b/util/qemu-option.c
> @@ -165,28 +165,6 @@ void parse_option_size(const char *name, const char *value,
>       *ret = size;
>   }
>   
> -bool is_valid_option_list(const char *p)
> -{
> -    char *value = NULL;
> -    bool result = false;
> -
> -    while (*p) {
> -        p = get_opt_value(p, &value);

Refreshing myself on what get_opt_value() does:

> const char *get_opt_value(const char *p, char **value)
> {
>     size_t capacity = 0, length;
>     const char *offset;
> 
>     *value = NULL;

start with p pointing to the tail of a string from which to extract a value,

>     while (1) {
>         offset = qemu_strchrnul(p, ',');

find the potential end of the value: either the first comma (not yet 
sure if it is ',,' or the end of this value), or the end of the string,

>         length = offset - p;
>         if (*offset != '\0' && *(offset + 1) == ',') {
>             length++;
>         }

if we found a comma and it was doubled, we are going to unescape the comma,

>         *value = g_renew(char, *value, capacity + length + 1);
>         strncpy(*value + capacity, p, length);

copy bytes into the tail of value,

>         (*value)[capacity + length] = '\0';
>         capacity += length;
>         if (*offset == '\0' ||
>             *(offset + 1) != ',') {
>             break;
>         }

if we hit the end of the string or the ',' before the next option, we 
are done,

> 
>         p += (offset - p) + 2;

otherwise we unescaped a ',,' and continue appending to the current value.

>     }
> 
>     return offset;
> }

and the resulting return value is a substring of p: either the NUL byte 
ending p, or the last ',' in the first odd run of commas (the next byte 
after the return is then NUL if the parser would next see an empty 
option name, or non-NUL if the parser would start processing the next 
option name).

Some interesting cases:
get_opt_value("", &value) returns "" with value set to ""
get_opt_value(",", &value) returns "," with value set to ""
get_opt_value(",,", &value) returns "" with value set to ","
get_opt_value(",,,", &value) returns "," with value set to ","
get_opt_value(",,a", &value) returns "" with value set to ",a"
get_opt_value("a,,", &value) returns "" with value set to "a,"
get_opt_value("a,b", &value) returns ",b" with value set to "a"
get_opt_value("a,,b", &value) returns "" with value set to "a,b"

With that detour out of the way:

> -        if ((*p && !*++p) ||

If *p, then we know '*p' == ','; checking !*++p moves past the comma and 
determines if we have the empty string as the next potential option name 
(if so, we ended in an odd number of commas) or anything else (if so, 
repeat the loop, just past the comma).  Oddly, this means that 
is_valid_option_list("a,,,b") returns true (first pass on "a,,,b" 
returned ",b", second pass on "b" returned "").  But I agree that !*++p 
only fires on the final iteration through our loop of get_opt_value() 
calls, matching your rewrite to check for an odd number of trailing 
commas (regardless of even or odd pairing of commas in the middle).

> -            (!*value || *value == ',')) {

Focusing on "*value == ','", on the first iteration, *value can be 
comma; on later iterations, we are guaranteed that *value will not be 
comma (because later iterations can only occur if the first iteration 
returned p pointing to a final comma of a run, but we always start the 
next iteration beyond that comma).  So this matches your rewrite to 
check for a leading comma.

Focusing on "!*value": the loop is never entered to begin with on 
is_valid_option_list("") (that returns true in the old implementation as 
well as yours); otherwise, value will only be empty if p originally 
started with an unpaired comma (but your new code catches that with its 
check for a leading comma).

Note that is_valid_option_list("") returning true has some odd effects:

$ qemu-img create -f qcow2 -o '' xyz 1
Formatting 'xyz', fmt=qcow2 size=1 cluster_size=65536 lazy_refcounts=off 
refcount_bits=16
$ qemu-img create -f qcow2 -o '' -o '' xyz 1
qemu-img: xyz: Invalid parameter ''
$ qemu-img create -f qcow2 -o 'help' -o '' -o '' xyz 1
qemu-img: xyz: Invalid parameter 'help'
$ qemu-img create -f qcow2 -o 'help' -o '' xyz 1 | head -n1
Supported options:

but as I can't see any substantial differences between the old algorithm 
and your new one, I don't see that changing here.  Perhaps you want 
another patch to make is_valid_option_list() return false for "".


> -            goto out;
> -        }
> -
> -        g_free(value);
> -        value = NULL;
> -    }
> -
> -    result = true;
> -out:
> -    g_free(value);
> -    return result;
> -}

At any rate, your new code is a LOT more efficient and legible than the 
old.  I'll restate the "why" in my own words: is_valid_option_list() is 
only used by our code base to concatenate multiple -o strings into one 
string, where each -o individually parses into one or more options; and 
where the concatenated string must parse back to the same number of 
embedded options.  As both -o ",help" and -o "help," are invalid option 
lists on their own (there is no valid empty option for -o), it makes no 
sense to append that -o to other option lists to produce a single string 
(where the appending would become confusing due to creating escaped ',,' 
that were not present in either original -o).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


