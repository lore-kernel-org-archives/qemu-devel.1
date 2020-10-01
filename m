Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D473C4727F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6577220B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjHB41Cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6577220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNwr5-0002wn-Hc
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNwqW-0002Ww-QZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNwqU-0000d8-Fy
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601552037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M0eMtFwx7HCmClTeR5uMXzCUF6n3RdR6tsK84I44RNI=;
 b=AjHB41CqxnzuGppNLEQe1TVL/pPG/nyk+w3Y6OTBWQfyJElwG/jK+JvSMRnTkhhekmapGR
 O1duRMxtQpHsnBH7sxYfp8jpfGCFdpBy6KS2hJAdtp+BC5WipMbMVtawkyn1LZduLRMk4f
 HoVdz2EuGY0ZVNmRZQAQjsiNwroTP1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-_o3AVmP3Oiq_xUl8Kb0D5g-1; Thu, 01 Oct 2020 07:33:55 -0400
X-MC-Unique: _o3AVmP3Oiq_xUl8Kb0D5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E61064082;
 Thu,  1 Oct 2020 11:33:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-92.ams2.redhat.com [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 463F85C1D0;
 Thu,  1 Oct 2020 11:33:53 +0000 (UTC)
Date: Thu, 1 Oct 2020 13:33:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/4] keyval: Parse help options
Message-ID: <20201001113351.GB6673@linux.fritz.box>
References: <20200930124557.51835-1-kwolf@redhat.com>
 <20200930124557.51835-2-kwolf@redhat.com>
 <001c321e-7400-f680-45ce-c920f078d5d8@redhat.com>
 <20200930151006.GF9292@linux.fritz.box>
 <87lfgq1bfx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfgq1bfx.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.10.2020 um 12:34 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 30.09.2020 um 15:35 hat Eric Blake geschrieben:
> >> On 9/30/20 7:45 AM, Kevin Wolf wrote:
> >> > This adds a new parameter 'help' to keyval_parse() that enables parsing
> >> > of help options. If NULL is passed, the function behaves the same as
> >> > before. But if a bool pointer is given, it contains the information
> >> > whether an option "help" without value was given (which would otherwise
> >> > either result in an error or be interpreted as the value for an implied
> >> > key).
> >> > 
> >> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> [...]
> >> > +++ b/util/keyval.c
> >> > @@ -166,7 +166,7 @@ static QObject *keyval_parse_put(QDict *cur,
> >> >   * On failure, return NULL.
> >> >   */
> >> >  static const char *keyval_parse_one(QDict *qdict, const char *params,
> >> > -                                    const char *implied_key,
> >> > +                                    const char *implied_key, bool *help,
> >> >                                      Error **errp)
> >> >  {
> >> >      const char *key, *key_end, *s, *end;
> >> > @@ -238,13 +238,20 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
> >> >      if (key == implied_key) {
> >> >          assert(!*s);
> >> >          s = params;
> >> > +    } else if (*s == '=') {
> >> > +        s++;
> >> >      } else {
> >> > -        if (*s != '=') {
> >> > +        if (help && !strncmp(key, "help", s - key)) {
> >> 
> >> Should this use is_help_option() to also accept "?", or are we okay
> >> demanding exactly "help"?
> >
> > The comment for is_help_option() calls "?" deprecated, so I think we
> > don't want to enable it in a new parser.
> 
> Valid point.
> 
> But do we really want comparisons for "help" inline everywhere we want
> to check for non-deprecated help requests?  Would a common helper
> function be better?

How many more parsers are we going to add? I thought we intended the
keyval parser to be the one canoncial place in the long term?

If you prefer, I can make this a second static inline function in
include/qemu/help_option.h (that would have to work both as strcmp and
as strncmp), but I don't see a second user that would make it a "common"
helper.

> On the deprecation of "?": the comment is more than eight years old
> (commit c8057f951d6).  We didn't have a deprecation process back then,
> but we did purge '?' from the documentation.  Can we finally drop it?
> I'm going to ask that in a new thread.

I guess we can.

Kevin


