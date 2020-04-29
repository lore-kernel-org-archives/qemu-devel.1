Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DEFC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEB9206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAHIuCt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEB9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfdO-0005t4-JD
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 01:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTfcn-0005UF-QM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTfcn-0001rl-CU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:51:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48671
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTfcn-0001ra-0q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588139472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2QYuyzxmuJfNqtp+MgNkHGTDETvRZQvQE1UkosiCCM=;
 b=bAHIuCt3h0fW0bjQj4iAK2VNPB1F17/CeqdGqNIUb3Hdce4dZNC+4XOtBeZ+OQgoSbYaJ0
 yH//0+O8KgzRI6PvsY+WzHK6DG0do7nXoAgTyB0p1D68KWuZkVO/5sH4d7P6XKoTg0y5+x
 ztlM/GpYRP58KAqZNJgYUYrB1jHFdFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-YMQeJhJOPluFlBO0B_MOVw-1; Wed, 29 Apr 2020 01:51:09 -0400
X-MC-Unique: YMQeJhJOPluFlBO0B_MOVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6074F8005B7
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 05:51:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7922B60BEC;
 Wed, 29 Apr 2020 05:51:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C2DA11358BC; Wed, 29 Apr 2020 07:51:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 03/11] s390x/cpumodel: Fix harmless misuse of
 visit_check_struct()
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-4-armbru@redhat.com>
 <57392357-7422-180f-d965-3f7bf3e657c2@redhat.com>
Date: Wed, 29 Apr 2020 07:51:04 +0200
In-Reply-To: <57392357-7422-180f-d965-3f7bf3e657c2@redhat.com> (David
 Hildenbrand's message of "Mon, 27 Apr 2020 10:02:16 +0200")
Message-ID: <875zdix2k7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 24.04.20 21:20, Markus Armbruster wrote:
>> Commit e47970f51d "s390x/cpumodel: Fix query-cpu-model-FOO error API
>> violations" neglected to change visit_end_struct()'s Error ** argument
>> along with the others.  If visit_end_struct() failed, we'd take the
>
> s/visit_end_struct/visit_check_struct/ ?

Will fix.

>> success path.  Fortunately, it can't fail here:
>> qobject_input_check_struct() checks we consumed the whole dictionary,
>> and to get here, we did.  Fix it anyway.
>
> AFAIKs, if visit_check_struct() failed, we'd still do the memcopy, but
> also report the error. Not nice, not bad.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


