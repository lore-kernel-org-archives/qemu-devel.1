Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998DEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A1C21789
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FquKZ7Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A1C21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQnUw-0003jP-I5
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 04:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQnTy-00038R-Dx
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 04:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQnTw-0002bd-Q6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 04:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602231028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ol2rIX4QtxaM13kxeoNLJc4iCLUo7gfqMECthZUj2E=;
 b=FquKZ7IlYH1WMNthSyY6jdwiU1f2rDCr7SPp+bKGjP5bDX16KrG4s5CC8rmPYFh/AY7JxZ
 y4sbfMGW87aNb4Fm9sl/F2ju9EXW6P+w1ANGRG1Fe6HP5jE2t4cV8tDubNMshQV9jsRSfJ
 wyH/tdyJzE3op8ZD68j+tJLapvJqESM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-rED3WGIwOz2BLUrawMa60w-1; Fri, 09 Oct 2020 04:10:24 -0400
X-MC-Unique: rED3WGIwOz2BLUrawMa60w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D7521019625;
 Fri,  9 Oct 2020 08:10:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC53A60CD0;
 Fri,  9 Oct 2020 08:10:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35FF3112CE10; Fri,  9 Oct 2020 10:10:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 2/6] nbd: Add 'qemu-nbd -A' to expose allocation depth
References: <20201009020714.1074061-1-eblake@redhat.com>
 <20201009020714.1074061-3-eblake@redhat.com>
Date: Fri, 09 Oct 2020 10:10:18 +0200
In-Reply-To: <20201009020714.1074061-3-eblake@redhat.com> (Eric Blake's
 message of "Thu, 8 Oct 2020 21:07:10 -0500")
Message-ID: <87lfgfom51.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 rjones@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> Allow the server to expose an additional metacontext to be requested
> by savvy clients.  qemu-nbd adds a new option -A to expose the
> qemu:allocation-depth metacontext through NBD_CMD_BLOCK_STATUS; this
> can also be set via QMP when using block-export-add.
>
> qemu as client can be hacked into viewing this new context by using
> the now-misnamed x-dirty-bitmap option when creating an NBD blockdev
> (even though our x- naming means we could rename it, I did not think
> it worth breaking back-compat of tools that have been using it while
> waiting for a better solution).  It is worth noting the decoding of
> how such context information will appear in 'qemu-img map
> --output=json':
>
> NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
> NBD_STATE_DEPTH_LOCAL   => "zero":false, "data":false
> NBD_STATE_DEPTH_BACKING => "zero":true,  "data":true
>
> libnbd as client is probably a nicer way to get at the information
> without having to decipher such hacks in qemu as client. ;)
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20200930121105.667049-6-eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> [eblake: comment tweak suggested by Vladimir]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 3758ea991269..249bd434f4eb 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3882,9 +3882,12 @@
>  #
>  # @tls-creds: TLS credentials ID
>  #
> -# @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place of
> +# @x-dirty-bitmap: A metacontext name such as "qemu:dirty-bitmap:NAME" or

What is a "metacontext"?

Aside: nbd.h spells it "meta context".  The two spellings suggest
different meanings to me.  Using meta- as a prefix modifies the prefixed
word, as in metadata (data that provides information about other data).
Separated by space, meta becomes a noun.  None of its common meanings
seem to apply here.  Recommend to pick an appropriate one of
"metacontext", "meta-context", "meta context", and stick to it.

> +#                  "qemu:allocation-depth" to query in place of the
>  #                  traditional "base:allocation" block status (see
> -#                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (since 3.0)
> +#                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol; and
> +#                  yes, naming this option x-context would have made
> +#                  more sense) (since 3.0)
>  #
>  # @reconnect-delay: On an unexpected disconnect, the nbd client tries to
>  #                   connect again until succeeding or encountering a serious
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 65804834d905..524cd3a94400 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -78,11 +78,15 @@
>  #          NBD client can use NBD_OPT_SET_META_CONTEXT with
>  #          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
>  #
> +# @alloc: Also export the allocation map for @device, so the NBD client
> +#         can use NBD_OPT_SET_META_CONTEXT with "qemu:allocation-depth"
> +#         to inspect allocation details. (since 5.2)
> +#
>  # Since: 5.0
>  ##
>  { 'struct': 'BlockExportOptionsNbd',
>    'data': { '*name': 'str', '*description': 'str',
> -            '*bitmap': 'str' } }
> +            '*bitmap': 'str', '*alloc': 'bool' } }
>
>  ##
>  # @NbdServerAddOptions:
[...]


