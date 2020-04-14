Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90367C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC9020644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dj/syy7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC9020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOI64-0002C4-Ig
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOI5M-0001lQ-KG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOI5L-0000dK-Jh
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:42:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOI5L-0000dC-Gg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586857347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWLe+PZUrPkEpWenqMP65gLJPw0hEQ6+lg0K/VMWo4A=;
 b=dj/syy7h8ukLLj4+AP+myusdLSPN8qJQoUwCuoCsdN46qax1x4YatjDEFPSJ+aaiEymi+f
 a2+RYIrvQDvwi/mWJG/x0pjKuefKh+47RUh5c602lzpiVxxzB5QI4C5QyMULgQdfhQMH6+
 lAV2ZZb/am2UyHEXG2obxqGn4WeI8qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-ZKAlPqsuOC6juBUeUnStBg-1; Tue, 14 Apr 2020 05:42:25 -0400
X-MC-Unique: ZKAlPqsuOC6juBUeUnStBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6939210CE785;
 Tue, 14 Apr 2020 09:42:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31A639F999;
 Tue, 14 Apr 2020 09:42:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB69711385C8; Tue, 14 Apr 2020 11:42:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.1 2/8] qemu-options: Factor out get_opt_name_value()
 helper
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-3-armbru@redhat.com>
 <5f39e636-f799-55f3-873f-08a3a0f53dca@redhat.com>
Date: Tue, 14 Apr 2020 11:42:22 +0200
In-Reply-To: <5f39e636-f799-55f3-873f-08a3a0f53dca@redhat.com> (Eric Blake's
 message of "Thu, 9 Apr 2020 13:01:59 -0500")
Message-ID: <87blnuwght.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
>> The next commits will put it to use.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   util/qemu-option.c | 102 +++++++++++++++++++++++++--------------------
>>   1 file changed, 56 insertions(+), 46 deletions(-)
>>
>
>> +static const char *get_opt_name_value(const char *params,
>> +                                      const char *firstname,
>> +                                      char **name, char **value)
>> +{
>> +    const char *p, *pe, *pc;
>> +
>> +    pe =3D strchr(params, '=3D');
>> +    pc =3D strchr(params, ',');
>> +
>> +    if (!pe || (pc && pc < pe)) {
>> +        /* found "foo,more" */
>> +        if (firstname) {
>> +            /* implicitly named first option */
>> +            *name =3D g_strdup(firstname);
>> +            p =3D get_opt_value(params, value);
>
> Is this correct even when params is "foo,,more"?  But...
>
>>   static void opts_do_parse(QemuOpts *opts, const char *params,
>>                             const char *firstname, bool prepend,
>>                             bool *invalidp, Error **errp)
>>   {
>> -    char *option =3D NULL;
>> -    char *value =3D NULL;
>> -    const char *p,*pe,*pc;
>>       Error *local_err =3D NULL;
>> +    char *option, *value;
>> +    const char *p;
>>   -    for (p =3D params; *p !=3D '\0'; p++) {
>> -        pe =3D strchr(p, '=3D');
>> -        pc =3D strchr(p, ',');
>> -        if (!pe || (pc && pc < pe)) {
>> -            /* found "foo,more" */
>> -            if (p =3D=3D params && firstname) {
>> -                /* implicitly named first option */
>> -                option =3D g_strdup(firstname);
>> -                p =3D get_opt_value(p, &value);
>
> ...in this patch, it is just code motion, so if it is a bug, it's
> pre-existing and worth a separate fix.

If @p points to "foo,,more", possibly followed by additional characters,
then we have pc && pc < pe, and enter this conditional.  This means that

    foo,,more=3D42

gets parsed as two name=3Dvalue, either as

    name        value
    -----------------------
    @firstname  "foo,more"
    ""          "42"

if @firstname is non-null, or else as

    name        value
    -----------------
    "foo,,more" "on"
    ""          "42"

Has always been that way; see commit e27c88fe9e "QemuOpts: framework for
storing and parsing options.", v0.12.0.

You might expect

    name        value
    -----------------
    "foo,,more" "42"

or

    name        value
    -----------------
    "foo,more"  "42"

instead.  Close, but no cigar.

A language without syntax errors is bound to surprise.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


