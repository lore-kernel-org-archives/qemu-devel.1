Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3CAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D662068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZgKXaNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D662068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic30U-0005Ad-HY
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ic2wi-0004Fj-Uq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ic2wf-0005WI-FX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:50:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ic2wf-0005UJ-9X
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575359404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/x/pi+ghnQDu7r/1/Yeu/apE2D8B4OL8ot5bL9ZxWsI=;
 b=ZZgKXaNrsWERUC+sIZn5uslhfRlnD5/do6wSrE9K2W7MxNoU+RqiZ6NkED2dLsDRgRGjo0
 N1lzyMzaOKqWy2chhhsgTMdbkjiPBVAZ5rBY/X3P1mtKKwTSMG5TTPBp82HeAe7k0puROn
 7tMIi6KlSK7CF3AQcRdbWlW3p4ubGm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-7I_p7SunOfaAZXTZsFaZrw-1; Tue, 03 Dec 2019 02:50:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A00418557C4;
 Tue,  3 Dec 2019 07:50:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F365DA60;
 Tue,  3 Dec 2019 07:49:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4CE9B1138606; Tue,  3 Dec 2019 08:49:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-18-armbru@redhat.com>
 <20191202173147.3085b1a6.cohuck@redhat.com>
Date: Tue, 03 Dec 2019 08:49:58 +0100
In-Reply-To: <20191202173147.3085b1a6.cohuck@redhat.com> (Cornelia Huck's
 message of "Mon, 2 Dec 2019 17:31:47 +0100")
Message-ID: <87sgm17srd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7I_p7SunOfaAZXTZsFaZrw-1
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cornelia Huck <cohuck@redhat.com> writes:

> On Sat, 30 Nov 2019 20:42:36 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
> I don't really want to restart the discussion :), but what about:
>
>> cpu_model_from_info() is a helper for qmp_query_cpu_model_expansion(),
>> qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
>> crashes when the visitor or the QOM setter fails, and its @errp
>> argument is null.=20
>
> "It would crash when the visitor or the QOM setter fails if its @errp
> argument were NULL." ?
>
> (Hope I got my conditionals right...)

I don't think this is an improvement.

The commit message matches a pattern "what's wrong, since when, impact,
how is it fixed".  The pattern has become habit for me.  Its "what's
wrong" part is strictly local.  The non-local argument comes in only
when we assess impact.

Use of "would" in the what part's conditional signals the condition is
unlikely.  True (it's actually impossible), but distracting (because it
involves the non-local argument I'm not yet ready to make).

Let me try a different phrasing below.

>> Messed up in commit 137974cea3 's390x/cpumodel:
>
> I agree that "Introduced" is a bit nicer than "Messed up".

Works fine for me.  I didn't mean any disrespect --- I'd have to
disrespect myself: the mess corrected by PATCH 10 is mine.

>> implement QMP interface "query-cpu-model-expansion"'.
>>=20
>> Its three callers have the same bug.  Messed up in commit 4e82ef0502

Feel free to call it "issue" rather than "bug".  I don't care, but David
might.

>> 's390x/cpumodel: implement QMP interface "query-cpu-model-comparison"'
>> and commit f1a47d08ef 's390x/cpumodel: implement QMP interface
>> "query-cpu-model-baseline"'.
>
> If we agree, I can tweak the various commit messages for the s390x
> patches and apply them.

Tweaking the non-s390x commit messages as well would be nicer, but
requires a respin.

Let's try to craft a mutually agreeable commit message for this patch.
Here's my attempt:

    s390x: Fix query-cpu-model-FOO error API violations

    cpu_model_from_info() is a helper for qmp_query_cpu_model_expansion(),
    qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
    dereferences @errp when the visitor or the QOM setter fails.  That's
    wrong; see the big comment in error.h.  Introduced in commit
    137974cea3 's390x/cpumodel: implement QMP interface
    "query-cpu-model-expansion"'.

    Its three callers have the same issue.  Introduced in commit
    4e82ef0502 's390x/cpumodel: implement QMP interface
    "query-cpu-model-comparison"' and commit f1a47d08ef 's390x/cpumodel:
    implement QMP interface "query-cpu-model-baseline"'.

    No caller actually passes null.  To fix, splice in a local Error *err,
    and error_propagate().

    Cc: David Hildenbrand <david@redhat.com>
    Cc: Cornelia Huck <cohuck@redhat.com>
    Signed-off-by: Markus Armbruster <armbru@redhat.com>

Adapting it to other patches should be straightforward.

>> The bugs can't bite as no caller actually passes null.  Fix them
>> anyway.
>>=20
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  target/s390x/cpu_models.c | 43 ++++++++++++++++++++++++---------------
>>  1 file changed, 27 insertions(+), 16 deletions(-)
>
> David, I don't think you gave a R-b for that one yet?


