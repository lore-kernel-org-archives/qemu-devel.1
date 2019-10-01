Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2112C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA0A205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA0A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFO1S-00077A-TG
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iFNuT-0000yM-Jn
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iFNuQ-0004tP-TU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:34:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iFNuQ-0004sR-OH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:34:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B22142CE905;
 Tue,  1 Oct 2019 19:34:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 807C060579;
 Tue,  1 Oct 2019 19:34:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02DC3113864A; Tue,  1 Oct 2019 21:34:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v2 2/2] qapi: Allow introspecting fix for savevm's
 cooperation with blockdev
References: <cover.1568989362.git.pkrempa@redhat.com>
 <992ea9ca130b4fb6dbf82726aa3b1d8040c16944.1568989362.git.pkrempa@redhat.com>
Date: Tue, 01 Oct 2019 21:34:02 +0200
In-Reply-To: <992ea9ca130b4fb6dbf82726aa3b1d8040c16944.1568989362.git.pkrempa@redhat.com>
 (Peter Krempa's message of "Fri, 20 Sep 2019 16:26:45 +0200")
Message-ID: <87r23w2rbp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 01 Oct 2019 19:34:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> savevm was buggy as it considered all monitor owned block device nodes

Recommend "monitor-owned block device nodes" or "block device nodes
owned by a monitor"

> for snapshot. With introduction of -blockdev the common usage made all
> nodes including protocol nodes monitor owned and thus considered for
> snapshot.

What exactly is / was the problem?

>           This was fixed but clients need to be able to detect whether
> this fix is present.

Fixed where?  Commit hash, if possible.

>
> Since savevm does not have an QMP alternative add the feature for the

Comma after alternative.

> 'human-monitor-command' backdoor which is used to call this command in
> modern use.

Eww.  I don't have better ideas short of "design and implement a sane
QMP interface to internal snapshots", which is too much work.

> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  qapi/misc.json | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 6bd11f50e6..673445dfa9 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1020,6 +1020,12 @@
>  #
>  # @cpu-index: The CPU to use for commands that require an implicit CPU
>  #
> +# Features:
> +# @savevm-blockdev-monitor-nodes: If present, the savevm monitor command only

Maybe s/the savevm monitor command/HMP command savevm/

> +#                                 snapshots monitor owned nodes if they have no

monitor-owned or owner by a monitor again.

> +#                                 parents. This allows to use 'savevm' with
> +#                                 -blockdev. (since 4.2)
> +#
>  # Returns: the output of the command as a string
>  #
>  # Since: 0.14.0
> @@ -1047,7 +1053,8 @@
>  ##
>  { 'command': 'human-monitor-command',
>    'data': {'command-line': 'str', '*cpu-index': 'int'},
> -  'returns': 'str' }
> +  'returns': 'str',
> +  'features' : [ { 'name': 'savevm-blockdev-monitor-nodes' } ] }

No space before ':'.

Short form would do:

     'features': [ 'savevm-blockdev-monitor-nodes' ]

>
>  ##
>  # @change:

