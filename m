Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96DCC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68CD2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJcK90Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68CD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPSI-0006GD-SN
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOP7t-0000aQ-Bf
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOP7r-0004Je-6v
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:13:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOMdm-0000KA-Az
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586874858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFzhb4kAEqasUttGXHDzOYFmUYzd9ujfsvx8e7mBgk0=;
 b=jJcK90Ie1L9mknYfx9KPCzKiSZqN9Ddi+L+b/3ShKDDgha7ApVVS+bzN0wdI9ZhGJv+D4G
 6fWT1KKVF45IECz9xNB/iDKqT8ufhk7Bz8haSacY/FN5fZBraEqFThGPoPFe302qGzArWC
 AMmxH9eJyFShcK84wDmWfcaQqkAlnSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-StHte5k0PMG5agVruekZxA-1; Tue, 14 Apr 2020 10:34:15 -0400
X-MC-Unique: StHte5k0PMG5agVruekZxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954D9107ACCD;
 Tue, 14 Apr 2020 14:34:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EA8B99DFD;
 Tue, 14 Apr 2020 14:34:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE89411385C8; Tue, 14 Apr 2020 16:34:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-5.1 8/8] qemu-option: Move is_valid_option_list() to
 qemu-img.c and rewrite
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-9-armbru@redhat.com>
 <e3d05915-268f-0d1a-e760-723a10807d16@redhat.com>
 <87k12ixxlb.fsf@dusky.pond.sub.org>
Date: Tue, 14 Apr 2020 16:34:12 +0200
In-Reply-To: <87k12ixxlb.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Tue, 14 Apr 2020 10:47:44 +0200")
Message-ID: <87blnup257.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 4/9/20 10:30 AM, Markus Armbruster wrote:
>>> is_valid_option_list()'s purpose is ensuring qemu-img.c's can safely
>>> join multiple parameter strings separated by ',' like this:
>>>
>>>          g_strdup_printf("%s,%s", params1, params2);
>>>
>>> How it does that is anything but obvious.  A close reading of the code
>>> reveals that it fails exactly when its argument starts with ',' or
>>> ends with an odd number of ','.  Makes sense, actually, because when
>>> the argument starts with ',', a separating ',' preceding it would get
>>> escaped, and when it ends with an odd number of ',', a separating ','
>>> following it would get escaped.
>>>
>>> Move it to qemu-img.c and rewrite it the obvious way.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   include/qemu/option.h |  1 -
>>>   qemu-img.c            | 26 ++++++++++++++++++++++++++
>>>   util/qemu-option.c    | 22 ----------------------
>>>   3 files changed, 26 insertions(+), 23 deletions(-)
>>>
>>
>>> +++ b/qemu-img.c
>>> @@ -223,6 +223,32 @@ static bool qemu_img_object_print_help(const char =
*type, QemuOpts *opts)
>>>       return true;
>>>   }
>>>   +/*
>>> + * Is @optarg safe for accumulate_options()?
>>> + * It is when multiple of them can be joined together separated by ','=
.
>>> + * To make that work, @optarg must not start with ',' (or else a
>>> + * separating ',' preceding it gets escaped), and it must not end with
>>> + * an odd number of ',' (or else a separating ',' following it gets
>>> + * escaped).
>>> + */
>>> +static bool is_valid_option_list(const char *optarg)
>>> +{
>>> +    size_t len =3D strlen(optarg);
>>> +    size_t i;
>>> +
>>> +    if (optarg[0] =3D=3D ',') {
>>> +        return false;
>>> +    }
>>> +
>>> +    for (i =3D len; i > 0 && optarg[i - 1] =3D=3D ','; i--) {
>>> +    }
>>> +    if ((len - i) % 2) {
>>> +        return false;
>>> +    }
>>> +
>>> +    return true;
>>
>> Okay, that's easy to read.  Note that is_valid_option_list("") returns
>> true.
>
> Hmm, that's a bug:
>
>     $ qemu-img create -f qcow2 -o backing_file=3Da -o "" -o backing_fmt=
=3Draw,size=3D1M new.qcow2
>     qemu-img: warning: Could not verify backing image. This may become an=
 error in future versions.
>     Could not open 'a,backing_fmt=3Draw': No such file or directory
>     Formatting 'new.qcow2', fmt=3Dqcow2 size=3D1048576 backing_file=3Da,,=
backing_fmt=3Draw cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16
>     $ qemu-img info new.qcow2=20
>     image: new.qcow2
>     file format: qcow2
>     virtual size: 1 MiB (1048576 bytes)
>     disk size: 196 KiB
>     cluster_size: 65536
> --> backing file: a,backing_fmt=3Draw
>     Format specific information:
>         compat: 1.1
>         lazy refcounts: false
>         refcount bits: 16
>         corrupt: false
>
> My rewrite preserves this bug.  Will fix in v2.

Kevin, two obvious fixes:

* Make is_valid_option_list() reject -o ""

* Make accumulate_options(options, "") return options.

Got a preference?

[...]


