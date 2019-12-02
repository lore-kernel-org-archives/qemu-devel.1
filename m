Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC4C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D47215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKfpwS7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D47215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhmd-00041L-Op
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ibhlx-0003Tq-0j
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ibhlv-0006Pz-TD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:13:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20071
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ibhlv-0006Nc-GH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575278014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9EVSutnWBwfkpzzjowiNbh4aQdl9pO4MGtAIVZsRXI=;
 b=TKfpwS7lXFE6yHF2iXU+Scv8PJqOyeSmqndDYcimJSxO12mP3Uk8n35y5tQO0nku9haKsj
 Eps4be1asyQsXUALEhKkDUERNW9a+mM+fCd3zV8bNWp355MIVui4L8riqCz7tjzjoY9bAY
 NUjkWrmQwvoWKxTMpYek5FHXCckdLm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-QYkSB_W6NNaj9nw0kLIzfg-1; Mon, 02 Dec 2019 04:13:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DC748017DF;
 Mon,  2 Dec 2019 09:13:30 +0000 (UTC)
Received: from gondolin (ovpn-116-41.ams2.redhat.com [10.36.116.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7F1410013A7;
 Mon,  2 Dec 2019 09:13:25 +0000 (UTC)
Date: Mon, 2 Dec 2019 10:13:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 1/3] s390x: Properly fetch and test the short psw on
 diag308 subc 0/1
Message-ID: <20191202101323.5f8d26d2.cohuck@redhat.com>
In-Reply-To: <20191129142025.21453-2-frankja@linux.ibm.com>
References: <20191129142025.21453-1-frankja@linux.ibm.com>
 <20191129142025.21453-2-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QYkSB_W6NNaj9nw0kLIzfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 09:20:23 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> We need to actually fetch the cpu mask and set it. As we invert the
> short psw indication in the mask, SIE will report a specification
> exception, if it wasn't present in the reset psw.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 12 ++++++++++--
>  target/s390x/cpu.h |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)

Thanks, applied.


