Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58782C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F372068F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIdWDoMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F372068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGLg-000396-5r
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZGKe-0001q8-IR
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZGKd-0004oB-F3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:31:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZGKd-0004o7-BZ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574695879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqmrMZ9j3UPDh+jr7UoW8w/rCeSfyPb1dUZsTJOTGfc=;
 b=TIdWDoMAkPeHNsVRxUhjGomTScE1JywybtY/EDHQ3fWhWRP2OwHzc/CBnHsJsnfGpdRLdt
 PwGA+IqMaS9rgyEoSMKsoyVm7Vax5bhHvHZnyEh1KoWplfzl+VR2DvNETiaor9RXZsRnMR
 7Vf7DxSAsqN4O/Yg0WBl6sZJPEzvsLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-uIOkWZItOZ-0Zv84v-0Jag-1; Mon, 25 Nov 2019 10:31:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62091188352A;
 Mon, 25 Nov 2019 15:31:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 085151001B03;
 Mon, 25 Nov 2019 15:31:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 48D3C1138606; Mon, 25 Nov 2019 16:31:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/2] test-keyval: Tighten test of trailing crap after size
References: <20191125133846.27790-1-armbru@redhat.com>
 <20191125133846.27790-3-armbru@redhat.com>
 <b06f7807-b201-5a52-5a62-b50f52cc4d44@redhat.com>
Date: Mon, 25 Nov 2019 16:31:14 +0100
In-Reply-To: <b06f7807-b201-5a52-5a62-b50f52cc4d44@redhat.com> (Eric Blake's
 message of "Mon, 25 Nov 2019 08:29:54 -0600")
Message-ID: <87fticdlbx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: uIOkWZItOZ-0Zv84v-0Jag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, tao3.xu@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 11/25/19 7:38 AM, Markus Armbruster wrote:
>> test_keyval_visit_size() should test for trailing crap after size with
>> and without suffix.  It does test the latter: "sz2=3D16Gi" has size
>> "16G" followed by crap "i".  It fails to test the former "sz1=3D16E" is
>> a syntactically valid size that overflows uint64_t.  Replace by
>> "sz1=3D0Z".
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/test-keyval.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/test-keyval.c b/tests/test-keyval.c
>> index 09b0ae3c68..e331a84149 100644
>> --- a/tests/test-keyval.c
>> +++ b/tests/test-keyval.c
>> @@ -478,7 +478,7 @@ static void test_keyval_visit_size(void)
>>       visit_free(v);
>>         /* Trailing crap */
>> -    qdict =3D keyval_parse("sz1=3D16E,sz2=3D16Gi", NULL, &error_abort);
>> +    qdict =3D keyval_parse("sz1=3D0Z,sz2=3D16Gi", NULL, &error_abort);
>
> Does this actually test both failure cases, or does it abort the parse
> after the first failure (sz1=3D0Z) without ever hitting the second half
> of the parse (sz2=3D16Gi)?

Fair question!  Short answer: yes, we check both.

Long answer follows.

       /* Trailing crap */
       qdict =3D keyval_parse("time1=3D89ks,time2=3Dns", NULL, &error_abort=
);

keyval_parse() must succeed: it takes &error_abort.

        v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
        qobject_unref(qdict);

Can't fail.

        visit_start_struct(v, NULL, NULL, 0, &error_abort);

Must succeed.

        visit_type_size(v, "sz1", &sz, &err);
        error_free_or_abort(&err);

This is where we parse "0Z".  Must fail.  We continue.

        visit_type_size(v, "sz2", &sz, &err);
        error_free_or_abort(&err);

This is where we parse "16Gi".  Must fail.  We continue.

        visit_end_struct(v, NULL);
        visit_free(v);
    }

Clear now?


