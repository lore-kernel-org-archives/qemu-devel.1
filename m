Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F916C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3934C2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvNDN+OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3934C2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6g9-0005xE-D6
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL6fD-0004R7-AL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL6fB-0006AH-7b
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600874792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dpPvZKezEruSSP4vKXpS7Hccq2fIIS8lRChkxaFOl2M=;
 b=VvNDN+OTlTHs/DTWuwzw5Kx+bLfGo8PDwFvGbhvWz4NPEEg9Xh7iPulGKNTZFEzolPpiJy
 UP9rkSz8dmGCbHlo1T++QweFCTwcfMY15sHXKM2qjeBEC69P7JDu/vTaX7sGARX9LCamKB
 aXchqj40WvvruoKNaiOzVDctJ63JkQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-OyepF1E7O-WZMP_rs7UhtQ-1; Wed, 23 Sep 2020 11:26:27 -0400
X-MC-Unique: OyepF1E7O-WZMP_rs7UhtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B3F91007B2A;
 Wed, 23 Sep 2020 15:26:26 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08440100239F;
 Wed, 23 Sep 2020 15:26:25 +0000 (UTC)
Date: Wed, 23 Sep 2020 11:26:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 28/38] qapi/gen.py: update write() to be more idiomatic
Message-ID: <20200923152624.GO3312949@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-29-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-29-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:00:51PM -0400, John Snow wrote:
> Make the file handling here just a tiny bit more idiomatic.
> (I realize this is heavily subjective.)
> 
> Use exist_ok=True for os.makedirs and remove the exception,
> use fdopen() to wrap the file descriptor in a File-like object,
> and use a context manager for managing the file pointer.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I really miss a comment below explaining why we use
open(os.open(pathname, ...), ...) instead of open(pathname, ...).

> ---
>  scripts/qapi/gen.py | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index ba32f776e6..cf340e66d4 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -14,7 +14,6 @@
>  # See the COPYING file in the top-level directory.
>  
>  from contextlib import contextmanager
> -import errno
>  import os
>  import re
>  from typing import Dict, Generator, List, Optional, Tuple
> @@ -64,21 +63,18 @@ def write(self, output_dir: str) -> None:
>              return
>          pathname = os.path.join(output_dir, self.fname)
>          odir = os.path.dirname(pathname)
> +
>          if odir:
> -            try:
> -                os.makedirs(odir)
> -            except os.error as e:
> -                if e.errno != errno.EEXIST:
> -                    raise
> +            os.makedirs(odir, exist_ok=True)
> +
>          fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
> -        f = open(fd, 'r+', encoding='utf-8')
> -        text = self.get_content()
> -        oldtext = f.read(len(text) + 1)
> -        if text != oldtext:
> -            f.seek(0)
> -            f.truncate(0)
> -            f.write(text)
> -        f.close()
> +        with os.fdopen(fd, 'r+', encoding='utf-8') as fp:
> +            text = self.get_content()
> +            oldtext = fp.read(len(text) + 1)
> +            if text != oldtext:
> +                fp.seek(0)
> +                fp.truncate(0)
> +                fp.write(text)
>  
>  
>  def _wrap_ifcond(ifcond: List[str], before: str, after: str) -> str:
> -- 
> 2.26.2
> 

-- 
Eduardo


