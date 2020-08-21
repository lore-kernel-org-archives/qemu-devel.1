Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274E020702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWUyOXQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274E020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9AGB-0006z1-F0
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k9AFZ-0006Rn-Lw
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:50:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k9AFW-0003OR-DQ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598028641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APEsGxl8zZ9eIO0E6pLjH6qqCDvhq9A/WlahytIw4Bw=;
 b=jWUyOXQLoXHvWqf06KAaeOP/lbOJuXjytx8bRvmRV+YaJKHw3lfzJWFNsAZaIrAXXiV1ke
 t0uqkqzzyv8gpVnraZwbDRws6PcI4x/d7llepARqF9K1rExgHMq55Kg8iv845oR9NWmCja
 bnY5gw8oE4iKLwEQPKQJmhpdXDhue2c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-MVVPAGhHOzq1UD-jMBL1EA-1; Fri, 21 Aug 2020 12:50:39 -0400
X-MC-Unique: MVVPAGhHOzq1UD-jMBL1EA-1
Received: by mail-wr1-f72.google.com with SMTP id z1so723783wrn.18
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=APEsGxl8zZ9eIO0E6pLjH6qqCDvhq9A/WlahytIw4Bw=;
 b=cG6nWJQSh0MUEKY9wrcFDLzJB8xr/mi6UP0OrH0+GVGgmGCgwS5Z0FlT6TGqlmUyjQ
 UmZF3TloYtI52PA/4gyP5EJq6hLnAMNnE06NEYdCxyyiMzUGCUJldxVck6kdYHmwiAyS
 kLPm2eMC+3t+FiJHpac7fAS4jNKlyHZSy5kNc8F5SpEFE6n10V5tYS8L/RKy5H+mmAxW
 G2syWHx8Er4qAL1v9Ro+MmZl1YoPhfairhRial4P9BkY8F9+QKHEgq+NMzegM4Ai3R7c
 b5qNj+R58ESPEEiwUGH8P7URkdsQB7QF2sLACFQ7TOi4xhYbI3queRgR8rvBEgP11zHg
 FycQ==
X-Gm-Message-State: AOAM530kmDdRtuVlcOZPMVFkjyuoHvXhQ44U9WahdCa1GQjNdeuniaBK
 WooITcQ24y69EqycnR9m6Ox4Y8ITWN0Kr4xfvOBIMjmF8WRzc/32Gq19KceZjUBDb2Iy5V8DTei
 dlsvCRwiX/urwgNA=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr3657247wrs.27.1598028638403; 
 Fri, 21 Aug 2020 09:50:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMtxEzlTm899mzSnfe1HZGM5UVZB7peblGmZMoz63cg87jH9ojfQLWdmQgm+V1TBEi5godxw==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr3657229wrs.27.1598028638134; 
 Fri, 21 Aug 2020 09:50:38 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id y142sm6562785wmd.3.2020.08.21.09.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:50:37 -0700 (PDT)
Date: Fri, 21 Aug 2020 18:50:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] util/meson.build: fix fdmon-io_uring build
Message-ID: <20200821165034.mfq4yj4s3kpvzjes@steredhat>
References: <20200821154853.94379-1-sgarzare@redhat.com>
 <b750b7e1-2fca-2662-b575-2883d1073743@redhat.com>
 <20200821162339.33waweneizhzases@steredhat>
 <84ba3c37-c00a-d130-c988-51bcb195a29d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <84ba3c37-c00a-d130-c988-51bcb195a29d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 06:46:15PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/21/20 6:23 PM, Stefano Garzarella wrote:
> > On Fri, Aug 21, 2020 at 06:12:45PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
> >> Hi Stefano,
> >>
> >> On 8/21/20 5:48 PM, Stefano Garzarella wrote:
> >>> libqemuutil.a build fails with this error:
> >>>
> >>>   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `get_sqe':
> >>>   qemu/build/../util/fdmon-io_uring.c:83: undefined reference to `io_uring_get_sqe'
> >>>   /usr/bin/ld: qemu/build/../util/fdmon-io_uring.c:92: undefined reference to `io_uring_submit'
> >>>   /usr/bin/ld: qemu/build/../util/fdmon-io_uring.c:96: undefined reference to `io_uring_get_sqe'
> >>>   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_wait':
> >>>   qemu/build/../util/fdmon-io_uring.c:289: undefined reference to `io_uring_submit_and_wait'
> >>>   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_setup':
> >>>   qemu/build/../util/fdmon-io_uring.c:328: undefined reference to `io_uring_queue_init'
> >>>   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_destroy':
> >>>   qemu/build/../util/fdmon-io_uring.c:343: undefined reference to `io_uring_queue_exit'
> >>>   collect2: error: ld returned 1 exit status
> >>
> >> Can you add a gitlab job to reproduce this? (Or at least explain
> >> how to reproduce, so we add that job later). Thanks!
> > 
> > I think the only prerequisite is to install 'liburing-devel' package
> > (Fedora 32) on the build system, and then fdmon-io_uring.c will be built.
> 
> Oh easy then, simply add it to PACKAGES in
> tests/docker/dockerfiles/fedora.docker :)

Yeah, I just found it ;-)

I'll send a patch.

Thanks,
Stefano


