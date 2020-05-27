Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F726C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044C8207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB5SeXqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044C8207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduP0-0001KJ-98
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jduOR-0000uH-Hy
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:38:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jduOQ-00089c-LA
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590579522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcWjV8RtwXknvrPYeyXdwXU6Cp97YI2F49n6SbtCDJs=;
 b=LB5SeXqqoyBB4o8q89NgrdjIsSWNvvMUAuOK1ahW2fyWsXdBTLUwEImCuG4dnp2+bL7mEf
 /jH+EFiF6NUt50abrvuf+qwXhD2FDAQqWGpZHLuSgHHxAzSynjWtI6p8o/VJFWTEOD9wIi
 4ZIlffBfqTQYOS2AZsVU7nvGBsDjdMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-oU_QUdTMOtOboDq_NM3YHw-1; Wed, 27 May 2020 07:38:40 -0400
X-MC-Unique: oU_QUdTMOtOboDq_NM3YHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CAC680B714
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 11:38:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B39866E9F3;
 Wed, 27 May 2020 11:38:34 +0000 (UTC)
Date: Wed, 27 May 2020 12:38:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 2/5] softmmu/vl: Let -fw_cfg option take a 'blob_id'
 argument
Message-ID: <20200527113831.GM2665520@redhat.com>
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-3-philmd@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 08:20:21PM +0200, Philippe Mathieu-Daudé wrote:
> The 'blob_id' argument refers to a QOM object able to produce
> data consumable by the fw_cfg device. The producer object must
> implement the FW_CFG_DATA_GENERATOR interface.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  softmmu/vl.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index ae5451bc23..f76c53ad2e 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -489,6 +489,10 @@ static QemuOptsList qemu_fw_cfg_opts = {
>              .name = "string",
>              .type = QEMU_OPT_STRING,
>              .help = "Sets content of the blob to be inserted from a string",
> +        }, {
> +            .name = "blob_id",
> +            .type = QEMU_OPT_STRING,
> +            .help = "Sets id of the object generating fw_cfg blob to be used",
>          },

<bikeshed>

I wonder if "generator_id" or "gen_id" is more appropriate as the property
name

</bikeshed>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


