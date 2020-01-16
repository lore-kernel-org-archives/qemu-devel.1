Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A7C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9029D206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/gRWdAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9029D206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8bs-0008HB-Q0
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is8b7-0007VA-Ea
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is8az-0008Ks-9c
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:06:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is8ay-0008JU-Vv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579194371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/IemZDQh418fVA7BdNHlPr+d0bEGMgz6W1IthOiwZw=;
 b=g/gRWdAcKzndhCHCsZxQVV9vSZgqUUWUAny1TiFwjucRLGG1UkhvoZ6PQYXf4D5LpILwPn
 4BKpFo48vrX3Dn8hNnVAvgdaCEuKNICggDeM37LdWmr2pSIJxViXYUfT2gjvXrLVhiPhWX
 vCiZTCw/E58D+Uk2fT7fDt0RtM8G0Lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-Q2VKcf3AM7eoiPtLv5JMpw-1; Thu, 16 Jan 2020 12:06:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 183C018C8C00
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 17:06:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54C2F7C41A;
 Thu, 16 Jan 2020 17:06:08 +0000 (UTC)
Date: Thu, 16 Jan 2020 18:06:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 83/86] tests:numa-test: make top level args dynamic
 and g_autofree(cli) cleanups
Message-ID: <20200116180606.134cb1a6@redhat.com>
In-Reply-To: <20e88588-13b4-8c7d-3f97-cb2d50b85edd@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-84-git-send-email-imammedo@redhat.com>
 <20e88588-13b4-8c7d-3f97-cb2d50b85edd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Q2VKcf3AM7eoiPtLv5JMpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 17:35:32 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 15/01/2020 16.07, Igor Mammedov wrote:
> > Use GString to pass argument to make_cli() so that it would be easy
> > to dynamically change test case arguments from main(). The follow up
> > patch will use it to change RAM size options depending on target.
> > 
> > While at it cleanup 'cli' freeing, using g_autofree annotation.  
> 
> Hmm, I'd use g_autofree for new code or do it in a separate cleanup
> patch, but doing this here distracts quite a bit from the real changes
> that you are doing...
I'll split it into separate patch

> 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > PS:
> >   made as a separate patch so it won't clutter followup testcase changes.
> > 
> > CC: thuth@redhat.com
> > CC: lvivier@redhat.com
> > ---
> >  tests/qtest/numa-test.c | 38 ++++++++++++++------------------------
> >  1 file changed, 14 insertions(+), 24 deletions(-)
> > 
> > diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
> > index 17dd807..a696dfd 100644
> > --- a/tests/qtest/numa-test.c
> > +++ b/tests/qtest/numa-test.c
> > @@ -14,16 +14,16 @@
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/qmp/qlist.h"
> >  
> > -static char *make_cli(const char *generic_cli, const char *test_cli)
> > +static char *make_cli(const GString *generic_cli, const char *test_cli)
> >  {
> > -    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
> > +    return g_strdup_printf("%s %s", generic_cli->str, test_cli);
> >  }  
> [...]
> > @@ -539,11 +529,11 @@ static void pc_hmat_erange_cfg(const void *data)
> >  
> >  int main(int argc, char **argv)
> >  {
> > -    const char *args = NULL;
> > +    g_autoptr(GString) args = g_string_new("");  
> 
> I think g_string_new(NULL) would be better?
> 
> >      const char *arch = qtest_get_arch();
> >  
> >      if (strcmp(arch, "aarch64") == 0) {
> > -        args = "-machine virt";
> > +        g_string_append(args, " -machine virt")>      }  
> 
> Is this really required? Looking at your next patch, you could also
> simply do
> 
>           args = " -object memory-backend-ram,id=ram,size=xxxM"
xxx is variable so options are
 1 build this part of CLI dynamically
 2 mostly duplicate testcase function and include per target size there
 3 make up a test data structure and pass that to test cases

Given simplicity of current testcases, I'd prefer continue with
passing CLI as testcase data (option #1).


> 
> there? So using a GString seems overkill to me here.
> 
>  Thomas


