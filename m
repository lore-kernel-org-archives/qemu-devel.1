Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2551C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F062222A4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1V+2n7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F062222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlXt-0005yz-1D
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iWlWy-0005WK-I1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iWlWx-0004K0-9F
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:13:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iWlWx-0004Jc-1D
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574100822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebGhny6YnKXQQmm9Vb4CegxTdc99s68CgOEU30aJ3LM=;
 b=a1V+2n7/Ngi3sX+zA5H5uUkDRcwTmmjd5Q4OMoade/P5n0mLf5XNVT+xAiMbwGoAPgfn6w
 16B56CjMETQAx3oBN68TnhFsfkicPdF8TG2WN1EB10vz1DZpVa3WVDZ0tpxyUgJmXgNcZv
 0AXBcRLDsPGC/5ENJwN26SJmUeDhEIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-LXzCOKddMa-dJd13gjxb-A-1; Mon, 18 Nov 2019 13:13:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6FE01005514;
 Mon, 18 Nov 2019 18:13:38 +0000 (UTC)
Received: from gondolin (ovpn-117-194.ams2.redhat.com [10.36.117.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75C792AF50;
 Mon, 18 Nov 2019 18:13:37 +0000 (UTC)
Date: Mon, 18 Nov 2019 19:13:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 1/8] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL
 for EIO
Message-ID: <20191118191334.001f9343.cohuck@redhat.com>
In-Reply-To: <20191115033437.37926-2-farman@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-2-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LXzCOKddMa-dJd13gjxb-A-1
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 04:34:30 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
>=20
> EIO is returned by vfio-ccw mediated device when the backing
> host subchannel is not operational anymore. So return cc=3D3
> back to the guest, rather than returning a unit check.
> This way the guest can take appropriate action such as
> issue an 'stsch'.

Hnm, I'm trying to recall whether that was actually a conscious choice,
but I can't quite remember... the change does make sense at a glance,
however.

>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

I would need your s-o-b for that one, though :)

> ---
>  hw/vfio/ccw.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 6863f6c69f..0919ddbeb8 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -114,6 +114,7 @@ again:
>          return IOINST_CC_BUSY;
>      case -ENODEV:
>      case -EACCES:
> +    case -EIO:
>          return IOINST_CC_NOT_OPERATIONAL;
>      case -EFAULT:
>      default:


