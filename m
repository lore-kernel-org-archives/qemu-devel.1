Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CCC20768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nus8GanB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CCC20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyahv-0004vs-RL
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyagc-0003dp-A7
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:50:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22192
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyaga-0007KI-HE
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GglShkq8VO2R26dtBxRdBPqP76zifRY2wT/vLOvxI0=;
 b=Nus8GanByU9oF3sDeSFQ1S0NVjrdraCwgl5CXZEZvYAxr67tl9JnZXm8tzNg9rx6yQxwGH
 LORqyyRw/w8h0BooAkOvjhelthx+HLvh23jJZh6ea5fGBZidWsb7qMJt4m2Wolg5F/caha
 Sj6/Qs0ELv1YE8ehubT2MT1GmRu/Zr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174--lUUu7T0PeOOalGAsIrClQ-1; Thu, 23 Jul 2020 08:50:54 -0400
X-MC-Unique: -lUUu7T0PeOOalGAsIrClQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D8BE18C63CE;
 Thu, 23 Jul 2020 12:50:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E304472E48;
 Thu, 23 Jul 2020 12:50:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C505111CA26; Thu, 23 Jul 2020 14:50:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] qapi: enable use of g_autoptr with QAPI types
References: <20200723111250.2650203-1-berrange@redhat.com>
 <781b8043-bce5-9f64-bc5f-4f2f740c6a6d@redhat.com>
 <20200723115619.GG2615312@redhat.com>
Date: Thu, 23 Jul 2020 14:50:51 +0200
In-Reply-To: <20200723115619.GG2615312@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 23 Jul 2020 12:56:19 +0100")
Message-ID: <87a6zqgztg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jul 23, 2020 at 06:49:44AM -0500, Eric Blake wrote:
>> On 7/23/20 6:12 AM, Daniel P. Berrang=C3=A9 wrote:
>> > Currently QAPI generates a type and function for free'ing it:
>> >=20
>> >    typedef struct QCryptoBlockCreateOptions QCryptoBlockCreateOptions;
>> >    void qapi_free_QCryptoBlockCreateOptions(QCryptoBlockCreateOptions =
*obj);
>> >=20
>>=20
>> > The above code example now becomes
>> >=20
>> >    g_autoptr(QCryptoBlockCreateOptions) opts =3D NULL;
>> >=20
>> >    opts =3D g_new0(QCryptoBlockCreateOptions, 1);
>> >=20
>> >    ....do stuff with opts...
>> >=20
>> > Note, if the local pointer needs to live beyond the scope holding the
>> > variable, then g_steal_pointer can be used. This is useful to return t=
he
>> > pointer to the caller in the success codepath, while letting it be fre=
ed
>> > in all error codepaths.
>> >=20
>> >    return g_steal_pointer(&opts);
>> >=20
>>=20
>> Yep, the idea makes sense!

Agree.

>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >   include/crypto/block.h | 2 --
>> >   scripts/qapi/types.py  | 1 +
>> >   2 files changed, 1 insertion(+), 2 deletions(-)
>>=20
>> Missing a counterpart change to docs/devel/qapi-code-gen.txt.

Yes.  Can do that in my tree.

>>                                                                And it mi=
ght
>> be nice to make this a series with at least one followup patch using the=
 new
>> capability, or at least so 'make check' coverage.  But otherwise on the
>> right track.
>
> The crypto/block.c already makes use of this capability, which is why
> I had to remove the line from block.h to avoid declaring the same thing
> twice !

Could be mentioned in the commit message.

Still, using it somewhere in tests would be nice.
test-qobject-input-visitor.c's test_visitor_in_struct_nested() looks
trivial to convert.  Feel free to pick something else.

In case you prefer not to, with a qapi-code-gen.txt update:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


