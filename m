Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1699FCA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 05:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00092086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 05:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmZZmLtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00092086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQPmQ-0001D0-05
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 01:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iQPla-0000Gw-TM
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 01:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iQPlZ-000462-7S
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 01:46:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iQPlZ-00045g-4M
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 01:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572587192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8aCDrwXZdhrOrzDVkG1J+obKTXqtk9UWn4M7utZDJes=;
 b=cmZZmLtb0bntLJh8WqfUK4NBU6kUYpMrnlG2Iu/sCdOL2Hxq1G/i5W5pzUTyOX2+UZAoOn
 3Ph4V4GFai6AwLEpyvO/zp/5g9a2THIlL+aBqJTwAh9Ph6pZs/GslBFPE0SQsrPtY+R6Pq
 kLde4FDoZMwNmjzwJR95FSsoBg5kj5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-vgxAa4QfNw-9bYGV8D_KKQ-1; Fri, 01 Nov 2019 01:46:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A8A9107ACC0;
 Fri,  1 Nov 2019 05:46:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6731E60BFB;
 Fri,  1 Nov 2019 05:46:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CA3511385C9; Fri,  1 Nov 2019 06:40:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 1/9] IDE: deprecate ide-drive
References: <20191031105904.12194-1-jsnow@redhat.com>
 <20191031105904.12194-2-jsnow@redhat.com>
 <c688f160-e10e-52d1-5a54-881dd86987d4@redhat.com>
Date: Fri, 01 Nov 2019 06:40:33 +0100
In-Reply-To: <c688f160-e10e-52d1-5a54-881dd86987d4@redhat.com> (Paolo
 Bonzini's message of "Thu, 31 Oct 2019 23:02:45 +0100")
Message-ID: <87tv7ojgry.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vgxAa4QfNw-9bYGV8D_KKQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/10/19 11:58, John Snow wrote:
>> It's an old compatibility shim that just delegates to ide-cd or ide-hd.
>> I'd like to refactor these some day, and getting rid of the super-object
>> will make that easier.
>>=20
>> Either way, we don't need this.
>
> Good idea.  I will prepare a similar patch for scsi-disk, even though
> technically we're already in soft freeze; it makes no sense to deprecate
> only one of the two.

We still use scsi-disk for -drive if=3Dscsi,... and for the desugaring of
the usb-storage device, via scsi_bus_legacy_add_drive().  I figure you'd
need to either wean them off scsi-disk or deprecate them, too.


