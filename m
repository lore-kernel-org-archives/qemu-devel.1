Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFCBC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ADCF208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LABUN4so"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADCF208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDc1-0005t8-MQ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kJDag-0004nI-Sv
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:26:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kJDae-000469-Dx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600424763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDi8mQ0rA4N6SU7uINgKdkpwA+H3op/ojz2h2uaQCDE=;
 b=LABUN4soZi3p5yBBA3AgWv6M/4w+/tViGls9Sb+Cmw2SBKiwX+EBxWl+LMAKz8EucFYVhv
 +sGZuPuXURmo4YefmWkB5XjRqwABpY6Gpg1hrMkAG7QKZMWu8vUMYxVm9m/blbS88SRdMx
 fYNIV66mTbUEzrYBgucfNrRIGjnAipg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-Q0qxWGHDMnSzZX3L6if79w-1; Fri, 18 Sep 2020 06:25:59 -0400
X-MC-Unique: Q0qxWGHDMnSzZX3L6if79w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C239D10A7AF3;
 Fri, 18 Sep 2020 10:25:57 +0000 (UTC)
Received: from kaapi (ovpn-112-187.phx2.redhat.com [10.3.112.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 340C655765;
 Fri, 18 Sep 2020 10:25:54 +0000 (UTC)
Date: Fri, 18 Sep 2020 15:55:52 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH v2] hw/ide: check null block before _cancel_dma_sync
In-Reply-To: <CAKXe6SLv1HX5_ty2SP5F_MkVKYO-tz5fNOKhpqZr0mH_ePypSA@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2009181427350.10832@xnncv>
References: <20200903183138.2161977-1-ppandit@redhat.com>
 <CAKXe6SLv1HX5_ty2SP5F_MkVKYO-tz5fNOKhpqZr0mH_ePypSA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Ruhr-University <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 18 Sep 2020, Li Qiang wrote --+
| Update v2: use an assert() call
|   ->https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg08336.html
...
| I think it is better to defer this check to 'ide_cancel_dma_sync'. 
| 'ide_cancel_dma_sync' is also called by 'cmd_device_reset' and all of the 
| handlers of 'ide_cmd_table' will check whether the 's->blk' is NULL in the 
| beginning of 'ide_exec_cmd'.
| 
| So I think it is reasonable to check 's->blk' at the begining of 
| 'ide_cancel_dma_sync'.

* Yes, earlier patch v1 above does the same.

* From Peter's reply in another thread of similar issue I gather, issue is 
  setting 'blk' to NULL, even erroneously. So (blk == NULL) check should be 
  done where 'blk' is set to null, rather than where it is dereferenced.

* At the dereference point, assert(3) is good.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


