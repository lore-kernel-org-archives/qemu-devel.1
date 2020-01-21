Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E880C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183D622522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hn38ag4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183D622522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itoSQ-0004Jp-8i
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itoRh-0003ov-Ey
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itoRd-0001hq-K3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:59:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itoRd-0001hc-Gq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579593569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5ioB0h3k16V35nzK8aWSo3SOCFCXR51hEbmCEZuz8U=;
 b=Hn38ag4vwhnEqF/ozNOeahKNPTp3d1fNXL+EN9hze+h7f5J/k4fkRAWh6CyxsCdy2KE2NQ
 +klZRijhevVFHcz1cGCfeJ6pB88zh72Mh0RA3He/e91Hd8SXr8yDLICve1fSe8BNUrnrzP
 USFjtxAAmGYUvt7+PEEkf8157eMmQvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-2s6dCqWiPwKCTGflBknvxA-1; Tue, 21 Jan 2020 02:59:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0825E800A02;
 Tue, 21 Jan 2020 07:59:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 384DA5C28F;
 Tue, 21 Jan 2020 07:59:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF4DD1138600; Tue, 21 Jan 2020 08:59:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 10/13] block: add generic infrastructure for
 x-blockdev-amend qmp command
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-11-mlevitsk@redhat.com>
Date: Tue, 21 Jan 2020 08:59:18 +0100
In-Reply-To: <20200114193350.10830-11-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Tue, 14 Jan 2020 21:33:47 +0200")
Message-ID: <87muahi6jt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 2s6dCqWiPwKCTGflBknvxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> blockdev-amend will be used similiar to blockdev-create
> to allow on the fly changes of the structure of the format based block de=
vices.
>
> Current plan is to first support encryption keyslot management for luks
> based formats (raw and embedded in qcow2)
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ff5e5edaf..601f7dc9a4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4743,6 +4743,48 @@
>    'data': { 'job-id': 'str',
>              'options': 'BlockdevCreateOptions' } }
> =20
> +##
> +# @BlockdevAmendOptions:
> +#
> +# Options for amending an image format
> +#
> +# @driver           block driver that is suitable for the image
> +#
> +# Since: 5.0
> +##
> +{ 'union': 'BlockdevAmendOptions',
> +  'base': {
> +      'driver':         'BlockdevDriver' },
> +  'discriminator': 'driver',
> +  'data': {
> +  } }
> +
> +##
> +# @x-blockdev-amend:
> +#
> +# Starts a job to amend format specific options of an existing open bloc=
k device
> +# The job is automatically finalized, but a manual job-dismiss is requir=
ed.
> +#
> +# @job-id:          Identifier for the newly created job.
> +#
> +# @node-name:       Name of the block node to work on
> +#
> +# @options:         Options (driver specific)
> +#
> +# @force:           Allow unsafe operations, format specific
> +#                   For luks that allows erase of the last active keyslo=
t
> +#                   (permanent loss of data),
> +#                   and replacement of an active keyslot
> +#                   (possible loss of data if IO error happens)

PATCH 2 appears to reject that.  What am I missing?

> +#
> +# Since: 5.0
> +##
> +{ 'command': 'x-blockdev-amend',
> +  'data': { 'job-id': 'str',
> +            'node-name': 'str',
> +            'options': 'BlockdevAmendOptions',
> +            '*force': 'bool' } }
> +
>  ##
>  # @blockdev-open-tray:
>  #
> diff --git a/qapi/job.json b/qapi/job.json
> index a121b615fb..362b634ec1 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -19,10 +19,12 @@
>  #
>  # @create: image creation job type, see "blockdev-create" (since 3.0)
>  #
> +# @amend: image options amend job type, see "x-blockdev-amend" (since 5.=
0)
> +#
>  # Since: 1.7
>  ##
>  { 'enum': 'JobType',
> -  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
> =20
>  ##
>  # @JobStatus:


