Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45EC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF94206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6eKO93H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF94206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOHFl-00048j-Cs
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 04:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOHEX-0003M9-Gb
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOHEV-0002I8-82
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:47:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOHEV-0002Ht-3S
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586854069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akPXFbylf4f93bjkBQ7IOqLDUWF9JwfCeEVJKIxonqA=;
 b=F6eKO93HL3gMPDx+Qll3m4br2Oadb0tGdbU8vey5yWiOrMFZz4oFqk4ncuDL1isefZpdEM
 8yZXh7EnRRZef+PyQ3+gJGAV10zjZ0DEK1OwYvqGz5UU5ezgPf+vNFMs1FD8n18Jj9cjEh
 Lf/GZ3iRT5wsu3RZAmXDKGWilIwvCrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-Riil1wMSPEC6rud0cugzIw-1; Tue, 14 Apr 2020 04:47:48 -0400
X-MC-Unique: Riil1wMSPEC6rud0cugzIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A31310CE781;
 Tue, 14 Apr 2020 08:47:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8917A10372C0;
 Tue, 14 Apr 2020 08:47:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E919B11385C8; Tue, 14 Apr 2020 10:47:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.1 8/8] qemu-option: Move is_valid_option_list() to
 qemu-img.c and rewrite
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-9-armbru@redhat.com>
 <e3d05915-268f-0d1a-e760-723a10807d16@redhat.com>
Date: Tue, 14 Apr 2020 10:47:44 +0200
In-Reply-To: <e3d05915-268f-0d1a-e760-723a10807d16@redhat.com> (Eric Blake's
 message of "Thu, 9 Apr 2020 14:45:10 -0500")
Message-ID: <87k12ixxlb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/9/20 10:30 AM, Markus Armbruster wrote:
>> is_valid_option_list()'s purpose is ensuring qemu-img.c's can safely
>> join multiple parameter strings separated by ',' like this:
>>
>>          g_strdup_printf("%s,%s", params1, params2);
>>
>> How it does that is anything but obvious.  A close reading of the code
>> reveals that it fails exactly when its argument starts with ',' or
>> ends with an odd number of ','.  Makes sense, actually, because when
>> the argument starts with ',', a separating ',' preceding it would get
>> escaped, and when it ends with an odd number of ',', a separating ','
>> following it would get escaped.
>>
>> Move it to qemu-img.c and rewrite it the obvious way.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qemu/option.h |  1 -
>>   qemu-img.c            | 26 ++++++++++++++++++++++++++
>>   util/qemu-option.c    | 22 ----------------------
>>   3 files changed, 26 insertions(+), 23 deletions(-)
>>
>
>> +++ b/qemu-img.c
>> @@ -223,6 +223,32 @@ static bool qemu_img_object_print_help(const char *=
type, QemuOpts *opts)
>>       return true;
>>   }
>>   +/*
>> + * Is @optarg safe for accumulate_options()?
>> + * It is when multiple of them can be joined together separated by ','.
>> + * To make that work, @optarg must not start with ',' (or else a
>> + * separating ',' preceding it gets escaped), and it must not end with
>> + * an odd number of ',' (or else a separating ',' following it gets
>> + * escaped).
>> + */
>> +static bool is_valid_option_list(const char *optarg)
>> +{
>> +    size_t len =3D strlen(optarg);
>> +    size_t i;
>> +
>> +    if (optarg[0] =3D=3D ',') {
>> +        return false;
>> +    }
>> +
>> +    for (i =3D len; i > 0 && optarg[i - 1] =3D=3D ','; i--) {
>> +    }
>> +    if ((len - i) % 2) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>
> Okay, that's easy to read.  Note that is_valid_option_list("") returns
> true.

Hmm, that's a bug:

    $ qemu-img create -f qcow2 -o backing_file=3Da -o "" -o backing_fmt=3Dr=
aw,size=3D1M new.qcow2
    qemu-img: warning: Could not verify backing image. This may become an e=
rror in future versions.
    Could not open 'a,backing_fmt=3Draw': No such file or directory
    Formatting 'new.qcow2', fmt=3Dqcow2 size=3D1048576 backing_file=3Da,,ba=
cking_fmt=3Draw cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
    $ qemu-img info new.qcow2=20
    image: new.qcow2
    file format: qcow2
    virtual size: 1 MiB (1048576 bytes)
    disk size: 196 KiB
    cluster_size: 65536
--> backing file: a,backing_fmt=3Draw
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false

My rewrite preserves this bug.  Will fix in v2.

>        But proving it replaces the obtuse mess is harder...
>
>> +++ b/util/qemu-option.c
>> @@ -165,28 +165,6 @@ void parse_option_size(const char *name, const char=
 *value,
>>       *ret =3D size;
>>   }
>>   -bool is_valid_option_list(const char *p)
>> -{
>> -    char *value =3D NULL;
>> -    bool result =3D false;
>> -
>> -    while (*p) {
>> -        p =3D get_opt_value(p, &value);
>
> Refreshing myself on what get_opt_value() does:
>
>> const char *get_opt_value(const char *p, char **value)
>> {
>>     size_t capacity =3D 0, length;
>>     const char *offset;
>>
>>     *value =3D NULL;
>
> start with p pointing to the tail of a string from which to extract a val=
ue,
>
>>     while (1) {
>>         offset =3D qemu_strchrnul(p, ',');
>
> find the potential end of the value: either the first comma (not yet
> sure if it is ',,' or the end of this value), or the end of the
> string,
>
>>         length =3D offset - p;
>>         if (*offset !=3D '\0' && *(offset + 1) =3D=3D ',') {
>>             length++;
>>         }
>
> if we found a comma and it was doubled, we are going to unescape the comm=
a,
>
>>         *value =3D g_renew(char, *value, capacity + length + 1);
>>         strncpy(*value + capacity, p, length);
>
> copy bytes into the tail of value,
>
>>         (*value)[capacity + length] =3D '\0';
>>         capacity +=3D length;
>>         if (*offset =3D=3D '\0' ||
>>             *(offset + 1) !=3D ',') {
>>             break;
>>         }
>
> if we hit the end of the string or the ',' before the next option, we
> are done,
>
>>
>>         p +=3D (offset - p) + 2;
>
> otherwise we unescaped a ',,' and continue appending to the current value=
.
>
>>     }
>>
>>     return offset;
>> }
>
> and the resulting return value is a substring of p: either the NUL
> byte ending p, or the last ',' in the first odd run of commas (the
> next byte after the return is then NUL if the parser would next see an
> empty option name, or non-NUL if the parser would start processing the
> next option name).

Yes.

> Some interesting cases:
> get_opt_value("", &value) returns "" with value set to ""
> get_opt_value(",", &value) returns "," with value set to ""
> get_opt_value(",,", &value) returns "" with value set to ","
> get_opt_value(",,,", &value) returns "," with value set to ","
> get_opt_value(",,a", &value) returns "" with value set to ",a"
> get_opt_value("a,,", &value) returns "" with value set to "a,"
> get_opt_value("a,b", &value) returns ",b" with value set to "a"
> get_opt_value("a,,b", &value) returns "" with value set to "a,b"

QemuOpts is a language without syntax errors.

> With that detour out of the way:
>
>> -        if ((*p && !*++p) ||
>
> If *p, then we know '*p' =3D=3D ','; checking !*++p moves past the comma
> and determines if we have the empty string as the next potential
> option name (if so, we ended in an odd number of commas) or anything
> else (if so, repeat the loop, just past the comma).  Oddly, this means
> that is_valid_option_list("a,,,b") returns true (first pass on "a,,,b"
> returned ",b", second pass on "b" returned "").  But I agree that
> !*++p only fires on the final iteration through our loop of
> get_opt_value() calls, matching your rewrite to check for an odd
> number of trailing commas (regardless of even or odd pairing of commas
> in the middle).
>
>> -            (!*value || *value =3D=3D ',')) {
>
> Focusing on "*value =3D=3D ','", on the first iteration, *value can be
> comma; on later iterations, we are guaranteed that *value will not be
> comma (because later iterations can only occur if the first iteration
> returned p pointing to a final comma of a run, but we always start the
> next iteration beyond that comma).  So this matches your rewrite to
> check for a leading comma.
>
> Focusing on "!*value": the loop is never entered to begin with on
> is_valid_option_list("") (that returns true in the old implementation
> as well as yours); otherwise, value will only be empty if p originally
> started with an unpaired comma (but your new code catches that with
> its check for a leading comma).
>
> Note that is_valid_option_list("") returning true has some odd effects:
>
> $ qemu-img create -f qcow2 -o '' xyz 1
> Formatting 'xyz', fmt=3Dqcow2 size=3D1 cluster_size=3D65536
> lazy_refcounts=3Doff refcount_bits=3D16
> $ qemu-img create -f qcow2 -o '' -o '' xyz 1
> qemu-img: xyz: Invalid parameter ''
> $ qemu-img create -f qcow2 -o 'help' -o '' -o '' xyz 1
> qemu-img: xyz: Invalid parameter 'help'
> $ qemu-img create -f qcow2 -o 'help' -o '' xyz 1 | head -n1
> Supported options:
>
> but as I can't see any substantial differences between the old
> algorithm and your new one, I don't see that changing here.  Perhaps
> you want another patch to make is_valid_option_list() return false for
> "".

I do.

>> -            goto out;
>> -        }
>> -
>> -        g_free(value);
>> -        value =3D NULL;
>> -    }
>> -
>> -    result =3D true;
>> -out:
>> -    g_free(value);
>> -    return result;
>> -}
>
> At any rate, your new code is a LOT more efficient and legible than
> the old.  I'll restate the "why" in my own words:
> is_valid_option_list() is only used by our code base to concatenate
> multiple -o strings into one string, where each -o individually parses
> into one or more options;

Correct.

>                           and where the concatenated string must parse
> back to the same number of embedded options.

We want the concatenated string to parse into the concatenation of the
parse of its parts.  Whether "same number" implies that is an
interesting puzzle, but not one worth solving today :)

>                                               As both -o ",help" and
> -o "help," are invalid option lists on their own (there is no valid
> empty option for -o),

Yes, it's *semantically* invalid.  It parses as sugar for "help=3Don,=3Don"=
,
except "help=3Don" doesn't get you help, only "help" does.

>                       it makes no sense to append that -o to other
> option lists to produce a single string (where the appending would
> become confusing due to creating escaped ',,' that were not present in
> either original -o).

Yes.  If the empty option existed, concatenation would not do.  It
doesn't now, and I expect it to stay that way.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks for your thorough review!


