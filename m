Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CD0C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 05:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE8C2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 05:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE8C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYOxT-0002Lh-Ud
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 01:59:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYOwg-000223-6d
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 01:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYOwf-0001BB-7k
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 01:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hYOwd-0000xx-1p; Wed, 05 Jun 2019 01:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE1D73086202;
	Wed,  5 Jun 2019 05:58:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B415C207;
	Wed,  5 Jun 2019 05:58:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 25AB411386A0; Wed,  5 Jun 2019 07:58:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
	<20190603123823.32661-3-mehta.aaru20@gmail.com>
Date: Wed, 05 Jun 2019 07:58:32 +0200
In-Reply-To: <20190603123823.32661-3-mehta.aaru20@gmail.com> (Aarushi Mehta's
	message of "Mon, 3 Jun 2019 18:08:16 +0530")
Message-ID: <871s08efp3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 05 Jun 2019 05:58:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/9] qapi/block-core: add option for
 io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aarushi Mehta <mehta.aaru20@gmail.com> writes:

> Option only enumerates for hosts that support it.

Blank line here, please.  Same in other patches.

> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  qapi/block-core.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1defcde048..db7eedd058 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2792,11 +2792,13 @@
>  #
>  # @threads:     Use qemu's thread pool
>  # @native:      Use native AIO backend (only Linux and Windows)
> +# @io_uring:    Use linux io_uring (since 4.1)
>  #
>  # Since: 2.9
>  ##
>  { 'enum': 'BlockdevAioOptions',
> -  'data': [ 'threads', 'native' ] }
> +  'data': [ 'threads', 'native',
> +            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }

We prefer '-' over '_' in the QAPI schema: 'io-uring' instead of
'io_uring'.  Exceptions can be made when existing siblings use '_' (not
the case here), or to match how the thing is commonly spelled outside
QEMU.  Up to the subject matter experts; I just want to make sure it's
not accidental.

>  
>  ##
>  # @BlockdevCacheOptions:

