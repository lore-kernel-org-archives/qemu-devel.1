Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20F7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C64D20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJNYnnfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C64D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5trI-0008PU-Lj
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5tqa-0007yZ-6k
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:43:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5tqX-0004D9-Bo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597250603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=byHl8U/4/DgDGVX3gJd/tg3dUT9RzcLMP6R80a7BPNc=;
 b=gJNYnnfThO37k9bs/2NfULLfk/b+eg/PYWPdXbx4tEBY6ziI2543M4V/n3n9Rc3qX0qZv3
 Zg9yoGZPjClCbUfeKWldssGbs5fa7aiLI5MCpFv5I98A8X1ltne9UTXFN4W998Iwb2/4mv
 L6RkaUYjXLaj22RVi0f8Dj4N6jLYBKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Ksf8idvRNiGHJ09hy4icWg-1; Wed, 12 Aug 2020 12:43:21 -0400
X-MC-Unique: Ksf8idvRNiGHJ09hy4icWg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F31E91007B00
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 16:43:20 +0000 (UTC)
Received: from work-vm (ovpn-113-233.ams2.redhat.com [10.36.113.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B8E5100AE50;
 Wed, 12 Aug 2020 16:43:11 +0000 (UTC)
Date: Wed, 12 Aug 2020 17:43:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/3] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20200812164309.GN2810@work-vm>
References: <20200803191511.45261-1-dgilbert@redhat.com>
 <20200803191511.45261-2-dgilbert@redhat.com>
 <20200805124749.GH361702@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200805124749.GH361702@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 03:52:04
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Mon, Aug 03, 2020 at 08:15:09PM +0100, Dr. David Alan Gilbert (git) wrote:
> > diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> > index 824e713491..82b6f6d90a 100644
> > --- a/docs/tools/virtiofsd.rst
> > +++ b/docs/tools/virtiofsd.rst
> > @@ -107,6 +107,51 @@ Options
> >    performance.  ``auto`` acts similar to NFS with a 1 second metadata cache
> >    timeout.  ``always`` sets a long cache lifetime at the expense of coherency.
> >  
> > +xattr-mapping
> > +-------------
> > +
> > +By default the name of xattr's used by the client are passe through to the host
> > +file system.  This can be a problem where either those xattr names are used
> > +by something on the host (e.g. selinux guest/host confusion) or if the
> > +virtiofsd is running in a container with restricted priviliges where it cannot
> > +access some attributes.
> > +
> > +A mapping of xattr names can be made using -o xattrmap=mapping where the ``mapping``
> > +string consists of a series of rules.
> > +
> > +Each rule starts and ends with a ':'.  The mapping stops on a matching
> > +rule.  White space may be added before and after each rule.
> > +
> > +:scope:type:key:prepend:
> > +
> > +scope= 'c' - match 'key' against a xattr name from the client
> > +            for setxattr/getxattr/removexattr
> > +       'h' - match 'prepend' against a xattr name from the host
> > +            for listxattr
> > +       both letters can be included to match both cases.
> > +
> > +type is one of:
> > +       'p' Prefixing: If 'key' matches the client then the 'prepend'
> > +           is added before the name is passed to the host.
> > +           For a host case, the prepend is tested and stripped
> > +           if matching.
> > +
> > +       'o' OK: The attribute name is OK and passed through to
> > +           the host unchanged.
> > +
> > +       'b' Bad: If a client tries to use this name it's
> > +           denied using EPERM; when the host passes an attribute
> > +           name matching it's hidden.
> > +
> > +key is a string tested as a prefix on an attribute name originating
> > +       on the client.  It maybe empty in which case a 'c' rule
> > +       will always match on client names.
> > +
> > +prepend is a string tested as a prefix on an attribute name originiating
> > +       on the host, and used as a new prefix by 'p'.  It maybe empty
> > +       in which case a 'h' rule will always match on host names.
> 
> This syntax and the documentation is hard to understand. Defining
> concrete commands instead of a single super-command would make it more
> straightforward.

Yeh I realised it was getting a bit arcane.

> Here is the functionality I've been able to extract from the
> documentation:
> 
> 1. Rewrite client xattrs
> 
>    rewrite OLD NEW -> s/^OLD/NEW/

It's not actually that flexible; it can only prepend a prefix;
conditionally on a given prefix, i.e.

   s/^OLD/NEWOLD/

it can't do a generic rewrite.  It's precisely the inverse of (4).

> 2. Allow client xattrs
> 
>    allow PREFIX -> allow if matching
> 
> 3. Deny client xattrs
> 
>    deny PREFIX -> EPERM if matching
> 
> 4. Unprefix server xattrs
> 
>    unprefix PREFIX -> s/^PREFIX//
> 
> 5. Hide server xattrs
> 
>    hide PREFIX -> skip if matching
> 
> Did I miss any functionality?

It can explicitly allow server xattrs.

What we have is 
(client, server, all) x ([un-]prefix , good, bad)

> I suggest using "client" and "server" terminology instead of "client"
> and "host".

OK; so the 'server' being the one with the underlying fs from which a
capability is read.

> Prefix syntax: xattr names are matched by prefix. The empty string
> matches all xattr names. How is ':' escaped?

I didn't bother adding any escaping code; do you think we need to
bother? I've not seen any use of an xattr pattern that uses a :  - if
I was going to suggest an easiest thing I think I'd do it like 'sed'
in making the first character be the matching character rather than
explicitly :.

> It is unclear whether 'o' terminates processing immediately. Will later
> 'p' rules still execute?

The point of 'o' and 'b' is to terminate immediately; the idea is to be
able to do something like:

    'trusted.chocolate' -> OK
    'trusted.cheese' -> BAD
    'trusted' -> prefix by user.virtiofs

so that the trusted.something is accepted and stops processing, and then
any other trusted's get prefixed.

> It is unclear whether 'o'/'b' match the original client name or the
> rewritten name after a 'p' command.

Any match terminates; so a 'p' prefixes and that's it - no other command
is processed.

I'll rework so that:
  a) I replace any single letters by an explicit name
  b) I use 'server' instead of host'

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


