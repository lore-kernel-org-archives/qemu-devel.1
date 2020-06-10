Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50289C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185EF20656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpkTE+Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185EF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiy8y-0001vq-Ar
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jiy8M-0001Us-7X
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 06:39:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jiy8L-0004Vn-5R
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 06:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591785540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSZItTXAjw8hhlbGai4V6JKLPmvMLmNd0IRpwakipzw=;
 b=cpkTE+BwJVuPdBMnFTi8FCTQQU21tUNCM3EYshIetsXUSAe2qgTvC5M/QzFgf1qXXDbJtE
 rTZKLZVPCLoPbjH/OfDAhrEIcIy95cAMshaRYUgcf06hBbVTZjSGKF3qVe66NJuNvx/stQ
 u+cj0JArXBJpJ5BqasgKDlDcITYWeeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-54j780hRPCaGi5SL9wNcSw-1; Wed, 10 Jun 2020 06:38:58 -0400
X-MC-Unique: 54j780hRPCaGi5SL9wNcSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F7D08735C0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 10:38:57 +0000 (UTC)
Received: from work-vm (ovpn-114-209.ams2.redhat.com [10.36.114.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1E6F10027AA;
 Wed, 10 Jun 2020 10:38:52 +0000 (UTC)
Date: Wed, 10 Jun 2020 11:38:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] hmp: Make json format optional for qom-set
Message-ID: <20200610103850.GE2718@work-vm>
References: <20200610075153.33892-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610075153.33892-1-david@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> Commit 7d2ef6dcc1cf ("hmp: Simplify qom-set") switched to the json
> parser, making it possible to specify complex types. However, with this
> change it is no longer possible to specify proper sizes (e.g., 2G, 128M),
> turning the interface harder to use for properties that consume sizes.
> 
> Let's switch back to the previous handling and allow to specify passing
> json via the "-j" parameter.
> 
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yep OK.  Shame it's got back to even more complex but it makes sense.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> v1 - v2:
> - keep the "value:S" as correctly noted by Paolo :)
> ---
>  hmp-commands.hx    |  7 ++++---
>  qom/qom-hmp-cmds.c | 20 ++++++++++++++++----
>  2 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 28256209b5..5d12fbeebe 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1806,9 +1806,10 @@ ERST
>  
>      {
>          .name       = "qom-set",
> -        .args_type  = "path:s,property:s,value:S",
> -        .params     = "path property value",
> -        .help       = "set QOM property",
> +        .args_type  = "json:-j,path:s,property:s,value:S",
> +        .params     = "[-j] path property value",
> +        .help       = "set QOM property.\n\t\t\t"
> +                      "-j: the property is specified in json format.",
>          .cmd        = hmp_qom_set,
>          .flags      = "p",
>      },
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index f704b6949a..a794e62f0b 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -44,15 +44,27 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
>  
>  void hmp_qom_set(Monitor *mon, const QDict *qdict)
>  {
> +    const bool json = qdict_get_try_bool(qdict, "json", false);
>      const char *path = qdict_get_str(qdict, "path");
>      const char *property = qdict_get_str(qdict, "property");
>      const char *value = qdict_get_str(qdict, "value");
>      Error *err = NULL;
> -    QObject *obj;
>  
> -    obj = qobject_from_json(value, &err);
> -    if (err == NULL) {
> -        qmp_qom_set(path, property, obj, &err);
> +    if (!json) {
> +        Object *obj = object_resolve_path(path, NULL);
> +
> +        if (!obj) {
> +            error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                      "Device '%s' not found", path);
> +        } else {
> +            object_property_parse(obj, value, property, &err);
> +        }
> +    } else {
> +        QObject *obj = qobject_from_json(value, &err);
> +
> +        if (!err) {
> +            qmp_qom_set(path, property, obj, &err);
> +        }
>      }
>  
>      hmp_handle_error(mon, err);
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


