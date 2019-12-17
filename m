Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE00C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE342082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXLClPs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE342082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihC6M-0002Pp-Cm
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 07:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihC5g-0001yT-Fu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihC5e-0007Xw-Oq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:36:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihC5e-0007Ui-K2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576586197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=awitZ+xjVjgpO8oycCrMpvMjAWKHvCDXLsyIF3j7Zdc=;
 b=HXLClPs29xsIRX/F20aYkzsDQt4PikLKQbmSajSc5XD4d5c4b901WE3eLrvuwgCfRVOh9Y
 VGzqErYWUmnl0tehOjxxVUOnoSObICam1sCc4ZrYaMknTPNUljVR26XLjTq3RuDDuBEmMi
 w15M3utWA7HlWtx39lvEjKKfvV0Xj84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-sdos2IAOO5Cj8if5IIteGQ-1; Tue, 17 Dec 2019 07:36:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF20100550E;
 Tue, 17 Dec 2019 12:36:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-149.ams2.redhat.com [10.36.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 441725D9C9;
 Tue, 17 Dec 2019 12:36:30 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] pc-bios/s390x: Fix reset psw mask
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-5-frankja@linux.ibm.com>
 <20191205111239.01e7b114.cohuck@redhat.com>
 <20191213130616.7da8136c.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7d8f46eb-a08c-a678-1638-4634a6e675a3@redhat.com>
Date: Tue, 17 Dec 2019 13:36:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213130616.7da8136c.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sdos2IAOO5Cj8if5IIteGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/2019 13.06, Cornelia Huck wrote:
> On Thu, 5 Dec 2019 11:12:39 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
>> On Tue,  3 Dec 2019 08:28:13 -0500
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> We need to set the short psw indication bit in the reset psw, as it is
>>> a short psw.
>>>
>>> fixes: 9629823290 ("pc-bios/s390-ccw: do a subsystem reset before runni=
ng the guest")
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  pc-bios/s390-ccw/jump2ipl.c | 12 +++++++-----
>>>  1 file changed, 7 insertions(+), 5 deletions(-) =20
>>
>> Thanks, applied (together with a rebuild of the bios images.)
>=20
> This unfortunately breaks 'make check-qtest-s390x':
>=20
>    TEST    check-qtest-s390x: tests/boot-serial-test
>    TEST    check-qtest-s390x: tests/pxe-test
> ERROR - too few tests run (expected 1, got 0)
>=20
> When I revert this, the rebuild, and "s390x: Properly fetch and test
> the short psw on diag308 subc 0/1" (as it exposes the bug this commit
> tried to fix), everything passes again. No idea what is wrong, though :(
>=20
> For now, I've dropped the three patches mentioned above from the
> s390-next branch (I plan to send a pull request later). Let's fix this
> on top once we figured out whatever went wrong, no need to rush here.

I think I might have found the problem. You now need this patch on top
to get it working again:

diff a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -18,7 +18,7 @@
 typedef struct ResetInfo {
     uint64_t ipl_psw;
     uint32_t ipl_continue;
-} ResetInfo;
+} __attribute__((packed)) ResetInfo;

 static ResetInfo save;

Without this patch, there is now a 32-bit padding in the struct. Not
sure why it then fails (I had a quick look at the disassembly of
jump2ipl.o and could not spot anything that was obviously wrong), but if
I mark the struct as "packed" to get the old size again, then the
pxe-test is working fine for me again.

 Thomas


