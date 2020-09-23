Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD2CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B23C20725
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIuJBzPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B23C20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLBWd-0007JS-3R
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 16:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLBVW-0006Yg-8J
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLBVT-0007gz-2l
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600893409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2d3GoEkYl1O2En22jMlh1Uz1ftU6kq/EbijelLuq2Xw=;
 b=ZIuJBzPfAOKi4hR5TfeRLK9+RaHZf/5hnREewpTppg99z1r5XswGEPz0IHV4ZxH0Q31sd4
 ZTFU4H0GZN9gixHKRhnHz17ftLOyu4O/unJxHFsFxrkR4eqjZU033CKNMdnTMzNBO5mlIe
 ThmvoPEs5lKCfM49vcAsG4hzWt3+syA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-AH1dGHLwM3-DqbKcavknuw-1; Wed, 23 Sep 2020 16:36:47 -0400
X-MC-Unique: AH1dGHLwM3-DqbKcavknuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137D11074669;
 Wed, 23 Sep 2020 20:36:46 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9118973668;
 Wed, 23 Sep 2020 20:36:45 +0000 (UTC)
Date: Wed, 23 Sep 2020 16:36:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch
 table
Message-ID: <20200923203644.GL3717385@habkost.net>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-17-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-17-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:13:13PM -0400, John Snow wrote:
> This enforces a type signature against all of the top-level expression
> check routines without necessarily needing to create some
> overcomplicated class hierarchy for them.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/expr.py | 69 ++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index 74b2681ef8..cfd342aa04 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -31,8 +31,11 @@
>  structures and contextual semantic validation.
>  """
>  
> +from enum import Enum
>  import re
>  from typing import (
> +    Callable,
> +    Dict,
>      Iterable,
>      List,
>      MutableMapping,
> @@ -494,6 +497,26 @@ def check_event(expr: Expression, info: QAPISourceInfo) -> None:
>      check_type(args, info, "'data'", allow_dict=not boxed)
>  
>  
> +class ExpressionType(str, Enum):
> +    INCLUDE = 'include'
> +    ENUM = 'enum'
> +    UNION = 'union'
> +    ALTERNATE = 'alternate'
> +    STRUCT = 'struct'
> +    COMMAND = 'command'
> +    EVENT = 'event'
> +
> +
> +_CHECK_FN: Dict[str, Callable[[Expression, QAPISourceInfo], None]] = {
> +    'enum': check_enum,
> +    'union': check_union,
> +    'alternate': check_alternate,
> +    'struct': check_struct,
> +    'command': check_command,
> +    'event': check_event,
> +}
> +
> +
>  def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
>      """
>      Validate and normalize a list of parsed QAPI schema expressions. [RW]
> @@ -519,28 +542,20 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
>          assert tmp is None or isinstance(tmp, QAPIDoc)
>          doc: Optional[QAPIDoc] = tmp
>  
> -        if 'include' in expr:
> -            continue
> -
> -        if 'enum' in expr:
> -            meta = 'enum'
> -        elif 'union' in expr:
> -            meta = 'union'
> -        elif 'alternate' in expr:
> -            meta = 'alternate'
> -        elif 'struct' in expr:
> -            meta = 'struct'
> -        elif 'command' in expr:
> -            meta = 'command'
> -        elif 'event' in expr:
> -            meta = 'event'
> +        for kind in ExpressionType:
> +            if kind in expr:
> +                meta = kind

I see lots of meta.value expressions below.  Maybe setting
  meta = kind.value
will make the code more readable?

I don't think this should block an obvious improvement to the
code, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> +                break
>          else:
>              raise QAPISemError(info, "expression is missing metatype")
>  
> +        if meta == ExpressionType.INCLUDE:
> +            continue
> +
>          name = cast(str, expr[meta])  # asserted right below:
> -        check_name_is_str(name, info, "'%s'" % meta)
> -        info.set_defn(meta, name)
> -        check_defn_name_str(name, info, meta)
> +        check_name_is_str(name, info, "'%s'" % meta.value)
> +        info.set_defn(meta.value, name)
> +        check_defn_name_str(name, info, meta.value)
>  
>          if doc:
>              if doc.symbol != name:
> @@ -551,22 +566,8 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
>              raise QAPISemError(info,
>                                 "documentation comment required")
>  
> -        if meta == 'enum':
> -            check_enum(expr, info)
> -        elif meta == 'union':
> -            check_union(expr, info)
> -        elif meta == 'alternate':
> -            check_alternate(expr, info)
> -        elif meta == 'struct':
> -            check_struct(expr, info)
> -        elif meta == 'command':
> -            check_command(expr, info)
> -        elif meta == 'event':
> -            check_event(expr, info)
> -        else:
> -            assert False, 'unexpected meta type'
> -
> -        check_if(expr, info, meta)
> +        _CHECK_FN[meta](expr, info)
> +        check_if(expr, info, meta.value)
>          check_features(expr.get('features'), info)
>          check_flags(expr, info)
>  
> -- 
> 2.26.2
> 

-- 
Eduardo


