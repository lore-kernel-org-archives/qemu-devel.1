Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8267E22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eiym+YNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8267E22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWMK-0001Y0-Oe
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxWLZ-000173-3r
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:00:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxWLW-0000h7-IO
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595253644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbywQwZqjN+BPXcbu4JuE+ic6Ve5LQa+tBDuAiKGt+c=;
 b=Eiym+YNN8TVkaZuvqKgzHuFEdlWFWk6yGV23y9L/CB0LhPVzG46njb46X4bJD2d4ZipWyv
 09GlEcOFtBeyeYkvTKJ/Y092JqcNzMoG4iYKJ7RksRMLp8QJHChhGr/UhZU+D94GMbyoHi
 o4suob6nzPt4tPabn9VT9W8FrvpAlcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-8NhkDvJGObOHjrRL-WzsHg-1; Mon, 20 Jul 2020 10:00:38 -0400
X-MC-Unique: 8NhkDvJGObOHjrRL-WzsHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6269100CCCC
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 14:00:37 +0000 (UTC)
Received: from turbo.dinechin.lan (ovpn-114-55.ams2.redhat.com [10.36.114.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7AD6619C5;
 Mon, 20 Jul 2020 14:00:14 +0000 (UTC)
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-5-kraxel@redhat.com>
User-agent: mu4e 1.3.9; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 04/10] build: fix device module builds
In-reply-to: <20200624131045.14512-5-kraxel@redhat.com>
Message-ID: <7hpn8qmglv.fsf@turbo.dinechin.lan>
Date: Mon, 20 Jul 2020 16:00:12 +0200
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 21:45:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-24 at 15:10 CEST, Gerd Hoffmann wrote...
> See comment.  Feels quite hackish.  Better ideas anyone?
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  Makefile.target | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Makefile.target b/Makefile.target
> index 8ed1eba95b9c..c70325df5796 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -179,6 +179,13 @@ endif # CONFIG_SOFTMMU
>  dummy := $(call unnest-vars,,obj-y)
>  all-obj-y := $(obj-y)
>
> +#
> +# common-obj-m has some crap here, probably as side effect from
> +# filling obj-y.  Clear it.  Fixes suspious dependency errors when

Typo: suspicious

> +# building devices as modules.
> +#

(As an aside: I'm also not filled with confidence by this comment ;-)

> +common-obj-m :=
> +
>  include $(SRC_PATH)/Makefile.objs
>  dummy := $(call unnest-vars,.., \
>                 authz-obj-y \


--
Cheers,
Christophe de Dinechin (IRC c3d)


