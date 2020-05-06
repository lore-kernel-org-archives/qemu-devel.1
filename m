Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A394EC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:26:03 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B3C20663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNEdq8pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B3C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWERF-000758-0L
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 03:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWEQa-0006XU-6f
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:25:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWEQY-0005Nq-Ur
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588749909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxYdpZ6CuKDUs1WL0wFK5pDPnW9ooBrswJqgYnPVQL4=;
 b=XNEdq8pzoa+mwO7w/RCMkOSo4SUx2aGvxzu/JKfFttp73rhQ6UJjoa/fvd8geP6c5b7IrP
 VMdYCss8/ueaftteb95FoExE2TQm5MvqCTR49+n+OC0fEX7LO5L4jFXtP4guGlxfI32FTp
 GLmVHSQWGSn8NJkE+NJlbR23QDQDjuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-SOH0HKJeOF2wGVDo0Qvkcw-1; Wed, 06 May 2020 03:25:07 -0400
X-MC-Unique: SOH0HKJeOF2wGVDo0Qvkcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5AFA1895944
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 07:25:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71DAF5D9C5;
 Wed,  6 May 2020 07:25:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA81C11358BC; Wed,  6 May 2020 09:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/18] qom: Drop convenience method
 object_property_get_uint16List()
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-6-armbru@redhat.com>
 <9e7d4512-db46-d6fa-327d-994c401d233f@redhat.com>
Date: Wed, 06 May 2020 09:25:04 +0200
In-Reply-To: <9e7d4512-db46-d6fa-327d-994c401d233f@redhat.com> (Paolo
 Bonzini's message of "Tue, 5 May 2020 18:42:21 +0200")
Message-ID: <87d07h4jan.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: philmd@redhat.com, berrange@redhat.com,
 Markus Armbruster <armbru@redhat.com>, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/05/20 17:29, Markus Armbruster wrote:
>> qom/object.c provides object_property_get_TYPE() and
>> object_property_set_TYPE() for a number of common types.  These are
>> all convenience wrappers around object_property_get_qobject() and
>> object_property_set_qobject().
>>=20
>> Except for object_property_get_uint16List(), which is unusual in two way=
s:
>>=20
>> * It bypasses object_property_get_qobject().  Fixable; the previous
>>   commit did it for object_property_get_enum())
>>=20
>> * It stores the value through a parameter.  Its contract claims it
>>   returns the value, like the other functions do.  Also fixable.
>>=20
>> Fixing is not worthwhile, though: object_property_get_uint16List() has
>> seen exactly one user in six years.
>>=20
>> Convert the lone user to do its job with the generic
>> object_property_get_qobject(), and drop object_property_get_qobject().
>
> Typo, otherwise

Will fix.

> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!


