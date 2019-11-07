Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF98C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 04:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089762166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 04:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JI3xUP34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089762166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSZJc-0004rN-3b
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 23:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iSZIZ-0004Ou-PH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 23:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iSZIW-00074F-Vz
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 23:21:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59710
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iSZIW-00072x-SB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 23:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573100487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUqmXJFPu/ehbA5mmVoLVJcBN9hFKprG7wWXc1sJd6c=;
 b=JI3xUP34kQ15h95A+atU/qSgF5AZ/2DRWp4TzaCn0U+QXMiN4cfdYA2AzscnS3vfX0z/q2
 56lj3vjUDJrB7v5gkGiA/bttbTUSGLJ+pB4YRio222pQOFjTs2ZmW9UAYWLe2ZfYqDeinQ
 m1Hz/ay3CQhW9LT0cQWgstaSI4hay1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-_fffvus1PgqWSMXbCobeUw-1; Wed, 06 Nov 2019 23:21:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02ACC800C61;
 Thu,  7 Nov 2019 04:21:23 +0000 (UTC)
Received: from [10.72.12.214] (ovpn-12-214.pek2.redhat.com [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE26A10002D0;
 Thu,  7 Nov 2019 04:21:07 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v2 1/2] net: assert that tx packets have
 nonzero size
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190722132344.30798-1-alxndr@bu.edu>
 <20190722132344.30798-2-alxndr@bu.edu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d549979a-3482-febc-4dc8-77dae431ad2c@redhat.com>
Date: Thu, 7 Nov 2019 12:21:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722132344.30798-2-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _fffvus1PgqWSMXbCobeUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/7/22 =E4=B8=8B=E5=8D=889:24, Oleinik, Alexander wrote:
> Virtual devices should not try to send zero-sized packets. The caller
> should check the size prior to calling qemu_sendv_packet_async.
>
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
> v2:
>    * Improve the comment to explain the rationale for adding the assert.
>   net/net.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/net/net.c b/net/net.c
> index 7d4098254f..4ad21df36f 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -741,6 +741,15 @@ ssize_t qemu_sendv_packet_async(NetClientState *send=
er,
>       size_t size =3D iov_size(iov, iovcnt);
>       int ret;
>  =20
> +    /*
> +     * Since this function returns the size of the sent packets, and a r=
eturn
> +     * value of zero indicates that the packet will be sent asynchronous=
ly,
> +     * there is currently no way to report that a 0-sized packet has bee=
n sent
> +     * successfully. Forbid it for now, and if someone needs this functi=
onality
> +     * later, the API will require a change.
> +     */
> +    assert(size);


This probably will make the assertion triggerable from guest. Is this=20
better to warn and return NET_BUFSIZE + 1 here?

Thanks


> +
>       if (size > NET_BUFSIZE) {
>           return size;
>       }


