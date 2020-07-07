Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB052C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD8B206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdY270aW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD8B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jstOo-0007pm-0J
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jstOF-0007Ot-NY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:36:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jstOD-0006kr-Ky
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594150584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4pxyif6vCA7Q2ARf0cNNXCLU62fQ7KvB9o94CRQIdw=;
 b=GdY270aWt7AsPaiQzolf8QNkDAoM7dX+I611ZDO2JjQRA5IwJ4xeCnAF95i7Yh469G0z/i
 etVD1R4hM2dwC3ea/aSDUEYNw/E62eLtGcf0Ey+WSwsaxr0J8cjOQM3tifaaJSHp2dab+K
 pf0tIVunAOzxIN2/AzhIcsCkYK06hlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-lslRWG3pO1GJwf3QQRsP1Q-1; Tue, 07 Jul 2020 15:36:12 -0400
X-MC-Unique: lslRWG3pO1GJwf3QQRsP1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0EA3800D5C;
 Tue,  7 Jul 2020 19:36:09 +0000 (UTC)
Received: from [10.3.115.46] (ovpn-115-46.phx2.redhat.com [10.3.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A97601A7CE;
 Tue,  7 Jul 2020 19:36:02 +0000 (UTC)
Subject: Re: [PATCH v12 2/8] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200707165037.1026246-1-armbru@redhat.com>
 <20200707165037.1026246-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <764387d7-0d42-a291-d720-60df303c15e4@redhat.com>
Date: Tue, 7 Jul 2020 14:36:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707165037.1026246-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, groug@kaod.org,
 Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 11:50 AM, Markus Armbruster wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
> does corresponding changes in code (look for details in
> include/qapi/error.h)
> 
> Usage example:
> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>   --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>   --max-width 80 FILES...
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/coccinelle/auto-propagated-errp.cocci | 337 ++++++++++++++++++
>   include/qapi/error.h                          |   3 +
>   MAINTAINERS                                   |   1 +
>   3 files changed, 341 insertions(+)
>   create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

Needs a tweak if we go with ERRP_GUARD.  But that's easy.

> +
> +// Convert special case with goto separately.
> +// I tried merging this into the following rule the obvious way, but
> +// it made Coccinelle hang on block.c
> +//
> +// Note interesting thing: if we don't do it here, and try to fixup
> +// "out: }" things later after all transformations (the rule will be
> +// the same, just without error_propagate() call), coccinelle fails to
> +// match this "out: }".

"out: }" is not valid C; would referring to "out: ; }" fare any better?

> +@ disable optional_qualifier@
> +identifier rule1.fn, rule1.local_err, out;
> +symbol errp;
> +@@
> +
> + fn(..., Error ** ____, ...)
> + {
> +     <...
> +-    goto out;
> ++    return;
> +     ...>
> +- out:
> +-    error_propagate(errp, local_err);
> + }
> +
> +// Convert most of local_err related stuff.
> +//
> +// Note, that we inherit rule1.fn and rule1.local_err names, not
> +// objects themselves. We may match something not related to the
> +// pattern matched by rule1. For example, local_err may be defined with
> +// the same name in different blocks inside one function, and in one
> +// block follow the propagation pattern and in other block doesn't.
> +//
> +// Note also that errp-cleaning functions
> +//   error_free_errp
> +//   error_report_errp
> +//   error_reportf_errp
> +//   warn_report_errp
> +//   warn_reportf_errp
> +// are not yet implemented. They must call corresponding Error* -
> +// freeing function and then set *errp to NULL, to avoid further
> +// propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
> +// For example, error_free_errp may look like this:
> +//
> +//    void error_free_errp(Error **errp)
> +//    {
> +//        error_free(*errp);
> +//        *errp = NULL;
> +//    }

I guess we can still decide later if we want these additional functions, 
or if they will even help after the number of places we have already 
improved after applying this script as-is and with Markus' cleanups in 
place.

While I won't call myself a Coccinelle expert, it at least looks sane 
enough that I'm comfortable if you add:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


