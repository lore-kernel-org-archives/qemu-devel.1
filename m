Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA03C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A7720656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8dKRoiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A7720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4yC-0005IZ-8O
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jT4vb-0000WM-Ay
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jT4va-0007tp-D6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:40:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jT4vZ-0007ti-Vc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587998408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=457P6psTw4EK7DX3Vy0xW3grFqYb6BElTV8TIrw6GEQ=;
 b=G8dKRoiBc9/SOuQCgOaqhzzdtdjsZXVd5LW0yuPbCnL5/7aEBWeC1VQoQqdBmqtoMpbULC
 A2rpTCgAO/zdXHyZxAbD/5ivLgvOdb7JbXAzAdUWHIL5utHM89UPnG4PxX+hrx0gu4ZEr/
 U0AagrogWailkqc92OO8mhCWg2r4NIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-_I8-kAj_MtK1L6DlPa1nvw-1; Mon, 27 Apr 2020 10:40:06 -0400
X-MC-Unique: _I8-kAj_MtK1L6DlPa1nvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 258D7107BEF7;
 Mon, 27 Apr 2020 14:40:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB87F60BEC;
 Mon, 27 Apr 2020 14:40:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70A9411358BC; Mon, 27 Apr 2020 16:40:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH 04/11] s390x/pci: Fix harmless mistake in zpci's property
 fid's setter
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-5-armbru@redhat.com>
 <a461ce39-e603-43ad-aea0-4aebf031ce52@linux.ibm.com>
Date: Mon, 27 Apr 2020 16:40:02 +0200
In-Reply-To: <a461ce39-e603-43ad-aea0-4aebf031ce52@linux.ibm.com> (Matthew
 Rosato's message of "Mon, 27 Apr 2020 10:11:05 -0400")
Message-ID: <87mu6xf0vx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Matthew Rosato <mjrosato@linux.ibm.com> writes:

> On 4/24/20 3:20 PM, Markus Armbruster wrote:
>> s390_pci_set_fid() sets zpci->fid_defined to true even when
>> visit_type_uint32() failed.  Reproducer: "-device zpci,fid=3Djunk".
>> Harmless in practice, because qdev_device_add() then fails, throwing
>> away @zpci.  Fix it anyway.
>>
>> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index ed8be124da..19ee1f02bb 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -1276,7 +1276,9 @@ static void s390_pci_set_fid(Object *obj, Visitor =
*v, const char *name,
>>           return;
>>       }
>>   -    visit_type_uint32(v, name, ptr, errp);
>> +    if (!visit_type_uint32(v, name, ptr, errp)) {
>> +        return;
>> +    }
>
> Hi Markus,
>
> Am I missing something here (a preceding patch maybe?) --=20
> visit_type_uint32 is a void function.  A quick look, no other callers
> are checking it for a return value either...
>
> The error value might get set in visit_type_uintN though.  Taking a
> hint from other places that handle this sort of case (ex:
> cpu_max_set_sve_max_vq), maybe something like:
>
> Error *err =3D NULL;
> ...
> visit_type_uint32(v, name, ptr, &err);
> if (err) {
> =09error_propogate(errp, err);
> =09return;
> }
> zpci->fid_defined =3D true;
>
> Instead?

This patch crept into this series by mistake.  It indeed depends on
other work I haven't published, yet.  Thanks, and sorry for wasting your
time!


