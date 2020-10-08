Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFEC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED632064C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ4jgbPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED632064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQ1g-0006hg-MA
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQPze-0004fQ-NL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQPzc-0003O8-F0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602140735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q/0DRjVMlNrsBeM6+Gbs/OPv/a+CrN7cBOde8BfdrEY=;
 b=IZ4jgbPNQl/mxP/mYuu8bgbm0R/aBX1SD6ijIHV3c4dFXScfs2/FykDiOC/yyMXeP28RA6
 nAGGt2pA8zyhGBNo3GmONEOVu9a+0KibDhJ0Ewz6ZkFtumjjeO7W/FzgvTpSOTWIOO9WTH
 cRuBNLI3uXVCa/4W1jsI/4/Uest7bP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-2PNYiKF9PbWRFsA1JMZCLw-1; Thu, 08 Oct 2020 03:04:51 -0400
X-MC-Unique: 2PNYiKF9PbWRFsA1JMZCLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46CB51018F83;
 Thu,  8 Oct 2020 07:04:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-68.ams2.redhat.com [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE774100239A;
 Thu,  8 Oct 2020 07:04:48 +0000 (UTC)
Date: Thu, 8 Oct 2020 09:04:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 08/20] python/machine.py: fix _popen access
Message-ID: <20201008070447.GA4672@linux.fritz.box>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-9-jsnow@redhat.com>
 <20201007100705.GD7212@linux.fritz.box>
 <1c562773-6216-7cbe-eddf-fa18cdcc84f3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1c562773-6216-7cbe-eddf-fa18cdcc84f3@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.10.2020 um 20:44 hat John Snow geschrieben:
> On 10/7/20 6:07 AM, Kevin Wolf wrote:
> > Am 07.10.2020 um 01:58 hat John Snow geschrieben:
> > > As always, Optional[T] causes problems with unchecked access. Add a
> > > helper that asserts the pipe is present before we attempt to talk with
> > > it.
> > > 
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > 
> > First a question about the preexisting state: I see that after
> > initialising self._popen once, we never reset it to None. Should we do
> > so on shutdown?
> > 
> 
> Yup, we should.
> 
> > >   python/qemu/machine.py | 16 +++++++++++-----
> > >   1 file changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> > > index 3e9cf09fd2d..4e762fcd529 100644
> > > --- a/python/qemu/machine.py
> > > +++ b/python/qemu/machine.py
> > > @@ -131,7 +131,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
> > >           # Runstate
> > >           self._qemu_log_path = None
> > >           self._qemu_log_file = None
> > > -        self._popen = None
> > > +        self._popen: Optional['subprocess.Popen[bytes]'] = None
> > 
> > Another option that we have, especially if it's an attribute that is
> > never reset, would be to set the attribute only when it first gets a
> > value other than None. Accessing it while it hasn't been set yet
> > automatically results in an AttributeError. I don't think that's much
> > worse than the exception raised explicitly in a property wrapper.
> > 
> > In this case, you would only declare the type in __init__, but not
> > assign a value to it:
> > 
> >      self._popen: Optional['subprocess.Popen[bytes]']
> > 
> 
> If you do this, you can just declare it as non-Optional. Whenever it exists,
> it is definitely a subprocess.Popen[bytes].

Sorry, yes, copied too much while thinking too little.

Getting rid of Optional was the whole point of the suggestion.

> > Maybe a nicer alternative in some cases than adding properties around
> > everything.
> > 
> > Instead of checking for None, you would then have to use hasattr(),
> > which is a bit uglier, so I guess it's mainly for attributes where you
> > can assume that you will always have a value (if the caller isn't buggy)
> > and therefore don't even have a check in most places.
> > 
> 
> As long as the style checkers are OK with that sort of thing. After a very
> quick test, it seems like they might be.
> 
> Generally, we run into trouble because pylint et al want variables to be
> declared in __init__, but doing so requires Optional[T] most of the time to
> allow something to be initialized later.
> 
> A lot of our stateful objects have this kind of pattern. QAPIGen has a ton
> of it. machine.py has a ton of it too.
> 
> You can basically imply the stateful check by just foregoing the actual
> initialization, which trades the explicit check for the implicit one when
> you get the AttributeError.
> 
> This is maybe more convenient -- less code to write, certainly. The error
> message you get I think is going to be a little worse, though.

Whether this matters depends on the meaning of the individual attribute.

There can be attributes that can legitimately be None during most of
the lifetime of the object. These should clearly be Optional.

In many cases, however, the contract say that you must first call method
A that initialises the attribute and then you can call method B which
uses it.  Calling B without A would be a bug, so it's not an error
message that users should ever see. For developers who will then look at
the stack trace anyway, I don't think it should make a big difference.

Here, it's usually expected that the attribute is not None except during
phases where the object is mostly inactive anyway (like VMs before
launch or after shutdown). Then you can just not add the attribute yet
and access it without checks (which would only throw an exception
anyway) elsewhere.

> I think I have been leaning towards the cute little @property shims because
> it follows a familiar OO model where a specific class always has a finite
> set of properties that does not grow or shrink. You can also use the shim to
> give a meaningful error that might be nicer to read than the AttributeError.
> 
> I'm open to suggestions on better patterns. I had considered at one point
> that it might be nice to split Machine out into a version with and without
> the console to make stronger typing guarantees. It has implications for how
> shutdown and cleanup and so on is handled, too.
> 
> (I had some WIP patches to do this, but I think I got a little stuck making
> the code pretty, and then the release, and then I got busy, and...)

I guess the way to have everything static would be splitting QEMUMachine
into QEMUVMConfig (which exists without a running QEMU instance) and
QEMUVMInstance (which gets a QEMUVMConfig passed to its constructor and
is directly tied to a QEMU process).

Not sure if it would be worth such a major change.

> > >           self._events = []
> > >           self._iolog = None
> > >           self._qmp_set = True   # Enable QMP monitor by default.
> > > @@ -244,6 +244,12 @@ def is_running(self):
> > >           """Returns true if the VM is running."""
> > >           return self._popen is not None and self._popen.poll() is None
> > > +    @property
> > > +    def _subp(self) -> 'subprocess.Popen[bytes]':
> > > +        if self._popen is None:
> > > +            raise QEMUMachineError('Subprocess pipe not present')
> > > +        return self._popen

The major downside that I saw while reviewing this patch (besides having
extra code just for making the error message of what essentially a
failed assertion nicer) is that we have two names for the same thing, we
have both names in active use in the other methods, and I'll never be
able to remember which of _subp and _popen is the real attribute and
which is the property (or that they are related at all and changing one
will actually change the other, too) without looking it up.

I mean, I guess tools will tell me after getting it wrong, but still...

Properties can make a nice external interface, but I feel using them
internally while you don't avoid accessing the real attribute in methods
other than the property implementation is more confusing than helpful.

> > >       def exitcode(self):
> > >           """Returns the exit code if possible, or None."""
> > >           if self._popen is None:
> > 
> > Of course, even if an alternative is possible, what you have is still
> > correct.
> > 
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > 
> 
> Thanks; I'll continue with this for now, but I really am open to talking
> about better ways to model the common pattern of "Optional sub-feature for a
> class that can be engaged post-initialization".
> 
> It's an interesting typing problem. If we were using semantic types, what we
> are describing is an f(x) such that:
> 
> f(object-without-feature) -> object-with-feature
> 
> It's a kind of semantic cast where we are doing something akin to an
> in-place transformation of a base type to a subtype. I'm not sure I have
> encountered any language that actually intentionally supports such a
> paradigm.
> 
> (Maybe haskell? I just assume haskell can do everything if you learn to lie
> to computers well enough.)

You can always express this kind of thing as object-with-feature
containing an object-without-feature.

Kevin


