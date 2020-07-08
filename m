Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84746C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C03720772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZM8mZnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C03720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtITj-0005mj-GL
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtIEz-0007yP-J2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:08:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtIEx-0007ZM-Qy
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeQHJXSA7nBv8209xwxlYccIg8Y1tb3sy0L5+6VExMU=;
 b=TZM8mZnAUoc17/TiV0Y8cYx9qRHM40y0Dv8a+sZL+UidPX6ZmWL9MuSkJ80sdqBYea9m4G
 qz/vabq79+I877AGRbhU6jYuUmEG/fHPeQTqaln0kJR1o6ltp1in4C+o2OAWygbCur/VMw
 9xCEDtbyi6Kz4DlkNf6G+iHQs32ft+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-L-b7-Z2APjOsdAi9O3pYFw-1; Wed, 08 Jul 2020 09:06:56 -0400
X-MC-Unique: L-b7-Z2APjOsdAi9O3pYFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80C0788C923;
 Wed,  8 Jul 2020 13:06:55 +0000 (UTC)
Received: from starship (unknown [10.35.206.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BCCE75550;
 Wed,  8 Jul 2020 13:06:46 +0000 (UTC)
Message-ID: <71ce9ceb32e5bd8f18cd26621e380df364f25cb7.camel@redhat.com>
Subject: Re: [PATCH v8 11/14] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 08 Jul 2020 16:06:45 +0300
In-Reply-To: <20200708123329.udy3k7ewtbcztjin@sirius.home.kraxel.org>
References: <20200608094030.670121-1-mlevitsk@redhat.com>
 <20200608094030.670121-12-mlevitsk@redhat.com>
 <20200708123329.udy3k7ewtbcztjin@sirius.home.kraxel.org>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-08 at 14:33 +0200, Gerd Hoffmann wrote:
> On Mon, Jun 08, 2020 at 12:40:27PM +0300, Maxim Levitsky wrote:
> > blockdev-amend will be used similiar to blockdev-create
> > to allow on the fly changes of the structure of the format based block devices.
> 
> This one breaks the build:
> 
> In file included from /home/kraxel/projects/qemu/include/block/throttle-groups.h:29,
>                  from /home/kraxel/projects/qemu/include/sysemu/block-backend.h:17,
>                  from /home/kraxel/projects/qemu/qemu-img.c:46:
> /home/kraxel/projects/qemu/include/block/block_int.h:154:39: error: unknown type name ‘BlockdevAmendOptions’; did you mean ‘BlockdevAioOptions’?
>                                        BlockdevAmendOptions *opts,
>                                        ^~~~~~~~~~~~~~~~~~~~
>                                        BlockdevAioOptions
> make: *** [/home/kraxel/projects/qemu/rules.mak:69: qemu-img.o] Error 1
> 
> take care,
>   Gerd
> 

Apparently I didn't add #include of qapi-types-block-core.h in block_int.h (I'll fix this in a patch soon),
but it looks like throttle-groups.h includes "qemu/throttle.h" which includes "qapi/qapi-types-block-core.h",
so it should be included explicitly here.

Could you share your configure.sh options?

Best regards,
	Maxim Levitsky


