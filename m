Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC644C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D352065F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2bRZ9Xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D352065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTWd-0001KD-Pi
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTVS-0007aC-L2
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:07:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23013
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTVR-0005Hm-5E
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sT2EpVcdb4CHg+FKs0qoxn+ObY2zXYzhu6d67pde+b0=;
 b=a2bRZ9Xuf4h9CpUckKW7XJtHW1OYVzENPDewStgXpW4YdnomSI/LRiiqxG6NpsDENW6Udr
 XyCtNdSfjcAmD3gsrLNAhnigMNz+0Ac65rBxV9duM0VEjz9p+hIBaivc8HdlwG+gYFfJ0G
 g7DdpL4p7alFCT+NV4BdPIn2w9ZTQIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-vo1IfYmsNa-pMRz6q0xkew-1; Fri, 15 May 2020 02:07:32 -0400
X-MC-Unique: vo1IfYmsNa-pMRz6q0xkew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49E5480183C;
 Fri, 15 May 2020 06:07:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 174FA78B22;
 Fri, 15 May 2020 06:07:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA94211358BC; Fri, 15 May 2020 08:07:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 1/3] qom/object: Move Object typedef to
 'qemu/typedefs.h'
References: <20200504115656.6045-1-f4bug@amsat.org>
 <20200504115656.6045-2-f4bug@amsat.org>
Date: Fri, 15 May 2020 08:07:25 +0200
In-Reply-To: <20200504115656.6045-2-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 May 2020 13:56:54
 +0200")
Message-ID: <87wo5drasi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> We use the Object type all over the place.
> Forward declare it in "qemu/typedefs.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/qemu/typedefs.h   | 1 +
>  include/qom/object.h      | 2 --
>  include/qom/qom-qobject.h | 2 --
>  include/sysemu/sysemu.h   | 1 -
>  4 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 375770a80f..b03ec9f40a 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -75,6 +75,7 @@ typedef struct NetFilterState NetFilterState;
>  typedef struct NICInfo NICInfo;
>  typedef struct NodeInfo NodeInfo;
>  typedef struct NumaNodeMem NumaNodeMem;
> +typedef struct Object Object;
>  typedef struct ObjectClass ObjectClass;
>  typedef struct PCIBridge PCIBridge;
>  typedef struct PCIBus PCIBus;
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 784c97c0e1..1edc12e64c 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -20,8 +20,6 @@
>  struct TypeImpl;
>  typedef struct TypeImpl *Type;
> =20
> -typedef struct Object Object;
> -
>  typedef struct TypeInfo TypeInfo;
> =20
>  typedef struct InterfaceClass InterfaceClass;
> diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
> index 77cd717e3f..82136e6e80 100644
> --- a/include/qom/qom-qobject.h
> +++ b/include/qom/qom-qobject.h
> @@ -13,8 +13,6 @@
>  #ifndef QEMU_QOM_QOBJECT_H
>  #define QEMU_QOM_QOBJECT_H
> =20
> -#include "qom/object.h"
> -
>  /*
>   * object_property_get_qobject:
>   * @obj: the object
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index ef81302e1a..ca4458e451 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -5,7 +5,6 @@
>  #include "qemu/timer.h"
>  #include "qemu/notify.h"
>  #include "qemu/uuid.h"
> -#include "qom/object.h"
> =20
>  /* vl.c */

How did you identify the inclusions to drop?


