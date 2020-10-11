Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0215AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 08:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABB9221FC
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 08:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9NsjvAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABB9221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRWt7-0007k1-5n
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 04:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kRWs9-0007Fv-6U
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 04:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kRWs7-00016W-6D
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 04:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602405505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ph+992TY/9lmJKlVtrR1Dq/TpsZuAH4Gz2ZiRr5vlk=;
 b=B9NsjvArh354x224EcTmj7jjK59fvH2exGJiHK2fDz+/xAQeoH1zAUETv92N12eBgPu5M2
 C2XksSlkocObMbBfCgGYJETsBwAwDKMAU2hcolVwz+bNXF6TqMh4d7O5rMN9K+9PQoruNx
 TgBi76RqhjcK8iHolXK8pVNRtgtIJ1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-Fe0kRrQZP5a5KIkH8dgOLA-1; Sun, 11 Oct 2020 04:38:22 -0400
X-MC-Unique: Fe0kRrQZP5a5KIkH8dgOLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78118030B9;
 Sun, 11 Oct 2020 08:38:20 +0000 (UTC)
Received: from starship (unknown [10.35.206.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 253C2100239A;
 Sun, 11 Oct 2020 08:38:16 +0000 (UTC)
Message-ID: <87581129083b0708a323001ac93c0583e6092860.camel@redhat.com>
Subject: Re: [PATCH] qcow2: cleanup created file when qcow2_co_create
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Date: Sun, 11 Oct 2020 11:38:15 +0300
In-Reply-To: <w514koh8vzy.fsf@maestria.local.igalia.com>
References: <20200716113359.15656-1-mlevitsk@redhat.com>
 <w514koh8vzy.fsf@maestria.local.igalia.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 02:10:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-09-01 at 15:30 +0200, Alberto Garcia wrote:
> On Thu 16 Jul 2020 01:33:59 PM CEST, Maxim Levitsky wrote:
> >      if (ret < 0) {
> > +
> > +        Error *local_delete_err = NULL;
> > +        int r_del = bdrv_co_delete_file(bs, &local_delete_err);
> > +        /*
> > +         * ENOTSUP will happen if the block driver doesn't support
> > +         * the 'bdrv_co_delete_file' interface. This is a predictable
> > +         * scenario and shouldn't be reported back to the user.
> > +         */
> > +        if ((r_del < 0) && (r_del != -ENOTSUP)) {
> > +            error_report_err(local_delete_err);
> > +        }
> 
> I think you're leaking the error on ENOTSUP.

Indeed, just like in the original code from where I copy&pasta'ed this from.
I'll send a patch to fix this and update the patch as well.

Thanks,
Best regards,
	Maxim Levitsky

> 
> Berto
> 



