Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E863CC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29702053B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWXVpOdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29702053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZECR-0003Xe-BJ
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iZE9q-0001ec-Ox
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iZE9o-0001BC-GZ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:12:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iZE9o-0001Aj-Bu
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574687519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUP7o32wdF6Edrz6sHJTfpiobJ65Z069L1Q2kRgLsF0=;
 b=eWXVpOdCLdCLteN8sWVZfGsLW5IEo420SG5SS/Nk6vkYmC5vFxD22TbEDqFN4siDAHFx+6
 RUsx4YjyiBQDXCAKszzBVpstbSa9q7jpo5C3acw1z5Fi5JthvdFS7TZK9BccFAqHFaEK2h
 Z1b/dE5ObRboYGIgmWwZuf2pap8v6Pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-flbiYYjmN8a9sqmWvKNmRg-1; Mon, 25 Nov 2019 08:11:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D76508064D2;
 Mon, 25 Nov 2019 13:11:54 +0000 (UTC)
Received: from gondolin (ovpn-116-165.ams2.redhat.com [10.36.116.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A7DE60C63;
 Mon, 25 Nov 2019 13:11:50 +0000 (UTC)
Date: Mon, 25 Nov 2019 14:11:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 1/5] s390x: Don't do a normal reset on the initial cpu
Message-ID: <20191125141146.43ef5857.cohuck@redhat.com>
In-Reply-To: <20191125090348.27010-2-frankja@linux.ibm.com>
References: <20191125090348.27010-1-frankja@linux.ibm.com>
 <20191125090348.27010-2-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: flbiYYjmN8a9sqmWvKNmRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Nov 2019 04:03:44 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> The initiating cpu needs to be reset with an initial reset. While
> doing a normal reset followed by a initial reset is not wrong per se,
> the Ultravisor will only allow the correct reset to be performed.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d3edeef0ad..c1d1440272 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -348,6 +348,9 @@ static void s390_machine_reset(MachineState *machine)
>          break;
>      case S390_RESET_LOAD_NORMAL:
>          CPU_FOREACH(t) {
> +            if (t == cs) {
> +                continue;
> +            }
>              run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>          }
>          subsystem_reset();

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


