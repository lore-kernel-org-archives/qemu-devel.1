Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B659C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669D42224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgYNh91J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669D42224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFNT-0002M2-96
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 10:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVFMX-0001qB-PG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVFMT-00069o-Ku
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603291506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bqw8GYQJnm1SejsSU0VQPMej+E1ZgNy/kibE7PW3pPw=;
 b=QgYNh91JkKjU441tWE+AfIiFCL9wWjgA6x+0TI5eDhZMN+ii8AhfHcUMzgq7FyWfimxunl
 ndo9PKsJNJ39Mk1Z0NFZg0j60mQuH5maNIB2r+FXE7ISrjl5x4f/ya26knGgd200YnuG+q
 SCCVr607brIxmM5PRTGC56cRMTm5CLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-wR9Ip1vkOFq-t5h6sLOKpw-1; Wed, 21 Oct 2020 10:45:03 -0400
X-MC-Unique: wR9Ip1vkOFq-t5h6sLOKpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D06E38463DE;
 Wed, 21 Oct 2020 14:45:02 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11B5B5B4BE;
 Wed, 21 Oct 2020 14:44:58 +0000 (UTC)
Date: Wed, 21 Oct 2020 10:44:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] pc: Implement -no-hpet as sugar for -machine hpet=off
Message-ID: <20201021144457.GU5733@habkost.net>
References: <20201020220150.1326086-1-ehabkost@redhat.com>
 <50e184db-bf46-48c1-b3a2-f4151d00cdf6@redhat.com>
 <20201021123920.GS5733@habkost.net>
 <9d8ec809-6764-48cd-75b7-8f4450756849@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9d8ec809-6764-48cd-75b7-8f4450756849@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 03:31:30PM +0200, Paolo Bonzini wrote:
> On 21/10/20 14:39, Eduardo Habkost wrote:
> >> Should this be within #ifdef CONFIG_HPET?  [...]
> > Oops, I wasn't aware of CONFIG_HPET
> 
> That's just a config-devices.h (aka CONFIG_DEVICES) definition.
> 
> > , and hadn't noticed that
> > pc_basic_device_init() uses qdev_try_new().  I agree that not
> > failing if hpet=on is explicitly set and CONFIG_HPET=n is wrong.
> > 
> > Supporting a "require hpet to be on" use case would be a new
> > feature and out of scope of this work, though.  I will just
> > rename the property to "allow-hpet".  We can still implement a
> > OnOfAuto "hpet" property in the future, if we think it's useful.
> 
> You don't need OnOffAuto; you can just change the qdev_try_new() to
> qdev_new() if you default it to true only if CONFIG_HPET is defined.  It
> should work properly, defaulting to on/off depending on CONFIG_HPET and
> failing if hpet=on is explicitly set with CONFIG_HPET=n.

Makes sense, except for the fact that qdev_new(TYPE_HPET) will
abort if CONFIG_HPET=n.  But we can just use qdev_try_new() and
error out if it fails.

-- 
Eduardo


