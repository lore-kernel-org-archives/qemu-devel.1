Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC592067C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcBhrFk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC592067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHwL-00062Z-N0
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iiHvB-00054z-IG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iiHv6-00087e-Ct
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:02:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36407
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iiHv6-00086B-6B
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576846935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMX8TPumHETGIvt66tVBb2cmbuaQl0z4CMrEQI60adI=;
 b=LcBhrFk393Z/oB1gKxt56k974SfHE5Q/Zi9TxnhRJjbprNpUN9RJ9TncS2pONoFy8KVx4Y
 NSyaAIRlj1vIVDH3DFBIZdLzRYHOYOQvOuvLFLbaaOjEzg85vqSJ7uPYF1kLLq79e9KGhb
 uhQehABS7Mu6gkLkx3ltNb5GLGVMiRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-MLRCa-CPPkuopXUf0Jvw9Q-1; Fri, 20 Dec 2019 08:02:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 818D9DBE6;
 Fri, 20 Dec 2019 13:02:11 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13D315C28F;
 Fri, 20 Dec 2019 13:02:08 +0000 (UTC)
Date: Fri, 20 Dec 2019 14:02:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
Message-ID: <20191220130207.GH4019@dhcp-200-226.str.redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
 <87lfr7go0z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfr7go0z.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: MLRCa-CPPkuopXUf0Jvw9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.12.2019 um 13:49 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 19.12.2019 um 15:38 hat Max Reitz geschrieben:
> >> fuse-export-add allows mounting block graph nodes via FUSE on some
> >> existing regular file.  That file should then appears like a raw disk
> >> image, and accesses to it result in accesses to the exported BDS.
> >>=20
> >> Right now, we only set up the mount point and tear all mount points do=
wn
> >> in bdrv_close_all().  We do not implement any access functions, so
> >> accessing the mount point only results in errors.  This will be
> >> addressed by a followup patch.
> >>=20
> >> The set of exported nodes is kept in a hash table so we can later add =
a
> >> fuse-export-remove that allows unmounting.
> >>=20
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >
> >> diff --git a/qapi/block.json b/qapi/block.json
> >> index 145c268bb6..03f8d1b537 100644
> >> --- a/qapi/block.json
> >> +++ b/qapi/block.json
> >> @@ -317,6 +317,29 @@
> >>  ##
> >>  { 'command': 'nbd-server-stop' }
> >> =20
> >> +##
> >> +# @fuse-export-add:
> >> +#
> >> +# Exports a block graph node on some (file) mountpoint as a raw image=
.
> >> +#
> >> +# @node-name: Node to be exported
> >> +#
> >> +# @mountpoint: Path on which to export the block device via FUSE.
> >> +#              This must point to an existing regular file.
> >> +#
> >> +# @writable: Whether clients should be able to write to the block
> >> +#            device via the FUSE export. (default: false)
> >> +#
> >> +# Since: 5.0
> >> +##
> >> +{ 'command': 'fuse-export-add',
> >> +  'data': {
> >> +      'node-name': 'str',
> >> +      'mountpoint': 'str',
> >> +      '*writable': 'bool'
> >> +  },
> >> +  'if': 'defined(CONFIG_FUSE)' }
> >
> > Can this use a BlockExport union from the start like I'm introducing in
> > the storage daemon series, together with a generic block-export-add?
> >
> > It also looks like node-name and writable should be part of the common
> > base of BlockExport. Unfortunately this would mean that I can't use the
> > same BlockExportNbd for the existing nbd-server-add command any more. I
> > guess I could somehow get a shared base type for both, though.
> >
> > Markus, any thoughts on these QAPI interfaces?
>=20
> Context?  How far back should I read?

Basically just the hunk quoted above and the QAPI portion of the
following storage daemon patch:

    [RFC PATCH 08/18] qemu-storage-daemon: Add --export option

Maybe the cover letter, too, if you need a more high-level introduction.

Kevin


