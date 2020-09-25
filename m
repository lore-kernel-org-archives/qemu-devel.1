Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A4EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CB22083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/Zy5WOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CB22083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnjp-0000iU-Ix
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kLniu-0007ik-EO
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kLnir-0005lq-Sc
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:25:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601040312;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nkGifd19yOmg59pMMcDC5W4L+0GufPAEDNr8VMwdTTI=;
 b=B/Zy5WOSUXr+VS++iP0pZZYQO69S5ve+qa7bE9NMi+p9R3H4WknvFtIfZx68CzPfXd6xiw
 T21EluIF8SoyKXhiWQgYrW20dUF0SzI5eLf1tdpNa/2vDYlJSkuMFUi3beppsCQcEAXeAK
 9hyw0TH4Jq4MMwFr4nD9WRb8zvP6h8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-tDYeFqVeOk2OEu6y1UC6jg-1; Fri, 25 Sep 2020 09:25:04 -0400
X-MC-Unique: tDYeFqVeOk2OEu6y1UC6jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8AE91008559;
 Fri, 25 Sep 2020 13:25:02 +0000 (UTC)
Received: from redhat.com (ovpn-114-208.ams2.redhat.com [10.36.114.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C52115D9F3;
 Fri, 25 Sep 2020 13:25:00 +0000 (UTC)
Date: Fri, 25 Sep 2020 14:24:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 28/38] qapi/gen.py: update write() to be more idiomatic
Message-ID: <20200925132458.GJ2178035@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-29-jsnow@redhat.com>
 <20200923152624.GO3312949@habkost.net>
 <c0b8ed9e-c66a-a6fa-43e1-c3c61581d928@redhat.com>
 <20200924155959.GC191229@localhost.localdomain>
 <87r1qqro8i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87r1qqro8i.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 25, 2020 at 03:15:57PM +0200, Markus Armbruster wrote:
> Cleber Rosa <crosa@redhat.com> writes:
> 
> > On Wed, Sep 23, 2020 at 02:37:27PM -0400, John Snow wrote:
> >> On 9/23/20 11:26 AM, Eduardo Habkost wrote:
> >> > On Tue, Sep 22, 2020 at 05:00:51PM -0400, John Snow wrote:
> >> > > Make the file handling here just a tiny bit more idiomatic.
> >> > > (I realize this is heavily subjective.)
> >> > > 
> >> > > Use exist_ok=True for os.makedirs and remove the exception,
> >> > > use fdopen() to wrap the file descriptor in a File-like object,
> >> > > and use a context manager for managing the file pointer.
> >> > > 
> >> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > 
> >> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >> > 
> >> > I really miss a comment below explaining why we use
> >> > open(os.open(pathname, ...), ...) instead of open(pathname, ...).
> 
> This code:
> 
>         fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
>         f = open(fd, 'r+', encoding='utf-8')
> 
> >> Not known to me. It was introduced in 907b846653 as part of an effort to
> >> reduce rebuild times. Maybe this avoids a modification time change if the
> >> file already exists?
> >> 
> >> Markus?
> >
> > AFACIT the change on 907b846653 is effective because of the "is new
> > text different from old text?" conditional.  I can not see how the
> > separate/duplicate open/fdopen would contribute to that.
> >
> > But, let's hear from Markus.
> 
> This was my best attempt to open the file read/write, creating it if it
> doesn't exist.
> 
> Plain
> 
>         f = open(pathname, "r+", encoding='utf-8')
> 
> fails instead of creates, and
> 
>         f = open(pathname, "w+", encoding='utf-8')
> 
> truncates.
> 
> If you know a better way, tell me!

IIUC, you need  "a+" as the mode, rather than "w+"

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


