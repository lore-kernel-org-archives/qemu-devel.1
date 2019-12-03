Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE8DC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF7220684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxOm1Q1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF7220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic2YH-0002LJ-HD
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ic2Vs-0001j8-Ij
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ic2Vp-0003uC-Tz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:22:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ic2Vp-0003qj-Pr
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575357740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xMP/LkqtrI3XDzdSJ4gteSjaoLYnB9pNp+8xwsXnN0M=;
 b=NxOm1Q1/R5q4xONi5c1c2yOBxfmCO6ZWMUeyb1/LHHocJk5aBFUsCCAmMf+pSm0uvblo1J
 v5HT6Naviganakf9Xozc6VI/16HVvu+F2xsoxPix1vld0wwt/1vorqL96cknEvSejbJtUz
 OeioU8CvFsaX16uCgVAZxwamlA3NBwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-_Ed6ptghNRWWe8hva6lQTg-1; Tue, 03 Dec 2019 02:22:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9B7A800C71;
 Tue,  3 Dec 2019 07:22:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 159A819C68;
 Tue,  3 Dec 2019 07:22:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9AECF1138606; Tue,  3 Dec 2019 08:22:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 15/21] s390x/cpu_models: Fix latent feature property error
 handling bugs
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-16-armbru@redhat.com>
 <39af282a-2c6f-5717-0edd-93d9d767cfd0@redhat.com>
Date: Tue, 03 Dec 2019 08:22:12 +0100
In-Reply-To: <39af282a-2c6f-5717-0edd-93d9d767cfd0@redhat.com> (David
 Hildenbrand's message of "Mon, 2 Dec 2019 10:57:44 +0100")
Message-ID: <87fti198m3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _Ed6ptghNRWWe8hva6lQTg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 30.11.19 20:42, Markus Armbruster wrote:
>> s390x-cpu property setters set_feature() and set_feature_group() crash
>> when the visitor fails and its @errp argument is null.  Messed up in
>> commit 0754f60429 "s390x/cpumodel: expose features and feature groups
>> as properties".
>
> Same comment as to the other patches :)
>
> I think we usually use "s390x/cpumodels", but that's just nitpicking.

$ git-log --oneline target/s390x/cpu_models.c | awk '$2 ~ /:$/ { print $2 }=
' | sort | uniq -c
      1 S390:
      6 qapi:
      1 qemu-common:
      1 qmp:
      2 qobject:
      1 qom:
      1 s390/cpumodel:
      1 s390x/ccw:
     21 s390x/cpumodel:
      1 s390x/cpumodels:
      1 s390x/kvm:
      4 s390x/tcg:
      7 s390x:
      1 target/s390x/cpu_models:
     17 target/s390x:
      1 target:

You're right, except for the plural vs. singular.  I should've browsed
git-log.

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


