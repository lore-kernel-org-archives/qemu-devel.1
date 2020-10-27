Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC9C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5E42222C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKuEBPae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5E42222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUqR-0003sw-3K
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kXUpZ-0003NO-Kt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kXUpX-0006Qu-G7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603827626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxwFI+xsYoxj72V+tlkqVXO+K87Zdda85/4OcFjGOmo=;
 b=IKuEBPaeBquL90JHCB+VBZoYzppvBAa2vx8ORRwV1UxrsVO4f0jln3Q40k6jB0iisP8c/v
 /f+sDkJ6rf/I91OeVMERTcdRCnZItuaOFq9QPq0T7KRisJcqBHbPz0P8ybvEbgblTp4ATg
 UNZD6sZLBMkKsiYizCbNLzrHJgTb7Qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-cjJSFnPTNeemUUdttGQHog-1; Tue, 27 Oct 2020 15:40:22 -0400
X-MC-Unique: cjJSFnPTNeemUUdttGQHog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1E0518C9F4A;
 Tue, 27 Oct 2020 19:40:20 +0000 (UTC)
Received: from localhost (ovpn-114-98.ams2.redhat.com [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B76760C07;
 Tue, 27 Oct 2020 19:40:17 +0000 (UTC)
Date: Tue, 27 Oct 2020 19:40:16 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Libguestfs] [libnbd PATCH] info: Add support for new 'qemu-nbd
 -A' qemu:allocation-depth
Message-ID: <20201027194016.GV30099@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201016152318.80889-1-eblake@redhat.com>
 <e1b65875-c47b-4aea-98b3-599e06627ee6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e1b65875-c47b-4aea-98b3-599e06627ee6@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 QEMU <qemu-devel@nongnu.org>, libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 10:33:48AM -0500, Eric Blake wrote:
> On 10/16/20 10:23 AM, Eric Blake wrote:
> > A rather trivial decoding; we may enhance it further if qemu extends
> > things to give an integer depth alongside its tri-state encoding.
> > ---
> > 
> > I'll wait to push this to libnbd until the counterpart qemu patches
> > land upstream, although it looks like I've got positive review.
> 
> Whoops, I accidentally pushed this before qemu stuff landed upstream,
> and in the meantime, we changed our minds on what to expose over
> qemu:allocation-depth to be a bare integer rather than a tri-state.
> I'll push this followup (but this time, wait for the actual qemu patch
> to land).  In fact, I should probably add test-suite coverage...

ACK.  I have a patch which touches this file but it's a simple merge
to combine the two changes.

Rich.

> >From eba8734654e6fd340e18b3e07c3213ed1a0ab9e8 Mon Sep 17 00:00:00 2001
> From: Eric Blake <eblake@redhat.com>
> Date: Tue, 27 Oct 2020 10:27:25 -0500
> Subject: [libnbd PATCH] info: Adjust to actual 'qemu-nbd -A' semantics
> 
> Review on the qemu list has led to an altered definition of what
> 'qemu:allocation-depth' should report: rather than a tri-state value,
> it is an actual depth.  It's time to match what actually got committed
> into qemu, which in turn means a slight refactoring to use a malloc'd
> string for a description.
> 
> Fixes: 71455c021
> ---
>  info/nbdinfo.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/info/nbdinfo.c b/info/nbdinfo.c
> index 2b22f51..b152f28 100644
> --- a/info/nbdinfo.c
> +++ b/info/nbdinfo.c
> @@ -767,28 +767,30 @@ get_content (struct nbd_handle *nbd, int64_t size)
>  }
> 
>  /* Callback handling --map. */
> -static const char *
> +static char *
>  extent_description (const char *metacontext, uint32_t type)
>  {
> +  char *ret;
> +
>    if (strcmp (metacontext, "base:allocation") == 0) {
>      switch (type) {
> -    case 0: return "allocated";
> -    case 1: return "hole";
> -    case 2: return "zero";
> -    case 3: return "hole,zero";
> +    case 0: return strdup ("allocated");
> +    case 1: return strdup ("hole");
> +    case 2: return strdup ("zero");
> +    case 3: return strdup ("hole,zero");
>      }
>    }
>    else if (strncmp (metacontext, "qemu:dirty-bitmap:", 18) == 0) {
>      switch (type) {
> -    case 0: return "clean";
> -    case 1: return "dirty";
> +    case 0: return strdup ("clean");
> +    case 1: return strdup ("dirty");
>      }
>    }
>    else if (strcmp (metacontext, "qemu:allocation-depth") == 0) {
> -    switch (type & 3) {
> -    case 0: return "unallocated";
> -    case 1: return "local";
> -    case 2: return "backing";
> +    switch (type) {
> +    case 0: return strdup ("unallocated");
> +    case 1: return strdup ("local");
> +    case 2: asprintf (&ret, "backing depth %d", type); return ret;
>      }
>    }
> 
> @@ -810,7 +812,7 @@ extent_callback (void *user_data, const char
> *metacontext,
> 
>    /* Print the entries received. */
>    for (i = 0; i < nr_entries; i += 2) {
> -    const char *descr = extent_description (map, entries[i+1]);
> +    char *descr = extent_description (map, entries[i+1]);
> 
>      if (!json_output) {
>        fprintf (fp, "%10" PRIu64 "  "
> @@ -837,6 +839,7 @@ extent_callback (void *user_data, const char
> *metacontext,
>        comma = true;
>      }
> 
> +    free (descr);
>      offset += entries[i];
>    }
> 
> -- 
> 2.29.0
> 
> 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 
> _______________________________________________
> Libguestfs mailing list
> Libguestfs@redhat.com
> https://www.redhat.com/mailman/listinfo/libguestfs

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


