Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA60C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A00D2071A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRlQ4lyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A00D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlasN-00017V-AU
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlaqS-0007Wg-Uf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:23:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34653
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlaqR-00024w-6f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592411002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XaB2Aa9uvi6TFVo3948pjxmXSbe3hSsjvBBAbNYUXtc=;
 b=DRlQ4lygU4q/XiBlKFsdrIAQccOXCvVIYWjmgxE4fVrNnp8yREf6NwUR/qJfqefSSjHB/4
 NrHT54W9S2Iqrj5nLC2ijM9TZ06celIdOPcMa94v0Cjrnu4aAAMg469l+noLNTnsVOCaSQ
 2RYQAnd80zeHV9INcOk8/DAGLF5kYpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-f19A9SOPNZeMk66Ink9XeQ-1; Wed, 17 Jun 2020 12:23:19 -0400
X-MC-Unique: f19A9SOPNZeMk66Ink9XeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD794835B40;
 Wed, 17 Jun 2020 16:23:17 +0000 (UTC)
Received: from work-vm (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CB785C1D4;
 Wed, 17 Jun 2020 16:23:16 +0000 (UTC)
Date: Wed, 17 Jun 2020 17:23:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] qom-hmp-cmds: fix a memleak in hmp_qom_get
Message-ID: <20200617162313.GA18975@work-vm>
References: <20200603070338.7922-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200603070338.7922-1-pannengyuan@huawei.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com, pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Pan Nengyuan (pannengyuan@huawei.com) wrote:
> 'obj' forgot to free at the end of hmp_qom_get(). Fix that.
> 
> The leak stack:
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f4e3a779ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
>     #1 0x7f4e398f91d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>     #2 0x55c9fd9a3999 in qstring_from_substr /build/qemu/src/qobject/qstring.c:45
>     #3 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/qapi/qobject-output-visitor.c:175
>     #4 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/qapi/qobject-output-visitor.c:168
>     #5 0x55c9fd88b34d in visit_type_str /build/qemu/src/qapi/qapi-visit-core.c:308
>     #6 0x55c9fd59aa6b in property_get_str /build/qemu/src/qom/object.c:2064
>     #7 0x55c9fd5adb8a in object_property_get_qobject /build/qemu/src/qom/qom-qobject.c:38
>     #8 0x55c9fd4a029d in hmp_qom_get /build/qemu/src/qom/qom-hmp-cmds.c:66
> 
> Fixes: 89cf4fe34f4
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Queued.

> ---
>  qom/qom-hmp-cmds.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index f704b6949a..3d2a23292d 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -71,6 +71,7 @@ void hmp_qom_get(Monitor *mon, const QDict *qdict)
>          qobject_unref(str);
>      }
>  
> +    qobject_unref(obj);
>      hmp_handle_error(mon, err);
>  }
>  
> -- 
> 2.18.2
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


