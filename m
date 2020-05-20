Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367D7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DB72072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tuv7Xf0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DB72072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLWQ-0005ls-VX
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbLVb-0005Mj-7M
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:59:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbLVZ-0004E5-Qm
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589968769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxc5et1g7QWXxjsMVs/652uHZHTCieVP+s3cWAIfUGk=;
 b=Tuv7Xf0DixReYZts6JvwStvFrUMpRPyIh6eslgiqUZpILLjPE5+H9KFAatlhKE+h6HLSIE
 EmDr9Kdyg9T1rarBXaT375AmAEar4IDLktOsPtQNQWoO+dZHIMDJ+SmvSmcdiqN/Lkgnx0
 TT1Yss7xQbLiRYmGZf8eTmCrHp7I550=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-lqyR7XLLP1-VsHRXbgzwVg-1; Wed, 20 May 2020 05:59:25 -0400
X-MC-Unique: lqyR7XLLP1-VsHRXbgzwVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CE25107ACCA;
 Wed, 20 May 2020 09:59:24 +0000 (UTC)
Received: from work-vm (ovpn-114-169.ams2.redhat.com [10.36.114.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F30D5C1C8;
 Wed, 20 May 2020 09:59:22 +0000 (UTC)
Date: Wed, 20 May 2020 10:59:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
Message-ID: <20200520095920.GB2820@work-vm>
References: <20200407114449.482532-1-clg@kaod.org>
 <87a72q6fi4.fsf@dusky.pond.sub.org> <20200507170611.GF2699@work-vm>
 <87h7wq2a8t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87h7wq2a8t.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Cédric Le Goater <clg@kaod.org> writes:
> >> 
> >> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> >
> >> > Reimplement it based on qmp_qom_get() to avoid converting QObjects back
> >> > to strings.
> >> >
> >> > Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
> >> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> >> >
> >> > Slight fix for bit-rot:
> >> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> > [clg: updates for QEMU 5.0 ]
> >> > Signed-off-by: Cédric Le Goater <clg@kaod.org>
> >> > ---
> >> >
> >> >  I would like to restart the discussion on qom-get command to understand
> >> >  what was the conclusion and see if things have changed since.
> >> 
> >> I've since learned more about QOM.  I believe we should do HMP qom-get,
> >> but not quite like this patch does.  Let me explain.
> >> 
> >> A QOM property has ->get() and ->set() methods to expose the property
> >> via the Visitor interface.
> >> 
> >> ->get() works with an output visitor.  With the QObject output visitor,
> >> you can get the property value as a QObject.  QMP qom-get uses this.
> >> With the string output visitor, you can get it as a string.  Your
> >> proposed HMP qom-get uses this.
> >> 
> >> ->set() works with an input visitor.  With the QObject input visitor,
> >> you can set the property value from a QObject.  QMP qom-set uses this.
> >> With the string input visitor, you can set it from a string.  HMP
> >> qom-set uses this.  With the options visitor, you can set it from a
> >> QemuOpts.  CLI -object uses this.
> >> 
> >> The Visitor interface supports arbitrary QAPI types.  The ->get() and
> >> ->set() methods can use them all.
> >> 
> >> Some visitors, howerver, carry restrictions:
> >> 
> >>  * The string output visitor does not implement support for visiting
> >>  * QAPI structs, alternates, null, or arbitrary QTypes.  It also
> >>  * requires a non-null list argument to visit_start_list().
> >> 
> >>  * The string input visitor does not implement support for visiting
> >>  * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
> >>  * of integers (except type "size") are supported.
> >> 
> >>  * The Opts input visitor does not implement support for visiting QAPI
> >>  * alternates, numbers (other than integers), null, or arbitrary
> >>  * QTypes.  It also requires a non-null list argument to
> >>  * visit_start_list().
> >> 
> >> If you try to qom-set a property whose ->set() uses something the string
> >> input visitor doesn't support, QEMU crashes.  Same for -object, and your
> >> proposed qom-get.
> >
> > Crashing would be bad.
> >
> >> I'm not aware of such a ->set(), but this is a death trap all the same.
> >> 
> >> The obvious way to disarm it is removing the restrictions.
> >> 
> >> One small step we took towards that goal is visible in the comments
> >> above: support for flat lists of integers.  The code for that will make
> >> your eyes bleed.  It's been a thorn in my side ever since I inherited
> >> QAPI.  Perhaps it could be done better.  But there's a reason why it
> >> should not be done at all: it's language design.
> >> 
> >> The QObject visitors translate between QAPI types and our internal
> >> representation of JSON.  The JSON parser and formatter complete the
> >> translation to and from JSON.  Sensible enough.
> >> 
> >> The string visitors translate between QAPI and ...  well, a barely
> >> documented language of our own "design".  Tolerable when the language it
> >> limited to numbers, booleans and strings.  Foolish when it grows into
> >> something isomorphic to JSON.
> >> 
> >> This is a dead end.
> >> 
> >> Can we still implement a safe and tolerably useful HMP qom-get and
> >> qom-set?  I think we can.  Remember the basic rule of HMP command
> >> implementation: wrap around the QMP command.  So let's try that.
> >> 
> >> hmp_qom_get() calls qmp_qom_get() and formats the resulting QObject with
> >> qobject_to_json_pretty().
> >
> > Why don't we *just* do this?
> > OK, we wont fix the qom-set or the CLI, but if we just get hmp_qom_get
> > to call QMP, format it into json and then dump the json to the user,
> > then we get a usable, if not pretty, qom-get command, without having to
> > solve all these hard problems to move it forward?
> 
> Count me in favour.  I'd like to see the matching change to HMP qom-set,
> though.

It turns out I actually did do a JSON version, as the follow up to the
version Cédric reposted; but then that got lost in people not liking
JSON;   https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg01041.html

Having just resurrected that code, the only difference from my patch
then and what I just wrote was that instead of doing the object
resolution and stuff, I just call the qmp function.
It's still JSON output and I don't think the arguments from 4 years ago
moved forward.  I'll post it soon.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


