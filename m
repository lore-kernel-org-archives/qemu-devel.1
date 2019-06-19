Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D8FC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 13:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2004C20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 13:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2004C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdagA-0000CL-2A
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 09:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hdaeh-000819-DO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 09:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hdaeg-00044x-HU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 09:29:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hdaeg-00044E-C0
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 09:29:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2AAD307D866
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-204.rdu2.redhat.com
 [10.10.120.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFDE01001E71;
 Wed, 19 Jun 2019 13:29:33 +0000 (UTC)
Date: Wed, 19 Jun 2019 09:29:24 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190619132924.GA32240@localhost.localdomain>
References: <20190618142931.1694-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618142931.1694-1-imammedo@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 19 Jun 2019 13:29:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qmp: make qmp-shell work with python3
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 10:29:31AM -0400, Igor Mammedov wrote:
> python3 doesn't have raw_input(), so qmp-shell breaks.
> Use input() instead and override it with raw_input()
> if running on python2.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index 7776c7b141..8c49b39afa 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -308,7 +308,11 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>          @return True if execution was ok, return False if disconnected.
>          """
>          try:
> -            cmdline = raw_input(prompt)
> +            try: # attempt to set Python2 override
> +               import __builtin__;
> +               getattr(__builtin__, 'raw_input', input)
> +            except ModuleNotFoundError: pass

Something like:

   if sys.version_info[0] == 2:
       input = raw_input

Also does the job, and may be considered simpler and easier to read.

- Cleber.

> +            cmdline = input(prompt)
>          except EOFError:
>              print()
>              return False
> -- 
> 2.18.1
> 

