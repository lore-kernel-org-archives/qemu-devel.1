Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E9BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E81D2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fq+WLUsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E81D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19HB-0007gG-LY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k19GT-0006sr-FV
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:10:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k19GQ-0003ng-Re
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596118229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/2WlAdB2eep7A+WaXsVJ7lhXaTBpiZThoZtl5IbeAk=;
 b=Fq+WLUsAnYWnnGMWnIVQRHD6es7PmpWH7Fn6EK67dXZ2wVJHo0UB//awji4T7MxOBgsXfA
 mYpdNzTr3ExUOqEM8s5+4TdbLCkO/KSdiipd1aduhncYl8X19Ffnl6ZCxoTRjpoXiGxtzK
 GC1cX6Qa9vOnGdfUXImEvkpZCmewquY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-_0GXWYMwOoi8482Hctf4kw-1; Thu, 30 Jul 2020 10:10:27 -0400
X-MC-Unique: _0GXWYMwOoi8482Hctf4kw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53D27106B24D
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 14:10:26 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-166.rdu2.redhat.com [10.10.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 911F071932;
 Thu, 30 Jul 2020 14:10:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 198702237A7; Thu, 30 Jul 2020 10:10:20 -0400 (EDT)
Date: Thu, 30 Jul 2020 10:10:20 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/5] virtiofsd: create lock/pid file in per user cache dir
Message-ID: <20200730141020.GA149245@redhat.com>
References: <20200729221410.147556-1-vgoyal@redhat.com>
 <20200729221410.147556-3-vgoyal@redhat.com>
 <20200730085937.GA3477223@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200730085937.GA3477223@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, vromanso@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 09:59:37AM +0100, Daniel P. Berrangé wrote:
> On Wed, Jul 29, 2020 at 06:14:07PM -0400, Vivek Goyal wrote:
> > Right now we create lock/pid file in /usr/local/var/... and unprivliged
> > user does not have access to create files there.
> > 
> > So create this file in per user cache dir as queried as specified
> > by environment variable XDG_RUNTIME_DIR.
> > 
> > Note: "su $USER" does not update XDG_RUNTIME_DIR and it still points to
> > root user's director. So for now I create a directory /tmp/$UID to save
> > lock/pid file. Dan pointed out that it can be a problem if a malicious
> > app already has /tmp/$UID created. So we probably need to get rid of this.
> 
> IMHO use of "su $USER" is simply user error and we don't need to
> care about workarounds. They will see the startup fail due to
> EPERM on /run/user/0 directory, and then they'll have to fix
> their command to use "su - $USER" to setup a clean environment.

I tried "su - $USER". That clears the old XDG_RUNTIME_DIR but does
not set new one. So now we have an empty XDG_RUNTIME_DIR env variable.
But good thing is that now g_get_user_runtime_dir() returns
"/home/$USER/.cache" and we can store user specific temp files there.

So I agree that I will get rid of all the logic to create /tmp/$USER.
"su $USER" will not be a supported path.

> 
> 
> > +    /*
> > +     * Unpriviliged users don't have access to /usr/local/var. Hence
> > +     * store lock/pid file in per user directory. Use environment
> > +     * variable XDG_RUNTIME_DIR.
> > +     * If one logs into the system as root and then does "su" then
> > +     * XDG_RUNTIME_DIR still points to root user directory. In that
> > +     * case create a directory for user in /tmp/$UID
> > +     */
> > +    if (unprivileged) {
> > +        gchar *user_dir = NULL;
> > +        gboolean create_dir = false;
> > +        user_dir = g_strdup(g_get_user_runtime_dir());
> > +        if (!user_dir || g_str_has_suffix(user_dir, "/0")) {
> > +            user_dir = g_strdup_printf("/tmp/%d", geteuid());
> > +            create_dir = true;
> > +        }
> 
> As above, I don't think we need to have this fallback code to deal
> with something that is just user error.
> 
> Also, g_get_user_runtime_dir() is guaranteed to return non-NULL.

Thanks. I will get rid of (!user_dir) case.

> 
> > +
> > +        if (create_dir && g_mkdir_with_parents(user_dir, S_IRWXU) < 0) {
> > +            fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s",
> > +                     __func__, user_dir, strerror(errno));
> > +            g_free(user_dir);
> > +            return false;
> > +        }
> > +        dir = g_strdup(user_dir);
> 
> Don't we also want to be appending "virtiofsd" to this directory path
> like we do in the privileged case ?

Yes. I forgot to append "virtiofsd" dir. Will do.

Thanks
Vivek


