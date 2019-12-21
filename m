Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86135C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 09:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF5A2070C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 09:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7ew1ARb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF5A2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiafR-00058X-E2
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 04:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiaep-0004fm-CX
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 04:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiaem-00029c-2y
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 04:02:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53017
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiael-00021y-FH
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 04:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576918958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLJHztfj3QvG2mqEvMXvc3vR71khY5QoK9Vw9aTlWd4=;
 b=I7ew1ARbKLBivN2DRra/bf+CtmlxG1cmO9SA6uju00laFQ7shP/D9PPWreWmvKQ3wURkKC
 Mk1envVApAbuf3a1f3zO5EHAtggP791vl0xO8dy+n5HoSEtEIPMDq/uLGLSMmrYX/W42TB
 ZZM6HR30zssicowUBxo2PyE4q85C1GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-ClJ5f89PMw-r1bUk9FtbQA-1; Sat, 21 Dec 2019 04:02:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 952451005514;
 Sat, 21 Dec 2019 09:02:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F2A610842AF;
 Sat, 21 Dec 2019 09:02:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 228B011385C9; Sat, 21 Dec 2019 10:02:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
Date: Sat, 21 Dec 2019 10:02:23 +0100
In-Reply-To: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 (Stefan Hajnoczi's message of "Fri, 20 Dec 2019 16:13:59 +0000")
Message-ID: <87h81unja8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ClJ5f89PMw-r1bUk9FtbQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> Hi,
> QEMU presents a command-line interface and QMP monitor for
> applications to interact with.  Applications actually need API
> bindings in their programming language.  Bindings avoid reimplementing
> code to spawn a QEMU process and interact with QMP.  QEMU is kind of
> lazy and de facto relies on libvirt for API bindings.
>
> Is it time for better QEMU APIs?
>
> 1. We have qapi-schema.json.  Let's render to HTML and publish
> versioned documentation online.

Make can build docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.  Grab
the .html and go for it.  There's also qmp-ga-ref.

Sadly, this documentation is not nearly as good as it could be.  The doc
comment format is an ad hoc solution to the problem of enabling doc
generation with minimal churn to existing comments.  The doc generator
makes an effort to play that hand (but the hand sucks).  Finally and
most seriously, the doc comments are simply not good enough.

> 2. scripts/qmp/ contains command-line tools for QMP communication.
> They could use some polish and then be shipped.

MAINTAINERS blames them on me, but they're effectively unmaintained.
Prerequisite for shipping: having a maintainer who actually gives a
damn.

Let's review them:

* scripts/qmp/qemu-ga-client

  Is anybody using this?

  I think it should be unter "QEMU Guest Agent", not under "QMP".

* scripts/qmp/qmp

  Half-hearted attempt at a CLI tool for sending a QMP command.  Is
  anybody using this?
=20
* scripts/qmp/qmp-shell

  Half-hearted attempt at a human-friendly wrapper around the JSON
  syntax.  I have no use for this myself.

* scripts/qmp/qom-fuse

  I find this occasionally useful for QOM-spelunking.  The need for this
  indicates our QMP interface to QOM is too primitive for such uses.

* scripts/qmp/qom-get
  scripts/qmp/qom-list
  scripts/qmp/qom-set
  scripts/qmp/qom-tree

  Rather specialized.  Is anybody using them?

> 3. python/qemu/ contains Python modules for managing a QEMU process
> and QMP communication.  This should be packaged in distros and
> available on PyPI.

Currently maintained by Eduardo and Cleber (cc'ed) under "Python
scripts".

> 4. Go and Rust bindings would also be useful.  There is
> https://github.com/intel/govmm but I think it makes sense to keep it
> in qemu.git and provide an interface similar to our Python modules.

Mapping QAPI/QMP commands and events to function signatures isn't hard
(the QAPI code generator does).  Two problems (at least):

1. Leads to some pretty ridiculous functions.  Here's one:

    void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                             const char *device,
                             const char *target,
                             bool has_replaces, const char *replaces,
                             MirrorSyncMode sync,
                             bool has_speed, int64_t speed,
                             bool has_granularity, uint32_t granularity,
                             bool has_buf_size, int64_t buf_size,
                             bool has_on_source_error,
                             BlockdevOnError on_source_error,
                             bool has_on_target_error, BlockdevOnError on_t=
arget_error,
                             bool has_filter_node_name, const char *filter_=
node_name,
                             bool has_copy_mode, MirrorCopyMode copy_mode,=
=20
                             bool has_auto_finalize, bool auto_finalize,
                             bool has_auto_dismiss, bool auto_dismiss,
                             Error **errp);

  We commonly use 'boxed': true for such beasts, which results in
  functions like this one:

    void qmp_blockdev_add(BlockdevOptions *arg, Error **errp);

2. Many schema changes that are nicely backward compatible in QMP are
   anything but in such an "obvious" C API.  Adding optional arguments,
   for instance, or changing integer type width.  The former is less of
   an issue with 'boxed': true.

Perhaps less of an issue with dynamic languages.

I figure a static language would need much more expressive oomph than C
to be a good target.  No idea how well Go or Rust bindings can work.

> 5. A jailer is needed to isolate the QEMU process and vhost-user
> device backends using seccomp, Linux namespaces, and maybe
> SELinux/AppArmor.  We used to be able to rely on libvirt for QEMU
> security, but it's becoming a common task for any device backend and
> IMO should be its own launcher tool.

Perhaps the libvirt refactoring effort can give us one.

> 6. A configuration file format is sorely needed so that guest
> configuration can be persisted and easily launched.  Today you have to
> create a shell script that executes a QEMU command-line, but this is
> suboptimal because sharing executable scripts is dangerous from a
> security perspective and is hard to parse or modify programmatically.

No argument.  There is -readconfig, but it falls way short.

With command line QAPIfication, a real configuration file will be quite
feasible.

The main reason for the lack of progress there is our dedication to
backward compatibility.  A functional replacement of our CLI is a huge
task already.  Throwing in backward compatibility makes it a daunting
one.  Not least because nobody fully understands all the quirks.

> In many of these areas we already have a partial solution.  It just
> needs more work.  I think it would be worth the effort and the mental
> shift to really providing APIs that are easy to use by applications.
>
> What do you think?
>
> Have I missed things that are needed?
>
> Have I included things that are unnecessary?

I feel we need to make up our minds what kind of interface(s) we want to
provide.

We provide a low-level interface for management applications.  I feel we
need to nail this one.  Its QMP part is okay, I think, the CLI part is
not.

We also try to provide friendlier interfaces for human users.  Not only
do we suck at it, we're also prone to create liabilities for later: much
of the compatibility woes that have been holding us back are rooted in
"convenience" features.  And don't get me started on the folly of us
dabbling in GUI.


