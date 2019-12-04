Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F299C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99B42073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul2JdkZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99B42073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQTG-000260-2t
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 03:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icQGx-0006NT-3u
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icQGq-00068Z-Ay
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:44:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icQGq-0005qE-6M
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575449063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiN/8fKPNTaU2pznycIQdkbix1HMwLzh6aYJsOCrXkY=;
 b=Ul2JdkZtjY4gD0W0C+IJYQDLIrrWeb2tH45VwvEK2gBu/Nc9WxsoM+SiviwPmQ1s02RWmG
 kwN2M7fEQIr8fJXSJRO6drwOaa9YN979lipCDHoGPRVpsMIQfrnnFUAFJ8nS1EOpZP322o
 4lyHPnn3CdPR1r7iFvA/LBXi2WEjPVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-tCFUSmiXMYWIaJjNHzRmUQ-1; Wed, 04 Dec 2019 03:44:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A96758C2A40;
 Wed,  4 Dec 2019 08:44:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB4FF600C8;
 Wed,  4 Dec 2019 08:44:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B3F81138606; Wed,  4 Dec 2019 09:44:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/21] Error handling fixes, may contain 4.2 material
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191201094354-mutt-send-email-mst@kernel.org>
Date: Wed, 04 Dec 2019 09:44:09 +0100
In-Reply-To: <20191201094354-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Sun, 1 Dec 2019 09:44:47 -0500")
Message-ID: <87immwfpk6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tCFUSmiXMYWIaJjNHzRmUQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 vsementsov@virtuozzo.com,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Nishanth Aravamudan <naravamudan@digitalocean.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Sat, Nov 30, 2019 at 08:42:19PM +0100, Markus Armbruster wrote:
>> PATCH 2-4 fix crash bugs.  Including them would be a no-brainer at
>> -rc0.  But we're post -rc3, and even for crash bugs we require a
>> certain likelihood of users getting bitten.
>>=20
>> Jens, please assess impact of PATCH 2's crash bug.
>>=20
>> Kevin, please do the same for PATCH 3.
>>=20
>> Daniel, please do the same for PATCH 4.
>
> virtio things:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

In my haste to get this into -rc4, I lost your r-bys.  Sorry about that!

> Jason do you want to pick these?

Merged in commit 39032981fa851d25fb27527f25f046fed800e585.


