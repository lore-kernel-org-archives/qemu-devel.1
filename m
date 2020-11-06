Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F6C388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 00:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311D020759
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 00:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+kaMzz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311D020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kapgs-0000wz-VV
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 19:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kapfu-0000U8-Qd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 19:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kapfs-0002lq-62
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 19:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604622734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjMoZUxzx97lnSHUTbLhKkZRFZTd8pQoU2ORDOoXtDE=;
 b=Y+kaMzz5l0543flkjp4JjBrsTwRTZQLh0zgs5AiH6hDzBrANXstNDFUVvubGomGx3LGh15
 WzzB8DzkghGlbWbkreEh6XHJgqzhtcOTK2ABIN35Ur+BfNtOh9sHFYvjSQjFc6hRtvL8RP
 vv8yxvjN3v0BnZRyZFX7wkemRcTtPrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-jMGhLuwAPM6aY7UvVzg9jQ-1; Thu, 05 Nov 2020 19:32:12 -0500
X-MC-Unique: jMGhLuwAPM6aY7UvVzg9jQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B5B8049C9;
 Fri,  6 Nov 2020 00:32:11 +0000 (UTC)
Received: from x1.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA1A35C1CF;
 Fri,  6 Nov 2020 00:32:10 +0000 (UTC)
Date: Thu, 5 Nov 2020 17:32:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v3 04/32] vfio: Add migration region initialization and
 finalize function
Message-ID: <20201105173210.4bba74bc@x1.home>
In-Reply-To: <CAFEAcA_g2gurj2FcKqTbEK7QTMu8yDFc+SZQF1scVOAAQ1d4pA@mail.gmail.com>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
 <160426438011.24886.10899498493892012350.stgit@gimli.home>
 <CAFEAcA_g2gurj2FcKqTbEK7QTMu8yDFc+SZQF1scVOAAQ1d4pA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 19:32:14
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Cornelia Huck <cohuck@redhat.com>,
 Neo Jia <cjia@nvidia.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 23:55:32 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Sun, 1 Nov 2020 at 21:02, Alex Williamson <alex.williamson@redhat.com> wrote:
> >
> > From: Kirti Wankhede <kwankhede@nvidia.com>
> >
> > Whether the VFIO device supports migration or not is decided based of
> > migration region query. If migration region query is successful and migration
> > region initialization is successful then migration is supported else
> > migration is blocked.
> >
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> Hi; Coverity points out (CID 1436126) that this code has a
> use-after-free:

Thanks, I already relayed this to Kirti and expect to see a patch.
Thanks,

Alex


> > +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> > +{
> > +    struct vfio_region_info *info = NULL;
> > +    Error *local_err = NULL;
> > +    int ret;
> > +
> > +    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
> > +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
> > +    if (ret) {
> > +        goto add_blocker;
> > +    }
> > +
> > +    ret = vfio_migration_init(vbasedev, info);
> > +    if (ret) {
> > +        goto add_blocker;
> > +    }
> > +
> > +    g_free(info);
> > +    trace_vfio_migration_probe(vbasedev->name, info->index);  
> 
> We free info, and then access info->index. Switching the
> order of the g_free() and the tracepoint seems the obvious fix.
> 
> thanks
> -- PMM
> 


