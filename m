Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962A8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4B92070C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N22nrwL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4B92070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itud7-0000vR-TJ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1itu2w-0000IY-B6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1itu2v-0004la-0q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:58:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41993
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1itu2u-0004lI-SC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579615100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvXxoX6jp2Kal2x1WuBJtLAun1LA7PgjImxZeIcOVBU=;
 b=N22nrwL+rpdgQeQHsyTSwJ7QlPzp9uNo5bNskRAXWKbpJ7p0NBRSkzyaB9aXx1DAJ5gB2l
 mRtE5v3xcDr+dS0xPjxQ18keNHDYe6G9Kng/u6YgHl32PElBdbz0zFjOhNQKGH0nFy32u5
 aPj+XLy/lPogL8+wao+wI48KDraJyls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-eOwM_ZZ9PkiwcVVJFWP44A-1; Tue, 21 Jan 2020 08:58:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D465F190D346;
 Tue, 21 Jan 2020 13:58:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8041D19C58;
 Tue, 21 Jan 2020 13:58:05 +0000 (UTC)
Message-ID: <60697a8b3e73ed0bcf68368fc6502c0ae9b65a20.camel@redhat.com>
Subject: Re: [PATCH 10/13] block: add generic infrastructure for
 x-blockdev-amend qmp command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Jan 2020 15:58:02 +0200
In-Reply-To: <87muahi6jt.fsf@dusky.pond.sub.org>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-11-mlevitsk@redhat.com>
 <87muahi6jt.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: eOwM_ZZ9PkiwcVVJFWP44A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-21 at 08:59 +0100, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > blockdev-amend will be used similiar to blockdev-create
> > to allow on the fly changes of the structure of the format based block devices.
> > 
> > Current plan is to first support encryption keyslot management for luks
> > based formats (raw and embedded in qcow2)
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [...]
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7ff5e5edaf..601f7dc9a4 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4743,6 +4743,48 @@
> >    'data': { 'job-id': 'str',
> >              'options': 'BlockdevCreateOptions' } }
> >  
> > +##
> > +# @BlockdevAmendOptions:
> > +#
> > +# Options for amending an image format
> > +#
> > +# @driver           block driver that is suitable for the image
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'union': 'BlockdevAmendOptions',
> > +  'base': {
> > +      'driver':         'BlockdevDriver' },
> > +  'discriminator': 'driver',
> > +  'data': {
> > +  } }
> > +
> > +##
> > +# @x-blockdev-amend:
> > +#
> > +# Starts a job to amend format specific options of an existing open block device
> > +# The job is automatically finalized, but a manual job-dismiss is required.
> > +#
> > +# @job-id:          Identifier for the newly created job.
> > +#
> > +# @node-name:       Name of the block node to work on
> > +#
> > +# @options:         Options (driver specific)
> > +#
> > +# @force:           Allow unsafe operations, format specific
> > +#                   For luks that allows erase of the last active keyslot
> > +#                   (permanent loss of data),
> > +#                   and replacement of an active keyslot
> > +#                   (possible loss of data if IO error happens)
> 
> PATCH 2 appears to reject that.  What am I missing?

this parameter overrides the safety checks for both operations.
It allows to erase all the keyslots (to allow to destroy the data
in unrecoverable way very fast), and it allows to overwrite an active
keyslot, which is not as dramatic, but in case of IO failure can
also result in bad things happening.

> 
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'command': 'x-blockdev-amend',
> > +  'data': { 'job-id': 'str',
> > +            'node-name': 'str',
> > +            'options': 'BlockdevAmendOptions',
> > +            '*force': 'bool' } }
> > +
> >  ##
> >  # @blockdev-open-tray:
> >  #
> > diff --git a/qapi/job.json b/qapi/job.json
> > index a121b615fb..362b634ec1 100644
> > --- a/qapi/job.json
> > +++ b/qapi/job.json
> > @@ -19,10 +19,12 @@
> >  #
> >  # @create: image creation job type, see "blockdev-create" (since 3.0)
> >  #
> > +# @amend: image options amend job type, see "x-blockdev-amend" (since 5.0)
> > +#
> >  # Since: 1.7
> >  ##
> >  { 'enum': 'JobType',
> > -  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
> > +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
> >  
> >  ##
> >  # @JobStatus:


Best regards,
	Maxim Levitsky


