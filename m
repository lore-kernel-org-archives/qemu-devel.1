Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBB0C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3157F22277
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5nNCYPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3157F22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwO7-0005fG-7l
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQwN6-0005AH-Ny
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQwN1-0005Hk-PT
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602265194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVRCvaMBTcZgGU9NMDvR8LZMMiMeLF1KwnHn03RmG3k=;
 b=E5nNCYPg4X6fyAnMLVHVNydLuqIJBqzn1dKfGZxuHZp+0kLTa2Gz+FFJz16BnaoV/Mf8Sb
 4sjNtSKcYV5+aI77lXfTbE9igozOUCylB/OcoOTa+gOByaoBeAiWB8JnrGpZiGOYRtIeKJ
 8ecpBrmEEmLDUduFd2+I9vtOng+JVoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-i40kTQSPN0KdQA4j2ogAqg-1; Fri, 09 Oct 2020 13:39:52 -0400
X-MC-Unique: i40kTQSPN0KdQA4j2ogAqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684F618829D4;
 Fri,  9 Oct 2020 17:39:51 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAD247664F;
 Fri,  9 Oct 2020 17:39:50 +0000 (UTC)
Date: Fri, 9 Oct 2020 13:39:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 26/36] qapi/gen.py: Fix edge-case of _is_user_module
Message-ID: <20201009173949.GE7303@habkost.net>
References: <20201009161558.107041-1-jsnow@redhat.com>
 <20201009161558.107041-27-jsnow@redhat.com>
 <87zh4vcnv9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87zh4vcnv9.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 07:26:02PM +0200, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
> > The edge case is that if the name is '', this expression returns a
> > string instead of a bool, which violates our declared type.
> >
> > In practice, module names are not allowed to be the empty string, but
> > this constraint is not modeled for the type system.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Reviewed-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> >  scripts/qapi/gen.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> > index fff0c0acb6d..2c305c4f82c 100644
> > --- a/scripts/qapi/gen.py
> > +++ b/scripts/qapi/gen.py
> > @@ -241,7 +241,7 @@ def __init__(self, prefix, what, user_blurb, builtin_blurb, pydoc):
> >  
> >      @staticmethod
> >      def _is_user_module(name):
> > -        return name and not name.startswith('./')
> > +        return bool(name and not name.startswith('./'))
> 
>            return not (name is None or name.startswith('./')
> 
> Looks slightly clearer to me.

That would have exactly the same behavior as the
  name is not None and name.startswith('./')
expression we had in v1.

-- 
Eduardo


