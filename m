Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B11ECA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369D0214D8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHRXk5zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369D0214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRkZJ-0002cz-Cx
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 17:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laine@redhat.com>) id 1iRkYK-00021R-3p
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1iRkYI-0002Pb-4x
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:10:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1iRkYH-0002Nu-QI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572905420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihzfiZy4I1PzaxP1YtiEupvfocTjdxZ8tBKWi1mHcMI=;
 b=BHRXk5zEh+mi08kYyW1/wM+nU9qtGyvF0VITbAF3RwZgVLjT8alO+VKZdSSB4nnahf4PD4
 eZEjEKm+DnBAlj1uyix6RDUssUl6OhvSfvkRAv8Z4Re93cpFhqU9FYT3I887KQrJJtmB+P
 Icn1/jKi02CNgzZFuCXfVAO9oaAw0LY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-r-lbC5FOPNeHI_Bt5WVs1w-1; Mon, 04 Nov 2019 17:10:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 697991005500;
 Mon,  4 Nov 2019 22:10:16 +0000 (UTC)
Received: from [10.10.124.252] (ovpn-124-252.rdu2.redhat.com [10.10.124.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1A055D6D0;
 Mon,  4 Nov 2019 22:10:00 +0000 (UTC)
Subject: Re: [PATCH v7 0/11] add failover feature for assigned network devices
To: Parav Pandit <parav@mellanox.com>, Jens Freimann <jfreimann@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191029114905.6856-1-jfreimann@redhat.com>
 <AM0PR05MB4866CE01B7FA661DD2463F1DD17F0@AM0PR05MB4866.eurprd05.prod.outlook.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <9bd738fd-f0f4-49de-c455-c25a9dca0278@redhat.com>
Date: Mon, 4 Nov 2019 17:09:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB4866CE01B7FA661DD2463F1DD17F0@AM0PR05MB4866.eurprd05.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: r-lbC5FOPNeHI_Bt5WVs1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "aadam@redhat.com" <aadam@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ailan@redhat.com" <ailan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 4:21 PM, Parav Pandit wrote:
>>
>=20
> Patches are great to see failover capability enabled on the netdevice.
> However it's very difficult to test it without having libvirt support.
> Can we please have the necessary libvirt enhancements?

I'm working on libvirt support, and will make sure to Cc you with the=20
patches.


