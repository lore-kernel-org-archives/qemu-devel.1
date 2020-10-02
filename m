Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42BAC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1830B206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7xl7Cl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1830B206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kODW5-0003zu-51
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 01:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kODP9-0004Kx-DG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kODP7-0005Bi-Kx
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601615688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wAcCEhcjSj6tEpviteLqIkcMeqpz1f2yPRxsgvx9wE=;
 b=Z7xl7Cl41BW1pRsO22x0zcf8KKKPo76e9mKp1yBf0cVNzyCt7iP2Ld0P2wyDwBwpcF3E8J
 x6Cdvt/G1ljpmV4EZ3kTwJhOT7Fzz1UU22LBk2QeqyVrSK6cJUiLJ9ztb+XT5FVElBdrpx
 aVOfdiAVoY1XUukSW418ffogYQ8k9SY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-6Q4_ePN6N3ygIx1UzUgA-g-1; Fri, 02 Oct 2020 01:14:47 -0400
X-MC-Unique: 6Q4_ePN6N3ygIx1UzUgA-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D39571882FA0;
 Fri,  2 Oct 2020 05:14:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36B3010013BD;
 Fri,  2 Oct 2020 05:14:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92E221132784; Fri,  2 Oct 2020 07:14:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] block/nvme: Add driver statistics for access
 alignment and hw errors
References: <20201001162939.1567915-1-philmd@redhat.com>
Date: Fri, 02 Oct 2020 07:14:40 +0200
In-Reply-To: <20201001162939.1567915-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 1 Oct 2020 18:29:39
 +0200")
Message-ID: <87ft6xtdj3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Keep statistics of some hardware errors, and number of
> aligned/unaligned I/O accesses.
>
> QMP example booting a full RHEL 8.3 aarch64 guest:
>
> { "execute": "query-blockstats" }
> {
>     "return": [
>         {
>             "device": "",
>             "node-name": "drive0",
>             "stats": {
>                 "flush_total_time_ns": 6026948,
>                 "wr_highest_offset": 3383991230464,
>                 "wr_total_time_ns": 807450995,
>                 "failed_wr_operations": 0,
>                 "failed_rd_operations": 0,
>                 "wr_merged": 3,
>                 "wr_bytes": 50133504,
>                 "failed_unmap_operations": 0,
>                 "failed_flush_operations": 0,
>                 "account_invalid": false,
>                 "rd_total_time_ns": 1846979900,
>                 "flush_operations": 130,
>                 "wr_operations": 659,
>                 "rd_merged": 1192,
>                 "rd_bytes": 218244096,
>                 "account_failed": false,
>                 "idle_time_ns": 2678641497,
>                 "rd_operations": 7406,
>             },
>             "driver-specific": {
>                 "driver": "nvme",
>                 "completion-errors": 0,
>                 "unaligned-accesses": 2959,
>                 "aligned-accesses": 4477
>             },
>             "qdev": "/machine/peripheral-anon/device[0]/virtio-backend"
>         }
>     ]
> }
>
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: 'access-nb' -> 'accesses' (Stefan)
> ---
>  qapi/block-core.json | 24 +++++++++++++++++++++++-
>  block/nvme.c         | 27 +++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 86ed72ef9f..dec17e3036 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -941,6 +941,27 @@
>        'discard-nb-failed': 'uint64',
>        'discard-bytes-ok': 'uint64' } }
> =20
> +##
> +# @BlockStatsSpecificNvme:
> +#
> +# NVMe driver statistics
> +#
> +# @completion-errors: The number of completion errors.
> +#
> +# @aligned-accesses: The number of aligned accesses performed by
> +#                    the driver.
> +#
> +# @unaligned-accesses: The number of unaligned accesses performed by
> +#                      the driver.
> +#
> +# Since: 5.2
> +##
> +{ 'struct': 'BlockStatsSpecificNvme',
> +  'data': {
> +      'completion-errors': 'uint64',
> +      'aligned-accesses': 'uint64',
> +      'unaligned-accesses': 'uint64' } }
> +
>  ##
>  # @BlockStatsSpecific:
>  #
> @@ -953,7 +974,8 @@
>    'discriminator': 'driver',
>    'data': {
>        'file': 'BlockStatsSpecificFile',
> -      'host_device': 'BlockStatsSpecificFile' } }
> +      'host_device': 'BlockStatsSpecificFile',
> +      'nvme': 'BlockStatsSpecificNvme' } }
> =20
>  ##
>  # @BlockStats:

Acked-by: Markus Armbruster <armbru@redhat.com>


