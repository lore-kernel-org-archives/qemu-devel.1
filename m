Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A7923CD5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlLMS886"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A7923CD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsLf-0007xz-9L
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jpsL6-0007WH-62
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:52:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jpsL4-00073X-9g
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593431561;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwoEDzRC8lYlIKHHuLBhN6RQosDvIL3vX2MEnsGOV3w=;
 b=VlLMS886DwxfKswHzhq98SiOO4Py0AA13VANx4Or+cgEmUmWxre6ubWZ449D8vxvJIQ7Ol
 UIXy97UOL3ZapUbATUGi+U3L+/78pFZRftX0OZrqi3Xt0Fqh57yBhonbI19TrywaINy5nj
 Bi8MQ94yAJX26yQ7TCBosXUY0O6tAsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-BiiSy65aOQmdsicICLljXQ-1; Mon, 29 Jun 2020 07:52:20 -0400
X-MC-Unique: BiiSy65aOQmdsicICLljXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456ED18FE861;
 Mon, 29 Jun 2020 11:52:19 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68980121E29;
 Mon, 29 Jun 2020 11:52:16 +0000 (UTC)
Date: Mon, 29 Jun 2020 12:52:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 29/30] gitlab: limit re-builds of the containers
Message-ID: <20200629115213.GH1298906@redhat.com>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-30-alex.bennee@linaro.org>
 <20200629100350.GF1298906@redhat.com> <87pn9irxjz.fsf@linaro.org>
 <7240239e-813c-3c4b-7886-fe5e87c9b092@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7240239e-813c-3c4b-7886-fe5e87c9b092@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 f4bug@amsat.org, cota@braap.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 01:42:19PM +0200, Thomas Huth wrote:
> On 29/06/2020 12.11, Alex Bennée wrote:
> > 
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Fri, Jun 26, 2020 at 07:13:56PM +0100, Alex Bennée wrote:
> > > > Most of the time we are just rebuilding the same things. We can skip
> > > > this although currently there is no mechanism for picking up new
> > > > distro releases.
> > > > 
> > > > Rather than try to be too fine grained allow any change to trigger all
> > > > the images being rebuilt.
> > > > 
> > > > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > > > ---
> > > >   .gitlab-ci.d/containers.yml | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> > > > index 20b2fb1de5d..f56aa44f711 100644
> > > > --- a/.gitlab-ci.d/containers.yml
> > > > +++ b/.gitlab-ci.d/containers.yml
> > > > @@ -19,6 +19,10 @@
> > > >       - docker push "$TAG"
> > > >     after_script:
> > > >       - docker logout
> > > > +  only:
> > > > +    changes:
> > > > +      - .gitlab-ci.d/containers.yml
> > > > +      - tests/docker/*
> > > 
> > > How does this work for a person who forks the QEMU git repo and pushes
> > > a change which doesn't touch the containers.yml file ?  AFAICT, all
> > > their jobs will fail due to not having previously built any container
> > > images in their brand new fork.
> > 
> > Hmm what we really need is a condition check to see if there is a local
> > registry with images in it.
> 
> Maybe it would be good enough to do something like this instead:
> 
>   rules:
>     - if: '$CI_COMMIT_BRANCH == "master"'
>     - changes:
>       - .gitlab-ci.d/containers.yml
>       - tests/docker/*
> 
> ... so that the pipeline is certainly run the first time when the master
> branch gets initialized? (I did not try it out, just had the idea after
> looking at the gitlab CI docs)

IIUC, the rules: can only reduce scenarios where a job is run, vs the
baseline config. AFAIK, forking a repo doesn't cause any jobs to be
run, so adding extra rules: can't make that happen.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


