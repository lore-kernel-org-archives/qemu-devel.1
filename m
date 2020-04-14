Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF8C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836CF2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/AW7nQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836CF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOGZ3-0006Iu-L9
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 04:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOGYG-0005lg-3X
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOGYF-0002eS-4R
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:04:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOGYF-0002e3-19
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586851450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFIP8KV3jQRMaENmvmBHOr7z+Qaoo4BRSE86lXXFrZ0=;
 b=U/AW7nQtviWJUU4FzVmtWHHlX6RfzxAzQ+7vG7q2tGoKONed2JnCHQa27Ar/n+sV9J5ZNG
 EMom7QKFZlo56coz87bFZe+fqXdi+UvuvDF/+BI/QwI2i9a8M7c9YQTV52BLIwLud874Md
 gSEKFdEv2/HRVK4QVSCbl+MaGJJHYqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-7GJNIJSqOtO0EXifQb6x3Q-1; Tue, 14 Apr 2020 04:04:02 -0400
X-MC-Unique: 7GJNIJSqOtO0EXifQb6x3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F675801A26;
 Tue, 14 Apr 2020 08:04:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6782410027A9;
 Tue, 14 Apr 2020 08:03:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C326C11385C8; Tue, 14 Apr 2020 10:03:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 2/2] lockable: replaced locks with lock guard macros
 where appropriate
References: <20200404042108.389635-1-dnbrdsky@gmail.com>
 <20200404042108.389635-3-dnbrdsky@gmail.com>
 <CA+ZmoZVJhyuXbbUJHTQdFZKA6+WqYUgnxEXF0y-nq0=aK4cpww@mail.gmail.com>
 <aacbf5fb-2c13-b7a8-3a28-de0a9b1b465e@redhat.com>
Date: Tue, 14 Apr 2020 10:03:52 +0200
In-Reply-To: <aacbf5fb-2c13-b7a8-3a28-de0a9b1b465e@redhat.com> (Paolo
 Bonzini's message of "Sat, 11 Apr 2020 15:03:54 +0200")
Message-ID: <87y2qyxzmf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Lieven <pl@kamp.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/04/20 13:19, Daniel Brodsky wrote:
>> Just making sure this patch didn't get lost.
>> ping http://patchwork.ozlabs.org/patch/1266336/
>
> The patch looks good, but it will be included in QEMU only after 5.0 is
> released.

Can we queue it for 5.1 right away?


