Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF8C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B76420736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7UkdREs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B76420736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfnX-0001Hg-AM
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jRfmY-0007zC-Pf
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jRfmX-0005qL-Ow
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:37:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jRfmX-0005mG-Bf
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587663420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jssvPVYfi8/GlxgvwvbmwDKjxahXBOXCmebE4M4eSks=;
 b=O7UkdREsrwLxO4Ui+hahDR0rJaWMKAJya6rFcl+efCB1weEXPNb3vQxvbFFJdEoAZVRv1Y
 MfoGICjcONLGaQ+zsCkWf8TMIoxVZqYhpk631yOm25h5r3VNYyngHws7rCRFyemznTgMrT
 LyM6ZSB94j5qTn8bQVZ9adWGGMw2TTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-tptF1Z8IMC66pxnOdYheDw-1; Thu, 23 Apr 2020 13:36:49 -0400
X-MC-Unique: tptF1Z8IMC66pxnOdYheDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BA9D872FF4;
 Thu, 23 Apr 2020 17:36:48 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80EED600F5;
 Thu, 23 Apr 2020 17:36:48 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 63D841809541;
 Thu, 23 Apr 2020 17:36:48 +0000 (UTC)
Date: Thu, 23 Apr 2020 13:36:48 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?utf-8?Q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Message-ID: <348064782.9653447.1587663408130.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200423171322.GJ1077680@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
MIME-Version: 1.0
X-Originating-IP: [10.10.112.178, 10.4.195.9]
Thread-Topic: QEMU Gating CI
Thread-Index: gz63p6d6o1OSAYtEuHoU/HH199fWBQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> To: "Cleber Rosa" <crosa@redhat.com>
> Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Fam Zheng" <fam@euphon.n=
et>, "Thomas Huth" <thuth@redhat.com>,
> "Beraldo Leal" <bleal@redhat.com>, "Erik Skultety" <eskultet@redhat.com>,=
 "Philippe Mathieu-Daud=C3=A9"
> <philmd@redhat.com>, "Wainer Moschetta" <wmoschet@redhat.com>, "Markus Ar=
mbruster" <armbru@redhat.com>, "Wainer dos
> Santos Moschetta" <wainersm@redhat.com>, "QEMU Developers" <qemu-devel@no=
ngnu.org>, "Willian Rampazzo"
> <wrampazz@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@linaro.org>, "Edua=
rdo Habkost" <ehabkost@redhat.com>
> Sent: Thursday, April 23, 2020 1:13:22 PM
> Subject: Re: [PATCH 0/5] QEMU Gating CI
>=20
> On Thu, Apr 23, 2020 at 01:04:13PM -0400, Cleber Rosa wrote:
> >=20
> >=20
> > ----- Original Message -----
> > > From: "Peter Maydell" <peter.maydell@linaro.org>
> > > To: "Markus Armbruster" <armbru@redhat.com>
> > > Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>,
> > > "Beraldo Leal" <bleal@redhat.com>, "Erik
> > > Skultety" <eskultet@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@lina=
ro.org>,
> > > "Wainer Moschetta" <wmoschet@redhat.com>,
> > > "QEMU Developers" <qemu-devel@nongnu.org>, "Wainer dos Santos Moschet=
ta"
> > > <wainersm@redhat.com>, "Willian Rampazzo"
> > > <wrampazz@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Philippe
> > > Mathieu-Daud=C3=A9" <philmd@redhat.com>, "Eduardo
> > > Habkost" <ehabkost@redhat.com>
> > > Sent: Tuesday, April 21, 2020 8:53:49 AM
> > > Subject: Re: [PATCH 0/5] QEMU Gating CI
> > >=20
> > > On Thu, 19 Mar 2020 at 16:33, Markus Armbruster <armbru@redhat.com>
> > > wrote:
> > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > > I think we should start by getting the gitlab setup working
> > > > > for the basic "x86 configs" first. Then we can try adding
> > > > > a runner for s390 (that one's logistically easiest because
> > > > > it is a project machine, not one owned by me personally or
> > > > > by Linaro) once the basic framework is working, and expand
> > > > > from there.
> > > >
> > > > Makes sense to me.
> > > >
> > > > Next steps to get this off the ground:
> > > >
> > > > * Red Hat provides runner(s) for x86 stuff we care about.
> > > >
> > > > * If that doesn't cover 'basic "x86 configs" in your judgement, we
> > > >   fill the gaps as described below under "Expand from there".
> > > >
> > > > * Add an s390 runner using the project machine you mentioned.
> > > >
> > > > * Expand from there: identify the remaining gaps, map them to peopl=
e /
> > > >   organizations interested in them, and solicit contributions from
> > > >   these
> > > >   guys.
> > > >
> > > > A note on contributions: we need both hardware and people.  By peop=
le I
> > > > mean maintainers for the infrastructure, the tools and all the runn=
ers.
> > > > Cleber & team are willing to serve for the infrastructure, the tool=
s
> > > > and
> > > > the Red Hat runners.
> > >=20
> > > So, with 5.0 nearly out the door it seems like a good time to check
> > > in on this thread again to ask where we are progress-wise with this.
> > > My impression is that this patchset provides most of the scripting
> > > and config side of the first step, so what we need is for RH to provi=
de
> > > an x86 runner machine and tell the gitlab CI it exists. I appreciate
> > > that the whole coronavirus and working-from-home situation will have
> > > upended everybody's plans, especially when actual hardware might
> > > be involved, but how's it going ?
> > >=20
> >=20
> > Hi Peter,
> >=20
> > You hit the nail in the head here.  We were affected indeed with our
> > ability
> > to move some machines from one lab to another (across the country), but
> > we're
> > actively working on it.
>=20
> For x86, do we really need to be using custom runners ?
>=20

Hi Daniel,

We're already using the shared x86 runners, but with a different goal.  The
goal of the "Gating CI" is indeed to expand on non-x86 environments.  We're
in a "chicken and egg" kind of situation, because we'd like to prove that
GitLab CI will allow QEMU to expand to very different runners and jobs, whi=
le
not really having all that hardware setup and publicly available at this ti=
me.

My experiments were really around that point, I mean, confirming that we ca=
n grow
the number of architectures/runners/jobs/configurations to provide a covera=
ge
equal or greater to what Peter already does.

> With GitLab if someone forks the repo to their personal namespace, they
> cannot use any custom runners setup by the origin project. So if we use
> custom runners for x86, people forking won't be able to run the GitLab
> CI jobs.
>=20

They will continue to be able use the jobs and runners already defined in
the .gitlab-ci.yml file.  This work will only affect people pushing to the/=
a
"staging" branch.

> As a sub-system maintainer I wouldn't like this, because I ideally want
> to be able to run the same jobs on my staging tree, that Peter will run
> at merge time for the PULL request I send.
>=20

If you're looking for symmetry between any PR and "merge time" jobs, the
only solution is to allow any PR to access all the diverse set of non-share=
d
machines we're hoping to have in the near future.  This may be something
we'll get to, but I doubt we can tackle it in the near future now.

> Thus my strong preference would be to use the GitLab runners in every
> scenario where they are viable to use. Only use custom runners in the
> cases where GitLab runners are clearly inadequate for our needs.
>=20
> Based on what we've setup in GitLab for libvirt,  the shared runners
> they have work fine for x86. Just need the environments you are testing
> to be provided as Docker containers (you can actually build and cache
> the container images during your CI job too).  IOW, any Linux distro
> build and test jobs should be able to use shared runners on x86, and
> likewise mingw builds. Custom runners should only be needed if the
> jobs need todo *BSD / macOS builds, and/or have access to specific
> hardware devices for some reason.
>=20

We've discussed this before at the RFC time, wrt how the goal is for a wide=
r
community to provide a wider range of jobs.  Even for x86, one may want
to require their jobs to run on a given accelerator, such as KVM, so we
need to consider that from the very beginning.

I don't see a problem with converging jobs with are being run on custom
runners back into shared runners as much as possible.  At the RFC discussio=
n,
I actually pointed out how the build phase could be running essentially
on pre-built containers (on shared runners), but the test phase, say testin=
g
KVM, should not be bound to that.=20

So in essence, right now, moving everything to containers would invalidate =
the
exercise of being able to care for those custom architectures/builds/jobs w=
e'll
need in the near future.  And that's really the whole point here.

Cheers,
- Cleber.

>=20
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge
> |:|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om
> |:|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge
> |:|
>=20


