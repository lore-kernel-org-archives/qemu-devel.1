Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3790FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9015921D43
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1E6tjVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9015921D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQoKT-0005ET-1e
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 05:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kQoJb-0004ji-MH
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kQoJX-0000Pi-Tv
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602234226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40BLIpHmpxJ0tmZvEbnZG0e27rsaUOb3kN365+FYWOw=;
 b=W1E6tjVRMU3Am81/nGT/4NtqgNCdGXJ/+5bq0PfSQem/9S+mHGiT0MnOy5QtS/A7EV5TfR
 dblZT3tB3c9QwLTUXOinzsr5WNDAN1dhaVLG0xKOYwsAde4hN9OxkkAZnh/onQrBIfjUda
 XaP0uFrPoFx58ABUQLEMrMoWwxRIU24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-iF00IfEAP3-0Gb9yuz_E4g-1; Fri, 09 Oct 2020 05:03:43 -0400
X-MC-Unique: iF00IfEAP3-0Gb9yuz_E4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CD75101FFA5;
 Fri,  9 Oct 2020 09:03:42 +0000 (UTC)
Received: from localhost (ovpn-114-98.ams2.redhat.com [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5045E10002A4;
 Fri,  9 Oct 2020 09:03:39 +0000 (UTC)
Date: Fri, 9 Oct 2020 10:03:38 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 2/6] nbd: Add 'qemu-nbd -A' to expose allocation depth
Message-ID: <20201009090338.GE30079@redhat.com>
References: <20201009020714.1074061-1-eblake@redhat.com>
 <20201009020714.1074061-3-eblake@redhat.com>
 <87lfgfom51.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfgfom51.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=rjones@redhat.com;
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 10:10:18AM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > Allow the server to expose an additional metacontext to be requested
> > by savvy clients.  qemu-nbd adds a new option -A to expose the
> > qemu:allocation-depth metacontext through NBD_CMD_BLOCK_STATUS; this
> > can also be set via QMP when using block-export-add.
> >
> > qemu as client can be hacked into viewing this new context by using
> > the now-misnamed x-dirty-bitmap option when creating an NBD blockdev
> > (even though our x- naming means we could rename it, I did not think
> > it worth breaking back-compat of tools that have been using it while
> > waiting for a better solution).  It is worth noting the decoding of
> > how such context information will appear in 'qemu-img map
> > --output=json':
> >
> > NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
> > NBD_STATE_DEPTH_LOCAL   => "zero":false, "data":false
> > NBD_STATE_DEPTH_BACKING => "zero":true,  "data":true
> >
> > libnbd as client is probably a nicer way to get at the information
> > without having to decipher such hacks in qemu as client. ;)
> >
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > Message-Id: <20200930121105.667049-6-eblake@redhat.com>
> > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > [eblake: comment tweak suggested by Vladimir]
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> [...]
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 3758ea991269..249bd434f4eb 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3882,9 +3882,12 @@
> >  #
> >  # @tls-creds: TLS credentials ID
> >  #
> > -# @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place of
> > +# @x-dirty-bitmap: A metacontext name such as "qemu:dirty-bitmap:NAME" or
> 
> What is a "metacontext"?
>
> Aside: nbd.h spells it "meta context".  The two spellings suggest
> different meanings to me.  Using meta- as a prefix modifies the prefixed
> word, as in metadata (data that provides information about other data).
> Separated by space, meta becomes a noun.  None of its common meanings
> seem to apply here.  Recommend to pick an appropriate one of
> "metacontext", "meta-context", "meta context", and stick to it.

In the NBD protocol it's called a "metadata context".  This is
abbreviated to "...META_CONTEXT" in the names of constants,
eg. NBD_OPT_SET_META_CONTEXT.  For the reasons you gave I don't think
it's a very good name, but it's what we have.

https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md#metadata-querying

What it actually is, is a string, like "base:allocation" or
"qemu:dirty-bitmap:<NAME>" which selects which metadata you want to
query in NBD_CMD_BLOCK_STATUS commands.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/


