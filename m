Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95499C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A70820659
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVnxnMqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A70820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibdsL-0006G0-Io
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 00:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ibdrW-0005bp-AB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ibdrV-0007t9-BJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:03:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ibdrV-0007t1-7L
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575262984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6tANAKAPStyl0snrVe2wRqDlLEwwgijKe/X5yrrNLk=;
 b=WVnxnMqaSw62lLznbRX7wj+VNQfdgICcnLLhEqsOSvWUyXxMfExFOLTlVFBbdlu/Qe0aND
 lYGHBUcje2aqdMTpNs1fsqvGi5gmdGUGP2nHPjy2a5slfJwxJ2JB/aUiInLQdy/9kcVHBk
 E4BUgr8E0HpQ5iiSE14z00U/ZFET2qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-8fFuInlhPzqqtUMNFviPHQ-1; Mon, 02 Dec 2019 00:03:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5098D8017DF;
 Mon,  2 Dec 2019 05:03:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4116C5C21A;
 Mon,  2 Dec 2019 05:02:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 148EB1138606; Mon,  2 Dec 2019 06:02:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 16/21] s390/cpu_modules: Fix latent realize() error
 handling bugs
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-17-armbru@redhat.com>
 <357b5595-23bf-3884-5527-c22012483396@redhat.com>
Date: Mon, 02 Dec 2019 06:02:58 +0100
In-Reply-To: <357b5595-23bf-3884-5527-c22012483396@redhat.com> (David
 Hildenbrand's message of "Sun, 1 Dec 2019 15:25:58 +0100")
Message-ID: <87o8wrnwu5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8fFuInlhPzqqtUMNFviPHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 30.11.19 20:42, Markus Armbruster wrote:
>> get_max_cpu_model() crashes when kvm_s390_get_host_cpu_model() fails
>> and its @errp argument is null.
>>=20
>> apply_cpu_model() crashes when kvm_s390_apply_cpu_model() fails and
>> its @errp argument is null.
>>=20
>> s390_realize_cpu_model() crashes when get_max_cpu_model() or
>> check_compatibility() fail, and its @errp argument is null.
>>=20
>> All three messed up in commit 80560137cf "s390x/cpumodel: check and
>> apply the CPU model".
>>=20
>> The bugs can't bite as no caller actually passes null.  Fix them
>> anyway.
>>=20
>
> Subject is wrong, should e.g., start with "s390x/cpumodels". (I am not
> aware of CPU modules :) )

Of course.

> [...]
>
> Same comment regarding "local_err" and "BUG".
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


