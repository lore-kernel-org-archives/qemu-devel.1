Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A396EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CE72067D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHT6uKeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CE72067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaNhH-00027e-JM
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 14:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaNd6-0007vz-69
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:03:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaNd4-0006K8-5z
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589738593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2gwBW3gWAKDNGTTjCL/lH/oZeBrUPDC4ZEwI3GMPJc=;
 b=hHT6uKeuyCdOwG5xWMqL8UB8yCzSJmbm2hdniBg2+zlbSFhPAKXscmgm/Tuly7hrs5MjAv
 N3drBplf6ZOj+Pdlzn0pRbo957Op1dBTxYG24Asmu8PlXWfUyVvfhC5XQSO4eJd4e9Gaz0
 omUY7MiHLw4M5HtUZXk8ABDOmdd6Vhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129--at3fhajO0ulI_RgP-5_9A-1; Sun, 17 May 2020 14:03:11 -0400
X-MC-Unique: -at3fhajO0ulI_RgP-5_9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F48E8014D7;
 Sun, 17 May 2020 18:03:10 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55B7D5D9D7;
 Sun, 17 May 2020 18:03:08 +0000 (UTC)
Message-ID: <d38ff55b018cdd36a4a2bc7bdc9858f62d3de317.camel@redhat.com>
Subject: Re: [PATCH v6 08/14] block/qcow2: extend qemu-img amend interface
 with crypto options
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 17 May 2020 21:03:07 +0300
In-Reply-To: <2ed2c0fc-7b47-a46c-1603-b1c25bd1b0ae@redhat.com>
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-9-mlevitsk@redhat.com>
 <2ed2c0fc-7b47-a46c-1603-b1c25bd1b0ae@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 13:26:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-05-14 at 16:30 +0200, Max Reitz wrote:
> On 10.05.20 15:40, Maxim Levitsky wrote:
> > Now that we have all the infrastructure in place,
> > wire it in the qcow2 driver and expose this to the user.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  block/qcow2.c              | 72 +++++++++++++++++++++++++++++++++-----
> >  tests/qemu-iotests/082.out | 45 ++++++++++++++++++++++++
> 
> Again, some rebasing required because of compression_type.
Actually for this particular test, the output didn't change,
because the compression_type is not amendable (at least yet).


> 
> >  2 files changed, 108 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index db86500839..4bb6e3fc8f 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> 
> [...]
> 
> > @@ -4744,17 +4757,11 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
> >      g_free(optstr);
> >  
> >      if (has_luks) {
> > +
> 
> Why?
No reason. Fixed!

> 
> With this line dropped, and 082.out fixed up:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
Thank you very much!
Best regards,
	Maxim Levitsky





