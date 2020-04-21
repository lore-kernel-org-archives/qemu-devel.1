Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC51C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160872071C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzTQKZGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160872071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs6H-0006JP-4z
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jQs17-0007eQ-UY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jQs17-0008UH-9Y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:28:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jQs16-0008SQ-QB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587472124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1Wvv/v68P5zT6J+Nxeap+2ELWlledQycb/9xEl3RDQ=;
 b=RzTQKZGt/H4dgv+pc2kU/kOmwUP///4YdQijMKOc83fcNprH59JjGIeUq0rpOeMnNa+8yL
 J1npCXYHWf8DUQlvwkTO/pLQbNvC9N9uLccgBGzu97csNHaZm5vqAK77gAwhM8AI0Oq8pC
 B3DyAQrbH+RqHnlVzWPWi6UBdc/gExA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-kEPbwe5gMPSFtod9Us8r6g-1; Tue, 21 Apr 2020 08:28:40 -0400
X-MC-Unique: kEPbwe5gMPSFtod9Us8r6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC911853896;
 Tue, 21 Apr 2020 12:28:39 +0000 (UTC)
Received: from gondolin (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A7F2B3A6B;
 Tue, 21 Apr 2020 12:28:37 +0000 (UTC)
Date: Tue, 21 Apr 2020 14:28:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 6/7] s390x/css: Refactor the css_queue_crw() routine
Message-ID: <20200421142834.16f5ea16.cohuck@redhat.com>
In-Reply-To: <20200417023440.70514-7-farman@linux.ibm.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
 <20200417023440.70514-7-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 04:34:39 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> We have a use case (vfio-ccw) where a CRW is already built and
> ready to use.  Rather than teasing out the components just to
> reassemble it later, let's rework this code so we can queue a
> fully-qualified CRW directly.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/s390x/css.c         | 44 ++++++++++++++++++++++++++++--------------
>  include/hw/s390x/css.h |  1 +
>  2 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index a44faa3549..a72c09adbe 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -2170,30 +2170,23 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
>      }
>  }
>  
> -void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
> -                   int chain, uint16_t rsid)
> +void css_queue_crw_cont(CRW crw)

Don't really like this name, as it makes me think of 'continuation'
instead of 'container'.

css_queue_crw_container?
css_crw_add_to_queue?

Naming is hard :(

>  {
>      CrwContainer *crw_cont;
>  
> -    trace_css_crw(rsc, erc, rsid, chain ? "(chained)" : "");
> +    trace_css_crw((crw.flags & CRW_FLAGS_MASK_RSC) >> 8,
> +                  crw.flags & CRW_FLAGS_MASK_ERC,
> +                  crw.rsid,
> +                  (crw.flags & CRW_FLAGS_MASK_C) ? "(chained)" : "");
> +
>      /* TODO: Maybe use a static crw pool? */
>      crw_cont = g_try_new0(CrwContainer, 1);
>      if (!crw_cont) {
>          channel_subsys.crws_lost = true;
>          return;

Now that we actually pass something in, do we want to inform the caller
whether the crw was queued or not?

>      }
> -    crw_cont->crw.flags = (rsc << 8) | erc;
> -    if (solicited) {
> -        crw_cont->crw.flags |= CRW_FLAGS_MASK_S;
> -    }
> -    if (chain) {
> -        crw_cont->crw.flags |= CRW_FLAGS_MASK_C;
> -    }
> -    crw_cont->crw.rsid = rsid;
> -    if (channel_subsys.crws_lost) {
> -        crw_cont->crw.flags |= CRW_FLAGS_MASK_R;
> -        channel_subsys.crws_lost = false;
> -    }
> +
> +    crw_cont->crw = crw;
>  
>      QTAILQ_INSERT_TAIL(&channel_subsys.pending_crws, crw_cont, sibling);
>  

Generally, looks sane to me.


