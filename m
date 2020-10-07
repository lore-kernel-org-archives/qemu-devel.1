Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B86C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E9020789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSLnsO2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E9020789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8dB-00082Z-PL
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ8cD-0007VE-T1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ8cB-0006ey-GL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602073934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zo5aOPex7LJuDz0aXYXL5KhzXcsBX69gNAw/48EyXIA=;
 b=ZSLnsO2joerreGWvOrm+nt2aQqLPGS+KeWC6NMIJsRJpNFBTdQ7eWRL8f5KZHVKPMwrlQP
 6DngMiHVohvaokcxlE3p38FdZjBxe0niIlIsrtX/PL2i3qzN/yHsUTP4opYxRcgzW3CRLm
 +F8rDs3woHrdV5I269/HlJBXjRbGbsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-2ALXwj4wNbWh5V0MgajqoQ-1; Wed, 07 Oct 2020 08:32:12 -0400
X-MC-Unique: 2ALXwj4wNbWh5V0MgajqoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 777D280401F
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 12:32:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D9E702E7;
 Wed,  7 Oct 2020 12:32:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A09C11329C1; Wed,  7 Oct 2020 14:32:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 30/36] qapi/gen.py: update write() to be more idiomatic
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-31-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 14:32:09 +0200
In-Reply-To: <20201005195158.2348217-31-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:52 -0400")
Message-ID: <87wo02b4ja.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Make the file handling here just a tiny bit more idiomatic.
> (I realize this is heavily subjective.)
>
> Use exist_ok=True for os.makedirs and remove the exception,
> use fdopen() to wrap the file descriptor in a File-like object,
> and use a context manager for managing the file pointer.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/gen.py | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 3624162bb77..579ee283297 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -14,7 +14,6 @@
>  # See the COPYING file in the top-level directory.
>  
>  from contextlib import contextmanager
> -import errno
>  import os
>  import re
>  from typing import (
> @@ -67,21 +66,19 @@ def write(self, output_dir: str) -> None:
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

I wouldn't call this part "heavily subjective".  When wrote the old
code, exist_ok was still off limits (it's new in 3.2).

> +
> +        # use os.open for O_CREAT to create and read a non-existant file
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>


