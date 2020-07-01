Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E00DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAA6206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXlXhJ5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAA6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqXmV-0000Xg-6u
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 04:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqXlv-0008Lw-Pi
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:07:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqXls-0008T6-CS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593590827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbrjadC+STtwhaBrFyWEa7MscsEETHcngHqNfUAVqA8=;
 b=FXlXhJ5POP3gx7XbIssWW8XvAWUGu91Mdlq5Ux3hH8HxkxjSYFDST3NImcgpOTFqEb0HCN
 ZZ8BhQqt1dgdomvfy7Bx3QFwQAbtOXw1mFAsM83XXjRMoeqVp7S9oebY/+S5yqCAV0oyFM
 sXSYzApMRJLhivBTucJrg1oZBthuaPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-w3_qVtVfMd-UfGz6r0B5AA-1; Wed, 01 Jul 2020 04:07:05 -0400
X-MC-Unique: w3_qVtVfMd-UfGz6r0B5AA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83BF18E0D21;
 Wed,  1 Jul 2020 08:07:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A6DF90331;
 Wed,  1 Jul 2020 08:07:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB93511384A6; Wed,  1 Jul 2020 10:07:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 11/46] qemu-option: Make uses of find_desc_by_name() more
 similar
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-12-armbru@redhat.com>
 <a73876ff-2ac1-b077-9fba-a135d97ba9a8@virtuozzo.com>
 <5fd6cf6d-1214-d930-ce18-648cbbe0062e@virtuozzo.com>
Date: Wed, 01 Jul 2020 10:07:02 +0200
In-Reply-To: <5fd6cf6d-1214-d930-ce18-648cbbe0062e@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 29 Jun 2020 12:47:51 +0300")
Message-ID: <87r1tvbqvt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 29.06.2020 12:36, Vladimir Sementsov-Ogievskiy wrote:
>> 24.06.2020 19:43, Markus Armbruster wrote:
>>> This is to make the next commit easier to review.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>> =C2=A0 util/qemu-option.c | 32 ++++++++++++++++++--------------
>>> =C2=A0 1 file changed, 18 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/util/qemu-option.c b/util/qemu-option.c
>>> index 6119f971a4..9941005c91 100644
>>> --- a/util/qemu-option.c
>>> +++ b/util/qemu-option.c
>>> @@ -270,6 +270,7 @@ static void qemu_opt_del_all(QemuOpts *opts, const =
char *name)
>>> =C2=A0 const char *qemu_opt_get(QemuOpts *opts, const char *name)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QemuOpt *opt;
>>> +=C2=A0=C2=A0=C2=A0 const QemuOptDesc *desc;
>> Honestly, I don't see how this hunk helps with the following patch, whic=
h is simple anyway.
>> Keeping desc variable scope smaller seems better for me, as well as furt=
her scope of
>> def_val. (Still, keep my r-b if you don't want to change it).
>>
>
> Aha, I see, we have more similar patterns and you want them to look simil=
arly. Still, it's
> better to keep scope of variable smaller. May be a follow-up.

The variable goes away in the next patch.

I don't expect you to read PATCH n+1 before reviewing PATCH n :)


