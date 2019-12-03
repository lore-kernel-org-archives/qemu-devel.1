Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCFC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB792073F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY6cLIyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB792073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic3Bf-0007qs-OE
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 03:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ic37i-00070A-Gg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ic37V-0005xW-Q0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:01:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ic37V-0005to-J3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575360076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlbP08ecNPsaAQeNt8RBsxgD2snrsTj34NM/FQ2q3Q0=;
 b=BY6cLIyR5KrBrcoqBKuda2spIzkRzZck/y5/ufKgYo3cEb5rHieoG5IAYBtAZB49JDuXMM
 r6/4BjkybrrtFLepKUEYl41STJ8Jrrk3sattjgVk9lrqN3/TG9cCZC5H8kAblookOFFsb/
 +fWsdKI3IP/GNMsFLd5CYs9iaLo6x5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-jxTe_zsUPDCLIS3XU2jWiw-1; Tue, 03 Dec 2019 03:01:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 141DE10054E3;
 Tue,  3 Dec 2019 08:01:14 +0000 (UTC)
Received: from gondolin (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A00660C18;
 Tue,  3 Dec 2019 08:01:10 +0000 (UTC)
Date: Tue, 3 Dec 2019 09:01:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
Message-ID: <20191203090107.07d70225.cohuck@redhat.com>
In-Reply-To: <87sgm17srd.fsf@dusky.pond.sub.org>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-18-armbru@redhat.com>
 <20191202173147.3085b1a6.cohuck@redhat.com>
 <87sgm17srd.fsf@dusky.pond.sub.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jxTe_zsUPDCLIS3XU2jWiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Dec 2019 08:49:58 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
> 
> > On Sat, 30 Nov 2019 20:42:36 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> > I don't really want to restart the discussion :), but what about:
> >  
> >> cpu_model_from_info() is a helper for qmp_query_cpu_model_expansion(),
> >> qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
> >> crashes when the visitor or the QOM setter fails, and its @errp
> >> argument is null.   
> >
> > "It would crash when the visitor or the QOM setter fails if its @errp
> > argument were NULL." ?
> >
> > (Hope I got my conditionals right...)  
> 
> I don't think this is an improvement.
> 
> The commit message matches a pattern "what's wrong, since when, impact,
> how is it fixed".  The pattern has become habit for me.  Its "what's
> wrong" part is strictly local.  The non-local argument comes in only
> when we assess impact.
> 
> Use of "would" in the what part's conditional signals the condition is
> unlikely.  True (it's actually impossible), but distracting (because it
> involves the non-local argument I'm not yet ready to make).

I think we'll have to agree to disagree here...

> 
> Let me try a different phrasing below.

...but also see below :)

> 
> >> Messed up in commit 137974cea3 's390x/cpumodel:  
> >
> > I agree that "Introduced" is a bit nicer than "Messed up".  
> 
> Works fine for me.  I didn't mean any disrespect --- I'd have to
> disrespect myself: the mess corrected by PATCH 10 is mine.
> 
> >> implement QMP interface "query-cpu-model-expansion"'.
> >> 
> >> Its three callers have the same bug.  Messed up in commit 4e82ef0502  
> 
> Feel free to call it "issue" rather than "bug".  I don't care, but David
> might.
> 
> >> 's390x/cpumodel: implement QMP interface "query-cpu-model-comparison"'
> >> and commit f1a47d08ef 's390x/cpumodel: implement QMP interface
> >> "query-cpu-model-baseline"'.  
> >
> > If we agree, I can tweak the various commit messages for the s390x
> > patches and apply them.  
> 
> Tweaking the non-s390x commit messages as well would be nicer, but
> requires a respin.
> 
> Let's try to craft a mutually agreeable commit message for this patch.
> Here's my attempt:
> 
>     s390x: Fix query-cpu-model-FOO error API violations
> 
>     cpu_model_from_info() is a helper for qmp_query_cpu_model_expansion(),
>     qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
>     dereferences @errp when the visitor or the QOM setter fails.  That's
>     wrong; see the big comment in error.h.  Introduced in commit
>     137974cea3 's390x/cpumodel: implement QMP interface
>     "query-cpu-model-expansion"'.
> 
>     Its three callers have the same issue.  Introduced in commit
>     4e82ef0502 's390x/cpumodel: implement QMP interface
>     "query-cpu-model-comparison"' and commit f1a47d08ef 's390x/cpumodel:
>     implement QMP interface "query-cpu-model-baseline"'.
> 
>     No caller actually passes null.  To fix, splice in a local Error *err,
>     and error_propagate().
> 
>     Cc: David Hildenbrand <david@redhat.com>
>     Cc: Cornelia Huck <cohuck@redhat.com>
>     Signed-off-by: Markus Armbruster <armbru@redhat.com>

That sounds good to me.

> 
> Adapting it to other patches should be straightforward.

Ok, so how to proceed? I'm happy to tweak the commit messages for
s390x, but that is bound to get messy.

> 
> >> The bugs can't bite as no caller actually passes null.  Fix them
> >> anyway.
> >> 
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  target/s390x/cpu_models.c | 43 ++++++++++++++++++++++++---------------
> >>  1 file changed, 27 insertions(+), 16 deletions(-)  
> >
> > David, I don't think you gave a R-b for that one yet?  


