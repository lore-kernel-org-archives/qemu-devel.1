Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19F5C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08D520637
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiK/4aez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08D520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVHOI-0003Dt-PQ
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iVHN0-0002Ff-QL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iVHMw-0004G3-T5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:49:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60236
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iVHMt-0004Db-DE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573746544;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fm0NrpIM+mPK8qiXtyEpfBLeuxF1xpZVLoTV1fEgGzM=;
 b=fiK/4aezpkDkUF7Sln1LxfRX580RFpnfKOF5Uv0ycQRyupnObofnpjVqByCDJItHjVaWEi
 KLJTg4r+f14bjmxmEKzHSts8ZHTvXfvzju//tzzpdAGrnXIzfvE3BxUWuNpVRTBkhtek9N
 XOV5C0oUbB+eK0TJfbbPWY5UXB7ZcFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-PgcpVjMXNi-V50zxatOhiQ-1; Thu, 14 Nov 2019 10:47:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DEB58026B0;
 Thu, 14 Nov 2019 15:47:50 +0000 (UTC)
Received: from [10.3.112.37] (ovpn-112-37.phx2.redhat.com [10.3.112.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE2B5E261;
 Thu, 14 Nov 2019 15:47:49 +0000 (UTC)
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
From: Tony Asleson <tasleson@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920092226.GH14365@stefanha-x1.localdomain>
 <32a302d7-b85a-991b-4366-2a82e38a9382@redhat.com>
Organization: Red Hat
Message-ID: <0752f1c5-ed79-bda4-ad53-6b2566cc35a2@redhat.com>
Date: Thu, 14 Nov 2019 09:47:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <32a302d7-b85a-991b-4366-2a82e38a9382@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: PgcpVjMXNi-V50zxatOhiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Reply-To: tasleson@redhat.com
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 12:28 PM, Tony Asleson wrote:
> On 9/20/19 4:22 AM, Stefan Hajnoczi wrote:
>> blkdebug is purely at the QEMU block layer level.  It is not aware of
>> storage controller-specific error information or features.  If you want
>> to inject NVMe- or SCSI-specific errors that make no sense in QEMU's
>> block layer, then trying to do it in blkdebug becomes a layering
>> violation.  This justifies adding a new error injection feature directly
>> into AHCI, virtio-scsi, NVMe, etc devices.
>=20
> Good discussion point...
>=20
> In my opening use case for this POC I'm generically trying to create an
> unrecoverable media error for a specific sector.  For each of the
> different device types it's different on how that error is conveyed and
> the associated data in transfer.
>=20

I would like to get some additional clarification on this point.  Should
I be investing more time integrating my proposed functionality into
blkdebug or other?

Sorry for the long response time, got sidetracked with other stuff.

Thanks,
Tony


