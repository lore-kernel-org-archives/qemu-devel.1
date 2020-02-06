Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2506C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C070A214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrLRKjDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C070A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdap-0007hi-Vt
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1izdZj-0006c6-8t
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1izdZg-0007Zm-Vu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:35:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1izdZg-0007Kw-QQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580981751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXKPj+CNySLM4Gxh1pz3VSsgig+PCDe9ZectzG31HNE=;
 b=YrLRKjDNcum4Y8HDqw+Ay5qfW9rCIfK0o7zmw0NrZfvQL8hgIZGx6/7gZoIm32x4vqpA+0
 QZJNZBU7CUsoKfXEW5EhLd9xeqK6SYjroxz4eylDU3910vuVMCrIEgtMh1eCFDJTHJ2GU7
 0JSOU2+aiFP9I4cQZtL9+M81U9NWvHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-ndmyn-tiMVykbV36Tu3M2Q-1; Thu, 06 Feb 2020 04:35:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D04C6802702;
 Thu,  6 Feb 2020 09:35:48 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51BBF790CD;
 Thu,  6 Feb 2020 09:35:41 +0000 (UTC)
Date: Thu, 6 Feb 2020 09:35:39 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 00/13] RFC: [for 5.0]: HMP monitor handlers cleanups
Message-ID: <20200206093539.GB3655@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <2e885a1d-94c7-53b5-44f7-feffe70f57c3@redhat.com>
 <20200127204355.GE4544@andariel.pipo.sk>
 <12217cd6-7866-ce9c-c0da-24775f9d045d@redhat.com>
 <20200128164717.GT3215@work-vm>
 <68242a4a-1904-db1b-769d-3ab7b91a993b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <68242a4a-1904-db1b-769d-3ab7b91a993b@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ndmyn-tiMVykbV36Tu3M2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Jan Tomko <jtomko@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* John Snow (jsnow@redhat.com) wrote:
>=20
>=20
> On 1/28/20 11:47 AM, Dr. David Alan Gilbert wrote:
> > * John Snow (jsnow@redhat.com) wrote:
> >>
> >>
> >> On 1/27/20 3:43 PM, Peter Krempa wrote:
> >>> On Mon, Jan 27, 2020 at 14:39:02 -0500, John Snow wrote:
> >>>>
> >>>>
> >>>> On 1/27/20 5:36 AM, Maxim Levitsky wrote:
> >>>>> This patch series is bunch of cleanups
> >>>>> to the hmp monitor code.
> >>>>>
> >>>>> This series only touched blockdev related hmp handlers.
> >>>>>
> >>>>> No functional changes expected other that
> >>>>> light error message changes by the last patch.
> >>>>>
> >>>>> This was inspired by this bugzilla:
> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1719169
> >>>>>
> >>>>> Basically some users still parse hmp error messages,
> >>>>> and they would like to have them prefixed with 'Error:'
> >>>>>
> >>>>
> >>>> HMP isn't meant to be parsed. It's explicitly *not* API or ABI. I do
> >>>> like consistency in my UIs (it's useful for human eyes, too), but I'=
d
> >>>> like to know more about the request.
> >>>
> >>> That's true as long as there's an stable replacement ... see below.
> >>>
> >>
> >> Thanks for the context!
> >>
> >>>>
> >>>> Is this request coming from libvirt? Can we wean them off of this
> >>>> interface? What do they need as a replacement?
> >>>
> >>> There are 5 commands that libvirt still has HMP interfaces for:
> >>>
> >>> drive_add
> >>> drive_del
> >>>
> >>> savevm
> >>> loadvm
> >>> delvm
> >>>
> >>> From upstream point of view there's no value in adding the 'error'
> >>> prefix to drive_add/drive_del as libvirt now uses blockdev-add/del QM=
P
> >>> command instead which have implicit error propagation.
> >>>
> >>
> >> As thought.
> >>
> >>> There are no replacements for the internal snapshot commands, but the=
y
> >>> reported the 'error' prefix for some time even before this series.
> >>>
> >>> Said that, please don't break savevm/loadvm/delvm until a QMP
> >>> replacement is added.
> >>>
> >>
> >> Yes, noted. I wonder where userfaultfd write support is these days...
> >=20
> > How would that help you there?
> >=20
>=20
> Left at the traffic lights, but there was a thought that we'd be able to
> get transactionable save-memory support in QMP if we could use
> userfaultfd to do just-in-time copies of memory as needed, until the job
> is complete.
>=20
> This way we could support it properly in QMP and we'd have a replacement
> for the HMP version which -- from memory -- is not appropriate for the
> QMP channel.
>=20
> Maybe I imagined this restriction.

The restriction is there; but it's not related to the memory saving;
savevm mostly uses the core migration code (which would normally run in
a separate thread) but uses it itself in it's own loop in the main
thread with a bunch of bdrv code glued around it to do the snapshots
there.=20
It shouldn't be that hard to convert it to be much more like a normal
migration - except it needs some hook then to do the snapshotting stuff
at the end.

Dave

> --js
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


